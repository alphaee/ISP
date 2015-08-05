import java.io.*;
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

final int backAndForthTime = (int)fps*3;

final int bouncerTime = (int)fps*7;

//ENEMY ANIMATIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Animation chas_dying;
Animation baf_moving_hori;
Animation baf_moving_vert;
Animation baf_dying; 
Animation bounce_moving;
Animation bounce_dying;

//POWERUP VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ArrayList<Powerup>[] powerups;
final int powerupSize = 3;

/*
 Indices:
 0: Shield
 1: Mine
 2: Railgun
 */

final int shieldTime = (int)fps*30;

final int mineTime = (int)fps*10;

final int railgunTime = (int)fps*10;

PImage shield;
PImage mineActive;
PImage minePassive;

//JOYSTICK VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Joystick thumbCircle;
float controlAngle;
float controlDistance;

//HOME SCREEN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PImage button_play;
PImage button_instructions;
PImage button_credits;

//HIGH SCORE SCREEN~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String scores[] = new String[3];

PImage reset;
PImage home;

//MISC~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int state;
/*
 STATE 0: HOMESCREEN
 STATE 1: GAME
 STATE 2: GAME OVER
 */
int counter;
int score;

boolean active; //create a delay so button-spamming doesn't happen
int activeMillis;

boolean start;
int startMillis;

PFont font;

void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);

  XSIZE = (int)(displayWidth*1.4); //You want the gamebox size to be larger than the size of the screen
  YSIZE = (int)(displayHeight*1.4);

  thumbCircle = new Joystick();

  enemies = (ArrayList<Enemy>[])new ArrayList[enemySize];

  powerups = (ArrayList<Powerup>[])new ArrayList[powerupSize];

  frameRate(fps);

  //loading animations
  chas_dying = new Animation("DieRed", 7, 240, 200);
  baf_dying = new Animation("DieYellow", 5, 240, 200);
  baf_moving_hori = new Animation("MovingYellow", 13, 180, 150);
  baf_moving_vert = new Animation("MovingYellowVert", 13, 150, 180);
  bounce_moving = new Animation("MovingGreen", 13, 240, 200);
  bounce_dying = new Animation("DieGreen", 10, 240, 200);

  //home screen
  button_play = loadImage("Button_Play.png");
  button_instructions = loadImage("Button_Instructions.png");
  button_credits = loadImage("Button_Credits.png");
  //button_play.resize(displayWidth/4,displayHeight/7);

  //high score screen
  reset = loadImage("Reset_Button.png");
  home = loadImage("Home_Button.png");
  home.resize(displayHeight/7, displayHeight/7);
  reset.resize(displayHeight/7, displayHeight/7);

  //powerups
  shield = loadImage("Shield.png");
  shield.resize(60, 60);
  mineActive = loadImage("LandMineActivated1.png");
  mineActive.resize(65, 65);
  minePassive = loadImage("LandMine1.png");
  minePassive.resize(65, 65);

  font = loadFont("Kuro-Regular-120.vlw");
  textFont(font);

  active = true;
}

