

final int GRID_W_CASE_COUNT = 10;
final int GRID_H_CASE_COUNT = 22;
final int GRID_CASE_SIZE = 35;


class Grid {
  
  int X, Y;
  
  Grid(){
    final int margin = (int)(0.5 * (height - GRID_H_CASE_COUNT * GRID_CASE_SIZE));
    this.X = margin;
    this.Y = margin;
  }
  
  void Draw(){
    stroke(255, 0, 0);
    fill(255, 255, 255);
    
    for (int i = 0; i < GRID_W_CASE_COUNT; i++){
      for (int j = 0; j < GRID_H_CASE_COUNT; j++){
        rect(this.X + i * GRID_CASE_SIZE, this.Y + j * GRID_CASE_SIZE, GRID_CASE_SIZE, GRID_CASE_SIZE);
      }
    }
    
  }
  
} // Grid
