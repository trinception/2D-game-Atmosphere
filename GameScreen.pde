class GameScreen{
    PFont font;
    int timer= 360;
    int flag=0;
    int counter =0;
    
    int currentImgIdx=0;
    int currentImgIdx0=0;
    
    //fill mountains
    color lightBlue=color(229,215,217);
    color darkBlue=color(191,168,171);
    color navyRed=color(84,42,49);
    color gray= color(243,236,237);
    //fill ground
    color green= color(240,249,210); //211,249,181
    //fill sky
    color white= color(255);
    color skyPink= color(255, 229, 228);
    
    
    
    int screen=0;
    
    GameScreen(int gameScreen)
    {
      this.screen = gameScreen;
      
    }


//shows start screen
     void startScreen()
     {
       image(prompt1,0,0);
        controlP5.getController("Start").show();
        controlP5.getController("Credits").show();
        controlP5.getController("Replay").hide(); 
        controlP5.getController("Try Again").hide();
     }
      
   /* void controlEvent(ControlEvent theEvent) {
      if (theEvent.getController().getName() =="Start") 
        {
 
            scene = 1; 
        }
    }*/
      //shows instructions/narrative for level 1
     void drawInstructions1()
     {
       hideButtons();
       
       image(prompt2,0,0);
       if(keyPressed && key=='c')
       {
         scene=2;
       }
      
     }
         
              //displays level one, including player interaction and enemy/ boss enemy as well as feedback elements  
     void drawLevel1()
     {
       hideButtons();
       
       image(BG1,0,0);
       displayScores();
       player.update();
       if( player.dead())
       {
         scene=10;
       }
       if(right)
        player.accelerate(rightForce);
       if(left)
        player.accelerate(leftForce);
       if(down)
        player.accelerate(downForce);
       if(up)
        player.accelerate(upForce);
       if(shoot)
        {
        player.shoot();
        }
        
       for( int i= 0; i<enemies.size();i++)
       {
         Enemy e=enemies.get(i);
         e.update();
       }
        if(enemies.size()==0)
       {
         b.update();
       }
       if(b.dead())
       {
         reward.play(0);
         scene=3;
       }
       if(keyPressed && key=='d')
         scene =3;
       flag=0;
     }
     
     //Draws first reward scene after level 1- has rotating key
     void drawReward1()
     {
      hideButtons();
      
      PImage img = winning1[currentImgIdx];
      image(img, 0, 0);
       
     }
     
     //updates the reward screens that follow level 1 and 2- ensures they go to the next scene on their own(in 6 seconds)
     void updateScreen()
     {
       timer--;
       //BGSong.pause();
       if(frameCount%10==0)
       {
          currentImgIdx++;
          if(currentImgIdx == winning1.length)
          {
           currentImgIdx=0;
          }
        }
        if (timer==0)
        {
          scene++;
          //BGSong.loop();
          currentImgIdx=0;
          timer=360;
        }
     }
     
     //shows instructions/narrative for level 2
     void drawInstructions2(){
       image(prompt3, 0,0);
       hideButtons();
       
       player.health+=10;
       player.damage+=1;
       if (player.health>20)
       {
         player.health=20;
       }

       if(keyPressed && key=='a')
       {
          scene=5;
       }
     }
       
       
        //displays level two, including player interaction and enemy/ boss enemy as well as feedback elements  
     void drawLevel2()
     {
       hideButtons();
           image(BG2, 0, 0);
           if(flag==0)
           {
             enemyRespawn();
             bossRespawn(); 
             flag=1;
           }
           displayScores();
           player.update();
           if( player.dead())
           {
             scene=10;
           }
           
           if(right)
           {
            player.accelerate(rightForce);
           }
           if(left)
           {
            player.accelerate(leftForce);
           }
           if(down)
           {
            player.accelerate(downForce);
           }
           if(up)
           {
            player.accelerate(upForce);
           }
           if(shoot)
            {
                player.shoot();
            }
            
            
           for( int i= 0; i<enemies.size();i++)
           {
             Enemy e=enemies.get(i);
             e.update();
           }
           
           
           if(enemies.size()==0)
           {
             b.update();
           }
           
           if(b.dead())
           {
             reward.play(0);
             scene=6;
           }
           
           if(keyPressed && key=='d')
           {
             scene =6;
           }
      }
      
      //Draws second reward scene
      void drawReward2()
      {
        hideButtons();
        
         PImage img = winning2[currentImgIdx];
         image(img, 0, 0);
      }
      
      
      //shows instructions/narrative for level 3
      void drawInstructions3()
      {
        hideButtons();
        image(prompt4,0,0);
        flag=0;
        player.health=20;
        player.damage+=2;
        if(keyPressed && key== 'w')
        {
          scene=8;
        }
        
      }
      
      //displays level three, including player interaction and enemy/ boss enemy as well as feedback elements 
      void drawLevel3()
      {
        hideButtons();
        PImage img = level3BG[currentImgIdx0];
        image(img, 0, 0);
        player.update();
        if( player.dead())
       {
         scene=10;
       }
        displayScores();
        if(flag==0)
        {
          enemyRespawn();
          bossRespawn();
          flag=1;
        }
        
        if(right)
           {
            player.accelerate(rightForce);
           }
           if(left)
           {
            player.accelerate(leftForce);
           }
           if(down)
           {
            player.accelerate(downForce);
           }
           if(up)
           {
            player.accelerate(upForce);
           }
           if(shoot)
            {
                player.shoot();
            }
            
            
           for( int i= 0; i<enemies.size();i++)
           {
             Enemy e=enemies.get(i);
             e.update();
           }
           
           
           if(enemies.size()==0)
           {
             b.update();
             witchCackle.loop();
           }
           if(b.dead())
           {
             reward.play(0);
             scene=9;
           }
       
        if(keyPressed&&key=='d')
        {
          scene=9;
        }
      }
      
      
      //Updates level screen to ensure it continues to show movement- called in main sketch
      void updateLevelScreen()
      {
        if(frameCount%10==0)
       {
          currentImgIdx0++;
          if(currentImgIdx0 == level3BG.length)
          {
           currentImgIdx0=0;
          }
        }
      }
      
      //shows end screen after player has completed game
      void endScreen()
      {
        controlP5.getController("Start").hide();
        controlP5.getController("Credits").hide();
        controlP5.getController("Try Again").hide();
        controlP5.getController("Replay").show();
        image(end,0,0);
        flag=0;
        witchCackle.pause();
        
      }
      
      //shows end screen when olayer has died
      void gameOverScreen()
      {
        controlP5.getController("Start").hide();
        controlP5.getController("Credits").hide();
        controlP5.getController("Replay").hide();
        controlP5.getController("Try Again").show();
        image(gameOver,0,0);
        witchCackle.pause();
      }
      
      //Gives credit for images and sounds
      void creditsScreen()
      {
        hideButtons();
       
        image(credits,0,0);
        if(keyPressed&& key=='b')
        {
          scene=0;
        }
      }
      
      //restarts ga,e
      void restartGame()
      {
          
          if(enemies.size()>0&& scene==2 |scene==5 | scene==8)
          {
           for(int i=0; i<enemies.size();i++)
            {
              enemies.remove(this);
            }
            
          }
          
          scene=0;
          
          player= new Player(400, 305, 0, 0, 20, 1);
          if(flag==0)
          {
              for( int i=0; i<3; i++)
              {
                    enemies.add(new Enemy(random(800,1000), random(305, 500), -2, 0, 3, 1));
              
              }
              b= new BossEnemy(795, random(305, 500), -5, 0, 5, 2);
              flag=1;
          }
      }
      
      
    void displayScores()
    {
         font= loadFont("GB18030Bitmap-48.vlw");
         stroke(255);
         textFont(font, 20);
         
         if(scene==2)
         {
           fill(navyRed);
             
           for (int i=0; i<player.health;i++)
             {
               rect(150+(i*12.5), 10, 12.5, 50);
             }
           
         }else if (scene==5)
         {
           fill(23, 39, 88);
           for (int i=0; i<player.health;i++)
             {
               rect(150+(i*12.5), 540, 12.5, 50);
             }
        
         }else if(scene==8)
         {
           fill(228,143,99);
           for (int i=0; i<player.health;i++)
             {
               rect(150+(i*12.5), 10, 12.5, 50);
             }
         }
         textFont(font, 15);
         //text(enemies.size() + " enemies left", 600, 30);
       
     }
   
   
   
     void enemyRespawn()
     {
      
       if(scene==2)
       {
         
       
           for( int i=0; i<5; i++)
          {
                enemies.add(new Enemy(800, random(50, 500), -4, 0, 5, 1));
          
          }
          
       }
       
       if(scene==5)
       {
         
       
           for( int i=0; i<5; i++)
          {
                enemies.add(new Enemy(800, random(50, 500), -4, 0, 5, 1));
          
          }
          
       }
       
       if(scene==8)
       {
         
         for(int i=0; i<5;i++)
         {
           enemies.add(new Enemy(800, random(305, 500), -6, 0, 5, 1));
         }
       }
      
     }
     
     
     
     void bossRespawn()
     {
       if(scene==5)
       {
         b= new BossEnemy(800, random(305, 500), -6, 0, 7, 2);
         b.dead=false;
       }else if( scene==8)
       {
         b= new BossEnemy(800, random(305, 500), -6, 0, 10, 2);
         b.dead=false;
       }
   
     }
}
