class Shield
{
  int x; int y; int a;
  boolean active;
  
  Shield(int xpos, int ypos)
  {
    x = xpos;
    y = ypos;
    a = 50;
    active = true;
  }
  
  void block(Bullet aBullet)
  {
    if(active&& aBullet.valid)
    {
     if(aBullet.y<=y+a && aBullet.y>= y && aBullet.x+aBullet.bulletWidth>=x && aBullet.x <= x+a)
     {
       active = false;
       aBullet.valid = false;
     }
    }
  }
  void protect(Bomb aBomb)
  {
    if(active)
    {
      if(aBomb.y+aBomb.h>=y && aBomb.y<=y+a && aBomb.x+aBomb.w>=x && aBomb.x<=x+a)
      {
        active = false;
        aBomb.valid = false;
      }
    }
  }
  
  void draw()
  {
    noStroke();
    if(active)
    rect(x,y,a,a);
  }
  
}
