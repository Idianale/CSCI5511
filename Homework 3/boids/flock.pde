class Flock {
  ArrayList<Agent> agents; 
  
  Flock(){
    agents = new ArrayList<Agent>(); 
  }
  
  void run(){
    for(Agent a : agents){
      a.run(a.dt); 
    }
  }
  
  void addAgent(Agent a){
    agents.add(a); 
  }
}
