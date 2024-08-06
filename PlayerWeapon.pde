class PlayerWeapon extends Weapon{
  
  
  PlayerWeapon(float x, float y_, float speedX, float speedY)
  {
    super(x, y_, speedX, speedY);
  }
  
  void drawW(){
    pushMatrix();
    translate(pos.x+30,pos.y+40);
    image(pWeapon,0,0);
    popMatrix();
  }
  
  
  boolean hitE(Enemy e)
  {
    
    return pos.dist(e.pos)<((img.width-10)/2 + pWeapon.width/2);
    
  }
  
  boolean hitB(BossEnemy b)
  {
    return pos.dist(b.pos)<(img2.width/2+ pWeapon.width/2);
  }
  
  void checkWalls()
  {
    if( pos.x>800 || pos.x <0)
        player.weapons.remove(this);
  }
  
  
  
}
