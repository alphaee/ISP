class BackAndForth implements Enemy {  
  final int noCircles = 10;
  
  float xCor, yCor;
  int direction;
  float step;
  ArrayList<PShape> circlesTrail;

  BackAndForth() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    direction = (int)random(4f);
    step = 5;// May Change to increase speed
    circlesTrail = new ArrayList<PShape>(); //  trail of poison
    circlesTrail.add(createShape(ELLIPSE, xCor, yCor, 50, 80));
  }

  float xCor() {
    return xCor;
  }

  float yCor() {
    return yCor;
  }

  boolean detect() {
    if (xCor >= XSIZE){
      //direction = 0;//left
      direction = (int)random(3f);
      if (direction > 0){
        direction ++; //only 0,2, or 3
      }
      xCor -= step; // to move away from the border so it doesn't get caught here again
    }
    else if (xCor <= 0){
     // direction = 1;//right
     direction = (int)random(3f);
     direction ++; //only 1,2, or 3
     xCor += step; // same as xCor-=step
    }
    else if (yCor >= YSIZE){
      //direction = 2;//up
      direction = (int)random(3f); // only 0, 1, 2
      yCor -= step; // same as xCor-=step
    }
    else if (yCor <= 0){
      //direction = 3;//down
      direction = (int)random(3f);
      if (direction == 2){
        direction ++; // only 0,1, or 3
      }
      yCor+=step; // same as xCor-=step
    }
    return true;
     
  }

  void attack() {
    detect();
    //if ( xCor < 0 || xCor > width  || yCor < 0 || yCor > height){
    //  direction = (int) random(4);
    //}
    if (direction % 4 == 0)
      xCor -= step;
    else if (direction % 4 == 1)
      xCor += step;
    else if (direction % 4 == 2)
      yCor -= step;
    else
      yCor += step;
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
    } 
    else
      dying();
  }
       
  void display() {//display() should only display
    circlesTrail.add(createShape(ELLIPSE, xCor, yCor, 50, 80));
                        
    // if we have more than 10 circles remove oldest one
    if ( circlesTrail.size() > noCircles ){
      circlesTrail.remove( 0 );
    }
    
    // draw all the circles (we assumed they'll have been erased by the main draw() function
    // each newer circle gets more opaque
    
    for(int i = 0; i < circlesTrail.size(); i++){  
      PShape c = circlesTrail.get(i);
      c.setStroke(color(0,0,0,(int)i*256.0/circlesTrail.size()));
      c.setFill(color(250,241,68,(int)i*256.0/circlesTrail.size()));
      shape(c);
    }
  }
}
