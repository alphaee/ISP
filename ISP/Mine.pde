class Mine implements Powerup {
  float xCor, yCor;
  boolean activated;
  boolean exploded;
  int exploding;

  Mine() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    activated = false;
    exploded = false;
    exploding = 0;
  }

  void dying() {
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  35 );
  }

  boolean detect(Enemy e) {
    return( dist(xCor, yCor, e.xCor(), e.yCor()) <  50 );
  }

  boolean event(Enemy e) {
    if (detect()) {
      activated = true;
    }
    if (activated&&!exploded) {
      if (detect(e)) {
        exploded = true;
      }
      if (exploding<=frameRate*30)
        return true;
    }
    return false;
  }

  void display() {
    if (activated&&exploding<=frameRate*30)
      fill(#E80000);
    else 
      fill(#D8B8B8);
    if (exploding<=frameRate*30)
      ellipse(xCor, yCor, 50, 50);
  }
}

