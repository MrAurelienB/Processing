
int maxPoints = 4;

QuadTree_c quadtree;

void setup(){
  size(1280,720);
  
  quadtree = new QuadTree_c(0.5 * width, 0.5 * height, width, height);
  
}
