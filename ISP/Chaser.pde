class Chaser implements Enemy {  
  float xCor, yCor;
  int step;
  int myPlace, inLife;
  boolean isAlive;
  int tempFrameCount;

  Chaser() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    step = (int) random(2, 5);
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
      display();
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
      chas_dying.show(xCor, yCor, 1);
      if (counter >= tempFrameCount) {
        enemies[i].remove(j);
        score += 15;
      }
    }
  }

  void event(Enemy e, int i, int j) {
  }

  void display() {
    fill(#DE1616);
    ellipse(xCor, yCor, 30, 30);
  }
}

