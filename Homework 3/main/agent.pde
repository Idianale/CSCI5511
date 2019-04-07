class Agent{
  DVector pos; 
  DVector vel; 
  DVector acc; 
  float radius;
  double maxSpeed; 
  double maxForce;
  ArrayList<DVector> wayPoints; 
  int cWP; // Current wayPoints
  
  /* 
  Create a basic agent at the corner of the screen assuming
  500x500 work area and screen size is 720x720
  
  */
  Agent(){
    pos = new DVector(110,610,0);
    vel = new DVector(0,0,0); 
    acc = new DVector(0,0,0); 
    radius = 25; 
    maxSpeed = 5;
    maxForce = 5;
    wayPoints = new ArrayList<DVector>(); 
    Path path; 
    cWP = 0; 
  
  }
  
  public void run(){
    update(); 
    display(); 
  }
  
  void follow(Path p){
    DVector predict = vel.copy(); 
    predict.normalize(); 
    predict.mult(10); 
    DVector predictPos = pos.copy(); 
    predictPos.add(predict); 
    
    DVector normal = null; 
    DVector target = null; 
    double worldRecord = 1000000; 
    
    for(int i = 0; i < p.points.size()-1; i++){
      
      DVector a = p.points.get(i); 
      DVector b = p.points.get(i+1); 
      
      DVector normalPoint = getNormalPoint(predictPos, a, b); 
      if(normalPoint.x < a.x || normalPoint.x > b.x){
        normalPoint = b.copy(); 
      } 
      
      double distance = predictPos.dist(normalPoint); 
      if(distance < worldRecord){
        normal = normalPoint; 
        DVector dir = b.copy(); 
        dir.sub(a); 
        dir.normalize(); 
        dir.mult(10); 
        target = normalPoint.copy(); 
        target.add(dir); 
      }      
    }
    if (worldRecord > p.radius){
      seek(target); 
    }
    
    // Debug Mode
  
  }
  
  DVector getNormalPoint(DVector P, DVector a, DVector b){
    DVector ap = P.copy(); 
    ap.sub(a); 
    
    DVector ab = b.copy(); 
    ab.sub(a); 
    ab.normalize(); 
    ab.mult(ap.dot(ab)); 
    DVector normalPoint = a.copy(); 
    normalPoint.add(ab); 
    return normalPoint; 
  }
    
  // Seek Target
  void seek(DVector target){
    DVector desired = target.copy(); //<>//
    desired.sub(pos); 
    double d = desired.mag(); 
    desired.normalize(); 
    if(d < 100){
      double m = map((float)d, 0,100,0,(float)maxSpeed); 
      desired.setMag(m); 
    } else {
      desired.mult(maxSpeed);
    }
    DVector steer = desired.copy(); 
    steer.sub(vel); 
    steer.limit(maxForce); 
    applyForce(steer); 
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

  
  // Get wayPointList
  void recWayPoints(ArrayList<DVector> w){
    for(int i = 0;i < w.size(); i++){
      wayPoints.add(w.get(i).copy()); 
    }
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
  
  void borders(Path p){
    if(pos.x > p.getEnd().x +radius){
      pos.x = p.getStart().x - radius; 
      pos.y = p.getStart().y + (pos.y-p.getEnd().y); 
    }
  }
  
}
