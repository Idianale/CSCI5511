class Agent{
  DVector pos; 
  DVector vel; 
  DVector acc; 
  float radius;
  double maxSpeed; 
  double maxForce; 
  
  Solver mPlanner; // motion planning solver

  /* 
  Create a basic agent at the corner of the screen assuming
  500x500 work area and screen size is 720x720
  
  */
  Agent(){
    pos = new DVector(110,610,0);
    vel = new DVector(0,0,0); 
    radius = 25; 
    maxSpeed = 100;
    maxForce = 100;
    mPlanner = new Solver(); 

  }
  
  // Standard Euler Update
  void update(){
    vel.add(acc); 
    vel.limit(maxSpeed);
    pos.add(vel); 
    acc.mult(0); 
  }
  
  void applyForce(DVector force){
    acc.add(force); 
  }
  
  // Seek Target
  void seek(DVector target){
    DVector desired = new DVector(target.x - pos.x, target.y-pos.y, target.z-pos.z); 
    desired.normalize(); 
    desired.mult(maxSpeed); 
    DVector steer = new DVector(target.x - vel.x, target.y - vel.y, target.z - vel.z); 
    steer.limit(maxForce); 
    applyForce(steer); 
  }
  
  // Flee Target 
  
  // Pursuit Target 
  

  // Create an agent at the following location. 
  
  void checkCollision(){
  }
  
  void display(){
    fill(246,255,0); 
    pushMatrix();
    translate((float)pos.x, (float)pos.y); 
    circle(0,0,radius); 
    popMatrix(); 

  }
  
  void altDisplay(){
    double theta = vel.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate((float)pos.x,(float)pos.y);
    rotate((float)theta);
    beginShape();
    vertex(0, -radius*2);
    vertex(-radius, radius*2);
    vertex(radius, radius*2);
    endShape(CLOSE);
    popMatrix();
  }


  
}
