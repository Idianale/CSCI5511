class Ball{
   PVector pos; 
   PVector vel; 
   PVector acc;
   float velMax; 
   float time; 
   
   Ball(){
     pos = new PVector(width/2, 40);
     vel = new PVector(0,0);
     acc = new PVector(0.1,-0.01);
     velMax = 10;
     time = 0; 
     
   }
   
   void update(){
     acc.add(0.01,.98); 
     vel.add(acc);
     if(vel.y > velMax && vel.y < 0){
       vel.y = velMax; 
     }
     pos.add(vel);
     acc.mult(0); 
   }
   
   void display(){
     stroke(10);
     fill(32,193,27);
     ellipse(pos.x,pos.y,30,30);
   }

   void checkFloor() {
    if (pos.y > height-50) {
      acc.add(0,0.1); 
      vel.add(acc); 
      vel.mult(-1.0);
      pos.y = height-45;
    }
  }  
}
