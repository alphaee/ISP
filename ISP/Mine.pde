class Mine implements Powerup {
  float xCor, yCor;
  boolean activated;
  boolean exploded;
  int exploding;
  
  Mine(int i) {
    xCor = pxCor;
    yCor = pyCor;
    activated = false;
    exploded = false;
    exploding = 0;
  }
  
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
    }
    if (exploding<=fps*10&&detect(e)&&activated)
      return true;

    return false;
  }

  void display() {
    if (activated&&exploding<=fps*10)
      fill(#E80000);
    else 
      fill(#D8B8B8);
    ellipse(xCor, yCor, 50, 50);
  }
}

