class Chaser implements Enemy {  
  float xCor, yCor;
  int step;
  int myPlace, inLife;
  boolean isAlive, spawning;
  int tempFrameCount;
  int deathCounter, spawnCounter;

  Chaser() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    step = (int) random(2, 5);
    isAlive = true;
    tempFrameCount = 0;
    deathCounter = 14;
    spawnCounter = 5;
    spawning = true;
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
    return dist(xCor, yCor, pxCor, pyCor) < YSIZE/5;
  }

  void attack() { //nearly identical to Player class' "move()" method
    float speedX = (xCor - pxCor);
    float speedY = (yCor - pyCor);
    float speed = sqrt(speedX*speedX + speedY*speedY);
    speedX = (step*speedX)/speed;
    speedY = (step*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }

  void act() {
    if (isAlive) {
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
      chas_dying.show(xCor, yCor, 4);
      deathCounter--;
      if (deathCounter < 0) {
        //if (millis() >= tempFrameCount + 250) {
        if (inLife>=enemies[myPlace].size())
          inLife = enemies[myPlace].size()-1;
        enemies[myPlace].remove(inLife);
        score += 15;
      }
    }
  }

  void event(Enemy e, int i, int j) {
  }

  void display() {
    if (spawning){
      chas_spawning.show(xCor, yCor, 20);
      spawnCounter--;
      if (spawnCounter < 0){
        spawning = false;
      }
    }
    else{
      fill(#DE1616);
      ellipse(xCor, yCor, 30, 30);
    }
  }
}
