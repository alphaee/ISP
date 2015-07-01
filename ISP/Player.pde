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
  
  void move(){
    float destX = mouseX - XSIZE/3 + pxCor; //account for the translating done in ISP
    float destY = mouseY - YSIZE/3 + pyCor; 
    
    float speedX = (xCor - destX) / 15; //arbitrary constant to determine the amount to travel 
    float speedY= (yCor - destY) / 15;
    
    float speed = sqrt(speedX*speedX + speedY*speedY); //distance formula 
    
    speedX = (4*speedX)/speed; //more arbitrary stuff 
    speedY = (4*speedY)/speed;
    
    xCor -= speedX;
    yCor -= speedY;
  }
}
