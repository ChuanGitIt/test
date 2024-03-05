class Bomb
{
  int x; int y; PImage appearance; int speed;
  int h; int w; boolean collided; 
  boolean valid;
  Bomb(int xpos, int ypos)
  {
    x = xpos;
    y = ypos;
    appearance = bombImage;
    h = appearance.height;
    w = appearance.width;
    collided = false;
    valid = true;
  }
  void move()
  {
    if(valid)
    y++;
      if(offScreen())
      valid = false;
  }
  void draw()
  {
    if(valid)
    image(appearance,x,y);
 //   else
 //   {
 //     image(bombExploded,x,y);
 //   }
  }
  
  void collide(Player tPlayer)
  {
    if((x+w>=tPlayer.x && x<=tPlayer.x + tPlayer.w && y+h>=tPlayer.y && y<= tPlayer.y + tPlayer.h))
    {
      collided = true;
      appearance = bombExploded;
     // print("collided");
    }
    
  }
  
  
  
  boolean offScreen()
  {
    if (y> SCREENY)
    return true;
    else
    return false;
  }
  
}
