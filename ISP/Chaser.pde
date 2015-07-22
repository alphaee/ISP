class Chaser implements Enemy {  
  float xCor, yCor;
  int step;
  int myPlace, inLife;
  boolean isAlive;
  int tempFrameCount;

  Chaser() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    step = (int) random(30,60);
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
    if ( dist(xCor, yCor, pxCor, pyCor) < YSIZE/5 ) {
      return true;
    }
    return false;
  }

  void attack() { //nearly identical to Player class' "move()" method
    float speedX = (xCor - pxCor) / step;
    float speedY = (yCor - pyCor) / step;

    float speed = sqrt(speedX*speedX + speedY*speedY);

    speedX = (2*speedX)/speed;
    speedY = (2*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }

  boolean isAlive() {//Still needs work
    return true;
  }

  void act() {
    if (isAlive()) {
      display();
      if (detect())
        attack();
    } 
    else{
      dying(myPlace, inLife);
    }
  }

  void dying(int i, int j) {
    //println(frameCount);
    myPlace = i;
    inLife = j;
    if (isAlive){
      tempFrameCount = frameCount;
      isAlive = false;
    }
    else{
      if (frameCount == tempFrameCount + 6){
        enemies[i].remove(j);
        score += 15;
      }
    }
  }

  void event(Enemy e, int i, int j) {
  }

  void display() {
    fill(0);
    ellipse(xCor, yCor, 50, 80);
  }
}
