class Enemy{ 
  float xCor, yCor;  
  
  Enemy(){
    xCor = random(XSIZE); //spawn inside the boundaries
    yCor = random(YSIZE);
  }

  void display(){
    fill(0);
    ellipse(xCor,yCor,50,80);
    
    if(detect())
      chase();
    else
      move();
  }
  
  boolean detect(){
    if( dist(xCor,yCor,pxCor,pyCor) < YSIZE/5 ){
      return true;
    }
    return false;
  }
  
  void chase(){ //nearly identical to Player class' "move()" method
    float speedX = (xCor - pxCor) / 50;
    float speedY= (yCor - pyCor) / 50;
    
    float speed = sqrt(speedX*speedX + speedY*speedY);
    
    speedX = (2*speedX)/speed;
    speedY = (2*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }
  
  void move(){
  }
}
