class BackAndForth implements Enemy {  
  float xCor, yCor;
  int direction;
  float step;


  BackAndForth() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    direction = (int) random(4f);
    step = 5;// May Change to increase speed
  }

  float xCor() {
    return xCor;
  }

  float yCor() {
    return yCor;
  }

  boolean detect() {
    if (xCor>=XSIZE){
      //direction = 0;//left
      direction = (int) random(3f);
      if (direction > 0){
        direction += 1; //only 0,2, or 3
      }
      return true;
    }
    else if (xCor<=0){
     // direction = 1;//right
     direction = (int) random(3f);
     direction+=1; //only 1,2, or 3
     return true;
    }
    else if (yCor>=YSIZE){
      //direction = 2;//up
      direction = (int) random(3f); // only 0, 1, 2
      print(direction);
      return true;
    }
    else if (yCor<=0){
      //direction = 3;//down
      direction = (int) random(3f);
      if (direction == 2){
        direction+=1; // only 0,1, or 3
      }
      print(direction);
      return true;
    }
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
