MapGenerator_c MapGenerator;
Map_c Map;
RoomManager_c RoomManager;

MenuHandler_c MenuHandler;

void setup()
{
  size(1280,720);
  
  colorMode(RGB, 255, 255, 255, 255);
  rectMode(CORNER);
  
  ShowBackground();
  
  MenuHandler = new MenuHandler_c();
  
  MapGenerator = new MapGenerator_c();
  Map = MapGenerator.GenerateMap(128,72);
  RoomManager = new RoomManager_c(Map);

} // setup()


int i = 0, j = 0;

void draw()
{
  TestMenu();
}



void TestMenu()
{
  ShowBackground();
  MenuHandler.CheckAndShow();
}


void TestMap()
{
  ShowBackground();
  
  fill(0);
  stroke(0);
  
  Map.Print();
  RoomManager.PrintRoom(i,j);


  if (keyPressed && keyCode == LEFT)
    i = i - 1 < 0 ? 0 : i - 1;
  if (keyPressed && keyCode == RIGHT)
    i = i + 1 > 127 ? 127 : i + 1;
  if (keyPressed && keyCode == UP)
    j = j + 1 > 71 ? 71 : j + 1;
  if (keyPressed && keyCode == DOWN)
    j = j - 1 < 0 ? 0 : j - 1;
    
  fill(255,0,0,150);
  noStroke();
  rect(XConvertIntervalToCanvas(i * test_CellSize),
       YConvertIntervalToCanvas(j * test_CellSize) - test_CellSize,
       test_CellSize,
       test_CellSize);
}


void ShowBackground()
{
  background(255);
  fill(0 , 0, 255, 50);
  rect(-10, -10, width + 10, height + 10);
}
