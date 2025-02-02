class QuadTree_c{
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  float x, y, w, h;
  QuadTree_c nw = null, ne = null, sw = null, se = null;
  
  QuadTree_c(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void addPoint(float x, float y){
    if (this.points.size())
  }
  
  void show(){
    stroke(0);
    rect(this.x - 0.5 * width, this.y - 0.5 * height, this.w, this.h);
    if (this.nw != null)
      nw.show();
    if (this.ne != null)
      ne.show();
    if (this.sw != null)
      sw.show();
    if (this.se != null)
      se.show();
  }
  
}
