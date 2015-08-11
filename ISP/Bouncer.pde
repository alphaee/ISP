class Bouncer implements Enemy {
  float xCor, yCor;
  float speedX, speedY;
  boolean isAlive, spawning;
  int myPlace, inLife;
  int tempFrameCount;
  int spawnDelay, spawnCounter;
  int deathCounter;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    speedX = 5 - random( 10 );
    speedY = 5 - random( 10 );
    isAlive = true;
    tempFrameCount = 0;
    spawnDelay = fps*2;
    spawnCounter = 10;
    deathCounter = 28;
    spawning = true;
  }

  Bouncer(float x, float y) {
    xCor = x;
    yCor = y;
    speedX = 5 - random( 10 );
    speedY = 5 - random( 10 );
    isAlive = true;
    tempFrameCount = 0;
    spawnDelay = fps*2;
    spawnCounter = 10;
    deathCounter = 28;
  }

  float xCor() {
    return xCor;
  }
  float yCor() {
    return yCor;
  }

  boolean isAlive() {
    return isAlive;
  }

  boolean detect() { 
    return true;
  }

  void attack() { 
    xCor += speedX;
    yCor += speedY;
    float multiplier;
    multiplier = random(1.01, 1.4);
    if ( xCor <= 0 || xCor >= XSIZE ) {
      speedX *= -multiplier;

      if (abs(speedX)> 8)
        speedX = 8*speedX/abs(speedX);
    }
    if ( yCor < 0 || yCor > YSIZE ) {
      speedY *= -multiplier;

      if (abs(speedY)> 8)
        speedY = 8*speedY/abs(speedY);
    }
  }

  void act() {
    if (spawning){
      baf_spawning.show(xCor, yCor, 20);
      spawnCounter--;
      if (spawnCounter < 0){
        spawning = false;
      }
    }
    else if (isAlive) {
      if (xCor < pxCor + displayWidth/2 && xCor > pxCor - displayWidth/2 && yCor < pyCor + displayHeight/2 && yCor > pyCor - displayHeight/2)
        display();
      attack();
    } else {
      dying();
    }
  }

  void dead(int i, int j) {
    myPlace = i;
    inLife = j;
    if (isAlive) {
      //tempFrameCount = counter;
      tempFrameCount = millis();
      isAlive = false;
    }
  }

  void dying() {
    if (!isAlive) {
      bounce_dying.show(xCor, yCor, 8);
      deathCounter--;  
      if (deathCounter < 0) {
        if (inLife>=enemies[myPlace].size())
          inLife = enemies[myPlace].size()-1;
        enemies[myPlace].remove(inLife);
        BackAndForth baby = new BackAndForth(xCor, yCor, speedX, speedY);
        enemies[1].add(baby);
        score += 20;
      }
    }
  }


  boolean checkBounds() {
    if ( xCor < 0 || xCor > XSIZE) 
      return true;
    if ( yCor < 0 || yCor > YSIZE)
      return true;
    return false;
  }

  void event(Enemy e, int i, int j) {
  }

  void display() {
    if (spawning){
      
    }
    else{
    bounce_moving.show(xCor, yCor, 20);
    }
  }
}
