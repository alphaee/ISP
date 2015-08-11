interface Powerup {
  boolean detect(); //check if player is in radius

  boolean event(Enemy e);
  
  void display(); //display the powerup
}

