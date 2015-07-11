class Bouncer implements Enemy {
  float xCor, yCor;
  float origSpeedX, origSpeedY;
  float speedX, speedY;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    origSpeedX = 5 - random( 10 );
    origSpeedY = 5 - random( 10 );
    speedX = origSpeedX;
    speedY = origSpeedY;
  }
  
   Bouncer(float x, float y) {
    xCor = x;
    yCor = y;
    origSpeedX = 5 - random( 10 );
    origSpeedY = 5 - random( 10 );
    speedX = origSpeedX;
    speedY = origSpeedY;
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

  void attack() { // reflect when it hits the boundary with different speed
    xCor += speedX;
    yCor += speedY;
    
    float multiplier = random(0.5,2);
    
    if ( xCor < 0 || xCor > XSIZE ) {
      speedX = -origSpeedX * multiplier;
      speedY = origSpeedY * multiplier;
    }
    if ( yCor < 0 || yCor > YSIZE ) {
      speedY = -origSpeedY * multiplier;
      speedX = origSpeedX * multiplier;
    }
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
