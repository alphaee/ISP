class Player{
  float xCor, yCor;
  
  Player(){
    xCor = XSIZE/2;
    yCor = YSIZE/2;
  }
  
  void display(){
    ellipse(xCor,yCor,30,30);
  }
  
}
