/* 
 Current Bug: 
 Does not create the nearest neighbor list correctly 
 
 You implemnted Neighbors as an object of 
 
 */

import java.util.*;

public class WayPoint{
  DVector pos; 
  ArrayList<Neighbor> nn; // nearest neighbors
  boolean visted = false; 
  
  
  WayPoint() {      
    this.pos = new DVector((double)random(0, 500)+100, (double)random(0, 500)+100, 0);
    this.nn = new ArrayList<Neighbor>(); 
  }

  WayPoint(float area) {      
    this.pos = new DVector((double)random(-200, area)+200, (double)random(200, area)-200, 0);
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
      nDist = dist((float)nPos.x, (float)nPos.y, (float)pos.x, (float)pos.y);
      if(!(nPos.x != pos.x && nPos.y != pos.y && nPos.z != pos.z)){
            this.nn.add(new Neighbor(nPos, nDist)); 
      }
    }
    
    //      if(!lineSphIntersect(pos, obstacles.obsPos.get(j).pos, new DVector(obstacles.obsPos.get(j).pos.x,obstacles.obsPos.get(j).pos.y,0), (double)100)){
    
    Collections.sort(nn, new NeighborSort()); 
    Set<Neighbor> set = new LinkedHashSet(nn); 
    nn.clear(); 
    nn.addAll(set); 
    
    
    // If the list has less than 3 neighbors reduce the list to the 3 closest neightbors. 
    if (nn.size() > 4) {
      List<Neighbor>minDPoints = Arrays.asList(nn.get(0),nn.get(1), this.nn.get(2));  
      nn.retainAll(minDPoints);   
    }
   
   /*
   Iterator nNeighbor = nn.iterator(); 
     while(nNeighbor.hasNext()){
       Iterator itr = obstacles.obsPos.iterator(); 
       Neighbor curNeighbor =  (Neighbor)nNeighbor.next(); 
       while(itr.hasNext()){
         Obstacle o = (Obstacle)itr.next();
         if(lineSphIntersect(pos, curNeighbor.pos,o.pos)){
                nn.remove(nNeighbor); 
         }
       }
     }
    */
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
  
  
  boolean lineSphIntersect(DVector p1, DVector p2, DVector circ){
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
  
  @Override
    public int hashCode() {
      final int prime = 31;
      int result = 1;
      result += prime * result * (int)random(0,29);
      result += prime * result * (int)random(0,29);
      return result;
    }
    
    @Override
    public boolean equals(Object obj) {
      if (this == obj)
        return true;
      if (obj == null)
        return false;
      if (getClass() != obj.getClass())
        return false;
      WayPoint other = (WayPoint) obj;
      if (pos.equals(other.pos))
        return true;
      return true;
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
  
    @Override
    public int hashCode() {
      final int prime = 31;
      int result = 1;
      result += prime * result * (int)random(0,29);
      result += prime * result * (int)random(0,29);
      return result;
    }
    
    @Override
    public boolean equals(Object obj) {
      if (this == obj)
        return true;
      if (obj == null)
        return false;
      if (getClass() != obj.getClass())
        return false;
      Neighbor other = (Neighbor) obj;
      if (pos.equals(other.pos)) 
        return true;
      if(dist != other.dist)
        return true; 
      return true;
    }

  
}

class NeighborSort implements Comparator<Neighbor>{
    @Override
    public int compare(Neighbor n1, Neighbor n2) {
      
    return (int)n1.dist - (int)n2.dist;
} 

}
