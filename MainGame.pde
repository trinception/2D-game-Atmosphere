
//Importing controlP5 library
import controlP5.*;
//Calling controlP5 class
ControlP5 controlP5;
//Declaring button variables 
Button play, credit, replayWin, replayLose;
//Importing minim library
import ddf.minim.*;
Minim minim = new Minim(this);
//Declaring song variables: BGSong(backGround music),
AudioPlayer BGSong, fire, deathBell, laugh, reward, witchCackle;

int currentImgIdx=0;
int flag=0;
    //Declaring arrays for image-based animation of the players many states: standing, shooting, running right, running left, and running down
    PImage[] playerStanding= new PImage[11]; 
    PImage[] playerShooting= new PImage[6];
    PImage[] playerShootingL= new PImage[6];
    PImage[] playerRunningR= new PImage[14];
    PImage[] playerRunningL= new PImage[14];
    PImage[] playerRunningD= new PImage[10];

    //Declaring arrays for the image-based animation of "level complete" type screens where the player earns a key as well as a rainy background for level 3
     PImage[] winning1= new PImage[12];// Level complete award screen
     PImage[] winning2= new PImage[12];// Level complete award screen
     PImage[] level3BG= new PImage[12];// Level 3 background
     
     //Declaring arrays for the image-based animation of level 1 basic enemies("basicWalking") and boss enemy("walking")
     PImage[] basicWalking= new PImage[13];
     PImage[] walking = new PImage[8];
     PImage[] dyingFox= new PImage[5]; //In addition to the boss enemies dying sequence
     
     //Declaring arrays for the image-based animation of level 2 basic enemies("basicSwimming") and boss enemy("swimming")
     PImage[] basicSwimming= new PImage[15];
     PImage[] swimming= new PImage[15];
     PImage[] dyingFish= new PImage[5]; //In addition to the boss enemies dying sequence
     
     //Declaring arrays for the image-based animation of level 3 basic enemies("basicFlying") and boss enemy("flying")
     PImage[] basicFlying= new PImage[8];
     PImage[] flying= new PImage[16];
     PImage[] dyingWitch= new PImage[11];//In addition to the boss enemies dying sequence
     
     //Declaring global variable used to store states of basic enemies("img") and boss enemies ("img2")
     PImage img,img2,playerimg;
      
       //Declaring instance of Player class
      Player player;
    
      //Declaring instance of Boss Enemy class
      BossEnemy b;
      
      //Declaring ArrayList of enemies
      ArrayList<Enemy> enemies= new ArrayList<Enemy>();
      
      //Initializing scene- To be used in boolean expression to determine what gameScreen is displayed
      int scene=0;
      
     //Declaring and Initializing instance of GameScreen class, at scene=0
      GameScreen gameScreen = new GameScreen(scene);
   
 //Initializing variables for determining directional booleans-Will help determine which way the player moves    
  boolean right= false;
  boolean left= false;
  boolean down=false;
  boolean up=false;
  boolean shoot=false; //and an action boolean- will help determine when the player shoots

  //Initializing PVector variables for when the directional booleans(above) become true- cause the player to move in a different direction
  PVector rightForce = new PVector(1,0);
  PVector leftForce = new PVector(-1, 0);
  PVector upForce=new PVector(0,-1);
  PVector downForce=new PVector(0,1);

  //Declaring static image variable names
  PImage pWeapon /*player weapon*/, eWeapon/*enemy weapon*/,deadEnemy/*dead basic enemy*/, submarine/* used by player in level 2*/;
  PImage prompt1 /* start screen*/, prompt2/*Instructions/Narrative 1*/, prompt3/* Instructions/Narrative 2*/, prompt4/* Instructions/Narrative 3*/;
  PImage BG1/* Level 1 backGround*/, BG2/* Level 2 backGround*/, end/* endScreen backGround*/, gameOver/* game over backGround*/, credits/*credits page*/;

  void setup() {
  
    size(800,600);
  
    //Initializing player variable- To be used throughout game
    player= new Player(400, 305, 0, 0, 20, 1);
    
    //Initializing BossEnemy variable
     b= new BossEnemy(795, random(305, 500), -5, 0, 5, 2);
    
    //Initializing indexes for enemy ArrayList
     for( int i=0; i<3; i++)
    {
        
        enemies.add(new Enemy(random(800,1000), random(305, 500), -2, 0, 3, 1));
        
    }
     
     
     //Initializing all buttons
      controlP5= new ControlP5(this);
      
      play = controlP5.addButton("Start", 0, 150, 300, 200, 70); //1/2 Buttons on start screen- when clicked it will bring user to first instrcutions page
      PFont pfont = createFont("Atmosphere",20,true); 
      play.getCaptionLabel().setFont(pfont); 
      play.setColorLabel(color(255)); 
      play.setColorBackground(color(91, 39, 48));
      
      credit = controlP5.addButton("Credits", 0, 440, 300, 200, 70); //2/2 Buttons on start screen- when clicked it will bring user to credits page
      credit.getCaptionLabel().setFont(pfont); 
      credit.setColorLabel(color(255)); 
      credit.setColorBackground(color(91, 39, 48));
     
      replayWin = controlP5.addButton("Replay", 0,width/2-75, 500, 150, 50); //Button on end screen page- shown when user has won the game, when clicked takes user to start
      replayWin.getCaptionLabel().setFont(pfont); 
      replayWin.setColorLabel(color(255)); 
      replayWin.setColorBackground(color(255,228,228));
      
      replayLose = controlP5.addButton("Try Again", 0, width/2-50, 400, 200, 50);//Button on game over screen- shown when user has died, when clicked takes user to start
      replayLose.getCaptionLabel().setFont(pfont); 
      replayLose.setColorLabel(color(255)); 
      replayLose.setColorBackground(color(36,32,69));
   
   
      //Loading all sounds
      BGSong = minim.loadFile("Szymon Matuszewski - Gooey.mp3"); //background music
      fire= minim.loadFile("gunshot.mp3"); //gunshot sound
      deathBell=minim.loadFile("deathBell.mp3");//sounds when basic enemy dies
      laugh=minim.loadFile("evilLaugh1.mp3");//sounds when boss enemy dies
      reward=minim.loadFile("winSound.mp3");//sounds when user passes a level/ gets reward
      witchCackle=minim.loadFile("witchCackle.mp3");// sounds when player bumps into witch enemies
      
      BGSong.loop();
   
        //load all images
        
        
        // Initializing pWeapon variable & submarine variable/ loading player weapon image & submarine image
        pWeapon = loadImage("playerWeapon.png");
        submarine= loadImage("submarine.png");
        
        //Initializing player state arrays/ loading player standing, shooting, dying, running right, and running left images
          for(int i=0; i<playerStanding.length; i++)
          {
            playerStanding[i]= loadImage("PlayerStanding"+i+".png");
          }
          /*for(int i=0; i<playerShooting.length; i++)
          {
            playerShooting[i]= loadImage("PlayerShooting"+i+".png");
          }
          for(int i=0; i<playerShootingL.length; i++)
          {
            playerShootingL[i]= loadImage("PlayerShootingL"+i+".png");
          }*/
          for(int i=0; i<playerRunningR.length; i++)
          {
            playerRunningR[i]= loadImage("PlayerRunningR"+i+".png");
          }
          for(int i=0; i<playerRunningL.length; i++)
          {
            playerRunningL[i]= loadImage("PlayerRunningL"+i+".png");
          }
          for(int i=0; i<playerRunningD.length; i++)
          {
            playerRunningD[i]= loadImage("PlayerRunningD"+i+".png");
          }
          
          
        // Initializing eWeapon variable/ loading enemy weapon image
        eWeapon= loadImage("EnemyWeapon.png");
        
        
        //Initializing basic enemy and boss enemy state arrays/ loading basic enemies/ boss enemies movement images
        
          //Initializing how all basic enemies die/ loading death image
            deadEnemy= loadImage("deadBasicEnemy.png");
            
                  //This is the basic fox walking action
                 for(int i=0; i<basicWalking.length; i++)
                  {
                    basicWalking[i]= loadImage("FoxEnemy"+i+".png");
                  }
                  
             //This is the boss fox walking action and dying action
             for(int i=0; i<walking.length; i++)
              {
                walking[i]= loadImage("BossFoxEnemy"+i+".png");
              }
              for(int i=0; i<dyingFox.length;i++)
              {
                dyingFox[i]= loadImage("deadBossFox"+i+".png");
              }
              
              
                  //This is the basic fish swimming action
                   for (int j=0; j<basicSwimming.length; j++)
                  {
                    basicSwimming[j]=loadImage("FishEnemy"+j+".png");
                  }
                  
              //This is the boss fish swimming action and dying action
              for (int j=0; j<swimming.length; j++)
              {
                swimming[j]=loadImage("BossFishEnemy"+j+".png");
              }
              for(int i=0; i<dyingFish.length;i++)
              {
                dyingFish[i]= loadImage("DeadBossFishEnemy"+i+".png");
              }
              
              
                  //This is the basic witch flying action
                  for (int j=0; j<basicFlying.length; j++)
                  {
                    basicFlying[j]= loadImage("witchEnemy"+j+".png");
                  }
              
              //This is the boss witch flying action and dying action
             for (int j=0; j<flying.length; j++)
                  {
                    flying[j]= loadImage("bossWitchFlying"+j+".png");
                  }
             for (int j=0; j<dyingWitch.length; j++)
                  {
                    dyingWitch[j]= loadImage("BossWitchDying"+j+".png");
                  }
           
       //Initializing static screen variables/ loading their images. 
       prompt1 = loadImage("prompt.png");//Start screen- prompts user for keyboard interaction
       prompt2 = loadImage("prompt2.png");//First instruction/narrative screen- prompts user for keyboard interaction
       prompt3 = loadImage("prompt3.png");//Second narrative/instruction screen- prompts user for keyboard interaction
       prompt4 = loadImage("prompt4.png");//Final narrative/instruction screen- prompts user for keyboard interaction
       BG2= loadImage("level2BG.png"); //Background of level 2
       BG1= loadImage("level1BG.png"); // Background of level 1
       end= loadImage("endScreen.png"); // background of end screen
       credits= loadImage("creditsPage.png");// credits page
       gameOver= loadImage("gameOver.png");//game over page
   
   //Initializing screen state arrays/ loading key rotation images
       for(int i=0; i<winning1.length;i++)
          {
            winning1[i]= loadImage("lvl1Complete"+i+".png");
          }
          
       for(int i=0; i<winning2.length;i++)
         {
            winning2[i]= loadImage("lvl2Complete"+i+".png");
         }
    
       for(int i=0; i<level3BG.length;i++)//As well as level 3 raining background
         {
           level3BG[i]= loadImage("level3BG"+i+".png");
         }
         
}

