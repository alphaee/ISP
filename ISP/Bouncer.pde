import java.lang.Math;

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
      return true;
  }

  void attack() { // reflect when it hits the boundary with different speed
    xCor += speedX;
    yCor += speedY;
    //multiplier will change the speed every time it hits the boundary.
    float multiplier;
    // here, we always update the sign of origSpeed to current Speed so reflect works correctly.
    if ( xCor < 0 || xCor > XSIZE ) {
      origSpeedX = Math.signum(speedX)*abs(origSpeedX); // signum returns +1 if number is positive 
      origSpeedY = Math.signum(speedY)*abs(origSpeedY); // -1 for negative and 0 for zero.
      multiplier = random(0.5,2);
      speedX = -origSpeedX * multiplier; // you don't want speed increasing to infinity or to 0 by chance
      speedY = origSpeedY * multiplier; // so you save and modify the origSpeed.
    }
    if ( yCor < 0 || yCor > YSIZE ) {
      origSpeedX = Math.signum(speedX)*abs(origSpeedX);
      origSpeedY = Math.signum(speedY)*abs(origSpeedY);
      multiplier = random(0.5,2);
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
