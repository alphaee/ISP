import java.io.*;
//Young Kim, Dan Kim, Franklin Wang

//FIXED CONSTANTS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int XSIZE, YSIZE;
float XCHANGE, YCHANGE;
final int fps = 30;

//CAMERA VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
float inc, scaleFactor, eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ;

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
//
//ENEMY ANIMATIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Animation chas_spawning;
Animation chas_dying;
Animation baf_spawning;
Animation baf_moving_hori;
Animation baf_moving_vert;
Animation baf_merge;
Animation baf_dying; 
Animation bounce_spawning;
Animation bounce_moving;
Animation bounce_dying;
Animation gunMoving;


//POWERUP VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ArrayList<Powerup>[] powerups;
final int powerupSize = 4;

/*
 Indices:
 0: Shield
 1: Mine
 2: Railgun
 3: Spikes
 */

int spikesCounter;

PImage shield;
PImage mineActive;
PImage minePassive;
PImage railgun;
PImage spikes;

//JOYSTICK VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Joystick thumbCircle;
float controlAngle;
float controlDistance;

//SPAWN VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int prevMillisE;
int prevMillisP;
int percentBAF;
int numSpawn;
int intervalTime;
boolean initEnemy;

int numMines, numRailguns;

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

boolean dead;
int deathMillis;

boolean jCheck;

boolean released;

boolean spiking;

boolean init_anim;

PFont font;
PImage background;

int borderColorR, borderColorG, borderColorB, borderStroke;

ArrayList<String> wtf;

void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight); //Disable for mobile

  XSIZE = (int)(displayWidth*1.2); //You want the gamebox size to be larger than the size of the screen
  YSIZE = (int)(displayHeight*1.2);

  thumbCircle = new Joystick();

  released = false;

  enemies = (ArrayList<Enemy>[])new ArrayList[enemySize];

  powerups = (ArrayList<Powerup>[])new ArrayList[powerupSize];

  frameRate(fps);

  borderColorR = 255;
  borderColorG = 255;
  borderColorB = 255;
  borderStroke = 10;

  //high score screen
  reset = loadImage("Reset_Button.png");
  home = loadImage("Home_Button.png");
  home.resize(displayHeight/7, displayHeight/7);
  reset.resize(displayHeight/7, displayHeight/7);

  //powerups
  shield = loadImage("Shield.png");
  shield.resize(displayHeight/14, displayHeight/14);
  mineActive = loadImage("LandMineActivated1.png");
  mineActive.resize(displayHeight/14, displayHeight/14);
  minePassive = loadImage("LandMine1.png");
  minePassive.resize(displayHeight/14, displayHeight/14);
  railgun = loadImage("Railgun.png");
  railgun.resize(displayHeight/14, displayHeight/14);
  spikes = loadImage("Spikes.png");
  spikes.resize(displayHeight/14, displayHeight/14);

  font = loadFont("Kuro-Regular-250.vlw");
  textFont(font);

  active = true;

  init_anim = true;
}

void init_animations() {
  chas_spawning = new Animation("SpawnRed", 5, 240*displayHeight/768, 200*displayHeight/768);
  chas_dying = new Animation("DieRed", 7, 240*displayHeight/768, 200*displayHeight/768);
  baf_spawning = new Animation("SpawnYellow", 10, 240*displayHeight/768, 200*displayHeight/768);
  baf_dying = new Animation("DieYellow", 5, 240*displayHeight/768, 200*displayHeight/768);
  baf_moving_hori = new Animation("MovingYellow", 13, 180*displayHeight/768, 150*displayHeight/768);
  baf_moving_vert = new Animation("MovingYellowVert", 13, 150*displayHeight/768, 180*displayHeight/768);
  bounce_spawning = new Animation("SpawnGreen", 10, 240*displayHeight/768, 200*displayHeight/768);
  bounce_moving = new Animation("MovingGreen", 13, 240*displayHeight/768, 200*displayHeight/768);
  bounce_dying = new Animation("DieGreen", 10, 240*displayHeight/768, 200*displayHeight/768);
  baf_merge = new Animation("MergeYellow", 14, 240*displayHeight/768, 200*displayHeight/768);

  gunMoving = new Animation("Railgun", 7, 2*displayHeight/32, 2*displayHeight/32);
}

