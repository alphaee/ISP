//Young Kim, Dan Kim, Franklin Wang

//FIXED CONSTANTS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int XSIZE, YSIZE;
float XCHANGE, YCHANGE;
final int fps = 60;

//PLAYER VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Player hero;
float pxCor, pyCor; //Player x-cor and y-cor
int iCounter; //Invincibility

//ENEMY VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ArrayList<Enemy>[] enemies; 
final int enemySize = 3;
/*
  Indices:
 0: Chasers
 1: Back&Forth-s
 2: Bouncers
 */

final int chaserTime = (int)fps*15;

final int backAndForthTime = (int)fps*5;

final int bouncerTime = (int)fps*7;



//POWERUP VARS------------------------------------
ArrayList<Powerup>[] powerups;
final int powerupSize = 3;

/*
  Indices:
 0: Shield
 1: Mine
 */

final int shieldTime = (int)fps*30;

final int mineTime = (int)fps*15;

final int railgunTime = (int)fps*10;

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
int counter;

boolean start;
int startMillis;

void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);

  XSIZE = (int)(displayWidth*1.4); //You want the gamebox size to be larger than the size of the screen
  YSIZE = (int)(displayHeight*1.4);

  hero = new Player();
  thumbCircle = new Joystick();

  enemies = (ArrayList<Enemy>[])new ArrayList[enemySize];

  for (int i = 0; i < enemySize; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  for (int i = 0; i < 10; i ++) { //FOR TESTING PURPOSES ONLY
    Chaser temp = new Chaser();
    enemies[0].add(temp);
    BackAndForth temp2 = new BackAndForth();
    enemies[1].add(temp2);
    Bouncer temp3 = new Bouncer();
    enemies[2].add(temp3);
  }

  powerups = (ArrayList<Powerup>[])new ArrayList[powerupSize];

  for (int i = 0; i < powerupSize; i ++) {
    powerups[i] = new ArrayList<Powerup>();
  }
  counter = 0;
  frameRate(fps);
  start = true;
  startMillis = millis();
}

