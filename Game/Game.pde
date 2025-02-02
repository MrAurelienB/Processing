
///////////////////////////////////// Set up the environment //////////////////////////////////////
EventHandler_c EventHandler = new EventHandler_c();
GameEngine_c GameEngine = new GameEngine_c(EventHandler);
UsrEventHandler_c UsrEventHandler = new UsrEventHandler_c();

void settings()
   {
   size(SCREEN_W, SCREEN_H);
   }

void setup()
   {
   EventHandler.OnInitializeStart();
   Initialize();
   EventHandler.OnInitializeEnd();
   }

void Initialize()
   {
   background(255);
   smooth();
   rectMode(CORNER);
   GameEngine.Initialize();
   }

void exit()
   {
   EventHandler.OnExit();
   super.exit();
   }

///////////////////////////////////////// Drawing loop ////////////////////////////////////////////
int It = 0;
void draw()
   {
   background(255);
   noStroke();
   GameEngine.DisplayMap();
   EventHandler.OnDraw();
   }

///////////////////////////////// Processing User event functions /////////////////////////////////
void keyPressed()
   { UsrEventHandler.KeyPressed(); }
 
void keyReleased()
   { UsrEventHandler.KeyReleased(); }

void mousePressed()
   { UsrEventHandler.MousePressed(); }