import peasy.*; 

// Camera 
PeasyCam cam; 

// Simulation Parameters   

float floor;
float grav = 98; //Gravity  
float radius = 10;
float restLen = 20; //
float k = 0.05; //1 1000
float kv = .01; // Spring Constant 


float dt = .01; // timestep 

// ArrayList; 

ArrayList<Particle> masses= new ArrayList<Particle>(); 


// Initial Positions


 //<>//
void setup(){
  fullScreen(P3D);
  floor = height - radius - 40; 
  //size(600,600,P3D); 
  surface.setTitle("Check In");
   
  lights(); 
  
  pushMatrix(); 
  translate(width/2, height/2,0); 
  cam = new PeasyCam(this,1500); 
  cam.setMinimumDistance(10); 
//  cam.setMaximumDistance(8000); 

  popMatrix(); 
  

  println("initial values "); 
  for(int k = 0; k < 34; k++){
    PVector initPos = new PVector(random(0,width), 200, random(0,height/8)); 
    //PVector initPos = new PVector(width/2, 200, height/8); 

    PVector initVel = new PVector(random(0,100),random(0,100),random(0,100)); 
    PVector initTop = new PVector(initPos.x,100,initPos.z); 
    PVector mass1Color = new PVector(random(k,k*6)%255,random(k,k*6)%255,random(k,k*6)%255);
  
    
    Particle mass = new Particle(initPos, initVel, initTop,  
                                restLen, radius, mass1Color,
                                true, null);  
                                
    masses.add(mass);     
    
    for(int i = (k*5)+1; i < (k*5)+5; i++){
      PVector fillColor = new PVector((i*20)%255,(200 * random(0,k))%255,(i*10)%255);
      PVector initNextPos = new PVector(masses.get(i-1).pos.x, masses.get(i-1).pos.y+30, masses.get(i-1).pos.z); 
      PVector initNextVel = new PVector(random(0,100),random(0,100),random(0,100)); 

      Particle newMass = new Particle(initNextPos, initNextVel, masses.get(i-1).pos, 
                                restLen, radius, fillColor,
                                false, masses.get(i-1)); 
      masses.get(i-1).addVessel(newMass);                               
      masses.add(newMass);
    }
    pushMatrix();   
    translate(masses.get(k).top.x, masses.get(k).top.y, masses.get(k).top.z); 
    box(width*10, 30, height*10); 
    popMatrix();    
  }
  
  background(255,255,255);      
  for(int i = masses.size()-1; i >= 0; i--){
    masses.get(i).display(); 
    println("Iter: " + i + "\n"); 
  }
  noLoop(); 
}

void keyPressed() {
  for(int i = 0; i < masses.size(); i++){
    if (keyCode == RIGHT) {
      masses.get(i).vel.x += 150;

    }
    if (keyCode == LEFT) {
      masses.get(i).vel.x -= 150;
    }
    if (keyCode == UP) {
      masses.get(i).vel.y += 150;
    }
    if (keyCode == DOWN) {
      masses.get(i).vel.y -= 150;
    }
  }
  if(key == 'Q' || key == 'q'){
    loop(); 
  }
  if(key == 'w' || key == 'W'){
    noLoop(); 
  }
}


int iteration = 1; 
void draw(){
  println("Iteration " + iteration); 
  iteration++; 
  //background(200,200,200);
  fill(0,0,0);
  
  for(int i = masses.size()-1; i >= 0; i--){
    masses.get(i).update(dt); 
    println("mass "+  i); 
    masses.get(i).display(); 
  }
  pushMatrix();   
  translate(width/2, height-30, 0); 
  //box(width*1.2, 30, height*1.2); 
  fill(68, 86, 7);
  popMatrix();     //<>//

//  cam.beginHUD(); 
//  cam.endHUD(); 
 
  
}
