class Joystick {
  float xCor;
  float yCor;

  int xSize;
  int ySize;

  float stickXCor;
  float stickYCor;

  int outerRadius;
  int stickRadius;

  Joystick() {
    xSize = width;
    ySize = height;
    xCor =  4 * xSize/5;
    yCor =  3 * ySize/4;
    outerRadius = (int)ySize/5;
    stickRadius = (int)ySize/10;
  }

  void display() {
    fill(255);
    ellipse(xCor, yCor, outerRadius, outerRadius);
    limitStick();
    ellipse(stickXCor, stickYCor, stickRadius, stickRadius);
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
