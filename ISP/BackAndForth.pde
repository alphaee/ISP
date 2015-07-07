class BackAndForth implements Enemy {  
  float xCor, yCor;
  int direction;
  float step;
  ArrayList circlesTrail;
  final int noCircles = 10;


  BackAndForth() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    direction = (int) random(4);
    step = 5;// May Change to increase speed
    circlesTrail = new ArrayList(); // leaves a trail of poison
    //circlesTrail.add(new CircleClass(xCor,yCor));
    circlesTrail.add(createShape(ELLIPSE, xCor, yCor, 50, 80));
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
    if ( xCor < 0 || xCor > width  || yCor < 0 || yCor > height){
      direction = (int) random(4);
    }
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
    circlesTrail.add(createShape(ELLIPSE, xCor, yCor, 50, 80));
                        
    // if we have more than 10 circles remove oldest one
    if ( circlesTrail.size() > noCircles ){
      circlesTrail.remove( 0 );
    }
    
    // draw all the circles (we assumed they'll have been erased by the main draw() function
    // each newer circle gets more opaque
    for( int i = 0; i < circlesTrail.size(); i += 1){  
      PShape c = (PShape)circlesTrail.get(i);
      c.setStroke(color(0,0,0,(int)i*256.0/circlesTrail.size()));
      c.setFill(color(250,241,68,(int)i*256.0/circlesTrail.size()));
      shape(c);
    }
  }
}
