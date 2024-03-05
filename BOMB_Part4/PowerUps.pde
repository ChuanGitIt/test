class PowerUp
{
  int x;int y;int r; int speed;
  int type;
  PowerUp(int xpos, int ypos)
  {
    x = xpos;
    y = ypos;
    speed = 3;
    r = 10;
    type = int(random(3));
  }
  
  void move()
  {
    y += speed;
  }
  
  void draw(Player tPlayer)
  {
    if(type==0)
      fill(255,0,0);
    else if(type == 1)
      fill(0,255,0);
    else if(type == 2)
      fill(0,0,255);
    if(y<=tPlayer.y)
      ellipse(x,y,r,r);
  }
  
}
