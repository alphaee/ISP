class Mine implements Powerup {
  float xCor, yCor;
  boolean activated;
  boolean exploded;
  int exploding;
  int duration;

  Mine(int i) {
    xCor = pxCor;
    yCor = pyCor;
    activated = false;
    exploded = false;
    exploding = 0;
    duration = fps * 1;
  }

  Mine() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    activated = false;
    exploded = false;
    exploding = 0;
    duration = fps * 1;
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  35 );
  }

  boolean detect(Enemy e) {
    return( dist(xCor, yCor, e.xCor(), e.yCor()) <  50 && e.isAlive());
  }

  boolean event(Enemy e) {
    if (detect()) {
      activated = true;
    }
    if (activated&&!exploded) {
      if (detect(e)) {
        exploded = true;
      }
    }
    if (exploding<=fps*10&&detect(e)&&activated)
      return true;

    return false;
  }

  void display() {
    if (!activated) {      
      image(minePassive, xCor, yCor);
    }
    if (activated&&exploding<=duration)
      image(mineActive, xCor, yCor);
  }
}

