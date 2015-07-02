class Chaser implements Enemy{  
  float xCor;
  float yCor;
  
  Chaser(){
    xCor = random(0,XSIZE);
    yCor = random(0,YSIZE);
  }

  void display(){
    fill(0);
    ellipse(xCor,yCor,50,80);
    
    if(detect())
      attack();
  }
  
  boolean detect(){
    if( dist(xCor,yCor,pxCor,pyCor) < YSIZE/5 ){
      return true;
    }
    return false;
  }
  
  float xCor(){
    return xCor;
  }
  
  float yCor(){
    return yCor;
  }
  
  void dying(){
  }
  
  void merging(){
  }
  
  boolean isAlive(){
    return true;
  }
  
  void attack(){ //nearly identical to Player class' "move()" method
    float speedX = (xCor - pxCor) / 50;
    float speedY= (yCor - pyCor) / 50;
    
    float speed = sqrt(speedX*speedX + speedY*speedY);
    
    speedX = (2*speedX)/speed;
    speedY = (2*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }
}
