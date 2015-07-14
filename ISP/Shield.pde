class Shield implements Powerup {
  float xCor, yCor;

  Shield() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
  }

  void dying() {
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  35 );
  }

  boolean event(Enemy e) {
    return true;
  }

  void display() {
    fill(0, 255, 255);
    ellipse(xCor, yCor, 50, 50);
  }
}

