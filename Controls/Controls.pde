
float controlAngle;
float controlDistance;

Joystick thumbCircle;
Player hero;

void setup() {
  size(500, 500);
  hero = new Player();
  thumbCircle = new Joystick();
}

void draw() {
  background(130);
  controlAngle = thumbCircle.calcAngle();
  controlDistance = thumbCircle.calcDistance();
  if (mousePressed) {
    thumbCircle.display();
    hero.move();
  }
  hero.display();
}
