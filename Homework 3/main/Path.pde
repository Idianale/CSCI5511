class Path {
  ArrayList<DVector> points; 
  double radius; 

  Path() {
    // Arbitrary radius of 20
    radius = 20;
    points = new ArrayList<DVector>();
  }

  // Add a point to the path
  void addPoint(float x, float y) {
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
    stroke(175); 
    strokeWeight((float)radius * 2); 
    noFill(); 
    
    beginShape(); 
    for(DVector v : points){
      vertex((float)v.x, (float)v.y); 
    }
    endShape(); 
  }

  
}
