class Obstacles {
  ArrayList<Agent> agentObs;
  ArrayList<Obstacle> obsPos; // static obstacle locations
  
  Obstacles(){
    agentObs = new ArrayList<Agent>(); 
    obsPos = new ArrayList<Obstacle>(); 
  }
  
  void addObs(Obstacle o){
    obsPos.add(o); 
  }
  
  void newObs(double x, double y, double r){
    Obstacle o = new Obstacle(new DVector(x,y,0), r);
    obsPos.add(o); 
  }
  
  void display(){
    for(int i = 0; i < obsPos.size(); i++){
      obsPos.get(i).display(); 
     }
  }
}

class Obstacle {
  DVector pos; 
  double radius;
  double area; 
  String shape; 
  Obstacle(){
    pos = new DVector(random(width/height), random(width/height), random(width/height));
    radius = 5; 
    area = (double)PI * Math.pow(5,2); 
  }
  
  // random Circle
  Obstacle(DVector p, double r){
    pos = p.copy(); 
    radius = r; 
    area = (double)PI * Math.pow(r,2);  
  }
  
  // random square
  Obstacle(DVector p, double l, String s){
    pos = p.copy(); 
    radius = l; 
    area = Math.pow(l,2); 
  }
  
   // Assumes object is either agent or obstacle
  boolean collision(Obstacle o){
    DVector d = o.pos.copy(); 
    boolean collide = false; 
    /*
    Do stuff
    */
    if(collide){
      return true; 
    } else {
      return false; 
    }
  }
  
  
  void display(){
    fill(0); 
    circle((float)pos.x, (float)pos.y, (float)radius); 
  }

}
