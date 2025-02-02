GuiMenuHandler_c MenuHandler;
EventHandler_c EventHandler;
TmapTiledMap_c TiledMap;
ObjMainCharacter_c Perso;
MathRect_c Screen;

TileSetSprites_c Sprite;

void setup()
   {
   size(1200, 900);
   background(255);
   smooth();

   println("Hello World !!!");

   Sprite = new TileSetSprites_c("charizard.json", 1, 0);

   TiledMap = new TmapTiledMap_c(TILESET_FOLDER_MAP + "FirstMap.json");
   Perso = new ObjMainCharacter_c(0.5 * TiledMap.MapWidth(), 0.5 * TiledMap.MapHeight(), new MathRect_c(0, 0, TiledMap.MapWidth() - 32, TiledMap.MapHeight() - 32), new MathRect_c(0, 0, 32, 32));
   Screen = new MathRect_c(0, 0, width, height);
   MenuHandler = new GuiMenuHandler_c();
   EventHandler = new EventHandler_c(MenuHandler, TiledMap, Perso, Screen);



   ///////////////////////////////////////////
   int ButtonSize = 64;
   int ButtonCount = 3;
   int MenuMargin = 4;

   // GENERIC MENU
   GuiMenu_c Menu = new GuiMenu_c(new MathRect_c(0, height - 71, ButtonCount * ButtonSize + (ButtonCount + 1) * MenuMargin, 71));
   Menu.SetIsDisplayed(true);
   Menu.SetIsActive(true);
   MenuHandler.AddMenu(Menu);

   GuiImageButton_c Button1 = new GuiImageButton_c("Gui/gui_menu_equip.png", Menu, new PVector(MenuMargin, MenuMargin));
   Menu.AddButton(Button1);
   GuiImageButton_c Button2 = new GuiImageButton_c("Gui/gui_menu_invent.png", Menu, new PVector(2 * MenuMargin + ButtonSize, MenuMargin));
   Menu.AddButton(Button2);
   GuiImageButton_c Button3 = new GuiImageButton_c("Gui/gui_menu_map.png", Menu, new PVector(MenuMargin + 2 * (ButtonSize + MenuMargin), MenuMargin));
   Menu.AddButton(Button3);

   // INVENT MENU
   int WidthInventMenu = 500;
   int HeightInventMenu = 600;
   GuiMenu_c InventMenu = new GuiMenu_c(new MathRect_c(0.5 * (width - WidthInventMenu), 0.5 * (height - HeightInventMenu), WidthInventMenu, HeightInventMenu));
   InventMenu.SetIsDisplayed(false);
   InventMenu.SetIsActive(false);
   InventMenu.SetBackgroundColor(color(160, 50, 160));
   MenuHandler.AddMenu(InventMenu);

   GuiImageButton_c CloseButton = new GuiImageButton_c("Gui/cross.png", InventMenu, new PVector(WidthInventMenu - 32, 0));
   InventMenu.AddButton(CloseButton);

   // SET MENUS
   Button2.SetMenuToShow(InventMenu);
   CloseButton.SetMenuToHide(InventMenu);
   ///////////////////////////////////////////
   }

void draw()
   {
   background(255);
   fill(255, 0, 0);
   noStroke();

   EventHandler.Update();

   TiledMap.DisplayLayers(0, 2);
   Perso.Display(TiledMap.ScreenPosition(), Sprite);

   MenuHandler.Display();
   }

void keyPressed()
   {
   EventHandler.KeyPressed(keyCode);
   }
 
void keyReleased()
   {
   EventHandler.KeyReleased(keyCode);
   }

void mousePressed()
   {
   EventHandler.MousePressed();
   }

///////////////////////////////////////////////


// Creer les menu depuis un fichier json
