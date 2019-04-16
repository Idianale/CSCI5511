class Agent{
  DVector pos; 
  DVector vel; 
  DVector acc; 
  DVector fil; 
  float radius;
  double maxSpeed; 
  double maxForce;
  double dt;
  boolean reachGoal; 
  int agentId;
  boolean reached = false; 
  DVector goal = new DVector(1300,20,0); 
  
  Path internalPath;

  
  /* 
  Create a basic agent at the corner of the screen assuming
  500x500 work area and screen size is 720x720
  
  */
  Agent(){
    dt = 0.5; 
    pos = new DVector(110,610,0);
    vel = new DVector(0,0,0); 
    acc = new DVector(0,0,0); 
    radius = 15; 
    maxSpeed = 140;
    maxForce = 100;
    reachGoal = false; 
  }
  
  Agent( DVector l, double ms, double mf, int i){
    pos = l.copy(); 
    vel = new DVector(ms/4,ms/4,0); 
    acc = new DVector(0,0,0); 
    radius = 15; 
    maxSpeed = ms;
    maxForce = mf;
    reachGoal = false; 
    agentId = i; 
    fil = new DVector(8,180,0); 
  }
  
  public void run(double dt){
    update(dt); 
    display(); 
  }
  
  public void run(Flock f, double dt){
    //flock(f); 
    update(dt); 
    //borders(); 
    display(); 
    
  }
  
  void applyBehaviors(ArrayList<Agent> agents, Path p){
    DVector f = follow(p); 
    
    // Weight them 
    f.mult(1); 
    
    applyForce(f); 
    
  }
  
  void flock(ArrayList<Agent> f){
    DVector sep = seperate(f); 
    DVector ali = align(f); 
    DVector coh = cohesion(f);
    
    sep.mult(1.5); 
    ali.mult(1); 
    coh.mult(2); 
    
    applyForce(sep); 
    applyForce(ali); 
    applyForce(coh); 
  }
  
  DVector follow(Path p){
    // Predict future location
    DVector predict = vel.copy(); 
    predict.normalize(); 
    predict.mult(50); 
    DVector predictPos = pos.copy(); 
    predictPos.add(predict); 
    

    DVector normal = null; 
    DVector target = null; 
    double worldRecord = 15000; 
    
    if(reached){
      return goal; 
    }
    
    // Loop through all the points to find the closest normal on the path
    DVector goal = p.points.get(p.points.size()-1); 
    if((pos.x > 1200 && pos.x < 1400)&& (pos.y <10 && pos.y > 40)){
      reached = true; 
      //println(pos.x + " " + pos.y); 
      //println("Goal reached by agent " + agentId);
      
      //pos = p.points.get(p.points.size()-1).copy();
      //fil.set(random(0,255),random(0,255),random(0,255)); 
      //radius+=random(-5,10); 
    }
    
    
    for(int i = 0; i < p.points.size(); i++){
      
      DVector a = p.points.get(i); 
      DVector b = p.points.get((i+1)%p.points.size()); 
      
      // Find the normal along the path
      DVector normalPoint = getNormalPoint(predictPos, a, b); 
      normal = normalPoint.copy(); 
      
      DVector dir = b.copy(); 
      dir.sub(a); 
      if(normalPoint.x < min((int)a.x,(int)b.x) || normalPoint.x > max((int)b.x,(int)a.x)|| 
        normalPoint.y < min((int)a.y, (int)b.y) || normalPoint.y > max((int)a.y,(int)b.y))
      {
        
        normalPoint = b.copy(); 
        a = p.points.get((i+1)%p.points.size());
        b = p.points.get((i+2)%p.points.size());  // Path wraps around
        dir = b.copy(); 
        dir.sub(a); 
      }      
      
      // Move along the path and set a target
      double distance = predictPos.dist(normalPoint); 
      if(distance < worldRecord){
        worldRecord = distance; 
        normal = normalPoint.copy(); 
        dir.normalize(); 
        dir.mult(10); 
        target = normal.copy(); 
        target.add(dir); 
      }      
    }
    
    // Debug Mode
    if (debug) {
      // Draw predicted future position
      stroke(0);
      fill(0);
      line((float)pos.x, (float)pos.y, (float)predictPos.x, (float)predictPos.y);
      ellipse((float)predictPos.x, (float)predictPos.y, 4, 4);

      // Draw normal position
      stroke(0);
      fill(0);
      ellipse((float)normal.x, (float)normal.y, 4, 4);
      // Draw actual target (red if steering towards it)
      line((float)predictPos.x, (float)predictPos.y, (float)normal.x, (float)normal.y);
      if (worldRecord > p.radius) fill(255, 0, 0);
      noStroke();
      ellipse((float)target.x, (float)target.y, 8, 8);
    }
    // Seek the path with your target if yu are off the path. 
    if (worldRecord > p.radius){
      return seek(target); 
    } else{
      return new DVector(0,0); 
    }
  
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
  DVector seek(DVector target){
    DVector desired = target.copy();
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
    return steer;  
  }
  
  DVector seperate(ArrayList<Agent> flock){
    double desiredSep = radius * 1*5;
    DVector steer = new DVector(0,0,0); 
    int count = 0; 
    
    for(int i = 0; i < flock.size(); i++){
      Agent other = flock.get(i); 
      Double dist = pos.dist(other.pos);
      if((dist > 0) && (dist < desiredSep)){
        DVector diff = pos.copy(); 
        diff.sub(other.pos); 
        diff.normalize(); 
        diff.div(dist); 
        steer.add(diff); 
        count++; 
      }
    }
    if(count > 0){
      steer.div((float)count); 
    }
    
    if(steer.mag() > 0){
      steer.normalize(); 
      steer.mult(maxSpeed); 
      steer.sub(vel); 
      steer.limit(maxForce); 
    }
    
    return steer; 
  }
  
  DVector align(ArrayList<Agent> flock){
    float neighborDist = 20; 
    DVector sum = new DVector(0,0); 
    int count = 0; 
    for (Agent other: flock){
      double dist = pos.dist(other.pos); 
      if((dist>0) && (dist < neighborDist)){
        sum.add(other.vel); 
        count++; 
      }
    }
    if(count > 0){
      sum.div((double)count);
      sum.normalize(); 
      sum.mult(maxSpeed); 
      DVector steer = sum.copy();
      steer.sub(vel); 
      steer.limit(maxForce); 
      return steer; 
    } else {
      return new DVector(0,0,0); 
    } 
  }
  
  DVector cohesion(ArrayList<Agent> flock){
    double neighborDist = 20; 
    DVector sum = new DVector(0,0,0); 
    int count = 0; 
    for(Agent other: flock){
      double dist = pos.dist(other.pos); 
      if((dist > 0) && (dist < neighborDist)){
        sum.add(other.pos); 
        count++; 
      }
    }
    if(count > 0){
      sum.div(count); 
      return seek(sum); 
    } else {
      return new DVector(0,0,0); 
    }
  }
  
  
  
 // Standard Euler Update
 void update(double dt){
    vel.add(acc.copy().mult(dt)); 
    vel.limit(maxSpeed);
    pos.add(vel.copy().mult(dt)); 
    acc.mult(0); 
  }
  
  void applyForce(DVector force){
    acc.add(force); 
  }

  
  // Flee Target 
  
  // Pursuit Target 
  

  // Create an agent at the following location. 
  
  void checkCollision(Obstacle o){
    if(pos.dist(o.pos) < o.radius){
      DVector normal = pos.copy().sub(o.pos);
      normal.normalize(); 
      pos.set(o.pos.copy().add(normal.mult(o.radius * 1.0002))); 
      DVector vNorm = vel.copy().mult(vel.copy().dot(normal)); 
      vel.sub(vNorm);
      vel.sub(vNorm.mult(0.01));
    }
    
  }
  
  void display(){
    fill((float)fil.x, (float)fil.y, (float)fil.z); 
    pushMatrix();
    translate((float)pos.x, (float)pos.y); 
    circle(0,0,radius); 
    popMatrix(); 

  }
  
  void altDisplay(){
    double theta = vel.heading() + PI/2;
    fill((float)fil.x, (float)fil.y, (float)fil.z);
    stroke(0);
    pushMatrix();
    translate((float)pos.x,(float)pos.y);
    rotate((float)theta);
    beginShape();
    vertex(0, -radius*2/4);
    vertex(-radius/4, radius*2/4);
    vertex(radius/4, radius*2/4);
    endShape(CLOSE);
    popMatrix();
  }
  
  void borders(Path p){
    if(pos.x > p.getEnd().x +radius){
      pos.x = p.getStart().x - radius; 
      //pos.y = p.getStart().y + (pos.y-p.getEnd().y); 
    }
  }
  
  // RRT Path
  Path genPath(DVector goal){
    Path p = new Path(); 
    p.addPoint(pos.x,pos.y);
    DVector[] samples = new DVector[5]; 
    DVector current = pos.copy(); 
    boolean found = false; 
    
    double min = 100000; 
    int minL = 0; 
    for(int i = 0; i < (int)random(5,40); i++){
      int k = (int)random(0,100); 
      if(k <= 2){
        p.addPoint(goal.x, goal.y); 
        found = true; 
        break; 
      }
      for(int j = 0; j < 5; j++){
        // Sample points
        samples[j] = new DVector((double)random((float)current.x-100, (float)current.x+300),(double)random((float)current.y-300, (float)current.y+300)); 
        if(pos.dist(samples[j]) < min){
          min = pos.dist(samples[j]); 
          minL = j; 
        }
      }
      p.addPoint(samples[minL].x, samples[minL].y); 
      current = samples[minL]; 
      }
    if(found == false){
      p.addPoint(goal.x, goal.y); 
    }
    internalPath = p; 
    return p; 
  }
}
