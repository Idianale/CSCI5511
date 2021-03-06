class Solver{
  ArrayList<WayPoint> wayPoints = new ArrayList<WayPoint>();
  float area = 500; 
  int sizeList = (int)random(10,500); 
  // Index corresponds to a node; 
  // each index contains: 
  // - list of waypoints that represent the nearest neighbors of that node
  // - distance from between that node and its neighbor
   
 
  Solver(){
    // Sample Points 
    for(int i = 0; i < sizeList; i++){
      WayPoint sample = new WayPoint(area); 
      // If sample point not in collision space add it to the list.
      if(!checkCollision(sample)){ wayPoints.add(sample);}
    }
        
    // find the nearest neighbors of the each wayPoint
    for(int i = 0; i < wayPoints.size(); i++){
      wayPoints.get(i).findNN(wayPoints); 
    }
   
    
    // construct a map 
    
  }
  
  boolean checkCollision(WayPoint d){
    if(d.pos.x >= 285 && d.pos.x < 435 && d.pos.y >= 285 && d.pos.y <= 435){    
      return true;
    } else {
      return false;
    }
  }
  
  
  void display(){
    for(int i = 0; i < wayPoints.size(); i++){
      wayPoints.get(i).display(); 
    }
  }
  

  
  
}



// Check if points are colliding. 


// Create A binary tree 


// Use DFS / BFS to find the best path a group of waypoints 


// move your start to the goal