void draw() 
{
  // Using nested if-else statements to determine which gamescreen is shown
  // I am aware that switch is considered slightly better, however when I applied it nothing showed at all
    if(scene==0)
    {
      gameScreen.startScreen();
    }else if(scene==1)
    {
      gameScreen.drawInstructions1();
    }else if( scene==2)
    {
      gameScreen.drawLevel1();
    }else if(scene==3)
    {
      gameScreen.drawReward1();
      gameScreen.updateScreen();
    }else if(scene==4)
    {
      gameScreen.drawInstructions2();
    }else if(scene==5)
    {
      gameScreen.drawLevel2();
    }else if(scene==6)
    {
      gameScreen.drawReward2();
      gameScreen.updateScreen();
    }else if (scene ==7)
    {
      gameScreen.drawInstructions3();
    }else if (scene==8)
    {
      gameScreen.drawLevel3();
      gameScreen.updateLevelScreen();
    }else if(scene==9)
    {
      gameScreen.endScreen();
    }else if(scene==10)
    {
      gameScreen.gameOverScreen();
    }else if(scene==11)
    {
      gameScreen.creditsScreen();
    }
    
      
}

/* 
  This determines the players response when a key is pressed
  this is a step to it moving and shooting based on these booleans
*/
void keyPressed()
    {
          if(key == CODED && keyCode == RIGHT)
          {
            right = true;
          }
          if(key == CODED && keyCode == LEFT)
            left = true;
          if(key == CODED && keyCode == UP)
            up = true;
          if(key == CODED && keyCode == DOWN)
            down = true;
          if(key == ' ')
          {
            shoot=true;
          }
    }
