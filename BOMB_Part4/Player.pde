class Player
{
  int x; int y; PImage laserGun;
  int h ; int w; int distance;
  int upgrade; int startTime;
  Player( int xpos , int ypos , PImage appearance)
  {
    w = appearance.width;
    distance = 5;
    x = xpos;
    y = ypos;
    laserGun = appearance;
    upgrade = -1;
  }
  void move()
  {
    if(keyPressed)
    {
      if(key == 'a')
        x -= distance;
      if(key == 'd')
        x += distance;
    }
    if(x<distance)
    {
      x = 1;
    }else if(SCREENX - w - distance < x)
    {
      x = SCREENX - w;
    }
    
  }
  void powerUp(PowerUp power)
  {
    String message = "";
    if(power.x > x && power.x < x+w && power.y >= y && power.y<SCREENY)
    {
     upgrade = power.type;
      powerUpTime = millis();
      if(upgrade == 0)
     {
        message="DOUBLE BARREL RELOAD!"; 
     }
     else if(upgrade == 1)
     {
       message = "FAT BULLET!";
     }
     else if(upgrade == 2)
     {
       message = "SNIPE'EM!";
     }
    }
  //     textAlign(CENTER, CENTER);
    //   textSize(32);
    //   fill(255);
   //       text(message,SCREENX/2,SCREENY/2);
    
  }
  
  
  void draw()
  {
     image(laserGun,x,y);  
  }
  
  
}
