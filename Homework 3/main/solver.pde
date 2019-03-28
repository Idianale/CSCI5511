class Solver{
  ArrayList<WayPoint> wayPoints = new ArrayList<WayPoint>();
  float area = 500; 
  int sizeList = (int)random(10,31); 

  Solver(){
    // Sample Points 
    for(int i = 0; i < sizeList; i++){
      WayPoint sample = new WayPoint(area); 
      // If sample point not in collision space add it to the list.
      if(!checkCollision(sample)){ wayPoints.add(sample);}
    }
    
    // Create Map
    
    // find the nearest neighbors of the each wayPoint
    for(int i = 0; i < wayPoints.size(); i++){
      wayPoints.get(i).findNN(wayPoints); 
    }
    
  }
  
  boolean checkCollision(WayPoint d){
    if(d.pos.x >= 285 && d.pos.x < 435 && d.pos.y >= 285 && d.pos.y <= 435){    
      return true;
    } else {
      return false;
    }
  }
  
  
  void displayPoints(){ //<>//
    for(int i = 0; i < wayPoints.size(); i++){
      wayPoints.get(i).display(); 
    }
  }
  
  /*
  void displayEdges(){
    for(int i = 0; i < wayPoints.size(); i++){
      stroke(2); 
      ArrayList<WayPoint> nList = wayPoints.get(i).getNeighbors();
      for(int j = 0; j < nList.size(); j++){ 
        line((float)wayPoints.get(i).pos.x, (float)nList.get(j).pos.x, (float)wayPoints.get(i).pos.y, (float)nList.get(j).pos.y); 
      }
    }
  }
  */
  
}



// Check if points are colliding. 


// Create A binary tree 


// Use DFS / BFS to find the best path a group of waypoints 


// move your start to the goal
