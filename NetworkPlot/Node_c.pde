class Node_c {
  
  int m_StopNumber;
  ArrayList<Arc_c> ArcList = new ArrayList<Arc_c>();
  
  Node_c(int StopNumber){
    this.m_StopNumber = StopNumber;
  }
  
  int StopNumber(){
    return (this.m_StopNumber);
  }
  
  void Add(Arc_c Arc){
    this.ArcList.add(Arc);
  }
  
}
