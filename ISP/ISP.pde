//Young Kim, Dan Kim, Franklin Wang
final static int XSIZE = 1280;
final static int YSIZE = 720;

Player hero;

void setup(){
  hero = new Player();
  size(XSIZE,YSIZE);
}

void draw(){
  hero.display();
}
