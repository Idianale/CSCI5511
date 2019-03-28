/* 
 Current Bug: 
 Does not create the nearest neighbor list
 
 */

import java.util.*;

public class WayPoint implements Comparator<WayPoint>{
  DVector pos; 
  ArrayList<WayPoint> nn; // nearest neighbors 
  
  WayPoint() {      
    pos = new DVector((double)random(0, 500)+100, (double)random(0, 500)+100, 0);
  }

  WayPoint(float area) {      
    pos = new DVector((double)random(0, area)+100, (double)random(0, area)+100, 0);
  }

  // Find nearest neighbors
  void findNN(ArrayList<WayPoint> nNew) {
    ArrayList<WayPoint> wP; 
    wP = (ArrayList<WayPoint>)nNew.clone();  
    // sort nNew by distance     
    Collections.sort(wP, new WayPoint()); 
    
    for (int i = 0; i < wP.size(); i++) {
      println("neighbor " + i + " : " + dist((float)wP.get(i).pos.x, (float)pos.x, (float)wP.get(i).pos.y, (float)pos.y));
    }

    print("new size: " + nNew.size() + "\n"); 
    if (wP.size() > 4) {
      //WayPoint[] minDPoints = new WayPoint[]{wP.get(0), wP.get(1), wP.get(2)}; 
      List<WayPoint>minDPoints = Arrays.asList(wP.get(0),wP.get(1), wP.get(2));  
      wP.retainAll(minDPoints);   
    }
    nn = wP; //<>//
    println("neighest neighbor distance top: " );  //<>//
    for (int i = 0; i < nn.size(); i++) {
      println("shortest neighbor " + i + " : " + dist((float)nn.get(i).pos.x, (float)pos.x, (float)nn.get(i).pos.y, (float)pos.y));
    }
  }

  void display() {
    displayVertice(); 
    displayNeighbors();
  }

  void displayVertice() {
    fill(100); 
    circle((float)pos.x, (float)pos.y, 5);
  }


  void displayNeighbors() {
    stroke(2); 
    for (int i = 0; i < nn.size(); i++) {
      line((float)pos.x, (float)pos.y, (float)nn.get(i).pos.x, (float)nn.get(i).pos.y);
    }
  }

  void sortByDist(ArrayList<WayPoint> nNew) {
    Collections.sort(nNew, new WayPoint());
  }

  ArrayList<WayPoint> getNeighbors() {
    ArrayList<WayPoint> nNew = new ArrayList<WayPoint>(); 
    nNew = nn; 
    return nNew;
  }
  
   @Override
    public int compare(WayPoint w1, WayPoint w2) {
    int dist1 = (int)dist((float)pos.x, (float)w1.pos.x, (float)pos.y, (float)w1.pos.y);
    int dist2 = (int)dist((float)pos.x, (float)w2.pos.x, (float)pos.y, (float)w2.pos.y);
    return dist1 - dist2;
  }

}

public class WayPointSorter implements Comparator<WayPoint> {
  WayPoint w;

  WayPointSorter(WayPoint point) {
    w = point;
  }

  @Override
    public int compare(WayPoint w1, WayPoint w2) {
    int dist1 = (int)dist((float)w.pos.x, (float)w1.pos.x, (float)w.pos.y, (float)w1.pos.y);
    int dist2 = (int)dist((float)w.pos.x, (float)w2.pos.x, (float)w.pos.y, (float)w2.pos.y);
    return dist1 - dist2;
  }
}

class Neighbor{
  // Way Point info 
  DVector pos; 
  double dist; 
}
