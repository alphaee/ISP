class Railgun implements Powerup {
  float xCor, yCor;
  float setXCor, setYCor;
  int step;
  boolean activated;

  Railgun() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    step = 2;
    activated = false;
  }

  void dying() {
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  50 );
  }

  boolean detect(Enemy e) {
    return( dist(xCor, yCor, e.xCor(), e.yCor()) <  50 );
  }

  boolean event(Enemy e) {
    if (detect()&&!activated) {
      setXCor=xCor+(pxCor-xCor);
      setYCor=yCor+(pyCor-yCor);
      activated = true;
    }    
    if (activated) {
      moving();
      if (detect(e)) {
        return true;
      }
    }
    return false;
  }

  void moving() {
    float speedX = (xCor - setXCor) / step;
    float speedY = (yCor - setYCor) / step;

    float speed = sqrt(speedX*speedX + speedY*speedY);

    speedX = (2*speedX)/speed;
    speedY = (2*speedY)/speed;
    
    xCor += speedX;
    yCor += speedY;
  //  print(xCor,yCor);
  }

  void display() {
    if (activated) 
      fill(#53A58C);
    else
      fill(#048B29);
    ellipse(xCor, yCor, 50, 50);
  }

  boolean checkBounds() {
    if ( xCor < 0 || xCor > XSIZE) 
      return true;
    if ( yCor < 0 || yCor > YSIZE)
      return true;
    return false;
  }
}

