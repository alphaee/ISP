class Enemy{ 
  float xCor, yCor;  
  
  Enemy(){
    xCor = random(XSIZE);
    yCor = random(YSIZE);
  }

  void display(){
    fill(0);
    move();
    ellipse(xCor,yCor,50,80);
  }
  
  void move(){
    float speedX = (xCor - pxCor) / 50;
    float speedY= (yCor - pyCor) / 50;
    float speed = sqrt(speedX*speedX + speedY*speedY);
    speedX = (2*speedX)/speed;
    speedY = (2*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }
}
