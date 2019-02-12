// class for a burst of fireworks
class FireWork{
  PVector origin; 
  PVector pos;  // location 
  PVector vel;  // velocity 
  PVector acc;  // acceleration 
  PImage img;   //img sprite
  int lifespan; // life of particle
  
  FireWork(int x, int y,int z){
    img = loadImage("heartParticles.jpg");
    origin = new PVector(x,y,z); 
    pos = origin;  // initial Position 
    lifespan = (int)random(0,255); 
  }
  
  void update(){
  }
  
  void display(){
    noStroke(); 
    pushMatrix(); 
    translate(pos.x,pos.y,pos.z); 
    beginShape(); 
    texture(img); 
    tint(255,lifespan); 
    /*
    vertex(-100, -100, 0, 0, 0);
    vertex(100, -100, 0, img.width, 0);
    vertex(100, 100, 0, img.width, img.height);
    vertex(-100, 100, 0, 0, img.height);
    */ 
    vertex(-50, -50, 0, 0, 0);
    vertex(50, -50, 0, img.width, 0);
    vertex(50, 50, 0, img.width, img.height);
    vertex(-50, 50, 0, 0, img.height); 
    endShape(); 
    popMatrix();
    lifespan--;
  }
  
  void run(){
    update(); 
    display();
    noTint();
  }
  
  void checkEdges(){
  }
  
  PVector getLocation(){
    return pos; 
  }
  
  Boolean isDead(){
    if(lifespan == 0){
      return true; 
    } else{
      return false; 
    }
  }
  
}
