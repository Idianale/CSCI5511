// Camera 

// Sim Parameters 
ArrayList<Agent> agents; 
Obstacles obstacles; 
Agent agent; 
Solver solver; 
Path path; 
Path dumbAss; 
int k = 0; 
DVector goal = new DVector(1300,20,0); 

boolean debug = false; 

void setup(){
  //path = newPath(); 
  
  obstacles = new Obstacles(); 
  
  // Scale is 1 meters to 25 pixels  
  
  // formula for region  
  fullScreen();   
  //size(720,720);
  // size - area/2: convert to a smaller area pixel
  
  agents = new ArrayList<Agent>();
  
  for(int i = 0; i < (int)random(10,30); i++){
    //newAgent(random(60,200), random(500,655));     
    newAgent(width/2, height); 
  }
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 4; j++){
        obstacles.newObs(100+(j*320),100+(i*300),150);
    }
  }
  //obstacles.newObs(width/4, height/4,300); 
  //obstacles.newObs(width/2, height/8,200); 
  //obstacles.newObs(width/2, height/2,200); 
  //obstacles.newObs(width/1.5, height/1.5,200); 
  
  for(int i = 0; i < agents.size(); i++){
    agents.get(i).genPath(goal); 
  }
  
  
  solver = new Solver(); 
  dumbAss = solver.returnPath(); 
  noLoop(); 
   
  

}

void draw(){
  background(120);  //<>//
  noStroke(); 

  
  fill(255); 
  // area is 500x500 for 20 set the triangle origin at the offsets
  //rect(60,60,600,600); 
  
  //path.display(); 
  //dumbAss.display(); 
  
  stroke(1); 
  strokeWeight(1); 

  // Obstacle circle
  obstacles.display(); 
  
  
  fill(255);
  stroke(1); 
  //Goal Circle
  circle(1300,20,25); 
  //solver.display(); 

  
  
  for(int i = 0; i < agents.size(); i++){
    //agents.get(i).applyBehaviors(agents, dumbAss);
    //agents.get(i).applyBehaviors(agents, path); 
    agents.get(i).applyBehaviors(agents,agents.get(i).internalPath); 
    agents.get(i).flock(agents); 
    agents.get(i).update(0.05); 
    if(agents.get(i).radius < 0){
      agents.remove(i); 
      println("Agent Died"); 
    } else{
      for(int j = 0; j < obstacles.obsPos.size(); j++){
        agents.get(i).checkCollision(obstacles.obsPos.get(j)); 
      }
      agents.get(i).display(); 
      agents.get(i).altDisplay(); 
      //agents.get(i).internalPath.display(); 
    }

  }
  
  //agent.borders(path); 

}

void mousePressed(){
  println("x: " + mouseX + " y: " + mouseY + "\n"); 
  rect(mouseX,mouseY,100,100); 

}

void keyPressed() {
   if(key == 'Q' || key == 'q'){
     loop(); 
   }
   if(key == 'w' || key == 'W'){
     noLoop(); 
   }
}

void newAgent(double x, double y) {
  double maxspeed = 140; 
  double maxforce = 105;
  agents.add(new Agent(new DVector(x,y),maxspeed,maxforce, agents.size()));
}


Path newPath(){
  path = new Path(); 
  path.points.trimToSize();

  return path; 
}
