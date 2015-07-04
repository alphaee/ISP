class Joystick {
  float xCor;
  float yCor;

  int xSize;
  int ySize;

  float stickXCor;
  float stickYCor;

  int outerRadius; //these are actually diameters
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
    noFill();
    stroke(255,233,26);
    strokeWeight(10);
    ellipse(xCor - XCHANGE, yCor - YCHANGE, outerRadius, outerRadius);
    if(pause)
      pause();
    else
      limitStick();
    strokeWeight(5);
    ellipse(stickXCor - XCHANGE, stickYCor - YCHANGE, stickRadius, stickRadius);
    strokeWeight(1);
    stroke(0);
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
    return sqrt((stickXCor-xCor)*(stickXCor-xCor) + (stickYCor-yCor)*(stickYCor-yCor)) / (outerRadius/2); //distance between stick circle and outer circle divided by the maximum distance; gives you proportion
  }
  
  void limitStick() {
    stickXCor = cos(calcAngle()) * min(outerRadius/2,abs(mouseX - xCor)) + xCor;
    stickYCor = sin(calcAngle()) * min(outerRadius/2,abs(mouseY - yCor)) + yCor;
  }
}
