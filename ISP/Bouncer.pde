import java.lang.Math;

class Bouncer implements Enemy {
  float xCor, yCor;
  float origSpeedX, origSpeedY;
  float speedX, speedY;
  boolean isAlive;
  int myPlace, inLife;
  int tempFrameCount;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    origSpeedX = 5 - random( 10 );
    origSpeedY = 5 - random( 10 );
    speedX = origSpeedX;
    speedY = origSpeedY;
    isAlive = true;
    tempFrameCount = 0;
  }
  
   Bouncer(float x, float y) {
    xCor = x;
    yCor = y;
    origSpeedX = 5 - random( 10 );
    origSpeedY = 5 - random( 10 );
    speedX = origSpeedX;
    speedY = origSpeedY;
    isAlive = true;
    tempFrameCount = 0;
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
    float multiplier, multiBefore;
    multiplier = 1;
    // here, we always update the sign of origSpeed to current Speed so reflect works correctly.
    if ( xCor < 0 || xCor > XSIZE ) {
      origSpeedX = Math.signum(speedX)*abs(origSpeedX); // signum returns +1 if number is positive 
      origSpeedY = Math.signum(speedY)*abs(origSpeedY); // -1 for negative and 0 for zero.
      multiBefore = multiplier;
      multiplier = random(1.01,1.4);
      speedX = -origSpeedX * multiplier; // you don't want speed increasing to infinity or to 0 by chance
      speedY = origSpeedY * multiplier; // so you save and modify the origSpeed.
      if (abs(origSpeedX*(multiplier-multiBefore)) > 3){// if it hits the boundary when the speedDiff is too great
                     // we should manually move it inside the boundary so 
                     // it doesn't get stuck
        emergencyMoving();
      }
    }
    if ( yCor < 0 || yCor > YSIZE ) {
      origSpeedX = Math.signum(speedX)*abs(origSpeedX);
      origSpeedY = Math.signum(speedY)*abs(origSpeedY);
      multiBefore = multiplier;
      multiplier = random(1.01,1.4);
      speedY = -origSpeedY * multiplier;
      speedX = origSpeedX * multiplier;
      if (abs(origSpeedY*(multiplier-multiBefore)) > 3){
        emergencyMoving();
      }
    }
  }
  
  void emergencyMoving(){
    
    if ( xCor < 0 ) {
          //while ( xCor < 0 ){
            //xCor+=5; 
          //}
          xCor = 15;
      }
      if (xCor > XSIZE){
          //while (xCor > XSIZE){
            //xCor-=10;
          //}
          xCor = XSIZE - 15;
      }
      if ( yCor < 0 ){
          //while (yCor < 0){
            //yCor+=10;
          //}
          yCor = 15;
      }
      if (yCor > YSIZE){
          //while (yCor > YSIZE){
            //yCor-=10;
          //}
          yCor = YSIZE - 15;
      }
      
      
  }

  boolean isAlive() {//Still needs work
    return true;
  }

  void act() {
    if (isAlive) {
      display();
      detect();
      attack();
    } 
    else{
      dying(myPlace, inLife);
    }
  }

  void dying(int i, int j) {
    myPlace = i;
    inLife = j;
    if (isAlive){
      tempFrameCount = millis();
      isAlive = false;
      //println("Im alive");
    }
    else{
      //println("Im dead");
      //println(millis());
      if (millis() >= tempFrameCount + 20){
        enemies[i].remove(j);
        BackAndForth baby = new BackAndForth(xCor, yCor);
        enemies[1].add(baby);
        //println("im hidden");
        score += 20;
      }
    }
  }
  
  boolean checkBounds(){
    if( xCor < 0 || xCor > XSIZE) 
      return true;
    if( yCor < 0 || yCor > YSIZE)
      return true;
    return false; 
  }
  
  void event(Enemy e, int i, int j) {
  }

  void display() {
    fill(100);
    ellipse(xCor, yCor, 50, 80);
  }
}
