import processing.opengl.*;

Cube c = new Cube(50);
Wandering[] stuff = new Wandering[500];
int tick = 0;

void setup(){
  size(800,800,OPENGL);
  camera( 0,0,500, 0,0,0, 0,-1,0);
  frustum( -200,200, -200,200, 400, 0);

  for (int i=0; i < stuff.length; i++){
    stuff[i] = new Cube((int)random(8)+2);
    stuff[i].x = (int)random(10);
    stuff[i].y = (int)random(10);
    stuff[i].z = 0;//(int)random(10);
  }
}

void draw(){
  background(0);
  stroke(0xff000000);
  fill(0x993366aa);

  tick ++;
  //rotateY(radians(tick % 360));
  //rotateX(radians(tick % 360));
  //rotateZ(radians(tick % 360));
  //axis();

  int delta = 0;
  for (int i=0; i < stuff.length; i ++){
    stuff[i].transform();
    stuff[i].draw();
  }
  delay(100);
}

void axis(){
  pushMatrix();
  stroke(0xffff0000);
  line(0,0,0, 100,0,0);
  stroke(0xff00ff00);
  line(0,0,0, 0,100,0);
  stroke(0xff0000ff);
  line(0,0,0, 0,0,100);
  popMatrix();
}

abstract class Wandering {
  int x,y,z;
  int xd,yd,zd;
  final int maxd = 10;

  abstract void plot();

  private void increment_deltas(){
    this.xd += (int) (random(10) - 5);
    this.yd += (int) (random(10) - 5);
    this.zd += (int) (random(10) - 5);

    if (this.xd > this.maxd) this.xd *= 0.4;
    if (this.yd > this.maxd) this.yd *= 0.4;
    if (this.zd > this.maxd) this.zd *= 0.4;
  }

  public void transform(){
    this.increment_deltas();
    this.x += this.xd;
    this.y += this.yd;
    this.z += this.zd;

    if (this.x > 100 || this.x < -100) this.xd = 0;
    if (this.y > 100 || this.y < -100) this.yd = 0;
    if (this.z > 100 || this.z < -100) this.zd = 0;

    this.draw();
  }

  public void draw(){
    pushMatrix();
    translate(this.x, this.y, this.z);
    this.plot();
    popMatrix();
  }
};

class Cube extends Wandering {
  int h;
  Cube()                           { this.x = this.y = this.z = this.h = 0;          }
  Cube(int h)                      { this.x = this.y = this.z = 0; this.h = h;       }
  Cube(int x, int y, int z)        { this.x = x; this.y = y; this.z = z; this.h = 1; }
  Cube(int x, int y, int z, int h) { this.x = x; this.y = y; this.z = z; this.h = h; }

  public void plot(){
    box(this.h);
  }
};