void setup2() {
  hero = new Player();

  for (int i = 0; i < enemySize; i++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  for (int i = 0; i < powerupSize; i++) {
    powerups[i] = new ArrayList<Powerup>();
  }

  for (int i = 0; i < 2; i ++) { //FOR TESTING PURPOSES ONLY
    Chaser temp = new Chaser();
    enemies[0].add(temp);
    //    BackAndForth temp2 = new BackAndForth();
    //     enemies[1].add(temp2);
    //Bouncer temp3 = new Bouncer();
    //enemies[2].add(temp3);
  }

  counter = 0;

  start = true;
  startMillis = millis();
  score = 0;
}

void draw() {
  println("running" + counter);
  switch(state) {

  case 00: //HOMESCREEN
    background(0);

    fill(#647775);
    rectMode(CENTER);
    //rect(displayWidth/2, displayHeight/2, displayWidth/3, displayHeight/7, displayHeight/20);
    rectMode(CORNER);

    textAlign(CENTER, CENTER);
    fill(#32CCD8);
    textSize(displayHeight/8);
    text("I.S.P.", displayWidth/2, displayHeight/8);
    textSize(displayHeight/22);
    imageMode(CENTER);
    text("Play", displayWidth/2, displayHeight/2 - displayHeight*2/25);
    text("Instructions", displayWidth/2, displayHeight/2 + displayHeight*3/25);
    text("Credits", displayWidth/2, displayHeight/2 + displayHeight*8/25);

    stroke(255);
    line(0, displayHeight/2 - displayHeight*2/25 - displayHeight/10, displayWidth, displayHeight/2 - displayHeight*2/25 - displayHeight/10);
    line(0, displayHeight/2 - displayHeight*2/25 + displayHeight/10, displayWidth, displayHeight/2 - displayHeight*2/25 + displayHeight/10);
    line(0, displayHeight/2 - displayHeight*2/25 + displayHeight*3/10, displayWidth, displayHeight/2 - displayHeight*2/25 + displayHeight*3/10);
    line(0, displayHeight/2 - displayHeight*2/25 + displayHeight*5/10, displayWidth, displayHeight/2 - displayHeight*2/25 + displayHeight*5/10);

    if (!active) {
      if (millis() - activeMillis > 500)
        active = !active;
    }

    if (mousePressed && active) {
      active = false;
      activeMillis = millis();
      if (mouseY > displayHeight/2 - displayHeight*2/25 + displayHeight*3/10)
        state = 02;
      else if (mouseY > displayHeight/2 - displayHeight*2/25 + displayHeight/10)
        state = 01;
      else if (mouseY > displayHeight/2 - displayHeight*2/25 - displayHeight/10) {
        state = 10;
        setup2();
        start = true;
        startMillis = millis();
      }
    }
    break;

  case 01: //INSTRUCTIONS
    fill(150);
    rectMode(CENTER);
    rect(displayWidth/2, displayHeight/2, displayWidth*9/10, displayHeight*9/10, 30);

    fill(#32CCD8);
    textSize(displayHeight/8);
    textAlign(CENTER, CENTER);
    text("Instructions", displayWidth/2, displayHeight/7);

    textSize(displayHeight/25);
    textAlign(LEFT);
    fill(0);
    text("Welcome to I.S.P.!", displayWidth/4, displayHeight/5 + displayHeight*2/20);
    text("Controls are self-explanatory, just use the", displayWidth/4, displayHeight/5 + displayHeight*4/20);
    text("thumbstick to move.", displayWidth/3, displayHeight/5 + displayHeight*5/20);
    text("To pause, just let go of the thumbstick at any time.", displayWidth/4, displayHeight/5 + displayHeight*6/20);

    textAlign(CENTER, CENTER);
    text("Tap Anywhere To Return!", displayWidth/2, displayHeight*6/7);

    if (!active) {
      if (millis() - activeMillis > 500)
        active = !active;
    }

    if (mousePressed && active) {
      state = 00;
      active = false;
      activeMillis = millis();
    }
    break;

  case 02: //CREDITS
    fill(150);
    rectMode(CENTER);
    rect(displayWidth/2, displayHeight/2, displayWidth*9/10, displayHeight*9/10, 30);

    fill(#32CCD8);
    textSize(displayHeight/8);
    textAlign(CENTER, CENTER);
    text("Credits", displayWidth/2, displayHeight/7);

    textSize(displayHeight/25);
    textAlign(LEFT);
    fill(0);
    text("Designed by cdelano, alphaee, boao", displayWidth/4, displayHeight/5 + displayHeight*4/20);
    text("AKA Young Kim, Dan Kim, Franklin Wang.", displayWidth/3, displayHeight/5 + displayHeight*5/20);

    textAlign(CENTER, CENTER);
    text("Tap Anywhere To Return!", displayWidth/2, displayHeight*6/7);

    if (!active) {
      if (millis() - activeMillis > 500)
        active = !active;
    }

    if (mousePressed && active) {
      state = 00;
      active = false;
      activeMillis = millis();
    }
    break;

  case 10: //MAIN GAME
    background(0);
    updatePlayerCors(); //update coordinates before applying translations; also updates XCHANGE & YCHANGE
    translate(XCHANGE, YCHANGE);

    createBoundary();

    displayAll();

    if (start) {
      countdown(startMillis);
    } 
    else {
      if (touchDetection()) {
        checkPowerupCounter();
        //checkEnemyCounter();
        enemiesAttack();
        enemiesCollide();
        checkShield();
        mineCollision();
        mineExploding();
        railgunCollision();
        railgunMove();
        iCounter++;
        counter++;
      }
      hero.move();
      checkDeath();
    }
    break;

  case 20: //GAME OVER
    background(0);
    textFont(font);
    textSize(displayHeight/9);         
    textAlign(CENTER, CENTER);         
    fill(#32CCD8);
    text("High Scores", displayWidth/2, displayHeight/11);

    textSize(displayHeight/20);      
    textAlign(LEFT);
    text("1st: ", displayWidth/3, displayHeight/4);
    text("2nd: ", displayWidth/3, displayHeight/4+ displayHeight/10);
    text("3rd: ", displayWidth/3, displayHeight/4+ 2*displayHeight/10);
    text("You: ", displayWidth/3, displayHeight/4 + 3*displayHeight/9);
    textAlign(RIGHT);
    text(scores[0], 2*displayWidth/3, displayHeight/4);
    text(scores[1], 2*displayWidth/3, displayHeight/4+ displayHeight/10);
    text(scores[2], 2*displayWidth/3, displayHeight/4+ 2*displayHeight/10);
    text(score*100, 2*displayWidth/3, displayHeight/4 + 3*displayHeight/9);

    imageMode(CORNER);
    fill(#D130A4, 0);
    image(home, displayWidth/5, displayHeight*3/4);
    rect(displayHeight/20, displayHeight/20, displayHeight/7, displayHeight/7);
    fill(#5BD832, 0);
    image(reset, displayWidth*4/5-displayHeight/7, displayHeight*3/4);
    rect(displayWidth-displayHeight/7-displayHeight/20, displayHeight/20, displayHeight/7, displayHeight/7);
    break;
  }
}

void keyPressed() {
  if (key == 'm') {
    Mine m = new Mine(1);
    powerups[1].add(m);
  }
  if (key == 'r') {
    setup2();
  }
  if (key == ' ') {
    Railgun r = new Railgun(1);
    powerups[2].add(r);
  }
}

void countdown(int t) {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  textFont(font);
  if (millis() - t < 1500)
    text("3", pxCor, pyCor-displayHeight/10);
  else if (millis() - t < 2500)
    text("2", pxCor, pyCor-displayHeight/10);
  else if (millis() - t < 3500)
    text("1", pxCor, pyCor-displayHeight/10);
  else
    start = false;
}

void mouseReleased() {
  if (get(mouseX, mouseY) == #D130A4)
    state = 00;
  if (get(mouseX, mouseY) == #5BD832) {
    start = true;
    startMillis = millis();
    state = 10;
  }
  if ((get(mouseX, mouseY) == -15091541 || get(mouseX, mouseY) == -1118590) && state == 20) {
    if (mouseX > displayWidth/2) {
      setup2();
      state = 10;
    } else 
      state = 00;
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

// void enemiesAct() {
//   for (int i = 0; i < enemySize; i ++) //2-D parsing
//     for (int j = 0; j < enemies[i].size (); j++) {
//       Enemy e = enemies[i].get(j);
//       if (e.xCor() < pxCor + displayWidth/2 && e.xCor() > pxCor - displayWidth/2 && e.yCor() < pyCor + displayHeight/2 && e.yCor() > pyCor - displayHeight/2)
//         e.act();
//     }
// }


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
    textFont(font);
    text("Play to Resume!", displayWidth/2-XCHANGE, displayHeight/2-YCHANGE);
    thumbCircle.pause = true;
    controlAngle = 0;
    controlDistance = 0;
    noTint();
    return false;
  }
}

void displayStats() {
  fill(100);
  textAlign(CENTER, CENTER);
  textFont(font);
  textSize(displayHeight/15);
  text("Shield: " + hero.shieldNum, pxCor + 3*displayWidth/8, pyCor - 3*displayHeight/8);
  text("Score: " + score*100, pxCor - 3*displayWidth/8, pyCor - 3*displayHeight/8);
}

void displayAll() {
  for (int i = 0; i < enemySize; i ++) //2-D parsing
    for (int j = 0; j < enemies[i].size (); j++) {
      Enemy e = enemies[i].get(j);
      if (e.xCor() < pxCor + displayWidth/2 && e.xCor() > pxCor - displayWidth/2 && e.yCor() < pyCor + displayHeight/2 && e.yCor() > pyCor - displayHeight/2)
        e.display();
    }
    
  for (int i = 0; i < powerupSize; i ++) //2-D parsing
    for (Powerup p : powerups[i])
      p.display();

  thumbCircle.display();
  hero.display();
  displayStats();
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
        Mine curr = (Mine)powerups[1].get(k);
        if (enemies[i].size()>0)
          if (curr.event(enemies[i].get(j))) {
            enemies[i].get(j).dying(i, j);
            j--;
            if (j<0)
              j=0;
          }
        if (curr.exploding>=curr.duration) {
          powerups[1].remove(k);
          k--;
          if (k<0)
            k=0;
        }
      }
    }
  }
}

void railgunCollision() {
  for (int i = 0; i < enemySize; i ++) {
    for (int j = 0; j < enemies[i].size (); j ++) {
      for (int k = 0; k < powerups[2].size (); k ++) {
        Railgun curr = (Railgun)powerups[2].get(k);
        if (enemies[i].size()>0)
          if (curr.event(enemies[i].get(j))) {
            enemies[i].get(j).dying(i, j);
            j--;
            if (j<0)
              j=0;
          }
        if (curr.checkBounds()) {
          powerups[2].remove(k);
        }
      }
    }
  }
}

void railgunMove() {
  for (int k = 0; k < powerups[2].size (); k ++) {
    if (((Railgun)powerups[2].get(k)).activated)
      ((Railgun)powerups[2].get(k)).moving();
  }
}

void mineExploding() {
  for (int k = 0; k < powerups[1].size (); k ++) {
    Mine curr = (Mine)powerups[1].get(k);
    if (curr.exploded)
      curr.exploding += 2;
  }
}

void checkPowerupCounter() {
  if (counter % shieldTime == 0) {
    Shield temp = new Shield();
    powerups[0].add(temp);
  }
  if (counter % mineTime == 0) {
    Mine temp = new Mine();
    powerups[1].add(temp);
  }
  if (counter % railgunTime == 0) {
    Railgun temp = new Railgun();
    powerups[2].add(temp);
  }
}

void checkEnemyCounter() {
  if (counter % chaserTime == 0) {
    Chaser temp = new Chaser();
    enemies[0].add(temp);
  }
  if (counter % backAndForthTime == 0) {
    BackAndForth temp = new BackAndForth();
    enemies[1].add(temp);
  }
}

void checkDeath() {
  for (int i = 0; i < enemySize; i ++) { //2-D parsing
    for (Enemy e : enemies[i]) {
      if (hero.isDead(e)) {
        try {
          checkHighScores();
          scores = highScores();
        }
        catch(Exception a) {
        }
        state = 20;
      }
    }
  }
}

void checkHighScores() throws IOException {
  String[] res = highScores();
  int i = 2;
  int index = -1;
  while ( (i >= 0)&&(score*100 >= Integer.parseInt(res[i]))) {
    index = i;
    i--;
  }
  if (index != -1) {
    i = index;
    if(i == 1){
      res[2] = res[1];
    } 
    else if(i == 0){
      res[2] = res[1];
      res[1] = res[0];
    }
    res[index] = (int)score*100 + "";
    PrintWriter out = createWriter("data/highScores.txt");
    for (int k = 0; k < res.length; k++)
      out.println(res[k]);
    out.flush();
    out.close();
  }
}

String[] highScores() throws FileNotFoundException {
  return loadStrings("highScores.txt");
}
