class Player{
  float xCor, yCor;
  int shieldNum;
  PImage img;
  
  Player(){
    xCor = XSIZE/2;
    yCor = YSIZE/2;
    
    img = loadImage("Hero.png");
    imageMode(CENTER);
    img.resize(40,65);
  }
  
  void display(){
    fill(255);
    pushMatrix();
    translate(xCor,yCor);
    rotate(controlAngle + PI/2); //rotations are always done over the origin
    image(img,0,0);
    popMatrix();
  }
  
  void addShield(){
    shieldNum++;
  }
  
  boolean checkBounds(){
    if( xCor < 0 || xCor > XSIZE) 
      return true;
    if( yCor < 0 || yCor > YSIZE)
      return true;
    return false; 
  }
  
  boolean isDead(Enemy e){
    if(dist(xCor,yCor,e.xCor(),e.yCor()) <  25){
      if(shieldNum > 0){
        shieldNum--;
        return false;
      }
      return true;
    }
    return false;
  }
  
  void move(){
    if( !checkBounds() ){ //if we are inbounds
      xCor += cos(controlAngle)*8.0*controlDistance;
      yCor += sin(controlAngle)*8.0*controlDistance;
    }
    else{ //accounts for out of bounds
      
      if((xCor <= 0)&&(yCor <= 0)){ //corner cases
        if(cos(controlAngle)*8.0*controlDistance >= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if(sin(controlAngle)*8.0*controlDistance >= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
      
      else if((xCor <= 0)&&(yCor >= YSIZE)){
        if(cos(controlAngle)*8.0*controlDistance >= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if(sin(controlAngle)*8.0*controlDistance <= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
      
      else if((xCor >= XSIZE)&&(yCor <= 0)){
        if(cos(controlAngle)*8.0*controlDistance <= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if(sin(controlAngle)*8.0*controlDistance >= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
      
      else if((xCor >= XSIZE)&&(yCor >= YSIZE)){
        if(cos(controlAngle)*8.0*controlDistance <= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if(sin(controlAngle)*8.0*controlDistance <= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
      
      else if(xCor <= 0){
        yCor += sin(controlAngle)*8.0*controlDistance;
        if(cos(controlAngle)*8.0*controlDistance >= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
      }
      
      else if(xCor >= XSIZE){
        yCor += sin(controlAngle)*8.0*controlDistance;
        if(cos(controlAngle)*8.0*controlDistance <= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
      }
      
      else if(yCor <= 0){
        xCor += cos(controlAngle)*8.0*controlDistance;
        if(sin(controlAngle)*8.0*controlDistance >= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
      
      else{
        xCor += cos(controlAngle)*8.0*controlDistance;
        if(sin(controlAngle)*8.0*controlDistance <= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
      
    }
  }
}
