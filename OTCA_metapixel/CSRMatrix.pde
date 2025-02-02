import java.util.Map;

class CSRMatrix{
  
  private int m_Size;
  private HashMap<Integer,ArrayList<Integer>> m_Values;
  
  CSRMatrix(int n){
    this.m_Size = n;
    this.m_Values = new HashMap<Integer,ArrayList<Integer>>();
  }
  
  boolean IsIn(int i, int j){
    if (IsOOB(i,j))
      return (false);
    return (this.m_Values.containsKey(i) && this.m_Values.get(i).contains(j));
  }
  
  void Add(int i, int j){
    if (IsOOB(i,j))
      return;
    if (this.m_Values.containsKey(i)){
      if (this.m_Values.get(i).contains(j))
        return;
      this.m_Values.get(i).add(j);
    } else {
      ArrayList<Integer> List = new ArrayList<Integer>();
      List.add(j);
      this.m_Values.put(i, List);
    }
  }
  
  void Remove(int i, int j){
    if (IsOOB(i,j))
      return;
    if (IsIn(i, j)){
      this.m_Values.get(i).remove(new Integer(j));
      if (this.m_Values.get(i).isEmpty())
        this.m_Values.remove(i);
    }
  }
  
  int ElementCount(){
    int count = 0;
    for (Map.Entry<Integer,ArrayList<Integer>> entry : this.m_Values.entrySet())
      count += entry.getValue().size();
    return (count);
  }
  
  boolean IsOOB(int i, int j){
    return (i < 0 || j < 0 || i >= this.m_Size || j >= this.m_Size);
  }
  
}
