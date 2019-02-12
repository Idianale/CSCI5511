class Rocket{
  PVector origin; 
  PVector pos;  // location 
  PVector vel;  // velocity 
  PVector acc;  // acceleration 
  PImage img;   //img sprite
  ArrayList<FireWork> burst; 
  

  
  //float[] noise; 
  

  float lifespan;  // life of particle

  
  Rocket(int x, int y, int z){
    origin = new PVector(x,y,z); 
    pos = origin; 
    img = loadImage("rocket.png"); 
    vel = new PVector(random(0.5,1.5),25,0.1); 
    acc = new PVector(0.1,15.5,0.1); 
    
  //noise = new float[]{random(0,100),random(0,100),random(0,100)};        
 
    burst = new ArrayList<FireWork>();
  
    lifespan = random(0,255); 
  }
  
  void update(){
    // add accelerations 
    acc.add(random(0.01), 0.98); 
    vel.add(acc);    
    pos.add(vel); 
    pos.mult(time); 
    acc.mult(0); 
    
    // add velocities
    
    // add positions 
    
    // burst()
    if(lifespan == 0){
      println("Fireworks Burst"); 
      for(int i = 0; i < (int)random(0,5); i++){
        burst.add(new FireWork((int)pos.x, (int)pos.y,(int)pos.z));
      }
      Iterator<FireWork> it = burst.iterator(); 
      while(it.hasNext()){
        FireWork p = it.next(); 
        p.run();  
        if(p.isDead()){
          it.remove(); 
        }
      }
     
    }
    lifespan--; 
  }
   
  
  void display(){
    noStroke(); 
    pushMatrix(); 
    translate(pos.x,pos.y,pos.z); 
    rotateZ(-90); 
    beginShape();
    texture(img); 
    tint(255,lifespan); 
    vertex(-50, -50, 0, 0, 0);
    vertex(50, -50, 0, img.width, 0);
    vertex(50, 50, 0, img.width, img.height);
    vertex(-50, 50, 0, 0, img.height); 
    endShape(); 
    popMatrix(); 
    ellipse(pos.x,pos.y,5,5); 
  }
  
  void run(){
    update(); 
    display(); 
  }
  
  boolean isDead(){
    if(lifespan == 0){
      return true; 
    } else {
      return false; 
    }
  }
  
}
  
