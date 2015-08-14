class Spikes implements Powerup {
  float xCor, yCor;

  Spikes() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
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
