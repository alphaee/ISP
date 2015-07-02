//Young Kim, Dan Kim, Franklin Wang

//FIXED CONSTANTS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int XSIZE, YSIZE;
float XCHANGE, YCHANGE;

//PLAYER VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Player hero;
float pxCor, pyCor; //Player x-cor and y-cor

//ENEMY VARS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ArrayList<Enemy> enemies;

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
int spawnTime; 

void setup(){
  orientation(LANDSCAPE);
  size(displayWidth,displayHeight);
  
  state = 1;
  
  XSIZE = (int)(displayWidth*1.5); //You want the gamebox size to be larger than the size of the screen
  YSIZE = (int)(displayHeight*1.5);
  
  hero = new Player();
  thumbCircle = new Joystick();
  
  enemies = new ArrayList<Enemy>();
  
  for(int i = 0; i < 10; i ++){ //FOR TESTING PURPOSES ONLY
    Enemy temp = new Enemy();
    enemies.add(temp);
  }
  
  spawnTime = 25;
}

void draw(){
  switch(state){
    case 0:
      break;
    
    case 1:
      background(0);
      
      updatePlayerCors(); //update coordinates before applying translations
      //also updates XCHANGE & YCHANGE
      
      translate(XCHANGE, YCHANGE);
      
      createBoundary();
      
      spawnEnemies();
      displayAll();
      
      touchDetection();
      
      hero.move();
      checkDeath();
      break;
      
    case 2:
      break;
  }
}

boolean sketchFullScreen() { //Necessary to start in full screen
  return true;
}

void updatePlayerCors(){
  pxCor = hero.xCor;
  pyCor = hero.yCor;
  XCHANGE = XSIZE/3 - pxCor;
  YCHANGE = YSIZE/3 - pyCor;
}

void createBoundary(){
  stroke(204, 102, 0); 
  fill(180);
  rect(0, 0, XSIZE, YSIZE);
  stroke(0);
}

void spawnEnemies(){
  /*
  if(counter >=spawnTime){
    Enemy temp = new Enemy();
    enemies.add(temp);
    counter = 0;
  }
  counter++;*/
}

void touchDetection(){
  if(mousePressed){
    thumbCircle.pause = false;
    controlAngle = thumbCircle.calcAngle();
    controlDistance = thumbCircle.calcDistance();
  }
  else{
    fill(0, 153, 204, 126);
    rect(-XCHANGE,-YCHANGE,displayWidth,displayHeight);
    fill(15);
    textSize(displayHeight/6);
    textAlign(CENTER,CENTER);
    text("Play to Resume!",displayWidth/2-XCHANGE,displayHeight/4-YCHANGE);
    thumbCircle.pause = true;
    controlAngle = 0;
    controlDistance = 0;
    noTint();
  }
}

void displayAll(){
  thumbCircle.display();
  hero.display();
  for(Enemy e : enemies)
    e.display();
}

void checkDeath(){
  for(Enemy e: enemies){
    if(hero.isDead(e))
      text("Dead!",displayWidth/2-XCHANGE,displayHeight/4-YCHANGE);
      //state = 2;
  }
}