void setup2() {
  hero = new Player();
  
  // eyeX = width/2.0;
  // eyeY = height/2.0;
  // eyeZ = (height/2.0) / tan(PI*30.0/180.0);
  // centerX = width/2.0;
  // centerY = height/2.0;
  // centerZ = 0;
  // upX = 0;
  // upY = 1;
  // upZ = 0;
  // camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  for (int i = 0; i < enemySize; i++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  for (int i = 0; i < powerupSize; i++) {
    powerups[i] = new ArrayList<Powerup>();
  }

  controlDistance = 0;

  counter = 0;

  spiking = false;

  start = true;
  jCheck = true;
  startMillis = millis();
  prevMillisE = startMillis;
  prevMillisP = startMillis;
  
  dead = false;

  percentBAF = 8;
  numSpawn = 1;
  intervalTime = 3000;
  initEnemy = true;

  setBoundaryNormal();

  score = 0;
  numMines = 3;
  numRailguns = 2;

//  for (int i = 0; i < 2; i++) {
//      BackAndForth temp2= new BackAndForth();
//      enemies[1].add(temp2);
//  }
  wtf = new ArrayList<String>();
}

void draw() {
  //println(state);
  switch(state) {

  case 00: //HOMESCREEN
    //    println("case 00");
    if (init_anim && millis() > 2000) {
      init_anim = !init_anim;
      init_animations();
    }
    background(0);

    fill(#647775);

    textAlign(CENTER, CENTER);
    fill(#32CCD8);
    textSize(displayHeight/4);
    text("I.S.P.", displayWidth/2, displayHeight/7);
    textSize(displayHeight/12);
    imageMode(CENTER);
    text("Play", displayWidth/2, displayHeight/2 - displayHeight*2/25);
    text("Instructions", displayWidth/2, displayHeight/2 + displayHeight*3/25);
    text("Credits", displayWidth/2, displayHeight/2 + displayHeight*8/25);

    if (!active) {
      if (millis() - activeMillis > 500)
        active = !active;
    }

    if (mousePressed && active && !init_anim) {
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
    text("To move, use the thumbstick.", displayWidth/6, displayHeight/6 + displayHeight*2/20);
    text("Survive the waves of enemies using three powerups:", displayWidth/6, displayHeight/6 + displayHeight*4/20);
    text("Mine:", displayWidth/5, displayHeight/6 + displayHeight/30 + displayHeight*5/20);
    text("Shield:", displayWidth/5, displayHeight/6 + displayHeight/30 + displayHeight*7/20);
    text("Railgun:", displayWidth/5, displayHeight/6 + displayHeight/30 + displayHeight*9/20);

    imageMode(CENTER);
    image(minePassive, displayWidth/3, displayHeight/6 + displayHeight/50 + displayHeight*5/20);
    image(shield, displayWidth/3, displayHeight/6 + displayHeight/50 + displayHeight*7/20);
    image(railgun, displayWidth/3, displayHeight/6 + displayHeight/50 + displayHeight*9/20);

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
    } else {
      if (touchDetection()) {

        spawnPowerups();
        spawnEnemies();

        enemiesAct();
        enemiesCollide();

        checkShield();

        mineCollision();
        mineExploding();

        railgunCollision();
        railgunMove();

        iCounter++;
        counter++; 
        
        checkSpikes();
        spikeCollision();
        spikeDeath();
      }
      hero.move();
      checkDeath();
    }
    break;

  case 20: //GAME OVER
    background(0);
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

    if (released&&mousePressed) {
      if ((get(mouseX, mouseY) == -15091541 || get(mouseX, mouseY) == -1118590)) {
        if (mouseX > displayWidth/2) {
          setup2();
          state = 10;
        } else 
          state = 00;
        released = false;
      }
    }

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
  fill(180);
  textAlign(CENTER, CENTER);
  textSize(displayHeight/9);
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
  //  boolean released = false;
  if (get(mouseX, mouseY) == #D130A4)
    state = 00;
  if (get(mouseX, mouseY) == #5BD832) {
    start = true;
    startMillis = millis();
    state = 10;
  }
  if (state==20)
    released = true;
}

boolean sketchFullScreen() { //Necessary to start in full screen
  return true;
}

void updatePlayerCors() {
  pxCor = hero.xCor;
  pyCor = hero.yCor;
  XCHANGE = XSIZE/2.4 - pxCor;
  YCHANGE = YSIZE/2.4 - pyCor;
}

void enemiesAct() {
  for (int i = 0; i < enemySize; i ++) //2-D parsing
    for (int j = 0; j < enemies[i].size (); j++) {
      Enemy e = enemies[i].get(j);
      e.act();
    }
}

void enemiesDisplay() {
  for (int i = 0; i < enemySize; i ++) //2-D parsing
    for (int j = 0; j < enemies[i].size (); j++) {
      Enemy e = enemies[i].get(j);
      e.display();
    }
}


void createBoundary() {
  stroke(borderColorR, borderColorG, borderColorB);
  strokeWeight(borderStroke);

  //image(background, XSIZE/2, YSIZE/2, XSIZE, YSIZE);

  line(0, -displayHeight/10, 0, YSIZE+displayHeight/10);
  line(XSIZE, -displayHeight/10, XSIZE, YSIZE+displayHeight/10);
  line(-displayHeight/10, 0, XSIZE+displayHeight/10, 0);
  line(-displayHeight/10, YSIZE, XSIZE+displayHeight/10, YSIZE);

  fill(0);
  strokeWeight(5);
  ellipse(-displayHeight/20, -displayHeight/20, displayHeight/50, displayHeight/50);
  ellipse(-displayHeight/20, YSIZE+displayHeight/20, displayHeight/50, displayHeight/50);
  ellipse(XSIZE+displayHeight/20, -displayHeight/20, displayHeight/50, displayHeight/50);
  ellipse(XSIZE+displayHeight/20, YSIZE+displayHeight/20, displayHeight/50, displayHeight/50);
}

boolean touchDetection() {
  if (mousePressed) {
    thumbCircle.pause = false;
    controlAngle = thumbCircle.calcAngle();
    controlDistance = thumbCircle.calcDistance();
    jCheck = false;
    return true;
  } else if (!jCheck) {
    enemiesDisplay();
    fill(0, 153, 204, 200);
    rect(-XCHANGE, -YCHANGE+displayHeight/4, displayWidth, displayHeight/2);
    fill(15);
    textSize(displayHeight/7);
    textAlign(CENTER, CENTER);
    text("Play to Resume!", displayWidth/2-XCHANGE, displayHeight/2-YCHANGE);
    thumbCircle.pause = true;
    controlAngle = 0;
    controlDistance = 0;
    noTint();
  } else {
    fill(180);
    textAlign(CENTER, CENTER);
    textSize(displayHeight/7);
    text("GO!", pxCor, pyCor-displayHeight/10);
  }
  return false;
}

void spawnPowerups() {
  for (int i = 0; i < numMines - powerups[1].size (); i++) {
    Mine temp = new Mine();
    powerups[1].add(temp);
  }
  for (int i = 0; i < numRailguns - powerups[2].size (); i++) {
    Railgun temp = new Railgun();
    powerups[2].add(temp);
  }
  //subsequent spawn
  if ((millis() >= prevMillisP + 6000) && (powerups[0].size() < 2)) {
    prevMillisP = millis();
    float guess = random(10);
    if (guess > 9 && hero.shieldNum < 3) {
      Shield temp = new Shield();
      powerups[0].add(temp);
    } else if (guess > 8 && hero.shieldNum < 2) {
      Shield temp = new Shield();
      powerups[0].add(temp);
    } else if (guess > 2 && hero.shieldNum < 1) {
      Shield temp = new Shield();
      powerups[0].add(temp);
    }
    float guess2 = random(10);
    if (guess2 > 1 && (powerups[3].size() == 0)) {
      Spikes temp = new Spikes();
      powerups[3].add(temp);
    }
  }
  if (millis() - startMillis >= 15000) {
    numMines = 4;
    numRailguns = 3;
  }
}

void spawnEnemies() {
  //initial spawn
  if (initEnemy) {
    for (int i = 0; i < 5; i++) {
      if (random(10) < percentBAF) {
        BackAndForth temp = new BackAndForth();
        enemies[1].add(temp);
      } else {
        Bouncer temp2 = new Bouncer();
        enemies[2].add(temp2);
      }
    }
    initEnemy = false;
  }
  //subsequent spawn
  if (enemies[0].size() + enemies[1].size() + enemies[2].size() < 40) {
    if (millis() >= prevMillisE + intervalTime) {
      prevMillisE = millis();
      for (int i = 0; i < numSpawn; i++) {
        if (random(10) < percentBAF) {
          BackAndForth temp0 = new BackAndForth();
          enemies[1].add(temp0);
        } else {
          Bouncer temp02 = new Bouncer();
          enemies[2].add(temp02);
        }
      }
    }
  }
  //need to fix this function
  numSpawn = (int)((millis() - startMillis)/15000) + 1;
  intervalTime = -1*(int)((millis() - startMillis)/40000) + 3000;
  if (millis() - startMillis >= 20000) {
    percentBAF = 6;
  }
  //  println(numSpawn);
}

void displayStats() {
  fill(180);
  textAlign(CENTER, CENTER);
  textSize(displayHeight/12);
  text("Shield: " + hero.shieldNum, pxCor + 11*displayWidth/32, pyCor - 3*displayHeight/8);
  text("Score: " + score*100, pxCor - 11*displayWidth/32, pyCor - 3*displayHeight/8);
}

void displayAll() {    
  for (int i = 0; i < powerupSize; i ++) //2-D parsing
    for (Powerup p : powerups[i])
      p.display();

  thumbCircle.display();
  hero.display();
  displayStats();
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
      powerups[0].remove(i);
      i--;
    }
  }
}

void checkSpikes() {
  for (int i = 0; i < powerups[3].size (); i ++) {
    if (powerups[3].get(i).detect()) {
      spikesCounter = fps*3;
      powerups[3].remove(i);
      i--;
      spiking = true;
    }
  }
}

void spikeCollision() {
  if (spikesCounter > 0) {
    spikesCounter--;
    borderColorR = 209;
    borderColorB = 209;
    borderColorG = (int)(96*cos(PI/30*counter))+113;
    borderStroke = (int)(10*sin(PI/30*counter))+10;
    for (int i = 0; i < enemySize; i ++) {
      for (int j = 0; j < enemies[i].size (); j ++) {  
        if(enemies[i].size() > 0)  
          if (enemies[i].get(j).checkSpikeDeath()) {
            println(i + " " + j + enemies[i].get(j).isAlive());
            enemies[i].get(j).dead(i, j);
            println(i + " " + j + enemies[i].get(j).isAlive());
            j--;
            if (j<0)
              j=0;
          }
      }
    }
  } else {
    if (spiking == true) {
      setBoundaryNormal();
    }
    spiking = false;
  }
}

void spikeDeath(){
  for(int i = 0; i < wtf.size(); i++){
    
  }
}

void setBoundaryNormal() {
  borderColorR = 255;
  borderColorG = 255;
  borderColorB = 255;
  borderStroke = 10;
}

void mineCollision() {
  for (int i = 0; i < enemySize; i ++) {
    for (int j = 0; j < enemies[i].size (); j ++) {
      for (int k = 0; k < powerups[1].size(); k ++) {
        Mine curr = (Mine)powerups[1].get(k);
        if (enemies[i].size()>0)
          if (curr.event(enemies[i].get(j))) {
            enemies[i].get(j).dead(i, j);
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
            enemies[i].get(j).dead(i, j);
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

void checkDeath() {
  for (int i = 0; i < enemySize; i ++) { //2-D parsing
    for (Enemy e : enemies[i]) {
      if (hero.isDead(e) && !e.spawning()) {
        if (!dead){
          deathMillis = millis();
          dead = !dead;
          inc = 0.0;
          scaleFactor = 0.0;
        }
        else{
          death();
        }
      }
    }
  }
}

void death() {
  if (millis() - deathMillis < 3000){
    // eyeZ-=10;
    // camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
    inc += 0.4;
    scaleFactor = cos(inc)*2;
    translate(width/2, height/2);
    scale(scaleFactor);
  }
  else{
    try {
      checkHighScores();
      scores = highScores();
    }
    catch(Exception a) {
    }
    state = 20;
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
    if (i == 1) {
      res[2] = res[1];
    } else if (i == 0) {
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
