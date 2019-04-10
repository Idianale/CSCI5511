// Camera 

// Sim Parameters 
ArrayList<Agent> agents; 
ArrayList<Obstacles> obstacles; 
Agent agent; 
Solver solver; 
Path path; 
Path dumbAss; 
int k = 0; 

boolean debug = true; 

void setup(){
  newPath(); 
  
  obstacles = new ArrayList<Obstacles>(); 
  
  // Scale is 1 meters to 25 pixels  
  
  // formula for region  
  
  
  size(720,720);
  // size - area/2: convert to a smaller area pixel
  
  agents = new ArrayList<Agent>();
  
  for(int i = 0; i < 25; i++){
    newAgent(random(width), random(height));     
  }
  
  solver = new Solver(); 
  dumbAss = solver.returnPath(); 

   
  

}

void draw(){
  background(120); 
  noStroke(); 

  
  fill(255); 
  // area is 500x500 for 20 set the triangle origin at the offsets
  rect(60,60,600,600); 
  
  //path.display(); 
  dumbAss.display(); 
  
  stroke(1); 
  strokeWeight(1); 

  // Obstacle circle
  fill(0); 
  circle(360,360,100); 
  
  fill(255);
  stroke(1); 
  //Goal Circle
  circle(610,110,25); 
  solver.display(); 
  for(Agent a: agents){
    a.applyBehaviors(agents,dumbAss); 
    a.flock(agents); 
    a.update(a.dt); 
    a.display(); 
  }

  agents.get(0).applyBehaviors(agents,path); 
  agents.get(0).update(0.1); 
  agents.get(0).display(); 
  //agent.borders(path); 

}

void mousePressed(){
  println("x: " + mouseX + " y: " + mouseY + "\n"); 

}


void newAgent(double x, double y) {
  //double maxspeed = random(2,4);
  double maxspeed = 140; 
  double maxforce = 5;
  agents.add(new Agent(new DVector(x,y),maxspeed,maxforce));
}


void newPath(){
  path = new Path(); 
  path.addPoint(110,610);
  path.addPoint(590,620); 
  path.addPoint(600,100); 
  path.addPoint(130,100); 
  path.points.trimToSize();

}
