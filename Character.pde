class Character{
  int health; 
  PVector dim,pos,vel;
  float damp;
  float cWidth, cHeight;
  
  
   Character( float x, float y, float speedX, float speedY, int health, int damage)
   {
     pos = new PVector( x , y );
     vel = new PVector( speedX , speedY );
     this.health=health;
   }
   
   void move()
   {
     this.pos.add(vel);
     vel.mult(0.8);
     
   }
   
   void accelerate(PVector force)
   {
     vel.add(force);
   }
   
   void update()
   {
     if(health>0)
     {
       drawMe();
       move();
       handleWalls();
     }
     
   }
   
   
  
   
   void handleWalls()
   {
    if (pos.x<-cWidth/2) pos.x=width+cWidth/2;
    if (pos.x>width+cWidth/2) pos.x=-cWidth/2;
    if (pos.y<-cWidth/2) pos.y=height+cWidth/2;
    if (pos.y>height+cWidth/2) pos.y=-cWidth/2;
     
   }
   
   boolean collision( Character c)
   {
     return pos.dist(c.pos)< ( cWidth/2 + 100/2);
     
   }
   
   void updateHealth( int health)
   {
     this.health--;
   }
   
  // void shoot();
  //  {
     
  // }
   
   void drawMe()
   {
     fill(0,0, 100);
     ellipse(0,0,10,10);
     
   }
   
}
