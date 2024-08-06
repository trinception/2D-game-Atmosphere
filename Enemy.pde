 class Enemy extends Character{

  boolean tell=false; //Declaring and initialing variable to be used as a flag in hitC- 
                      //prevents the impact between player and enemy from taking too much of the players health
                      
                      
  int walkingIdx=0;//Declaring and initializing variable for use as an incrementing index for walking fox
  int swimmingIdx=0;//Declaring and initializing variable for use as an incrementing index for swimmingfish
  int flyingIdx=0; //Declaring and initializing variable for use as an incrementing index for flying boss witch
  
  
  int health=3;//Declaring and initializing variable for enemy health
  int timer=60;//Declaring(step 1) and initializing(step 2) a timer to be used when enemy is dying
  int damage=1;//Declaring and initializing a variable that determines amount of harm enemy imposes on player health
  
  //Declaring ArrayList of enemy weapons
    ArrayList<EnemyWeapon> eWeapons = new ArrayList<EnemyWeapon>();


//Class constructor for enemy
 Enemy(float x, float y, float speedX, float speedY, int health, int damage)
  {
    super( x, y, speedX, speedY, health, damage);
  }
  
  
  /*
    Draws Enemy in each of its forms depending on the scene(AKA level) of the game
    (called in update)
  */
  void drawMe(){
    pushMatrix();
    translate(pos.x,pos.y);
    if(health< 3)
    {
      fill(0,255, 18);
      rect(5, -20, health*13.3, 10);
      noFill();
      stroke(255);
      rect(5, -20, 40, 10);
    }
    
    if (scene>0&& scene<3)
    {
     img = basicWalking[walkingIdx];
      image(img, 0, 0);
    }
      if(scene==5)
      {
        img = basicSwimming[swimmingIdx];
        image(img, 0,0);
      }
      if(scene==8)
      {
        img = basicFlying[flyingIdx];
        image(img, 0,0);
        
      }
    
    popMatrix();
  }
  
  
  
  /*
    Draws enemy in its dying state
    (called in update)
    */
  void drawDying()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    image(deadEnemy,0,0);
    popMatrix();
  }
  
  
  /*
    Called in all three levels of the game- checks projectiles, makes it move, shoots, handles walls, shows image sequence based on level
    Shows enemy dying: changes death boolean to tru when the timer is at 0
  */
  void update()
   {
     
     if(health>0){
      drawMe();
      if(scene==2)
      {
            if(frameCount%3==0)
            {
              walkingIdx++;
              if(walkingIdx == basicWalking.length)
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
              if(swimmingIdx == basicSwimming.length)
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
                if(flyingIdx == basicFlying.length)
              {
                flyingIdx=0;
              }
              }
      }
      shoot();
      move();
      handleWalls();
      if(scene==2){
      checkGround();
      }
      checkWeapons();
      if( hitC(player)){
        resolveCollision(player);
        player.updateHealth(damage);
        if(scene==8)
        {
          witchCackle.play(0);
        }
      }
      
    }else{
        timer--;

        drawDying();
        if(timer==0)
        {
          deathBell.play(0);
          enemies.remove(this);
        }

   }
   }
   
   /*
     Causes enemy to move based on vel its given
     (called in udpate)
   */
   void move()
   {
     this.pos.add(vel);
   }
   
   
   /*
  Causes enemy to, when at edge of screen, appear on the other side
  (called in update)
*/
    void handleWalls()
   {
    if (pos.x<-img.width/2) 
      pos.x=width+img.width/2;
    if (pos.x>width+img.width/2) 
      pos.x=-img.width/2;
   }
   
   
    /*
      Returns true if player and enemy are colliding
    */
  boolean hitC(Player p)
  {  
    if(!tell){
     if(pos.dist(p.pos)<=(img.width/2+playerimg.width/2)){
       tell=true;
       return true;
     }
   }
   else{
     if(pos.dist(p.pos)>(img.width/2+playerimg.width/2))
     {
       tell=false;
     }
     
   }
   return false;
     
  }
   
  
   
   //Resolves collision between player and enemy- sends the enemy in the opposite x direction
   void resolveCollision(Player p)
 {
   float nSpeed= (this.vel.mag());
   this.vel.set( nSpeed, 0);
 }
 
 
 //Makes sure enemy is within ground area
 void checkGround()
 {
    if (pos.y<305+img.height/2-20) 
      vel.y=-vel.y;
    if (pos.y>height+57/2) 
      vel.y=-vel.y;

 }
 
  /*
      Causes Enemy to fire projectile automatically every fraction of a second
      (called in update)
  */
 void shoot(){
   if(scene==2) //Level 1
   {
     
    if(frameCount%90==0)
        eWeapons.add(new EnemyWeapon( pos.x, pos.y, -5, 0));
   }else if(scene==5) //Level 2
   {
     if(frameCount%60==0)
         eWeapons.add(new EnemyWeapon( pos.x, pos.y, -5, 0));
   }else if(scene==8)
   {
     if(frameCount%(random(30,60))==0)
         eWeapons.add(new EnemyWeapon( pos.x, pos.y, -5, 0));
   }
  }
  
  //checks enemy weapons for collisions and removes them and decrements player health if so
  void checkWeapons()
  {
    for( int i=0; i<eWeapons.size(); i++)
    {
      EnemyWeapon ew = eWeapons.get(i);
      ew.update();
       if(ew.hitP(player))
        {
          eWeapons.remove(ew);
          player.updateHealth(damage);
        }
      }
    }
  
  //Decrements enemy health
  void updateHealth(int health)
  {
    this.health--;
  }
 }
