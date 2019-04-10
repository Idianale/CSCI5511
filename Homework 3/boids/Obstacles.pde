class Obstacles {
  ArrayList<Agent> agentObs;
  ArrayList<Obstacle> obsPos; // static obstacle locations
  
  Obstacles(){
    agentObs = new ArrayList<Agent>(); 
    obsPos = new ArrayList<Obstacle>(); 
  }
  
  boolean collisions(){
    boolean collide = false; 
    if(collide){
      return true; 
    } else {
      return false; 
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
  
  void display(){
  }
 
   // Assumes object is either agent or obstacle
  boolean collision(Agent o){
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

}
