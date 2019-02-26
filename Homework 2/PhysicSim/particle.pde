class Particle{
  PVector pos; // Current Position of mass
  PVector vel; // Current velocity;
  PVector top; // Top of string
  float gravity; 
  float restLength; 
  
  float rad; 
  PVector massColor; 
  

  Particle anchor; // Reference to the mass to which the top of spring line is attached too. 
  boolean staticAnchor;  // True if anchor is fixed and does not move
  
  Particle vessel; // Reference to the mass which this particle serves as an anchor too; 
  Boolean isAnchor; // True if the mass acts as an anchor to another object
  
  float sx; 
  float sy; 
  float sz; 
  float stringLength; 
  float stringF;
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
    restLength = restLen; 
    rad = radius; 
    
    staticAnchor = false;
    anchor = initParticle;
    isAnchor = false; 
  }
  
  Particle(PVector init_pos, PVector init_vel, PVector init_top,  
            float restLen, float radius, PVector initColor,
            boolean anchorMove, Particle init_Anchor){
   
    pos = new PVector(); 
    vel = new PVector();
    top = new PVector(); 
    massColor = new PVector(); 

    anchor = init_Anchor; 
    
    pos.set(init_pos); 
    vel.set(init_vel); 
    top.set(init_top); 
    
    gravity = grav;
    restLength = restLen; 

    rad = radius; 
    massColor = initColor; 
    
    staticAnchor = anchorMove; 
    isAnchor = false; 
    
  }
  
  void addVessel(Particle newVessel){
    vessel = newVessel; 
    isAnchor = true; 
  }
  
  void update(float dt){
    
     // Check If the top is still in the same position 
    if(staticAnchor == false){
      //top.set(anchor.pos); 
    }
    
    sx = (pos.x - top.x); 
    sy = (pos.y - top.y); 
    sz = (pos.z - top.z); 
    
    // Compute String Length
    stringLength = sqrt((sx * sx) + (sy * sy) + (sz * sz)); // Euclidian Norm
    //print(stringLen, " ", restLen); 
   
    // Compute (Damped) Hooke's Law for the spring 
    stringF = -k * (stringLength - restLength);
    
    if(staticAnchor == false){
      dampFx = -kv * (vel.x - anchor.vel.x);
      dampFy = -kv * (vel.y - anchor.vel.y);
      dampFz = -kv * (vel.z - anchor.vel.z);
    } else {
      dampFx = -kv * vel.x;
      dampFy = -kv * vel.y;
      dampFz = -kv * vel.z;      
    }
    

    dirX = sx/stringLength; 
    dirY = sy/stringLength; 
    dirZ = sz/stringLength; 
    
    forceX = dirX * stringF + dampFx;  
    forceY = dirY * stringF + dampFy;
    forceZ = dirZ * stringF + dampFz;
    
    // Apply Force in the direction of the string

    
    //replace 30 with an actual mass variable
    if(isAnchor){
      accX = gravity + .5 * forceX/2 - .5 * vessel.forceX/2; 
      accY = gravity + .5 * forceY/2 - .5 * vessel.forceY/2; 
      accZ = gravity + .5 * forceZ/2 - .5 * vessel.forceZ/2; 
    } else {
      accX = gravity + .5 * forceX/20; 
      accY = gravity + .5 * forceY/20; 
      accZ = gravity + .5 * forceZ/20; 
    }
      
    // Integration
    
    vel.add(accX*dt,accY*dt,accZ*dt);
    
    pos.add(vel.x*dt, vel.y*dt, vel.z*dt); 
        
    // Update Posistions   
    // Collision detection and response
    
    
    if (pos.x + rad > floor){
      PVector velColUpdate = new PVector(vel.x*-0.9, vel.y , vel.z);
      PVector posColUpdate = new PVector(floor - radius, pos.y, pos.z); 
      vel.set(velColUpdate);
      pos.set(posColUpdate);
    }
    
    if (pos.y + rad > floor){
      PVector velColUpdate = new PVector(vel.x, (vel.y*-0.9) , vel.z);
      PVector posColUpdate = new PVector(pos.y, floor-radius, pos.z); 
      vel.set(velColUpdate);
      pos.set(posColUpdate);
    }
    if (pos.z + rad > floor){
      PVector velColUpdate = new PVector(vel.x, vel.y , (vel.z * -0.9));
      PVector posColUpdate = new PVector(pos.y, pos.y, floor-radius); 
      vel.set(velColUpdate);
      pos.set(posColUpdate);
    }
    
    
    if(pos.x < rad){
      PVector velColUpdate = new PVector(vel.x * -0.9, vel.y, vel.z); 
      PVector posColUpdate = new PVector(radius, pos.y, pos.z ); 
      vel.set(velColUpdate); 
      pos.set(posColUpdate); 
    }
    if(pos.y < rad){
      PVector velColUpdate = new PVector(vel.x, vel.y * -0.9, vel.z); 
      PVector posColUpdate = new PVector(pos.x, radius, pos.z ); 
      vel.set(velColUpdate); 
      pos.set(posColUpdate); 
    }
    if(pos.z < rad){
      PVector velColUpdate = new PVector(vel.x, vel.y, vel.z* -0.9); 
      PVector posColUpdate = new PVector(pos.x, pos.y, radius ); 
      vel.set(velColUpdate); 
      pos.set(posColUpdate); 
    }
    
    
    if(isAnchor){
      vessel.top.set(pos); 
    }
    

   
  }
  
  void display(){
    pushMatrix(); 
    stroke(5); 
    line(top.x, top.y, top.z, pos.x, pos.y,pos.z);
    translate(pos.x,pos.y, pos.z);
    noStroke();
    fill(massColor.x, massColor.y, massColor.z);
    sphere(radius);
    popMatrix();
    
    pushMatrix();
    if(staticAnchor){
      translate(top.x,top.y,top.z); 
      fill(massColor.x, massColor.y, massColor.z, 100); 
      box(30); 
    }
    popMatrix(); 
    println("pos: " + pos); 
    println("vel: " + vel); 
    println("top: " + top + "\n"); 
    


  }
 

  
  

  
}
