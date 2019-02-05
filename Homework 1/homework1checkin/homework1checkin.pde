Ball ball; 

void setup() {
  size(360, 720); 
  background(255);
  ball = new Ball(); 
  
}

void draw() {
  background(255); 
  fill(0);
  rect(0,690,width,50); 
  ball.update(); 
  ball.checkFloor(); 
  ball.display(); 
}
