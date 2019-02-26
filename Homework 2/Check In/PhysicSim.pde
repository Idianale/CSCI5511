import peasy.*; 

// Camera 
PeasyCam cam; 
float x,y,z; 

// Simulation Parameters   

float floor = 600;
float grav = 98; //Gravity  
float radius = 10;
float restLen = 50; //
float k = 100; //1 1000
float kv = .1; // Spring Constant 


float dt = .005; // timestep 

// ArrayList; 

ArrayList<Particle> masses= new ArrayList<Particle>(); 


// Initial Positions
PVector initPos = new PVector(100,100,0); 
PVector initVel = new PVector(0,0,0); 
PVector initTop = new PVector(200,100,0); 
PVector mass1Color = new PVector(0,200,10);



 //<>// //<>//
void setup(){
  //fullScreen(P3D); 
  size(600,600,P3D); 
  surface.setTitle("Check In");
  
  x = width/2; 
  y = height/2; 
  z = 0; 
 
  lights(); 
  
  pushMatrix(); 
  translate(x,y,z); 
  cam = new PeasyCam(this, x,y,z,800); 
  cam.setMinimumDistance(200); 
  popMatrix(); 
  
  Particle mass = new Particle(initPos, initVel, initTop,  
                              restLen, radius, mass1Color,
                              true, null);  
                              
  masses.add(mass); 
  
  
  for(int i = 1; i < 6; i++){
    PVector fillColor = new PVector((i*20)%255,200,(i*10)%255);
    PVector initNextPos = new PVector(masses.get(i-1).pos.x+30, masses.get(i-1).pos.y+30, masses.get(i-1).pos.z+10); 
    Particle newMass = new Particle(initNextPos, initVel, masses.get(i-1).pos, 
                              restLen, radius, fillColor,
                              false, masses.get(i-1)); 
    masses.add(newMass); 
  }
                              
                              
                    

}

void keyPressed() {
  for(int i = 0; i < masses.size(); i++){
    if (keyCode == RIGHT) {
      masses.get(i).vel.x += 30;
    }
    if (keyCode == LEFT) {
      masses.get(i).vel.x -= 30;
    }
  }
}



void draw(){
  //background(255,255,255);
  fill(0,0,0);
  
  for(int i = 0; i < masses.size(); i++){
    masses.get(i).update(dt); 
    masses.get(i).display(); 
  }
  
  
}