void draw() {
  switch(state) {
  case 0: //HOMESCREEN
    background(0);
    textSize(displayHeight/6);
    textAlign(CENTER, CENTER);
    fill(#32CCD8);
    text("I.S.P", displayWidth/2, displayHeight/4);
    textSize(displayHeight/15);
    text("DanTheMan, CDelano, and Franklin", displayWidth/2, displayHeight/2);
    text("(Click to Continue!)", displayWidth/2, 3*displayHeight/4);
    if (mousePressed) {
      state = 1;
      start = true;
      startMillis = millis();
    }
    break;

  case 1: //MAIN GAME
    background(0);
    updatePlayerCors(); //update coordinates before applying translations
    //also updates XCHANGE & YCHANGE
    translate(XCHANGE, YCHANGE);

    createBoundary();

    displayStuff();

    displayAll();

    if (start) {
      countdown(startMillis);
    } else {
      if (touchDetection()) {
        checkPowerupCounter();
        // checkEnemyCounter();
        enemiesAttack();
        enemiesCollide();
        checkShield();
        mineCollision();
        railgunCollision();
        iCounter++;
        counter++;
      }
      hero.move();
      checkDeath();
    }
    break;

  case 2: //GAME OVER
    background(0);
    textSize(displayHeight/8);
    textAlign(CENTER, CENTER);
    fill(#32CCD8);
    text("High Scores", displayWidth/2, displayHeight/7);
    textSize(displayHeight/15);
    textAlign(LEFT);
    text("1", displayWidth/10, displayHeight/3);
    text("2", displayWidth/10, displayHeight/3+displayHeight/7);
    text("3", displayWidth/10, displayHeight/3+2*displayHeight/7);
    text("You", displayWidth/10, displayHeight/3 + 3*displayHeight/7);
    fill(#D130A4);
    rect(displayHeight/30, displayHeight/30, displayWidth/5, displayHeight/8);
    fill(#5BD832);
    rect(4*displayWidth/5-displayHeight/30, displayHeight/30, displayWidth/5, displayHeight/8);
    break;
  }
}

void countdown(int t) {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  if (millis() - t < 1500)
    text("3", pxCor, pyCor);
  else if (millis() - t < 2500)
    text("2", pxCor, pyCor);
  else if (millis() - t < 3500)
    text("1", pxCor, pyCor);
  else
    start = false;
}

void mouseReleased() {
  if (get(mouseX, mouseY)==#D130A4)
    state = 0;
  if (get(mouseX, mouseY)==#5BD832)
    state = 1;
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

void displayStuff() {
  fill(100);
  textSize(displayHeight/15);
  textAlign(CENTER, CENTER);
  text("Shield: " + hero.shieldNum, pxCor + 3*displayWidth/8, pyCor - 3*displayHeight/8);
}

void displayAll() {
  thumbCircle.display();
  hero.display();

  for (int i = 0; i < enemySize; i ++) //2-D parsing
    for (Enemy e : enemies[i])
      e.display();

  for (int i = 0; i < powerupSize; i ++) //2-D parsing
    for (Powerup p : powerups[i])
      p.display();
}

void enemiesAttack() {
  for (int i = 0; i < enemySize; i ++) //2-D parsing
    for (Enemy e : enemies[i])
      e.attack();
}

void enemiesCollide() {
  for (int i = 0; i < enemies[1].size (); i ++)
    for (int j = i+1; j < enemies[1].size (); j ++)
      enemies[1].get(i).event(enemies[1].get(j), i, j);
}

void checkShield() {
  for (int i = 0; i < powerups[0].size (); i ++) {
    if (powerups[0].get(i).detect()) {
      hero.addShield();
      powerups[0].get(i).dying();
      powerups[0].remove(i);
      i--;
    }
  }
}

void mineCollision() {
  for (int i = 0; i < enemySize; i ++) {
    for (int j = 0; j < enemies[i].size (); j ++) {
      for (int k = 0; k < powerups[1].size (); k ++) {
        if (((Mine)powerups[1].get(k)).exploded)
          ((Mine)powerups[1].get(k)).exploding ++;
        if (enemies[i].size()>0)
          if (powerups[1].get(k).event(enemies[i].get(j))) {
            println(i, j, k);
            enemies[i].get(j).dying(i, j);
            j--;
            if (j<0)
              j=0;
          }
      }
    }
  }
}

void railgunCollision() {
  for (int i = 0; i < enemySize; i ++) {
    for (int j = 0; j < enemies[i].size (); j ++) {
      for (int k = 0; k < powerups[1].size (); k ++) {     
        if (enemies[i].size()>0)
          if (powerups[2].get(k).event(enemies[i].get(j))) {
            println(i, j, k);
            enemies[i].get(j).dying(i, j);
            j--;
            if (j<0)
              j=0;
          }
      }
    }
  }
}

void checkPowerupCounter() {
  if (counter%shieldTime==0) {
    Shield temp = new Shield();
    powerups[0].add(temp);
  }
  if (counter%mineTime==0) {
    Mine temp = new Mine();
    powerups[1].add(temp);
  }
  if (counter%railgunTime==0) {
    Railgun temp = new Railgun();
    powerups[2].add(temp);
  }
}

void checkEnemyCounter() {
  if (counter%chaserTime==0) {
    Chaser temp = new Chaser();
    enemies[0].add(temp);
  }
  if (counter%backAndForthTime==0) {
    BackAndForth temp = new BackAndForth();
    enemies[1].add(temp);
  }
}

void checkDeath() {
  for (int i = 0; i < enemySize; i ++) { //2-D parsing
    for (Enemy e : enemies[i]) {
      if (hero.isDead(e)) {
        state = 2;
        setup();
      }
    }
  }
}

