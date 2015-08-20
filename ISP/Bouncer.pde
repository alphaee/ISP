class Bouncer implements Enemy {
  float xCor, yCor;
  float speedX, speedY;
  int rotation;
  boolean isAlive, spawning;
  int myPlace, inLife;
  int spawnDelay, spawnCounter;
  int deathCounter;
  boolean invincible;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    speedX = 10 - random( 10 ); //speed
    speedY = 10 - random( 10 );
    isAlive = true;
    spawnDelay = fps*2;
    spawnCounter = 10;
    deathCounter = 28;
    spawning = true;
    rotation = (int)random(PI*2/3);
  }

  Bouncer(float x, float y) {
    xCor = x;
    yCor = y;
    speedX = 10 - random( 20 ); //speed
    speedY = 10 - random( 20 );
    isAlive = true;
    spawnDelay = fps*2;
    spawnCounter = 10;
    deathCounter = 28;
    rotation = (int)random(PI*2/3);
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
  
  boolean invincible(){
    return false;
  }

  boolean spawning(){
    return spawning;
  }
  
  boolean checkSpikeDeath(){
    return (xCor > XSIZE-35 || xCor < 35 || yCor < 35 || yCor > YSIZE-35) && isAlive;
  }

  void attack() { 
    xCor += speedX;
    yCor += speedY;
    float multiplier;
    multiplier = random(1.01, 1.4);
    if ( xCor <= 0 || xCor >= XSIZE ) {
      speedX *= -multiplier;

      if (abs(speedX)> 16) //change this to change speed
        speedX = 16*speedX/abs(speedX);
    }
    if ( yCor < 0 || yCor > YSIZE ) {
      speedY *= -multiplier;

      if (abs(speedY)> 16) //change this to change speed
        speedY = 16*speedY/abs(speedY);
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
      pushMatrix();
      translate(xCor,yCor);
      rotate(rotation);
      bounce_moving.show(0, 0, 20);
      popMatrix();
    }
  }
}
