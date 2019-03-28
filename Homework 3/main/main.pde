// Camera 

// Sim Parameters 
Agent agent; 
void setup(){
  // Scale is 1 meters to 25 pixels  
  
  // formula for region 
  
  
  size(720,720);
  // size - area/2: convert to a smaller area pixel
  
  agent = new Agent(); 

// 

  
}

void draw(){
  background(120); 
  noStroke(); 
  fill(255); 
  // area is 500x500 for 20 set the triangle origin at the offsets
  rect(60,60,600,600); 

  // Obstacle circle
  fill(0); 
  circle(360,360,100); 
  
  fill(255);
  stroke(1); 
  //Goal Circle
  circle(610,110,25); 
  
  agent.display(); 
  agent.mPlanner.displayPoints(); 
}

void mousePressed(){
  println("x: " + mouseX + " y: " + mouseY + "\n"); 

}

// Stur