/*
 This is the step that makes sure that when the key is released, 
 the conditions above don't remain active
 
*/
void keyReleased()  
    {
        if(key == CODED && keyCode == RIGHT) 
            right = false;
          if(key == CODED && keyCode == LEFT)
            left = false;
          if(key == CODED && keyCode == UP)
            up = false;
          if(key == CODED && keyCode == DOWN)
            down = false;
          if(key== ' ')
            shoot=false;
    }

/*
    This controls each buttons response to being clicked,
    by bringing it to the scene state it leads to 
*/
 void controlEvent(ControlEvent theEvent) {
      if (theEvent.getController().getName() =="Start") 
        {
 
            scene = 1; //clicking the start button leads to the first instructions page
            
        }else if (theEvent.getController().getName() =="Credits")
        {
            scene=11;//clicking the credits button leads to the credits page
            
        }else if (theEvent.getController().getName() =="Replay" )
        {
            gameScreen.restartGame(); // clicking the replay button leads to the game being restarted
            
        }else if(theEvent.getController().getName() =="Try Again")
        {
          gameScreen.restartGame(); // same as above, except with the try again button
        }
        
    }
    
 /*
     I found myself repeating this chunk of code a lot in the GameScreen classes methods,
     and felt it would be much more efficient to give it its own class.
     This class hides every button from user view.
 */
     void hideButtons()
     {
       controlP5.getController("Start").hide();
       controlP5.getController("Credits").hide();
       controlP5.getController("Replay").hide();
       controlP5.getController("Try Again").hide();
     }
