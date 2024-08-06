class Player extends Character{
  int health = 20;
  int damage = 1;
  int flag=0;
  float time=0;
  boolean dead=false; 
  int currentImgIdx=0;
  int currentImgIdx0=0;
  int currentImgIdx1=0;
  int currentImgIdx2=0;
  int shootingRightIndex=0;
  int shootingLeftIndex=0;
  boolean firing=false;
  
    boolean right= false;
    boolean left= false;
    
    PVector rightForce = new PVector(2,0);
    PVector leftForce = new PVector(-2, 0);
    ArrayList<PlayerWeapon> weapons = new ArrayList<PlayerWeapon>();
  
  Player(float x, float y, float speedX, float speedY, int health, int damage)
  {
    super( x, y, speedX, speedY, health, damage);
    
  }
  
  void drawMe()
  {
    pushMatrix();
    translate(pos.x,pos.y);
    /*if(firing && vel.x>0.5)
    {
      playerimg = playerShooting[shootingRightIndex];
      image(playerimg, 10, 0);
    }else if(firing && vel.x<-0.5)
    {
      playerimg = playerShootingL[shootingLeftIndex];
      image(playerimg, -10, 0);
        }*/
        if(vel.x<0.5 && vel.x>-0.5 && vel.y>0.5 || vel.y<-0.5)
        {
          playerimg = playerRunningD[currentImgIdx2];
          image(playerimg, 0, 0);
          
        }else if (vel.x<0.5 && vel.x>-0.5)
        {
          playerimg = playerStanding[currentImgIdx];
          image(playerimg, 0, 0);
          
        }else if (vel.x>0)
        {
          playerimg = playerRunningR[currentImgIdx0];
          image(playerimg, 0, 0);
        }else if (vel.x<0)
        {
          playerimg = playerRunningL[currentImgIdx1];
          image(playerimg, 0, 0);
        }
    
    if(scene==5)
    {
      image(submarine,-32,-10);
    }
    popMatrix();
  }
  
  
  void update() {
    if(health>0){
    drawMe();
    /*if(firing && vel.x>=0)
    {
      if(frameCount%5==0)
                {
                  shootingRightIndex++;
                  if(shootingRightIndex == playerShooting.length)
                  {
                    shootingRightIndex=0;
                  }
                }
    }else if(firing && vel.x<0)
    {
      
      if(frameCount%5==0)
                {
                  shootingLeftIndex++;
                  if(shootingLeftIndex == playerShootingL.length)
                  {
                    shootingLeftIndex=0;
                  }
                }
    }*/
    if(vel.x<0.5 && vel.x>-0.5 && vel.y>0.5|| vel.y<-0.5)
    {
        if(frameCount%5==0)
                {
                  currentImgIdx2++;
                  if(currentImgIdx2 == playerRunningD.length)
                  {
                    currentImgIdx2=0;
                  }
                }
    }else if (vel.x<0.5 && vel.x>-0.5)
    {
      if(frameCount%5==0)
                {
                  currentImgIdx++;
                  if(currentImgIdx == playerStanding.length)
                  {
                    currentImgIdx=0;
                  }
                }
    }
    else if (vel.x>0.5)
    {
      if(frameCount%5==0)
                {
                  currentImgIdx0++;
                  if(currentImgIdx0 == playerRunningR.length)
                  {
                    currentImgIdx0=0;
                  }
                }
    
    }else if ( vel.x<0.5)
    {
      if(frameCount%5==0)
                {
                  currentImgIdx1++;
                  if(currentImgIdx1 == playerRunningL.length)
                  {
                    currentImgIdx1=0;
                  }
                }
    }
    move();
    handleWalls();
    checkWeapons();
    }
    else{
      dead=true;
    }
  }
  
  void accelerate(PVector force)
  {
    
    vel.add(force);
    //println("fast");
  }
  
  void move()
  {
    super.move();
    //println("moving");
  }
  


void checkWeapons()
  {
    for( int i=0; i<weapons.size(); i++)
    {
      PlayerWeapon w = weapons.get(i);
      w.update();
      
      for( int j=0; j<enemies.size(); j++)
      {
        Enemy e = enemies.get(j);
        if(w.hitE(e))
        {
          weapons.remove(w);
          e.updateHealth(e.health);
        }
      }
      if(enemies.size()==0)
      {
          if(w.hitB(b))
          {
            weapons.remove(w);
            b.updateHealth(b.health);
          }
      }
    }
  }

  void shoot()
   {
       int speedX=5;
       if(this.vel.x<0 && speedX==5 || this.vel.x>0 && speedX==-5)
       {
         speedX=-speedX;
       }
           if(flag==0)
           {
               weapons.add(new PlayerWeapon( pos.x, pos.y, speedX, 0));
               fire.play(0);
               flag=1;
               time=millis();
               firing=true;
               
           }
           if(millis()> time+100)
           {
             flag=0;
             firing=false;
           }
           
     
   }
   
   
   
   void updateHealth(int damage)
   {
     this.health=this.health-damage;
     
   }
   
   boolean dead()
   {
     return dead;
   }
   
}
