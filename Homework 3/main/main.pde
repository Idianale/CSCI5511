// Camera 

// Sim Parameters 
Agent agent; 
Solver solver; 
ArrayList<DVector> wPoints;

int k = 0; 

void setup(){
  // Scale is 1 meters to 25 pixels  
  
  // formula for region 
  
  
  size(720,720);
  // size - area/2: convert to a smaller area pixel
  
  agent = new Agent(); 
  solver = new Solver(); 
  
  
  wPoints = new ArrayList<DVector>(); 
  wPoints.add(new DVector(115,395,0));
  wPoints.add(new DVector(140,210,0));
  wPoints.add(new DVector(415,265,0));
  wPoints.add(new DVector(580,570,0)); 
  wPoints.add(new DVector(610,110,0));
  
  agent.recWayPoints(wPoints); 


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
  
  
  fill(#F0210F);
  
  for(int i = 0; i < wPoints.size(); i++){
    circle((float)wPoints.get(i).x,(float)wPoints.get(i).y, 20); 
  }
  

  agent.seek(wPoints.get(k)); 
  
  agent.update(); 

  agent.display(); 
  
  //solver.wayPoints.get(0).display();
  //solver.wayPoints.get(3).display(); 
  //solver.wayPoints.get(10).display(); 

  //solver.display(); 
   //<>//
}

void mousePressed(){
  println("x: " + mouseX + " y: " + mouseY + "\n"); 

}
int value = 0; 
void keyPressed(){
  if(value == 0){
    k++; 
    k = k %5; 
    println("moving to wayPoint " + k ); 
  }
}
/*
boolean lineSphIntersect(DVector p1, DVector p2 DVector c, double r){
  double a = math.pow((p2.x-p1.x),2) + math.pow((p2.y-p1.y),2) + math.pow((p2.y-p1.y),2);
  double b = 2 * ((p2.x-p1.x) * (c.x-p1.x) + (p2.y-p1.y) * (c.y-p1.y) + (p2.z-p1.z) * (c.z-p1.z));
  double c = math.pow(p1.x,2) + math.pow(p1.y,2) + math.pow(p1.z,2)
             + math.pow(c.x,2) + math.pow(c.y,2) + math.pow(c.z,2)
             - 2 * ((c.x * p1.x + c.y * p1.y + c.z + p1.z));
  
  double res = math.pow(b,2) - 4 * a * c; 
  if( res < 0){
    return false; 
  } else {
    return true; 
  }
}
*/ 
// Stur
