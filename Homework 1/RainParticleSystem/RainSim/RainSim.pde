import java.util.Iterator; 
import peasy.*; 

PeasyCam cam; 
float x,y,z; 
PImage img;
int time; 
PImage floor; 

Cloud clouds; 

void setup(){
  fullScreen(P3D);
  lights();
  
  x = width/2;
  y = height/2;
  z = 0; 
  
  pushMatrix(); 
  translate(x,y,z);
  cam = new PeasyCam(this, x,y,z,2500); 
  cam.setMinimumDistance(350); 
  popMatrix(); 
  
  
  pushMatrix();
  translate(width/2, 30, 0); 
  clouds = new Cloud(0,0,0); 
  popMatrix(); 

}

void draw(){
  time += 0.16; 
  background(0); 
  clouds.run();  
}; 
