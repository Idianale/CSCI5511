import java.util.Iterator; 
import peasy.*; 

PeasyCam cam; 
float x,y,z; 
PImage img;
int time; 
PImage floor; 

int deltaX = 0; 
int deltaZ = 0; 
Cannon[][] cannons = new Cannon[5][5]; 
//ArrayList<FireWork> hearts; 

void setup(){
  fullScreen(P3D);
  x = width/2; 
  y = height/2; 
  z = 0; 
  time = 0;
  //hearts = new ArrayList<FireWork>();

  lights();
  img = loadImage("heart.png");
  floor = loadImage("lawn.jpg"); 
  
  pushMatrix(); 
  translate(x,y,z);
  cam = new PeasyCam(this, x,y,z,2500); 
  cam.setMinimumDistance(350); 
  popMatrix(); 
  
  // Create my cannons which are the particle emitters
  //cannon = new Cannon(width/2, (height/2)+300,0); 
  for(int i = 0; i < cannons.length; i++){ 
    pushMatrix();
    for(int j = 0; j < cannons.length; j++){
    cannons[i][j] = new Cannon((int)((width/12)+deltaX), (int)height-100, (int)deltaZ); 
    deltaX+=150;    }
    deltaZ += 175; 
    deltaX = 0; 
    popMatrix(); 
  }  
}

void draw(){
  //noLoop(); 
  stroke(255); 
  time += 0.16;     
  background(255); 
  
  //makeFloor(); 
  
  for(int i = 0; i < cannons.length; i++){
    for(int j = 0; j < cannons.length; j++){
    cannons[i][j].run(); 
    }
  } 
}

void makeFloor(){
  pushMatrix();
  translate(0,height-5,0);  
  rotateX(PI/2); 
  rotateZ(PI/3); 
  beginShape();
  texture(floor);
  vertex(-width, -height, 0, 0, 0);
  vertex(width, -height, 0, img.width, 0);
  vertex(width, height, 0, img.width, img.height);
  vertex(-width, height, 0, 0, img.height);
  endShape(); 
  popMatrix();
}
