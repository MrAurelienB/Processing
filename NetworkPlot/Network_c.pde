class Network_c {
  
  HashMap<Integer,Node_c> NodeHMap = new HashMap<Integer,Node_c>();
  ArrayList<Arc_c> ArcList = new ArrayList<Arc_c>();
  
  Network_c(){
    
  }
  
  void Add(Node_c Node){
    this.NodeHMap.put(Node.StopNumber(), Node);
  }
  
  void Add(int StopFrom, int StopTo){
    if (!this.NodeHMap.containsKey(StopFrom) || !this.NodeHMap.containsKey(StopTo))
      return;
      
    Node_c NodeFrom = this.NodeHMap.get(StopFrom);
    Node_c NodeTo = this.NodeHMap.get(StopTo);
    
    if (NodeFrom == null || NodeTo == null)
      return;
      
    Arc_c Arc = new Arc_c(NodeFrom.StopNumber(), NodeTo.StopNumber());
    NodeFrom.Add(Arc);
    this.ArcList.add(Arc);
  }
  
  boolean IsPathBetweenNodes(int StopFrom, int StopTo){
    if (StopFrom == StopTo)
      return (true);
      
    if (!NodeHMap.containsKey(StopFrom))
      return (false);
      
    Node_c NodeFrom = NodeHMap.get(StopFrom);
    for (Arc_c Arc : NodeFrom.ArcList)
      {
      if (IsPathBetweenNodes(Arc.m_StopTo, StopTo))
        return (true);
        
      continue;
      }
    return (false);
  }
  
}
