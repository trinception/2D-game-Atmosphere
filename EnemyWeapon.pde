class EnemyWeapon extends Weapon{
  
  
  EnemyWeapon(float x, float y_, float speedX, float speedY)
  {
    super( x, y_, speedX, speedY);
  }
  
  
  /*
    Draws Enemy weapon
    (called in update)
  */
  void drawW()
  {
    pushMatrix();
    translate(pos.x, pos.y+30);
    
    image(eWeapon, 0,0);
    
    
    popMatrix();
  }
    
    
    //Checks to see if player and projectile have collided- if so, returns true
  boolean hitP(Player p)
  {
    return pos.dist(p.pos)<(playerimg.width/2 + eWeapon.width/2);
  }
  
  
}
