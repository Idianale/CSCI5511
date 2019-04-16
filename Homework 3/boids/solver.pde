class Solver{
  ArrayList<WayPoint> wayPoints = new ArrayList<WayPoint>();
  float area = 1000; 
  int sizeList = (int)random(10,20); 
  Path p; 
  // Index corresponds to a node; 
  // each index contains: 
  // - list of waypoints that represent the nearest neighbors of that node
  // - distance from between that node and its neighbor
   
 
  Solver(){
    // Sample Points 
    for(int i = 0; i < sizeList; i++){
      WayPoint sample = new WayPoint(area); 
      // If sample point not in collision space add it to the list.
      for(int j = 0; j < obstacles.obsPos.size(); j++){              
        if(!checkCollision(sample, obstacles.obsPos.get(j))){ wayPoints.add(sample); println("new point added"); }
      }
    }
        
    // find the nearest neighbors of the each wayPoint
    for(int i = 0; i < wayPoints.size(); i++){
      wayPoints.get(i).findNN(wayPoints); 
    }
    
    p = new Path(); 
    
    for(int i = 0; i < wayPoints.size(); i++){
      //if(random(0,100) > 70){
      p.addPoint(wayPoints.get(i).pos.x,wayPoints.get(i).pos.y);  
      }
      p.addPoint(1300,200); 
    }
    
    
    
    // construct a map 
    
  
  
  Path returnPath(){
    return p; 
  }
  
  boolean checkCollision(WayPoint d, Obstacle o){
    if(d.pos.x >= o.pos.x - o.radius && d.pos.x < o.pos.x + o.radius && d.pos.y >= o.pos.y-o.radius && d.pos.y <= o.pos.y+o.radius){    
      println("y COl"); 
      return true;
    } else {
      println("n col"); 
      return false;
      
    }
  }
  
  
  void display(){
    for(int i = 0; i < wayPoints.size(); i++){
      wayPoints.get(i).display(); 
    }
  }
  
  ArrayList<DVector> getWayPoint(){
    ArrayList<DVector> wP = new ArrayList<DVector>(); 
    for(WayPoint w: wayPoints){
      wP.add(w.pos); 
    }
    return wP; 
  }
  
  boolean lineSphIntersect(DVector p1, DVector p2, DVector circ, double r){
    double a = Math.pow((p2.x-p1.x),2) + Math.pow((p2.y-p1.y),2) + Math.pow((p2.y-p1.y),2);
    double b = 2 * ((p2.x-p1.x) * (circ.x-p1.x) + (p2.y-p1.y) * (circ.y-p1.y) + (p2.z-p1.z) * (circ.z-p1.z));
    double c = Math.pow(p1.x,2) + Math.pow(p1.y,2) + Math.pow(p1.z,2)
             + Math.pow(circ.x,2) + Math.pow(circ.y,2) + Math.pow(circ.z,2)
             - 2 * ((circ.x * p1.x + circ.y * p1.y + circ.z + p1.z));
  
    double res = Math.pow(b,2) - 4 * a * c; 
    if( res < 0){
      return false; 
    } else {
      return true; 
    }
  }
  
  
}
