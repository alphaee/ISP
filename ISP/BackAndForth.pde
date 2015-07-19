class BackAndForth implements Enemy {  
  float xCor, yCor;
  int direction;
  int step;
  int radius; //radius of circle - temp
  boolean avoid;
  
  Animation moving;

  BackAndForth() {
    radius = 50;

    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);

    direction = (int)random(4f);
    avoid = false;

    step = 5;// May Change to increase speed
    
    moving = new Animation("MovingYellow", 13);
  }
  
  BackAndForth(float x, float y){
    radius = 50;
    xCor = x;
    yCor = y;
    direction = (int)random(4f);
    avoid = false;
    step = 5;// May Change to increase speed
  }

  float xCor() {
    return xCor;
  }

  float yCor() {
    return yCor;
  }

  boolean detect() {
    if (xCor >= XSIZE) {
      //direction = 0;//left
      direction = (int)random(3f);
      if (direction > 0) {
        direction ++; //only 0,2, or 3
      }
      xCor -= step; // to move away from the border so it doesn't get caught here again
    } else if (xCor <= 0) {
      // direction = 1;//right
      direction = (int)random(3f);
      direction ++; //only 1,2, or 3
      xCor += step; // same as xCor-=step
    } else if (yCor >= YSIZE) {
      //direction = 2;//up
      direction = (int)random(3f); // only 0, 1, 2
      yCor -= step; // same as xCor-=step
    } else if (yCor <= 0) {
      //direction = 3;//down
      direction = (int)random(3f);
      if (direction == 2) {
        direction ++; // only 0,1, or 3
      }
      yCor+=step; // same as xCor-=step
    }

    if (avoid) { 
      if (xCor <= step) {
        direction = 1;
      } else if (xCor >= XSIZE-step) {
        direction = 0;
      } else if (yCor <= step) {
        direction = 3;
      } else if (yCor >= YSIZE-step) {
        direction = 2;
      }
      avoid = false;
    }
    return true;
  }

  void attack() {
    detect();
    if (direction % 4 == 0) //left
      xCor -= step;                                
    else if (direction % 4 == 1) //right
      xCor += step;
    else if (direction % 4 == 2) //up
      yCor -= step;
    else //down
    yCor += step;
  }

  boolean collide(Enemy e) {
    return dist( xCor, yCor, e.xCor(), e.yCor() ) < 30;
  }

  void event(Enemy e, int i, int j) {
    if (collide(e)) {
      if (random(10) < 3) { //30% chance of merging
        merge(e, i, j);
      } else { //if it doesn't merge, goes off border
        avoid = true;
      }
    }
  }

  void merge(Enemy e, int i, int j) {
    Bouncer temp = new Bouncer(xCor, yCor);
    enemies[2].add(temp);
    enemies[1].remove(j);
    enemies[1].remove(i);
  }

  boolean isAlive() {//Still needs work
    return true;
  }

  void dying(int i, int j) {
    enemies[i].remove(j);
  }

  void act() {
    if (isAlive()) {
      display();
      attack();
    } //else
      //dying();
  }

  void display() {//display() should only display
    //fill(255);
    //ellipse(xCor, yCor, radius, radius);
    moving.show(xCor, yCor);
  }
}

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count){
    imageCount = count;
    images = new PImage[imageCount];
    
    for (int i = 0; i < imageCount; i++){
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      PImage img = loadImage(filename);
      img.resize(120,100);
      images[i] = img;
    }
  }
  
  void show(float xpos, float ypos){
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
