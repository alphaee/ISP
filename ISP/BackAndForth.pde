class BackAndForth implements Enemy {  
  float xCor, yCor;
  int direction;
  float step;


  BackAndForth() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    direction = (int) random(4);
    step = 5;// May Change to increase speed
  }

  float xCor() {
    return xCor;
  }

  float yCor() {
    return yCor;
  }

  boolean detect() {
    if (xCor>=XSIZE)
      direction = 0;//left
    else if (xCor<=0)
      direction = 1;//right
    else if (yCor>=YSIZE)
      direction = 2;//up 
    else if (yCor<=0)
      direction = 3;//down
      return true;
  }

  void attack() {
    detect();
    if (direction%4 == 0)
      xCor-=step;
    else if (direction%4 == 1)
      xCor+=step;
    else if (direction%4 == 2)
      yCor-=step;
    else
      yCor+=step;
  }

  boolean isAlive() {//Still needs work
    return true;
  }

  void dying() {
  }

  void act() {
    if (isAlive()) {
      display();
      attack();
    } else
      dying();
  }

  void display() {//display() should only display
    fill(255);
    ellipse(xCor, yCor, 50, 80);
  }
}
