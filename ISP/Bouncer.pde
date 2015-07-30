class Bouncer implements Enemy {
  float xCor, yCor;
  float speedX, speedY;
  boolean isAlive;
  int myPlace, inLife;
  int tempFrameCount;
  int spawnDelay, spawnCounter;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    speedX = 5 - random( 10 );
    speedY = 5 - random( 10 );
    isAlive = true;
    tempFrameCount = 0;
    spawnDelay = fps*2;
    spawnCounter = 0;
  }

  Bouncer(float x, float y) {
    xCor = x;
    yCor = y;
    speedX = 5 - random( 10 );
    speedY = 5 - random( 10 );
    isAlive = true;
    tempFrameCount = 0;
    spawnDelay = fps*2;
    spawnCounter = 0;
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
    if (isAlive) {
      display();
      detect();
      attack();
    } else {
      dying(myPlace, inLife);
    }
  }

  void dying(int i, int j) {
    myPlace = i;
    inLife = j;
    if (isAlive) {
      tempFrameCount = counter;
      isAlive = false;
    } else {
      if (counter >= tempFrameCount) {
        enemies[i].remove(j);
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
    bounce_moving.show(xCor, yCor, 20);
  }
}
