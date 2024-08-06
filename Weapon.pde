class Weapon{
  
 
 PVector pos, vel;
  
  Weapon(float x, float y_, float speedX, float speedY)
  {
    
     pos=new PVector(x, y_);
     vel=new PVector(speedX, speedY);
     
  }
  
  void move()
  {
    
    pos.add(vel);
    
  }
  
  void checkWalls()
  {
      
      if( pos.x>800 || pos.x <0)
      {
        //remove this
      }
  
        
  }
  
  
  void update()
  {
    
    drawW();
    move();
    
  }
  
  void drawW()
  {
    
    pushMatrix();
    strokeWeight(5);
    stroke(124,124,124);
    fill(255);
    translate(pos.x, pos.y);
    ellipse(0,0,20,20);
    popMatrix();
    
  }
  
  
}
