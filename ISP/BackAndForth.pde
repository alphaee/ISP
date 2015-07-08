class BackAndForth implements Enemy {  
  float xCor, yCor;
  int direction;
  int step;
  int radius; //radius of circle - temp
  boolean avoid;

  BackAndForth() {
    radius = 50;

    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);

    direction = (int)random(4f);
    avoid = false;

    step = 5;// May Change to increase speed
  }

  float xCor() {
    return xCor;
  }

  float yCor() {
    return yCor;
  }

  boolean detect() {
    if (xCor >= XSIZE) {
      //direction = 0;//left
      direction = (int)random(3f);
      if (direction > 0) {
        direction ++; //only 0,2, or 3
      }
      xCor -= step; // to move away from the border so it doesn't get caught here again
    } else if (xCor <= 0) {
      // direction = 1;//right
      direction = (int)random(3f);
      direction ++; //only 1,2, or 3
      xCor += step; // same as xCor-=step
    } else if (yCor >= YSIZE) {
      //direction = 2;//up
      direction = (int)random(3f); // only 0, 1, 2
      yCor -= step; // same as xCor-=step
    } else if (yCor <= 0) {
      //direction = 3;//down
      direction = (int)random(3f);
      if (direction == 2) {
        direction ++; // only 0,1, or 3
      }
      yCor+=step; // same as xCor-=step
    }

    if (avoid) { 
      if (xCor <= step) {
        direction = 1;
      } else if (xCor >= XSIZE-step) {
        direction = 0;
      } else if (yCor <= step) {
        direction = 3;
      } else if (yCor >= YSIZE-step) {
        direction = 2;
      }
      avoid = false;
    }
    return true;
  }

  void attack() {
    detect();
    if (direction % 4 == 0) //left
      xCor -= step;                                
    else if (direction % 4 == 1) //right
      xCor += step;
    else if (direction % 4 == 2) //up
      yCor -= step;
    else //down
    yCor += step;
  }

  boolean collide(Enemy e) {
    return dist( xCor, yCor, e.xCor(), e.yCor() ) < 30;
  }

  void event(Enemy e) {
    if (collide(e)) {
      if (random(10) < 3) { //30% chance of merging
        merge(e);
      } else { //if it doesn't merge, goes off border
        avoid = true;
      }
    }
  }

  void merge(Enemy e) {
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
    ellipse(xCor, yCor, radius, radius);
  }
}

