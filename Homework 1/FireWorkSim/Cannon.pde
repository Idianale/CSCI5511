class Cannon{
  PVector pos; //location 
  PVector origin; 
  ArrayList<Rocket> rockets; 
  
  Cannon(int x, int y, int z){
    cylinder(x,y,z);
    origin = new PVector(x,y,z); 
    rockets = new ArrayList<Rocket>(); 
  }
  
  //Create Cylinder with number of sidesat x,y,and z location
  void cylinder(int x, int y, int z){
    pushMatrix();
    translate(x,y,z); 
    rotateX( -80 );
    drawCylinder( 8, 32, 64 );
    popMatrix();   
  }
  

  void drawCylinder(int sides, float r, float h){
      float angle = 360 / sides;
      float halfHeight = h / 2;
      // draw top shape
      beginShape();
      fill(0); 
      for (int i = 0; i < sides; i++) {
          float x = cos( radians( i * angle ) ) * r;
          float y = sin( radians( i * angle ) ) * r;
          vertex( x, y, -halfHeight );    
      }
      endShape(CLOSE);
      
      // draw bottom shape
      beginShape();
      fill(0); 
      for (int i = 0; i < sides; i++) {
          float x = cos( radians( i * angle ) ) * r;
          float y = sin( radians( i * angle ) ) * r;
          vertex( x, y, halfHeight );    
      }
      endShape(CLOSE);
      
      // draw body
      beginShape(TRIANGLE_STRIP);
      for (int i = 0; i < sides + 1; i++) {
          float x = cos( radians( i * angle ) ) * r;
          float y = sin( radians( i * angle ) ) * r;
          fill(132,41,188); 
          vertex( x, y, halfHeight);
          fill(251,255,53); 
          vertex( x, y, -halfHeight);
           
      }
      endShape(CLOSE); 
      noFill();
  } 
  
  void display(){
    noStroke(); 
    pushMatrix();
    translate(origin.x, origin.y, origin.z); 
    rotateX( -80 );
    drawCylinder( 12, 50, 250 );
    popMatrix();   
  }; 
  
  void update(){
    // fire a rocket; 
    pushMatrix(); 
    translate(origin.x,origin.y-random(5,30),origin.z); 
    float chance = random(0,1); 
    if(chance > 0.60){
      rockets.add(new Rocket(0,0,0)); 
    }
    popMatrix(); 
    
    if(rockets.isEmpty() == false){
      //println("cannon fired at " + getOrigin()); 
      Iterator<Rocket> it = rockets.iterator(); 
      while(it.hasNext()){
        Rocket p = it.next(); 
        p.run();  
        if(p.isDead()){
          it.remove(); 
        }
      }
    }
  }
  
  void run(){
    update(); 
    display(); 
  }
  
  
  
  PVector getOrigin(){
    return origin; 
  }
  
}
