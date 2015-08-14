class Shield implements Powerup {
  float xCor, yCor;

  Shield() {
    xCor = random(XSIZE/20, XSIZE*19/20);
    yCor = random(YSIZE/20, YSIZE*19/20);
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  35 );
  }

  boolean event(Enemy e) {
    return true;
  }

  void display() {
    image(shield, xCor, yCor);
  }
}
