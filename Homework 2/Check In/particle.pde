class Particle{
  PVector pos; // Current Position of mass
  PVector vel; // Current velocity;
  PVector top; // Top of string
  float gravity; 
  float restLength; 
  
  float rad; 
  PVector massColor; 
  

  Particle anchor; // Reference to the mass to which the top of spring line is attached too. 
  boolean staticAnchor;  // True if anchor is static
  
  Particle(Particle initParticle){
    pos = new PVector(); 
    vel = new PVector();
    top = new PVector(); 
    
    pos.set(initParticle.pos); 
    vel.set(initParticle.vel); 
    top.set(initParticle.top); 
    
    gravity = grav;
    restLen = restLength; 
    rad = radius; 
    
    staticAnchor = false;
    anchor = initParticle;
  }
  
  Particle(PVector init_pos, PVector init_vel, PVector init_top,   //<>// //<>// //<>//
            float restLength, float radius, PVector initColor,
            boolean anchorMove, Particle init_Anchor){
   
    pos = new PVector(); 
    vel = new PVector();
    top = new PVector(); 
    massColor = new PVector(); 

    anchor = init_Anchor; 
    
    pos.set(init_pos); 
    vel.set(init_vel); 
    top.set(init_top); 
    
    gravity = grav; //<>// //<>// //<>//
    restLen = restLength; 

    rad = radius; 
    massColor = initColor; 
    
    staticAnchor = anchorMove; 
    
  }
  
  void update(float dt){
     //<>// //<>// //<>//
     // Check If the top is still in the same position 
    if(staticAnchor == false){
      if(top != anchor.pos) top.set(anchor.pos); 
    }
    
    float sx = (pos.x - top.x); 
    float sy = (pos.y - top.y); 
    float sz = (pos.z - top.z); 
    
    // Compute String Length
    float stringLen = sqrt((sx * sx) + (sy * sy) + (sz * sz)); // Euclidian Norm
    //print(stringLen, " ", restLen); 
   
    
    // Compute (Damped) Hooke's Law for the spring 
    float stringF_y = -k * (pos.y - top.y ) - restLength; 
    float stringF_x = -k * (pos.y - top.y ) - restLength;
    float stringF_z = -k * (pos.y - top.y ) - restLength;
   
    
    
    // Apply Force in the direction of the string
    float dirX = sx/stringLen; 
    float dirY = sy/stringLen; 
    float dampFX = -kv * (vel.x - 0); 
    float dampFY = -kv * (vel.y - 0); 
    
    // sanity check
    // //If are are doing this right, the top spring should be much longer than the bottom
    //println("l1:",ballY1 - stringTop, " l2:",ballY2 - ballY1, " l3:",ballY3-ballY2)
    
  
    // Integration
    
    // String Force
    vel.add((stringF*dirX*dt),(stringF * dirY*dt),0); 
    
    // Dampening
    vel.add((dampFX*dt), (dampFY*dt),0);
    
    // Gravity 
    vel.add(0,gravity * dt,0); 
    
    
    // Update Posistions
    
    pos.add(vel.x *dt , vel.y * dt, vel.z * dt); 
    
    // Collision detection and response
     
    if (pos.y + radius > floor){
      PVector velColUpdate = new PVector(vel.x, (vel.y*-0.9) , vel.z);
      PVector posColUpdate = new PVector(pos.y, floor-radius, pos.z); 
      vel.set(velColUpdate);
      pos.set(posColUpdate); 
      
    } 
    
  }
  
  void display(){
    pushMatrix(); 
    stroke(5); 
    line(top.x, top.y, pos.x, pos.y);
    translate(pos.x,pos.y);
    noStroke();
    fill(massColor.x, massColor.y, massColor.z);
    sphere(radius);
    popMatrix();

  }
 

  
  

  
}
