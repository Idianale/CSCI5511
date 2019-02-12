class waterDroplet{
  PVector pos; 
  PVector vel; 
  PVector acc; 
  float lifespan; 
  
  waterDroplet(int x, int y, int z){
    pos = new PVector(x,y,z); 
    vel = new PVector(0,20,0); 
    acc = new PVector(0,9.8); 
    lifespan = 255; 
  }
  
  void update(){
    pos = acc.add(random(0.01), 0.98); 
    vel.add(acc);    
    pos.add(vel); 
    pos.mult(time); 
    acc.mult(0); 
    lifespan -= random(10,25); 
  }
  
  void display(){
    fill(66,134,244,lifespan); 
    sphere(40); 
  }
  
  boolean isDead(){
    if(lifespan == 0){
      return true; 
    } else{
      return false; 
    }
  }
  
  void run(){
    update(); 
    display(); 
  }
  
}
