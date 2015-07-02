class Player{
  float xCor, yCor;
  
  Player(){
    xCor = XSIZE/2;
    yCor = YSIZE/2;
  }
  
  void display(){
    fill(255);
    ellipse(xCor,yCor,50,50);
  }
  
  boolean checkBounds(){
    if( xCor < 0 || xCor > XSIZE) 
      return true;
    if( yCor < 0 || yCor > YSIZE)
      return true;
    return false; 
  }
  
  void move(){
    if( !checkBounds() ){ //if we are inbounds
      xCor += cos(controlAngle)*.07*controlDistance;
      yCor += sin(controlAngle)*.07*controlDistance;
    /*
      float destX = mouseX - XSIZE/3 + pxCor; //account for the translating done in ISP
      float destY = mouseY - YSIZE/3 + pyCor; 
      
      float speedX = (xCor - destX); 
      float speedY = (yCor - destY);
      
      float speed = sqrt(speedX*speedX + speedY*speedY); //distance formula 
      
      speedX = (8 * speedX)/speed; //CHANGE THIS CONSTANT TO INCREASE SPEED
      speedY = (8 * speedY)/speed;
      
      xCor -= speedX;
      yCor -= speedY;*/
    }
    else{ //accounts for out of bounds
      
    }
  }
}
