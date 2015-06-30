 //Young Kim, Dan Kim, Franklin Wang
int XSIZE, YSIZE; //Constants
float pxCor, pyCor; //Player x-cor and y-cor

Player hero;
ArrayList<Enemy> enemies;

int counter; 
int spawnTime; 

void setup(){
  orientation(LANDSCAPE);
  size(displayWidth,displayHeight);
  XSIZE = (int)(displayWidth*1.5);
  YSIZE = (int)(displayHeight*1.5);
  
  hero = new Player();
  enemies = new ArrayList<Enemy>();
  
  spawnTime = 25;
}

void draw(){
  background(180);
  
  updatePlayerCors();
  
  translate(XSIZE/3 - pxCor, YSIZE/3 - pyCor);
  stroke(204, 102, 0); 
  fill(180);
  rect(0, 0, XSIZE, YSIZE);
  stroke(0);
  hero.display();
  spawnEnemies();
  displayAll();
  hero.move();
}

boolean sketchFullScreen() { //Necessary to start in full screen
  return true;
}

void updatePlayerCors(){
  pxCor = hero.xCor;
  pyCor = hero.yCor;
  println("pxCor: " + pxCor);
  println("pyCor: " + pyCor);
}

void spawnEnemies(){
  if(counter >=spawnTime){
    Enemy temp = new Enemy();
    enemies.add(temp);
    counter = 0;
  }
  counter++;
}

void displayAll(){
  for(Enemy e : enemies)
    e.display();
}

void mousePressed(){
  hero.move();
}
