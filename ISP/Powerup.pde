interface Powerup {
  void dying(); //when player gets powerup

  void display(); //display the powerup

  boolean detect(); //check if player is in radius

  boolean event(Enemy e);
}

