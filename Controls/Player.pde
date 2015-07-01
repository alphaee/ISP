class Player {
  float xCor;
  float yCor;

  Player() {
    xCor = width/2;
    yCor = height/2;
  }

  void display() {
    ellipse(xCor, yCor, 50, 50);
  }

  void move() {
    xCor += cos(controlAngle)*.07*controlDistance;
    yCor += sin(controlAngle)*.07*controlDistance;
  }
}
