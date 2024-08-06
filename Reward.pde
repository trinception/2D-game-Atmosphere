class Reward{
  PVector pos;
  
  Reward(float x, float y){
    pos= new PVector(x,y);
  }
  
  void drawHealthPlus()
  {
    pushMatrix();
    translate(pos.x,pos.y);
    
    popMatrix();
  }
  
  
  
  
  
  
}
