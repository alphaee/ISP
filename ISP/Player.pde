class Player {
  float xCor, yCor;
  int shieldNum;
  PImage img, img2, img3, img4;

  Player() {
    xCor = XSIZE/2;
    yCor = YSIZE/2;

    img = loadImage("Hero.png");
    img2 = loadImage("Shielded-Hero1.png");
    img3 = loadImage("Shielded-Hero2.png");
    img4 = loadImage("Shielded-Hero3.png");
    imageMode(CENTER);
    img.resize(55, 65);
    img2.resize(55, 65);
    img3.resize(55, 65);
    img4.resize(55, 65);
  }

  void display() {
    fill(255);
    pushMatrix();
    translate(xCor, yCor);
    rotate(controlAngle + PI/2); //rotations are always done over the origin
    if((iCounter < frameRate/2)&&(counter > frameRate/2)){
      if(iCounter % 2 == 0){
        if (shieldNum == 0)
          image(img, 0, 0);
        else if (shieldNum == 1)
          image(img2, 0, 0);
        else if (shieldNum == 2)
          image(img3, 0, 0);
        else 
          image(img4, 0, 0);
      }
    }
    else{
      if (shieldNum == 0)
        image(img, 0, 0);
      else if (shieldNum == 1)
        image(img2, 0, 0);
      else if (shieldNum == 2)
        image(img3, 0, 0);
      else 
        image(img4, 0, 0);
    }
    popMatrix();
  }

  void addShield() {
    if (shieldNum <= 2)
      shieldNum++;
  }

  boolean checkBounds() {
    if ( xCor < 0 || xCor > XSIZE) 
      return true;
    if ( yCor < 0 || yCor > YSIZE)
      return true;
    return false;
  }

  boolean isDead(Enemy e) {
    if (dist(xCor, yCor, e.xCor(), e.yCor()) <  25 &&  iCounter>frameRate/2) {
      iCounter = 0;
      if (shieldNum > 0) {
        shieldNum--;
        return false;
      }
      return true;
    }
    return false;
  }

  void move() {
    if ( !checkBounds() ) { //if we are inbounds
      xCor += cos(controlAngle)*8.0*controlDistance;
      yCor += sin(controlAngle)*8.0*controlDistance;
    } else { //accounts for out of bounds

      if ((xCor <= 0)&&(yCor <= 0)) { //corner cases
        if (cos(controlAngle)*8.0*controlDistance >= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if (sin(controlAngle)*8.0*controlDistance >= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      } else if ((xCor <= 0)&&(yCor >= YSIZE)) {
        if (cos(controlAngle)*8.0*controlDistance >= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if (sin(controlAngle)*8.0*controlDistance <= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      } else if ((xCor >= XSIZE)&&(yCor <= 0)) {
        if (cos(controlAngle)*8.0*controlDistance <= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if (sin(controlAngle)*8.0*controlDistance >= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      } else if ((xCor >= XSIZE)&&(yCor >= YSIZE)) {
        if (cos(controlAngle)*8.0*controlDistance <= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
        if (sin(controlAngle)*8.0*controlDistance <= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      } else if (xCor <= 0) {
        yCor += sin(controlAngle)*8.0*controlDistance;
        if (cos(controlAngle)*8.0*controlDistance >= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
      } else if (xCor >= XSIZE) {
        yCor += sin(controlAngle)*8.0*controlDistance;
        if (cos(controlAngle)*8.0*controlDistance <= 0)
          xCor += cos(controlAngle)*8.0*controlDistance;
      } else if (yCor <= 0) {
        xCor += cos(controlAngle)*8.0*controlDistance;
        if (sin(controlAngle)*8.0*controlDistance >= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      } else {
        xCor += cos(controlAngle)*8.0*controlDistance;
        if (sin(controlAngle)*8.0*controlDistance <= 0)
          yCor += sin(controlAngle)*8.0*controlDistance;
      }
    }
  }
}

