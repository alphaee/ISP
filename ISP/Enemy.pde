interface Enemy {  

  void display(); 

  boolean detect();

  void dying();

  void merging();

  boolean isAlive();

  void attack();
  
  float xCor();
  float yCor();
}

