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
  /*
    //get the last circle we added to the tail
    CircleClass last = (CircleClass) circlesTrail.get(circlesTrail.size() - 1);
    
    //get its center coordinates
    float x = last.x;
    float y = last.y;
    
    if (direction%4 == 0)
      x-=step;
    else if (direction%4 == 1)
      x+=step;
    else if (direction%4 == 2)
      y-=step;
    else
      y+=step;
    */                    
    // add a new circle at the new location
    //circlesTrail.add( new CircleClass( x, y) );
    circlesTrail.add(createShape(ELLIPSE, xCor, yCor, 50, 80));
                        
    // if we have more than 10 circles remove oldest one
    if ( circlesTrail.size() > noCircles ){
      circlesTrail.remove( 0 );
    }
    
    // draw all the circles (we assumed they'll have been erased by the main draw() function
    for( int i = circlesTrail.size()-1; i >= 0; i = i - 1){  
      PShape c = (PShape)circlesTrail.get(i);
      stroke(0,(int)i*256/circlesTrail.size());
      fill(255,(int)i*256/circlesTrail.size());
      shape(c);
    }
  }
}
/**
 *  CircleClass: a simple container to hold the location of 
 *  the center of the circle, and the frameCount when it 
 *  appears on the applet, as the frameCount is used to
 *  define the rate at which the circles "breathes".
 *
class CircleClass {

        public float      x;
        public float      y;
        public int  frameCount;
        
        CircleClass( float xx, float yy){//, int fc ) {
                
                x = xx;
                y = yy;
                //frameCount = fc;
        }

        public void draw() {
                float radius1 = 50;// + 30 * p.sin( frameCount * 0.05f );
                float radius2 = 80;// + 30 * p.sin( frameCount * 0.05f );
                ellipse( x, y, radius1, radius2 );            
        }
}
*/
