class Cloud{
  PVector pos; 
  ArrayList<waterDroplet> water; 
  
  Cloud(int x, int y, int z){
    pos = new PVector(x,y,z); 
    water = new ArrayList<waterDroplet>(); 
  }
  
  void update(){
    for(int i = 0; i < 55; i++){
      water.add(new waterDroplet((int)random(-100,100),(int)random(-100,100),(int)random(-100,100))); 
    }
    Iterator<waterDroplet> it = water.iterator(); 
    while(it.hasNext()){
      waterDroplet w = it.next(); 
      w.run(); 
      if(w.isDead()){
        it.remove();
      }
    }
  }
  
  void display(){
    pushMatrix(); 
    translate(pos.x,pos.y,pos.z); 
    fill(133,136,140); 
    box(width-100,100,500); 
    popMatrix();
  }
 
  void run(){
    update(); 
    display(); 
  }
  
  
}
