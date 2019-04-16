class Path {
  ArrayList<DVector> points; 
  double radius; 

  Path() {
    radius = 15;
    points = new ArrayList<DVector>();
  }

  // Add a point to the path
  void addPoint(double x, double y) {
    DVector point = new DVector(x, y);
    points.add(point);
  }
  
  DVector getStart(){
    return points.get(0); 
  }
  
  DVector getEnd(){
    return points.get(points.size()-1); 
  }
  
 
  void display(){
    strokeJoin(ROUND); 
    
    stroke(175); 
    strokeWeight((float)radius * 2); 
    noFill(); 
    
    beginShape(); 
    for(DVector v : points){
      vertex((float)v.x, (float)v.y); 
    }
    endShape(CLOSE); 
    
    stroke(0); 
    strokeWeight(1); 
    noFill(); 
    beginShape(); 
    for(DVector v:points){
      vertex((float)v.x,(float) v.y); 
    }
    endShape(CLOSE); 
  }


  
}
