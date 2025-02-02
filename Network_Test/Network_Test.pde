import java.util.Random;

ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Arc> arcs = new ArrayList<Arc>();

void setup()
{
  for (int i = 0; i < 10; i++)
    nodes.add(new Node(i));
    
  arcs.add(new Arc(nodes.get(0), nodes.get(1), 0));
  arcs.add(new Arc(nodes.get(0), nodes.get(2), 1));
  arcs.add(new Arc(nodes.get(1), nodes.get(3), 2));
  arcs.add(new Arc(nodes.get(1), nodes.get(4), 3));
  arcs.add(new Arc(nodes.get(2), nodes.get(5), 4));
  arcs.add(new Arc(nodes.get(2), nodes.get(6), 5));
  arcs.add(new Arc(nodes.get(3), nodes.get(7), 6));
  arcs.add(new Arc(nodes.get(3), nodes.get(8), 7));
  arcs.add(new Arc(nodes.get(3), nodes.get(9), 8));
  arcs.add(new Arc(nodes.get(5), nodes.get(9), 9));
  
  boolean[][] isAccessible = new boolean[10][9];
  
  
  
  
}






class Node{
  
  int idx;
  
  Node(int idx){
    this.idx = idx;
  }
  
}

class Arc{
  
  int idx;
  Node a = null, b = null;
  
  Arc(Node a, Node b, int idx){
    this.a = a;
    this.b = b;
    this.idx = idx;
  }
  
}
