class Joystick {
  float xCor;
  float yCor;

  int xSize;
  int ySize;

  float stickXCor;
  float stickYCor;

  int outerRadius;
  int stickRadius;
  
  boolean pause;

  Joystick() {
    xSize = displayWidth;
    ySize = displayHeight;
    xCor =  5 * xSize/6;
    yCor =  3 * ySize/4;
    outerRadius = (int)ySize/5;
    stickRadius = (int)ySize/10;
  }

  void display() {
    fill(255);
    ellipse(xCor - XCHANGE, yCor - YCHANGE, outerRadius, outerRadius);
    if(pause)
      pause();
    else
      limitStick();
    ellipse(stickXCor - XCHANGE, stickYCor - YCHANGE, stickRadius, stickRadius);
  }
  
  void pause(){ //when player lifts his hand from the joystick
    stickXCor = xCor;
    stickYCor = yCor;
  }
  
  float calcAngle() {
    float x = (mouseX - xCor);
    float y = (mouseY - yCor);    
    if (x >= 0 && y >= 0)
      return atan(y / x);
    else if (x < 0 && y >= 0)
      return atan(y / x) + PI;
    else if (x < 0 && y < 0)
      return atan(y / x) + PI;
    else if (x >= 0 && y < 0) 
      return atan(y / x) + 2*PI;
    return 0;
  }
  
  float calcDistance(){
    return sqrt((stickXCor-xCor)*(stickXCor-xCor) + (stickYCor-yCor)*(stickYCor-yCor));
  }
  
  void limitStick() {
    stickXCor = cos(calcAngle()) * min(outerRadius/2,abs(mouseX - xCor)) + xCor;
    stickYCor = sin(calcAngle()) * min(outerRadius/2,abs(mouseY - yCor)) + yCor;
  }
}
