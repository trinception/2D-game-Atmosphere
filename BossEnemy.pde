class BossEnemy extends Enemy{
  
  int walkingIdx=0; //Declaring and initializing variable for use as an incrementing index for walking boss fox
  int swimmingIdx=0; //Declaring and initializing variable for use as an incrementing index for swimming boss fish
  int flyingIdx=0;  //Declaring and initializing variable for use as an incrementing index for flying boss witch
  
  
  int dyingFoxIndex=0; //Declaring and initializing variable for use as an incrementing index for dying boss fox
  int dyingFishIndex=0; //Declaring and initializing variable for use as an incrementing index for dying boss fish
  int dyingWitchIndex=0; //Declaring and initializing variable for use as an incrementing index for dying boss witch
  
  int health=5; //Declaring and initializing variable for bossEnemys health
  int timer=90; //Declaring(step 1) and initializing(step 2) a timer to be used when boss enemy is dying
  int damage=2; //Declaring and initializing a variable that determines amount of harm boss enemy imposes on player health
  boolean dead=false;  //Declaring and initializing a variable that tells program whether boss enemy is still alive or not
  
  //Class constructor for BossEnemy
  BossEnemy(float x, float y, float speedX, float speedY, int health, int damage)
  {
    super(x,y,speedX,speedY,health, damage);
    
  }
  
  
  /*
    Draws Boss Enemy in each of its forms depending on the scene(AKA level) of the game
    (called in update)
  */
  void drawMe()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    if(this.health< health)
    {
      stroke(255);
      rect(-img2.width/2, (-img2.height/2)-40, img2.width, 35);
      fill(0,255, 18);
      rect(-img2.width/2, (-img2.height/2)-40, health*(img2.width/5), 35);
    }
      
    if(scene==2)
    {
      img2 = walking[walkingIdx];
      
      image(img2, -img2.width/2, -img2.height/2);
    }
    
    if(scene==5)
    {
      img2 = swimming[swimmingIdx];
      image(img2,-img2.width/2, -img2.height/2);
    }
    if(scene==8)
    {
      img2 = flying[flyingIdx];
      image(img2,-img2.width/2, -img2.height/2);
    }
    popMatrix();
  }
  
  /*
      Causes Boss Enemy to fire projectile automatically every 1/60 of a second
      (called in update)
  */
   void shoot(){
    if(frameCount%60==0)
    eWeapons.add(new EnemyWeapon( pos.x, pos.y, -11, 0));
    
  }
  
  /*
    Called in all three levels of the game- checks projectiles, makes it move, shoots, handles walls, shows image sequence based on level
    Shows boss enemy when dying: changes death boolean to tru when the timer is at 0
  */
  void update()
  {
    if(health>0)
    {
            drawMe();
            laugh.play(0);
            if (scene==2)
            {
              //foxLaugh.play(0);
              if(frameCount%6==0)
              {
                    walkingIdx++;
                    if(walkingIdx == walking.length)
                    {
                      walkingIdx=0;
                    }
              }
            }
           if(scene==5)
           {
             if(frameCount%6==0)
             {
                  swimmingIdx++;
                  if(swimmingIdx == swimming.length)
                    {
                      swimmingIdx=0;
                    }
             }
            }
            if(scene==8)
           {
             
             if(frameCount%6==0)
             {
                  flyingIdx++;
                  if(flyingIdx == flying.length)
                    {
                      flyingIdx=0;
                    }
             }
            }
         shoot();
         handleWalls();
         move();
         checkWeapons();
         if( hitC(player)){
              resolveCollision(player);
              player.updateHealth(damage);
         }
    }
    else{
      
      timer--;//(step 3 of a timer) decrementing
      drawDying();
      if(scene==2)
      {
          
          if(frameCount%18==0)
                 {
                      dyingFoxIndex++;
                      if(dyingFoxIndex == dyingFox.length)
                        {
                          dyingFoxIndex=0;
                        }
                 }
      }
      if(scene==5)
      {
          if(frameCount%18==0)
                {
                      dyingFishIndex++;
                      if(dyingFishIndex== dyingFish.length)
                      {
                        dyingFishIndex=0;
                      }
                }
      }
      if(scene==8)
      {
          if(frameCount%8==0)
                {
                      dyingWitchIndex++;
                      if(dyingWitchIndex== dyingWitch.length)
                      {
                        dyingWitchIndex=0;
                      }
                }
      }
      if(timer==0)//(final step of timer)
      {
        dead=true;
        timer=90;
      }
    }
  }


/*
  Causes boss enemy to, when at edge of screen, appear on the other side
  (called in update)
*/
    void handleWalls()
    {
        if (pos.x<-img2.width/2) 
          pos.x=width+img2.width/2;
        if (pos.x>width+img2.width/2) 
          pos.x=-img2.width/2;
        
    }


/*
     Function is used as indicator of boss enemys state,
     and when true, causes the scene to change from a level to a reward
*/
    boolean dead()
    {
      return dead;
    }


/*
    Draws boss enemy in its dying state based on the scene(AKA level its in)
    */
    void drawDying()
    {
      if(scene==2)
      {
        img2 = dyingFox[dyingFoxIndex];
        image(img2, pos.x-img2.width/2, pos.y-img2.height/2);
          
      }
      
      if(scene==5)
      {
        img2 = dyingFish[dyingFishIndex];
        image(img2, pos.x-img2.width/2, pos.y-img2.height/2);

      }
      
      if(scene==8)
      {
        img2 = dyingWitch[dyingWitchIndex];
        image(img2, pos.x-img2.width/2, pos.y-img2.height/2);
      }
    }
    
    /*
      Returns true if player and boss enemy are colliding
    */
    boolean hitC(Player p)
  {    
    
    return pos.dist(p.pos)<=(img2.width/2+playerimg.width/2);
  }
  
  
  /*
      Decrements the boss enemys health based on the players damage level
  */
  void updateHealth(int health)
  {
    this.health=this.health-(player.damage);
  }
   
}
