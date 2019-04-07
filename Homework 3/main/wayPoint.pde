/* 
 Current Bug: 
 Does not create the nearest neighbor list correctly 
 
 You implemnted Neighbors as an object of 
 
 */

import java.util.*;

public class WayPoint{
  DVector pos; 
  ArrayList<Neighbor> nn; // nearest neighbors 
  
  
  WayPoint() {      
    this.pos = new DVector((double)random(0, 500)+100, (double)random(0, 500)+100, 0);
    this.nn = new ArrayList<Neighbor>(); 
  }

  WayPoint(float area) {      
    this.pos = new DVector((double)random(0, area)+100, (double)random(0, area)+100, 0);
    this.nn = new ArrayList<Neighbor>(); 

  }

  // Find nearest neighbors
  void findNN(ArrayList<WayPoint> nNew) {    
    // Add the nearest neighbors
    DVector nPos = new DVector(); 
    double nDist;
    
    // new neighbor
    for (int i = 0; i < nNew.size(); i++) {
      // Create a neighbor object 
      // add it to the list
      nPos = nNew.get(i).pos.copy();
      DVector cntr = new DVector(360,360,0); 
      if(!(nPos.x != pos.x && nPos.y != pos.y && nPos.z != pos.z)){
        if(!lineSphIntersect(pos, nPos, cntr, (double)100)){
          nDist = dist((float)nPos.x, (float)nPos.y, (float)pos.x, (float)pos.y);
        
          // This is the wrong code 
          //nDist = dist((float)nPos.x, (float)pos.x, (float)nPos.y, (float)pos.y);

          this.nn.add(new Neighbor(nPos, nDist)); 

        }
       }
    }
    
    // sort nNew by distance
    Collections.sort(this.nn, new NeighborSort()); 
    
    
    // If the list has less than 3 neighbors reduce the list to the 3 closest neightbors. 
    if (this.nn.size() > 4) {
      List<Neighbor>minDPoints = Arrays.asList(this.nn.get(0),this.nn.get(1), this.nn.get(2));  
      this.nn.retainAll(minDPoints);   
    }
    nn.trimToSize(); 
  } // End findNN


/* Display Function */ 
//-------------------------------
  void display() {
    displayVertice(); 
    displayNeighbors();
  }

  void displayVertice() {
    fill(100); 
    circle((float)this.pos.x, (float)this.pos.y, 5);
  }


  void displayNeighbors() {
    stroke(2); 
//    println("pos x: " + this.pos.x + " pos y: " + this.pos.y);
    for (int i = 0; i < nn.size(); i++) {
      line((float)this.pos.x, (float)this.pos.y, (float)this.nn.get(i).pos.x, (float)this.nn.get(i).pos.y);
    }
  }
  
  void printNeighbors(){
    for(int i = 0; i < this.nn.size(); i++){
      println(i + " Nearest Neighbors "); 
      println("X: " + this.nn.get(i).pos.x + " Y: " + this.nn.get(i).pos.y);
      println(this.nn.get(i).dist+ "\n"); 
    }
  }
  
  // Utility 
  
  
  boolean lineSphIntersect(DVector p1, DVector p2, DVector circ, double r){
  double a = Math.pow((p2.x-p1.x),2) + Math.pow((p2.y-p1.y),2) + Math.pow((p2.y-p1.y),2);
  double b = 2 * ((p2.x-p1.x) * (circ.x-p1.x) + (p2.y-p1.y) * (circ.y-p1.y) + (p2.z-p1.z) * (circ.z-p1.z));
  double c = Math.pow(p1.x,2) + Math.pow(p1.y,2) + Math.pow(p1.z,2)
             + Math.pow(circ.x,2) + Math.pow(circ.y,2) + Math.pow(circ.z,2)
             - 2 * ((circ.x * p1.x + circ.y * p1.y + circ.z + p1.z));
  
  double res = Math.pow(b,2) - 4 * a * c; 
  if( res < 0){
    return false; 
  } else {
    return true; 
  }
}

//-------------------------------
}


class Neighbor{
  // Way Point info 
  DVector pos; 
  double dist; 

  Neighbor(DVector p, double d){
    this.pos = new DVector(); 
    this.pos.set(p); 
    this.dist = d; 
  }
  
}

class NeighborSort implements Comparator<Neighbor>{
    @Override
    public int compare(Neighbor n1, Neighbor n2) {
      
    return (int)n1.dist - (int)n2.dist;
} 

}
