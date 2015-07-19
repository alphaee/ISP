class Railgun implements Powerup {
  float xCor, yCor;
  int step;

  Railgun() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    int step = 5;
  }

  void dying() {
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  35 );
  }

  boolean detect(Enemy e) {
    return( dist(xCor, yCor, e.xCor(), e.yCor()) <  20 );
  }

  boolean event(Enemy e) {
    return true;
  }

  void moving() {
  }

  void display() {
    fill(#8137D1);
    ellipse(xCor, yCor, 20, 20);
  }
}

