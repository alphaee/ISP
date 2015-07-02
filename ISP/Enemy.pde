interface Enemy {  
  float xCor();
  float yCor();

  boolean detect();
  void attack();
  
  boolean isAlive();
  void dying();
  
  void display(); 
}

