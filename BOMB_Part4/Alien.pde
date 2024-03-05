import ddf.minim.*;


class Alien {
 /* declare variables for alien position, direction of movement and appearance */
  int x; int y; int direction; boolean forwarding; int level;
  int spawnY;
  PImage appearance; 
  PImage explodedAppearance;
  float speed;
  int h; int w; //height and width
  boolean triggerExplosion;
  boolean speedup;
  float  sizeX; float sizeY;  //for explosion
 /* Constructor is passed the x and y position where the alien is to
 be created, plus the image to be used to draw the alien */
   
   //for challenge explosion only, no affect to main program.
PImage[][] imageSegments;
int numSegments = 4;
boolean blow;
int segmentSpeed;
float[][] segmentX;
float[][] segmentY;
float angle;
Bomb aBomb;
 
 Minim minim1;
 AudioSample blowsound;
 
 
 Alien(int xpos, int ypos, PImage alienImage, PImage explosion){
  /* set up the new alien object */ 
  x = xpos;
  y = ypos;
  spawnY = ypos;
  h = alienImage.height;
  w= alienImage.width;
  sizeX = w;
  sizeY = h;
  speed = 1;
  appearance = alienImage;    //height
  explodedAppearance = explosion;
  direction = A_FORWARD;
  triggerExplosion = false;
  level =spawnY;
  speedup = false;
  aBomb = null;
  
  //initialize attributes for challenge explosion
  imageSegments = new PImage[numSegments/2][numSegments/2];
  segmentX = new float[numSegments/2][numSegments/2];
  segmentY = new float[numSegments/2][numSegments/2];
  segmentSpeed = 5;
  segmentImage();

  minim1 = new Minim(this);
  blowsound = minim.loadSample("explosion2.mp3",512);
 }
 
 void dropBomb()
 {
   if(!triggerExplosion)
   {
   if(aBomb==null)
   {
     int i = int(random(1,1000));
     if(i==2)
     {
     aBomb  = new Bomb(x,y);
     }
   }
   else if(aBomb.offScreen())
   {
       int i = int(random(1,10));
       if(i==2)
       {
       aBomb  = new Bomb(x,y);
       }
     }
     else
     aBomb.move();
   }
   else
     if(aBomb!=null)
     aBomb.move();
 }
 
 Bomb getBomb()
 {
   return aBomb;
 }
 
  void explode()
  {
    if(!triggerExplosion){
   // float i = random(1,10);
   // if(i>=5.0&&i<=5.011)
    //{
    initSegments();
    }
    triggerExplosion=true;
   // triggerExplosion = true;    //everyframe p = 1% of blowing up
  //  }
    if(triggerExplosion){
    this.appearance = explodedAppearance;
    blowsound.trigger();
    }
  }
   
   // challenge explosion functions
void segmentImage() 
{
  int segmentWidth = appearance.width/2;
  int segmentHeight = appearance.height/2;
  for(int i =0 ; i< numSegments/2 ; i++)
  {
    for(int j = 0; j< numSegments/2 ; j++)
    {
      imageSegments[i][j] = appearance.get(i*segmentWidth,j*segmentHeight,segmentWidth,segmentHeight);
    }
  }
}
  // challenge explosion functions
void initSegments()
{
  for(int i =0; i<numSegments/2;i++)
  {
    for(int j = 0; j<numSegments/2 ; j++)
    {
      segmentX[i][j] = x+appearance.width/2;;
      segmentY[i][j] = y+appearance.height/2;;
    }
  }
}
  
 void move()
 {
  if(frameCount%500==0)
  {
    speed++;
    //textSize(32);
   // text("SPEED UP!",SCREENX/2-100,SCREENY/2);
    speedup = true;
  }
   if(x+w >= SCREENX-1)
   {     
   direction = A_DOWN;
   forwarding = false;
   }
   if(x <= 1)
   {
   direction = A_DOWN;
   forwarding = true;
   }
   if((y-spawnY)%(h-speed)>=0&&(y-spawnY)%(h-speed)<speed&&y>spawnY&&direction == A_DOWN)
   {
 //    println((y-spawnY)%(h-1));
       y+=speed;
       level = y;                       //set level everytime switching from moving down to moving forward or backward, in order to implement y = level + sin(sigma*X) .
     if(!forwarding)
     {
      direction = A_BACKWARD;
     }
     else
     {
    direction = A_FORWARD;
     }
   }

   if(direction==A_FORWARD)
   {
     x+=speed;
     y = level + int(10*sin(10*PI*(x/float(SCREENX-w))));        //y=sin(wt)=sin(wx/v)=sin(2PIx/waveLength);
   }
   if(direction==A_DOWN)
   {
     y+=speed;

   }
   if(direction==A_BACKWARD)
   {
     x-=speed;
     y = level + int(10*sin(10*PI*(x/float(SCREENX-w))));
   }
     dropBomb();
  /* Move the alien according to the instructions in the exercise */ 
 }
  
  void draw()
 {
    /* Draw the alien using the image() method demonstrated in class */
    

    if(triggerExplosion)
    {
      
      for(int i =0; i<numSegments/2;i++)
      {
        for(int j = 0; j<numSegments/2 ; j++)                    //for challenging explosion. If wanna switch, comment these and uncomment the blocks below!!
          {
           segmentX[i][j] += segmentSpeed*(2*i-1);
           segmentY[i][j] += segmentSpeed*(1-2*j);
           pushMatrix();
           translate(segmentX[i][j],segmentY[i][j]);
           rotate(radians(angle*2));
           image(imageSegments[i][j],0,0);
           popMatrix();
           angle++;
          }
       }
    }else
    {
    image(appearance,x,y);
    }
    if(aBomb!=null)
    aBomb.draw();
 }
}
      //image(appearance,x,y,sizeX,sizeY);                   // for disappearing-explosion!!
      //if(sizeX>0)
      //{
      //sizeX = lerp(sizeX, 0.0, 0.03);                      // decrease sizeX towards 0.0 by 0.03 each frame.
      //sizeY = lerp(sizeY, 0.0, 0.03);
      //}
class Elites extends Alien
{
  PImage eliteSkin;
  Elites(int xpos, int ypos, PImage skin, PImage es)
  {
    super(xpos , ypos, skin,es);
    direction = A_FORWARD;
  }
  void explode()
  {
    if(!triggerExplosion)
    {
       dropPowerUp(this);
       initSegments();
    }
       triggerExplosion=true;
       if(triggerExplosion){
       this.appearance = explodedAppearance;
    }
  }
}
