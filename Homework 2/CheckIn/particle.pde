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
  
  Particle vessel; // Reference to the mass which this particle serves as an anchor too; 
  Boolean isAnchor; // True if the mass acts as an anchor to another object
  
  float sx; 
  float sy; 
  float sz; 
  float stringLen; 
  float stringFx;
  float stringFy;
  float stringFz;
  float dampFx;
  float dampFy;
  float dampFz;  
  float forceX; 
  float forceY;
  float forceZ;
  float dirX; 
  float dirY; 
  float dirZ; 

  float accX; 
  float accY; 
  float accZ; 

  
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
    isAnchor = false; 
  }
  
  Particle(PVector init_pos, PVector init_vel, PVector init_top,   //<>//
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
    
    gravity = grav; //<>//
    restLen = restLength; 

    rad = radius; 
    massColor = initColor; 
    
    staticAnchor = anchorMove; 
    isAnchor = false; 
    
  }
  
  void addVessel(Particle newVessel){
    vessel = newVessel; 
    isAnchor = true; 
  }
  
  void update(float dt){ //<>//
     // Check If the top is still in the same position 
    if(staticAnchor == false){
      if(top != anchor.pos) top.set(anchor.pos); 
    }
    
    sx = (pos.x - top.x); 
    sy = (pos.y - top.y); 
    sz = (pos.z - top.z); 
    
    // Compute String Length
    stringLen = sqrt((sx * sx) + (sy * sy) + (sz * sz)); // Euclidian Norm
    //print(stringLen, " ", restLen); 
   
    // Compute (Damped) Hooke's Law for the spring 
    stringFx = -k * (pos.x - top.x ) - restLength; 
    stringFy = -k * (pos.y - top.y ) - restLength;
    stringFz = -k * (pos.z - top.z ) - restLength;
    
    if(staticAnchor == false){
      dampFx = -kv * (vel.x - anchor.vel.x);
      dampFy = -kv * (vel.y - anchor.vel.y);
      dampFz = -kv * (vel.z - anchor.vel.z);
    } else {
      dampFx = -kv * vel.x;
      dampFy = -kv * vel.y;
      dampFz = -kv * vel.z;      
    }
    

    dirX = sx/stringLen; 
    dirY = sy/stringLen; 
    dirZ = sz/stringLen; 
    
    forceX = dirX * stringFx + dampFx;  
    forceY = dirY * stringFy + dampFy;
    forceZ = dirZ * stringFz + dampFz;
    
    // Apply Force in the direction of the string

    
    //replace 30 with an actual mass variable
    if(isAnchor){
      accX = gravity + .5 * forceX - .5 * vessel.forceX; 
      accY = gravity + .5 * forceY - .5 * vessel.forceY; 
      accZ = gravity + .5 * forceZ - .5 * vessel.forceZ; 
    } else {
      accX = gravity + .5 * forceX; 
      accY = gravity + .5 * forceY; 
      accZ = gravity + .5 * forceZ; 
    }
      
    // Integration
    
    vel.add(accX,accY,accZ);
    vel.mult(dt); 
    
    pos.add(accX, accY, accZ); 
    pos.mult(dt); 
    
    // Update Posistions   
    // Collision detection and response
     
    if (pos.x + radius > floor){
      PVector velColUpdate = new PVector(vel.x*-0.9, vel.y , vel.z);
      PVector posColUpdate = new PVector(floor - radius, vel.y, pos.z); 
      vel.set(velColUpdate);
      pos.set(posColUpdate);
    }
    if (pos.y + radius > floor){
      PVector velColUpdate = new PVector(vel.x, (vel.y*-0.9) , vel.z);
      PVector posColUpdate = new PVector(pos.y, floor-radius, pos.z); 
      vel.set(velColUpdate);
      pos.set(posColUpdate);
    }
    if (pos.z + radius > floor){
      PVector velColUpdate = new PVector(vel.x, vel.y , (vel.z * -0.9));
      PVector posColUpdate = new PVector(pos.y, vel.y, floor-radius); 
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
    
    println("pos: " + pos); 
    println("vel: " + vel); 

  }
 

  
  

  
}
