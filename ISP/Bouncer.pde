class Bouncer implements Enemy {
  float xCor, yCor;
  float speedX, speedY;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    speedX = 5 - random( 10 );
    speedY = 5 - random( 10 );
  }
  
   Bouncer(float x, float y) {
    xCor = x;
    yCor = y;
    speedX = 5 - random( 10 );
    speedY = 5 - random( 10 );
  }

  float xCor() {
    return xCor;
  }
  float yCor() {
    return yCor;
  }

  boolean detect() {
    //if ( dist(xCor, yCor, pxCor, pyCor) < YSIZE/5 ) {
      return true;
    //}
    //return false;
  }

  void attack() { 

    //float speed = sqrt(speedX*speedX + speedY*speedY);

    //speedX = (2*speedX)/speed;
    //speedY = (2*speedY)/speed;
    xCor += speedX;
    yCor += speedY;
    
    if ( xCor < 0 || xCor > XSIZE ) speedX = -speedX;
    if ( yCor < 0 || yCor > YSIZE ) speedY = -speedY;
  }

  boolean isAlive() {//Still needs work
    return true;
  }

  void act() {
    if (isAlive()) {
      display();
      //if (detect())
        attack();
    } else
      dying();
  }

  void dying() {
  }
  void event(Enemy e, int i, int j) {
  }

  void display() {
    fill(100);
    ellipse(xCor, yCor, 50, 80);
  }
}
