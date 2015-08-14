interface Enemy {  
  float xCor();
  float yCor();
  boolean isAlive();
  boolean invincible();
  boolean spawning();
  boolean detect(); //Detects borders and player

  void attack(); //Defines how the character attacks

  void dying(); //How the character dies ie. splitting into smaller or disappearing

  void dead(int i, int j);

  void display(); //Draws the character with image import

  void act(); //Contains the display and attack fxns

  void event(Enemy e, int i, int j); //When two enemies collide,
  //merge or change directions?
}

