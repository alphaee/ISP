
import java.util.ArrayList;  // needed to 
import java.util.ListIterator;

import processing.core.*;

/**
 *  CircleClass: a simple container to hold the location of 
 *  the center of the circle, and the frameCount when it 
 *  appears on the applet, as the frameCount is used to
 *  define the rate at which the circles "breathes".
 */
class CircleClass {
        public float x;
        public float y;
        public int   frameCount;
        
        CircleClass( float xx, float yy, int fc ) {
                x = xx;
                y = yy;
                frameCount = fc;
        }
        
        public void draw( PApplet p ) {
                float radius1 = 50 + 30 * p.sin( frameCount * 0.05f );
                float radius2 = 50 + 30 * p.sin( frameCount * 0.05f );
                p.ellipse( x, y, radius1, radius2 );
        }
}

/**
 * Main3: the main Processing applet.
 *
 */
public class FadingTrails extends PApplet {

        ArrayList circles;
        
        /**
         * setup().  Sets the applet up.
         */
        public void setup(){
          size(800,600);           // Size of Background/panel
          background( 0xeeeeff );   //Color of Background, Black
          frameRate(30);    //Frame rate set at 30

          circles = new ArrayList();
        }

        
        /**
         * draw(): called to draw every frame.
         * draws a circle where ever the mouse is.  
         */
        public void draw() {        
          // erase the applet
          background( 0xeeeeff );
          
          // add a new circle to the end of the list
          circles.add( new CircleClass( mouseX, mouseY, frameCount ) );
                  
          // remove oldest (first) circle if more than 10
          if ( circles.size() > 10 )
                  circles.remove( 0 );
          
          // display the circles 
          /*
          stroke( 0 );   // black outline
          fill( 255 );   // white interior
          for ( Iterator< CircleClass > it = circles.iterator(); it.hasNext(); ) {
                  CircleClass c = it.next();
                  c.draw( this );
          }
          */
          //for ( int i = circles.size()-1; i >= 0; i = i - 1 ) {
            //CircleClass c = circles.get( i );
          for( int i = circles.size()-1; i >= 0; i = i - 1){
            CircleClass c = (CircleClass)circles.get(i);  
            stroke(0,(int)i*256/circles.size());
            fill(255,(int)i*256/circles.size());
            c.draw(this);
          }
        }
}
