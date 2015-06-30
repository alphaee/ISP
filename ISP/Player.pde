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
    float destX = mouseX;
    float destY = mouseY;
    float speedX = (xCor - destX) / 15;
    float speedY= (yCor - destY) / 15;
    float speed = sqrt(speedX*speedX + speedY*speedY);
    speedX = (4*speedX)/speed;
    speedY = (4*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }
}
