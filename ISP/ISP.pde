//Young Kim, Dan Kim, Franklin Wang

//FIXED CONSTANTS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int XSIZE, YSIZE;
float XCHANGE, YCHANGE;

//PLAYER VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Player hero;
float pxCor, pyCor; //Player x-cor and y-cor

//ENEMY VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ArrayList<Enemy>[] enemies; 
final int arraySize = 3;
/*
  Indices:
 0: Chasers
 1: Back&Forth-s
 2: Bouncers
 */

//JOYSTICK VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Joystick thumbCircle;
float controlAngle;
float controlDistance;

//MISC~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int state;
/*
  STATE 0: HOMESCREEN
 STATE 1: GAME
 STATE 2: GAME OVER
 */

void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);

  XSIZE = (int)(displayWidth*1.4); //You want the gamebox size to be larger than the size of the screen
  YSIZE = (int)(displayHeight*1.4);

  hero = new Player();
  thumbCircle = new Joystick();

  enemies = (ArrayList<Enemy>[])new ArrayList[arraySize];

  for (int i = 0; i < arraySize; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  for (int i = 0; i < 10; i ++) { //FOR TESTING PURPOSES ONLY
    Chaser temp = new Chaser();
   // enemies[0].add(temp);
    BackAndForth temp2 = new BackAndForth();
    enemies[1].add(temp2);
    Bouncer temp3 = new Bouncer();
    enemies[2].add(temp3);
  }
}

void draw() {
  switch(state) {
  case 0: //HOMESCREEN
    background(0);
    textSize(displayHeight/6);
    textAlign(CENTER, CENTER);
    text("I.S.P", displayWidth/2, displayHeight/4);
    textSize(displayHeight/15);
    text("DanTheMan, CDelano, and Franklin", displayWidth/2, displayHeight/2);
    text("(Click to Continue!)", displayWidth/2, 3*displayHeight/4);
    if (mousePressed) {
      state = 1;
    }
    break;

  case 1: //MAIN GAME
    background(0);
    updatePlayerCors(); //update coordinates before applying translations
    //also updates XCHANGE & YCHANGE
    translate(XCHANGE, YCHANGE);

    createBoundary();

    displayAll();

    if (touchDetection()) {
      enemiesAttack();
      enemiesCollide();
    }
    hero.move();
    checkDeath();
    break;

  case 2: //GAME OVER
    break;
  }
}

boolean sketchFullScreen() { //Necessary to start in full screen
  return true;
}

void updatePlayerCors() {
  pxCor = hero.xCor;
  pyCor = hero.yCor;
  XCHANGE = XSIZE/2.8 - pxCor;
  YCHANGE = YSIZE/2.8 - pyCor;
}

void createBoundary() {
  stroke(204, 102, 0); 
  fill(180);
  rect(0, 0, XSIZE, YSIZE);
  stroke(0);
}

boolean touchDetection() {
  if (mousePressed) {
    thumbCircle.pause = false;
    controlAngle = thumbCircle.calcAngle();
    controlDistance = thumbCircle.calcDistance();
    return true;
  } else {
    fill(0, 153, 204, 200);
    rect(-XCHANGE, -YCHANGE+displayHeight/4, displayWidth, displayHeight/2);
    fill(15);
    textSize(displayHeight/6);
    textAlign(CENTER, CENTER);
    text("Play to Resume!", displayWidth/2-XCHANGE, displayHeight/2-YCHANGE);
    thumbCircle.pause = true;
    controlAngle = 0;
    controlDistance = 0;
    noTint();
    return false;
  }
}

void displayAll() {
  thumbCircle.display();
  hero.display();

  for (int i = 0; i < arraySize; i ++) //2-D parsing
    for (Enemy e : enemies[i])
      e.display();
}

void enemiesAttack() {
  for (int i = 0; i < arraySize; i ++) //2-D parsing
    for (Enemy e : enemies[i])
      e.attack();
}

void enemiesCollide() {
  for (int i = 0; i < enemies[1].size(); i ++)
    for (int j = i+1; j < enemies[1].size(); j ++)
      enemies[1].get(i).event(enemies[1].get(j),i,j);
}



void checkDeath() {
  for (int i = 0; i < arraySize; i ++) { //2-D parsing
    for (Enemy e : enemies[i]) {
      if (hero.isDead(e)) {
        text("Dead!", displayWidth/2-XCHANGE, displayHeight/4-YCHANGE);
        //state = 2;
      }
    }
  }
}
