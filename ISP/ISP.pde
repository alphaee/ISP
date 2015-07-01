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
  
  XSIZE = (int)(displayWidth*1.5); //You want the gamebox size to be larger than the size of the screen
  YSIZE = (int)(displayHeight*1.5);
  
  hero = new Player();
  enemies = new ArrayList<Enemy>();
  
  spawnTime = 25;
}

void draw(){
  background(180);
  
  updatePlayerCors(); //update coordinates before applying translations 
  
  translate(XSIZE/3 - pxCor, YSIZE/3 - pyCor);
  
  createBoundary();
  
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

void createBoundary(){
  stroke(204, 102, 0); 
  fill(180);
  rect(0, 0, XSIZE, YSIZE);
  stroke(0);
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
  hero.display();
  for(Enemy e : enemies)
    e.display();
}

void mousePressed(){
  hero.move();
}
