class Cloth{


Particle[][] vert;
DVector[] curVel;
double stringLength; 
double stringF;

DVector e = new DVector(0,0,0); 
double l; 
double v1; 
double v2; 

DVector gravity = new DVector(0, -0.1, 0);  

Cloth(int rows, int cols){
    vert = new Particle[rows][cols]; 
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        DVector init_pos = new DVector(width/4+(i*30), 200+(j*30), 0); 
        DVector init_vel = new DVector(0,0,0); 
        PVector initCol =  new PVector(200,100,50); 
        vert[i][j] = new Particle(init_pos, init_vel, restLen, k, kV,40,initCol);        
    }
  }
}
  
  
// Vert vertices
void eulerSolve(double dt) { //<>//
 
    
    curVel = new DVector[(rows * cols)];
    
    // Update Velosity before pos 
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        curVel[(i*cols)+j]=vert[i][j].vel.copy();  
      }
    }
  
    // Horizontal 
    for(int i = 0; i < rows-1; i++){
      for(int j = 0; j < cols; j++){

        e.set(vert[i+1][j].pos.sub(vert[i+1][j].pos)); 
        e.normalize();  // Normalize 
        v1 = e.dot(curVel[(i*cols)+j]); 
        v2 = e.dot(curVel[((i+1)*cols)+j]);
        stringF = vert[i][j].k * (vert[i][j].restLength) - vert[i][j].kV * (v1-v2);
        println(stringF); 
        e.mult(stringF * dt); 
        vert[i][j].vel.add(e,vert[i][j].vel); 
        vert[i+1][j].vel.sub(e,vert[i+1][j].vel);  
      }
    }
    
    // Vertical
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols-1; j++){
        e.set(vert[i][j+1].pos.sub(vert[i][j].pos)); 
        e.normalize(); 
        v1 = e.dot(curVel[(i*cols)+j]); 
        v2 = e.dot(curVel[(i*cols)+j+1]);
        stringF = vert[i][j].k * (vert[i][j].restLength) - vert[i][j].kV * (v1-v2);
        e.mult(stringF * dt); 
        vert[i][j].vel.add(e,vert[i][j].vel); 
        vert[i][j+1].vel.sub(e,vert[i][j+1].vel);  
      }
    }
    
    // Final Update
    for(int i = 0; i < rows; i++){
      for(int j = 1; j < cols; j++){
        if(i == 0){ 
          vert[i][j].vel.mult(0);
        }   
        vert[i][j].vel.add(gravity);
        vert[i][j].pos.add(vert[i][j].vel.mult(dt)); 
        double halfstep = Math.pow(dt,2) * 0.5;  
        vert[i][j].pos.add(curVel[i*cols+j].mult(halfstep));
      }
    }
  }
  
  void collisionHandler(){
    
  }
  
  void display(){ 
     PVector pPos;
     PVector pPos1; 
     for(int i = 0; i < rows-1; i++){
       for(int j = 1; j < cols; j++){
          pPos = vert[i][j].pos.dToPVector().copy();   
          pPos1 = vert[i+1][j].pos.dToPVector().copy(); 
          pushMatrix(); 
          stroke(5); 
          line(pPos.x,pPos.x,pPos.z, pPos1.x, pPos1.y, pPos1.z);
          translate(pPos1.x, pPos1.y, pPos1.z);
          fill(random(255),random(255),random(255));
          //sphere((float)radius);
          popMatrix(); 
       }
     }
     for(int i = 0; i < rows; i++){
       for(int j = 1; j < cols-1; j++){
          pPos = vert[i][j].pos.dToPVector().copy();   
          pPos1 = vert[i][j+1].pos.dToPVector().copy(); 
          pushMatrix(); 
          stroke(5); 
          line(pPos.x,pPos.x,pPos.z, pPos1.x, pPos1.y, pPos1.z);
          translate(pPos1.x, pPos1.y, pPos1.z);
          fill(random(255),random(255),random(255));
          //sphere((float)radius);
          popMatrix(); 
          

       }
     }     

  }
  
  void run(int runs, double dt){
    for(int i = 0; i < runs; i++){ 
      eulerSolve(dt);
    }
    display(); 
  }
  
  
  void collisionDetection(){
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        //get distance frome sphere to point 
        float d = dist(spherePos.x,spherePos.y,spherePos.z,
                        (float)vert[i][j].pos.x, (float)vert[i][j].pos.y, (float)vert[i][j].pos.z);
        if(d < radius+0.9){
           PVector n = spherePos.sub(vert[i][j].pos.dToPVector()); 
           n.mult(-1); 
           n.normalize(); 
           PVector b = n.mult(n.dot(vert[i][j].vel.dToPVector()));
           DVector bounce = new DVector((double)b.x,(double)b.y,(double)b.z); 
           bounce.mult(-1.5); 
           PVector moveTarget = n.mult(.1+radius - d);
           DVector moveTar = new DVector((double)moveTarget.x, (double)moveTarget.y, (double)moveTarget.z); 
           
           vert[i][j].vel.add(bounce);
           vert[i][j].pos.add(moveTar); 
         }
        
      }
    }
  }
}
  
  
