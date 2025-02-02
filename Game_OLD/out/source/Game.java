import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import java.util.*; 
import java.util.HashMap; 
import java.util.HashMap; 
import java.util.*; 
import java.util.Objects; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Game extends PApplet {

GuiMenuHandler_c MenuHandler;
EventHandler_c EventHandler;
TmapTiledMap_c TiledMap;
ObjMainCharacter_c Perso;
MathRect_c Screen;

TileSetSprites_c Sprite;

public void setup()
   {
   
   background(255);
   

   println("Hello World !!!");

   Sprite = new TileSetSprites_c("charizard.json", 1, 0);

   TiledMap = new TmapTiledMap_c(TILESET_FOLDER_MAP + "FirstMap.json");
   Perso = new ObjMainCharacter_c(0.5f * TiledMap.MapWidth(), 0.5f * TiledMap.MapHeight(), new MathRect_c(0, 0, TiledMap.MapWidth() - 32, TiledMap.MapHeight() - 32), new MathRect_c(0, 0, 32, 32));
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
   GuiMenu_c InventMenu = new GuiMenu_c(new MathRect_c(0.5f * (width - WidthInventMenu), 0.5f * (height - HeightInventMenu), WidthInventMenu, HeightInventMenu));
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

public void draw()
   {
   background(255);
   fill(255, 0, 0);
   noStroke();

   EventHandler.Update();

   TiledMap.DisplayLayers(0, 2);
   Perso.Display(TiledMap.ScreenPosition(), Sprite);

   MenuHandler.Display();
   }

public void keyPressed()
   {
   EventHandler.KeyPressed(keyCode);
   }
 
public void keyReleased()
   {
   EventHandler.KeyReleased(keyCode);
   }

public void mousePressed()
   {
   EventHandler.MousePressed();
   }

///////////////////////////////////////////////


// Creer les menu depuis un fichier json
// // This class represents a point in k dimensions.
// public interface MathPoint_i
//    {
//    // This function returns the dimension of the point.
//    public int Dimension();

//    // This function returns the value of the n-th axis. Start by index 0.
//    public float GetAxis(final int Axis);
//    } // interface MathPoint_i

// // This class implements the comparator function to sort points according to the n-th dimension.
// private class MathSortPoint_c implements Comparator<MathPoint_i> 
//    {
   
//    private int m_Axis;

//    public MathSortPoint_c(final int Axis)
//       {
//       this.m_Axis = Axis;
//       } // MathSortPoint_c()

//    // Used for sorting in ascending order of index.
//    public int compare(MathPoint_i Lhs, MathPoint_i Rhs) 
//       {
//       float Diff = Lhs.GetAxis(this.m_Axis) - Rhs.GetAxis(this.m_Axis);
//       return (Diff < 0 ? -1 : (Diff > 0 ? 1 : 0)); 
//       } // compare()
//    } // class MathSortPoint_c


// // This class represents a kd-tree.
// public class AlgoKdTree_c
//    {

//    // The depth of the tree.
//    private int m_Depth = int_NULL;
//    // The current point of the tree.
//    private MathPoint_i m_CurrentPoint = null;
//    // The left tree.
//    private AlgoKdTree_c m_LeftTree = null;
//    // The right tree.
//    private AlgoKdTree_c m_RightTree = null;
//    // The number of node in the tree.
//    private int m_NodeCount = 0;

//    // Constructor
//    // PointList should never be empty.
//    public AlgoKdTree_c(final int Dimension, final ArrayList<MathPoint_i> PointList)
//       {
//       this.m_Depth = 0;
//       this.m_NodeCount = PointList.size();
//       Initialize(PointList);
//       } // AlgoKdTree_c()

//    // Constructor
//    // PointList should never be empty.
//    public AlgoKdTree_c(final ArrayList<MathPoint_i> PointList, final int Depth)
//       {
//       this.m_Depth = Depth;
//       Initialize(PointList);
//       } // AlgoKdTree_c()

//    // This function initilizes the tree.
//    private void Initialize(final ArrayList<MathPoint_i> PointList)
//       {
//       if (PointList.size() == 1)
//          {
//          this.m_CurrentPoint = PointList.get(0);
//          return;
//          }

//       int Dimension = PointList.get(0).Dimension();
//       int Axis = this.m_Depth % Dimension;
//       Collections.sort(PointList, new MathSortPoint_c(Axis));

//       int MedianIndex = ceil(PointList.size() / 2);
//       this.m_CurrentPoint = PointList.get(MedianIndex);

//       // If the median is at index 0, there is no left tree.
//       if (MedianIndex > 0)
//          {
//          ArrayList<MathPoint_i> LeftList = new ArrayList<MathPoint_i>(PointList.subList(0 /*Included*/, MedianIndex /*Excluded*/));
//          this.m_LeftTree = new AlgoKdTree_c(LeftList, this.m_Depth + 1);
//          }

//       // If the median is at index PointList.size() - 1, there is no right tree.
//       if (MedianIndex < PointList.size() - 1)
//          {
//          ArrayList<MathPoint_i> RigtList = new ArrayList<MathPoint_i>(PointList.subList(MedianIndex + 1 /*Included*/, PointList.size() /*Excluded*/));
//          this.m_RightTree = new AlgoKdTree_c(RigtList, this.m_Depth + 1);
//          }
//       } // Initialize()

//    } // class AlgoKdTree_c

// // This class is used to build a kd-tree for rectangles.
// public class AlgoKdTreeForRect_c extends AlgoKdTree_c
//    {

//    public AlgoKdTreeForRect_c(final ArrayList<MathPoint_i> PointList)
//       {
//       super(PointList, 0 /*Depth*/);
//       } // AlgoKdTreeForRect_c()

//    public ArrayList<MathPoint_i> GetIntersetingRectangles(final MathPoint_i Query)
//       {
//       ArrayList<MathPoint_i> PointList = new ArrayList<MathPoint_i>();

//       if (/*Intersect current point*/)
//          PointList.add(m_CurrentPoint);

//       int Axis = this.m_Depth % 4;
//       if (Axis == 0)
//          {

//          }
//       else if (Axis == 1)
//          {}
//       else if (Axis == 2)
//          {}
//       else // Axis == 3
//          {}

//       return (PointList);
//       } // GetIntersetingRectangles()

//    } // class AlgoKdTreeForRect_c


public class EventHandler_c
   {

   private GuiMenuHandler_c m_MenuHandler;
   private TmapTiledMap_c m_TiledMap;
   private ObjMainCharacter_c m_Perso;
   private MathRect_c m_Screen;

   public EventHandler_c(GuiMenuHandler_c MenuHandler, TmapTiledMap_c TiledMap, ObjMainCharacter_c Perso, MathRect_c Screen)
      {
      this.m_MenuHandler = MenuHandler;
      this.m_TiledMap = TiledMap;
      this.m_Perso = Perso;
      this.m_Screen = Screen;
      } // EventHandler_c()

   public boolean IsPersoKeyCode(final int KeyCode)
      {
      return (s_PersoKeyCodeList.contains(KeyCode));
      } // IsPersoKeyCode()

   public void KeyPressed(final int KeyCode)
      {
      if (IsPersoKeyCode(KeyCode))
         this.m_Perso.SetDirection(KeyCode, true);
      } // KeyPressed()

   public void KeyReleased(final int KeyCode)
      {
      if (IsPersoKeyCode(KeyCode))
         this.m_Perso.SetDirection(KeyCode, false);
      } // KeyReleased()

   public void MousePressed()
      {
      this.m_MenuHandler.MousePressed();
      } // MousePressed()

   public void Update()
      {
      this.m_Perso.Move();
      this.m_TiledMap.UpdateScreenPosition(Perso);
      } // Update()

   } // class EventHandler_c
// This class represents an image button.
/*public class GuiImageButton_c
   {

   private String m_FileNameSuffix = "";
   private PImage m_BaseImage;
   private PImage m_HoverImage;
   private PImage m_ClickedImage;
   private ButtonStatus_ch m_Status = ButtonStatus_ch.NULL;
   private PVector m_Position;

   // Constructor.
   public GuiImageButton_c(final PVector Position, final String FileNameSuffix)
      {
      this.m_FileNameSuffix = FileNameSuffix;
      this.m_BaseImage = loadImage(GUI_FOLDER + this.m_FileNameSuffix + "_base.png");
      this.m_HoverImage = loadImage(GUI_FOLDER + this.m_FileNameSuffix + "_hover.png");
      this.m_ClickedImage = loadImage(GUI_FOLDER + this.m_FileNameSuffix + "_clicked.png");
      this.m_Status = ButtonStatus_ch.BASE;
      this.m_Position = Position;
      } // GuiImageButton_c()

   // This function displays the button.
   public void Display()
      {
      switch (this.m_Status)
         {
         case BASE:
            {
            image(this.m_BaseImage, this.m_Position.x, this.m_Position.y);
            break;
            }
         case HOVER:
            {
            image(this.m_HoverImage, this.m_Position.x, this.m_Position.y);
            break;
            }
         case CLICKED:
            {
            image(this.m_ClickedImage, this.m_Position.x, this.m_Position.y);
            break;
            }
         }
      } // Display()

   // This function returns whether the mouse is on the button.
   boolean IsMouseOn()
      {
      return (mouseX > this.m_Position.x && mouseX < this.m_Position.x + 64 && mouseY > this.m_Position.y && mouseY < this.m_Position.y + 64);
      } // IsMouseOn()

   // This function sets the status of the button.
   public void SetStatus(final ButtonStatus_ch Status)
      {
      this.m_Status = Status;
      } // SetStatus()

   // This function returns the status of the button.
   public ButtonStatus_ch Status()
      {
      return (this.m_Status);
      } // Status()

   } // class GuiImageButton_c*/

// This class handles the Gui menus.
public class GuiMenuHandler_c
   {
   // The list of menus the GuiHandler has to handle.
   private ArrayList<GuiMenu_c> m_MenuList;

   // Constructor.
   public GuiMenuHandler_c()
      {
      this.m_MenuList = new ArrayList<GuiMenu_c>();
      } // GuiMenuHandler_c

   // Adds a menu to the list of menus.
   public void AddMenu(GuiMenu_c Menu)
      {
      this.m_MenuList.add(Menu);
      } // AddMenu()

   // Display the menus that need to be displayed.
   public void Display()
      {
      for (GuiMenu_c Menu : this.m_MenuList)
         {
         if (Menu.IsDisplayed()) // Should be displayed in order. Maybe constructed in the same order ???
            Menu.Display();
         }
      } // Display()

   // Called when the mouse is pressed. It calls the MousePressed on the active menu the mouse is over.
   public void MousePressed()
      {
      for (GuiMenu_c Menu : this.m_MenuList)
         {
         if (Menu.IsDisplayed() && Menu.IsActive() && Menu.IsMouseOver())
            Menu.MousePressed();
         }
      } // MousePressed()

   } // class GuiMenuHandler_c

// This class represents a Gui menu.
public class GuiMenu_c
   {
   // The background color.
   private int m_BackgroundColor = color(0, 0, 0);
   // The list of buttons of the menu.
   private ArrayList<GuiImageButton_c> m_ButtonList;
   // Indicates whether the menu is active or not.
   private boolean m_IsActive;
   // Indicates whether the menu is displayed or not.
   private boolean m_IsDisplayed;
   // The rectangle in which the menu wil be displayed.
   private MathRect_c m_MenuRect;

   // Constructor.
   public GuiMenu_c(final MathRect_c MenuRect)
      {
      this.m_ButtonList = new ArrayList<GuiImageButton_c>();
      this.m_MenuRect = MenuRect;
      this.m_IsActive = false;
      this.m_IsDisplayed = false;
      } // GuiMenu_c()

   // Adds a button to the menu.
   public void AddButton(GuiImageButton_c Button)
      {
      this.m_ButtonList.add(Button);
      } // AddButton()

   // Displays the menu.
   public void Display()
      {
      if (!this.m_IsDisplayed)
         return;

      fill(this.m_BackgroundColor);
      rect(this.m_MenuRect.OriginX(), this.m_MenuRect.OriginY(), this.m_MenuRect.Width(), this.m_MenuRect.Height());

      final boolean IsOver = this.IsMouseOver();
      for (GuiImageButton_c Button : this.m_ButtonList)
         Button.Display(IsOver, this.m_IsActive);
      } // Display()

   // This function hides the menu (active = false and displayed = false)
   public void Hide()
      {
      SetIsActive(false);
      SetIsDisplayed(false);
      } // Hide()

   // Indicates whether the menu is active or not. A menu can be displayed but inactive because an other menu is displayed above it.
   public boolean IsActive()
      {
      return (this.m_IsActive);
      } // IsActive()

   // Indicates whether a menu is displayed or not.
   public boolean IsDisplayed()
      {
      return (this.m_IsDisplayed);
      } // IsDisplayed()

   // Indicates whether the mouse is over the menu or not.
   public boolean IsMouseOver()
      {
      return (this.m_MenuRect.IsPointInside(mouseX, mouseY));
      } // IsMouseOver()

   // Returns the menu rectangle
   public MathRect_c MenuRect()
      {
      return (this.m_MenuRect);
      } // MenuRect()

   // Called when the mouse is pressed over the active and displayed menu.
   public void MousePressed()
      {
      if (!this.m_IsDisplayed || !this.m_IsActive)
         return;

      for (GuiImageButton_c Button : this.m_ButtonList)
         {
         if (Button.IsMouseOver())
            {
            Button.MousePressed();
            break; // The mouse cannot be over more than one button.
            }
         }
      } // MousePressed()

   // Sets the background color.
   public void SetBackgroundColor(final int BackgroundColor)
      {
      this.m_BackgroundColor = BackgroundColor;
      } // SetBackgroundColor()

   // Sets whether the menu is active or not.
   public void SetIsActive(final boolean IsActive)
      {
      this.m_IsActive = IsActive;
      } // SetIsActive()

   // Sets whether the button is displayed or not.
   public void SetIsDisplayed(final boolean IsDisplayed)
      {
      this.m_IsDisplayed = IsDisplayed;
      } // SetIsDisplayed()

   // This function shows the menu (active = true and displayed = true)
   public void Show()
      {
      SetIsActive(true);
      SetIsDisplayed(true);
      } // Show()
   } // class GuiMenu_c

// This class represents a generic button.
public class GuiImageButton_c
   {
   // The rectangle of the button.
   private MathRect_c m_ButtonRect = null;
   // The menu on which is the button.
   private GuiMenu_c m_Menu = null;
   // The image of the button.
   private PImage m_Image = null;
   // The image file name.
   private String m_ImageFileName = "";

   private GuiMenu_c m_MenuToHide = null;
   private GuiMenu_c m_MenuToShow = null;

   // Constructor.
   public GuiImageButton_c(final String ImagePath, GuiMenu_c Menu, final PVector Offset)
      {
      this.m_ImageFileName = ImagePath;
      this.m_Image = loadImage(ImagePath);
      this.m_Menu = Menu;
      this.m_ButtonRect = new MathRect_c(this.m_Menu.MenuRect().OriginX() + Offset.x, this.m_Menu.MenuRect().OriginY() + Offset.y, this.m_Image.width, this.m_Image.height);
      } // GuiImageButton_c()

   // Displays the button.
   public void Display(final boolean IsMousePossiblyOver, final boolean IsActive)
      {
      if (IsActive && IsMousePossiblyOver && this.IsMouseOver())
         tint(255, GUI_MOUSE_OVER_BUTTON_ALPHA);
      image(this.m_Image, this.m_ButtonRect.OriginX(), this.m_ButtonRect.OriginY());
      noTint();
      } // Display()

   // Indicates whether the mouse is over the button or not.
   public boolean IsMouseOver()
      {
      return (this.m_ButtonRect.IsPointInside(mouseX, mouseY));
      } // IsMouseOver()

   // Called when the mouse is pressed over the button.
   public void MousePressed()
      {
      if (this.m_MenuToHide != null)
         this.m_MenuToHide.Hide();
      if (this.m_MenuToShow != null)
         this.m_MenuToShow.Show();
      } // MousePressed()

   // This function sets the menu to hide (active = false and displayed = false) when the button is pressed.
   public void SetMenuToHide(final GuiMenu_c MenuToHide)
      {
      this.m_MenuToHide = MenuToHide;
      } // SetMenuToHide()

   // This function sets the menu to show (active = true and displayed = true) when the button is pressed.
   public void SetMenuToShow(final GuiMenu_c MenuToShow)
      {
      this.m_MenuToShow = MenuToShow;
      } // SetMenuToShow()
   } // class GuiImageButton_c


// This class represents a range. It is composed of two values, the first and the last.
public class MathRange_c
   {

   private int m_FromValue;
   private int m_ToValue;

   // Constructor
   public MathRange_c(final int FromValue, final int ToValue)
      {
      this.m_FromValue = FromValue;
      this.m_ToValue = ToValue;
      } // MathRange_c()

   // This function returns the from value of the range.
   public int FromValue()
      {
      return (this.m_FromValue);
      } // FromValue()

   // This function returns the range size.
   public int RangeSize()
      {
      return (this.m_ToValue - this.m_FromValue);
      } // RangeSize()

   // This function returns the to value of the range.
   public int ToValue()
      {
      return (this.m_ToValue);
      } // FromValue()

   } // class MathRange_c

// This class represents a rectangle with four values.
// The origin corrdinates (upper left corner), the width and the height.
public class MathRect_c
   {

   private float m_Height;
   private float m_OriginX;
   private float m_OriginY;
   private float m_Width;

   // Constructor
   public MathRect_c(final float OriginX, final float OriginY, final float Width, final float Height)
      {
      this.m_Height = Height;
      this.m_OriginX = OriginX;
      this.m_OriginY = OriginY;
      this.m_Width = Width;
      } // MathRect_c()

   // This function returns the value constrained in the rectangle.
   public void Constrain(final PVector Vector)
      {
      Vector.x = constrain(Vector.x, this.m_OriginX, this.m_OriginX + this.m_Width);
      Vector.y = constrain(Vector.y, this.m_OriginY, this.m_OriginY + this.m_Height);
      } // Constrain()

   // This function returns the height of the rectangle.
   public float Height()
      {
      return (this.m_Height);
      } // Height()

   // This function indicates whether the point of coordinates (XCoord,YCoord) is inside the rectangle or not.
   public boolean IsPointInside(final float XCoord, final float YCoord)
      {
      return (XCoord >= this.m_OriginX && XCoord <= this.m_OriginX + this.m_Width &&
              YCoord >= this.m_OriginY && YCoord <= this.m_OriginY + this.m_Height);
      } // IsPointInside()

   // This function returns the X coordinate of the origin.
   public float OriginX()
      {
      return (this.m_OriginX);
      } // OriginX()

   // This function returns the Y coordinate of the origin.
   public float OriginY()
      {
      return (this.m_OriginY);
      } // OriginY()

   // This function resets the rectangle.
   public void Reset(final float OriginX, final float OriginY, final float Width, final float Height)
      {
      this.m_Height = Height;
      this.m_OriginX = OriginX;
      this.m_OriginY = OriginY;
      this.m_Width = Width;
      } // Reset()

   // This function sets the height of the rectangle.
   public void SetHeight(final float Height)
      {
      this.m_Height = Height;
      } // SetHeight()

   // This function sets the X coordinate of the origin.
   public void SetOriginX(final float OriginX)
      {
      this.m_OriginX = OriginX;
      } // SetOriginX()

   // This function sets the Y coordinate of the origin.
   public void SetOriginY(final float OriginY)
      {
      this.m_OriginY = OriginY;
      } // SetOriginY()

   // This function sets the width of the rectangle.
   public void SetWidth(final float Width)
      {
      this.m_Width = Width;
      } // SetWidth()

   // This function returns the width of the rectangle.
   public float Width()
      {
      return (this.m_Width);
      } // Width()

   } // class MathRect_c


public enum MoveDir_ch
   {
   NORTH,
   SOUTH,
   EAST,
   WEST,
   NULL
   } // enum MoveDir_ch

// The component represents a movable object.
public class ObjMovableObject_p
   {

   protected PVector m_InWorldPosition = null;
   private int m_DefaultSpeed = 7;
   private PVector m_Speed = new PVector(m_DefaultSpeed, m_DefaultSpeed);
   private HashMap<MoveDir_ch,Boolean> m_DirectionHMap = null;
   private MathRect_c m_WorldBoundRect = null;
   protected MathRect_c m_HitBox = null;
   protected MoveDir_ch m_LastMoveDir;
   protected float m_MotionIdxFlt = 0.0f;

   // Constructor
   public ObjMovableObject_p(final float x, final float y, final MathRect_c BoundRect, final MathRect_c HitBox)
      {
      this.m_HitBox = HitBox;
      this.m_WorldBoundRect = BoundRect;
      this.m_InWorldPosition = new PVector(x, y);
      this.m_DirectionHMap = new HashMap<MoveDir_ch,Boolean>()
         {
            {
            put(MoveDir_ch.NORTH, false);
            put(MoveDir_ch.SOUTH, false);
            put(MoveDir_ch.EAST, false);
            put(MoveDir_ch.WEST, false);
            }
         };
      this.m_LastMoveDir = MoveDir_ch.SOUTH;
      } // ObjMovableObject_p()

   // This function constrain the the position to the boundaries rectangle.
   private void Constrain()
      {
      this.m_WorldBoundRect.Constrain(this.m_InWorldPosition);
      } // Constrain()

   // This function moves the object with the object speed.
   public void Move()
      {
      this.m_Speed.set((this.m_DirectionHMap.get(MoveDir_ch.EAST) ?  m_DefaultSpeed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.WEST) ?  m_DefaultSpeed : 0),
                       (this.m_DirectionHMap.get(MoveDir_ch.SOUTH) ? m_DefaultSpeed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.NORTH) ? m_DefaultSpeed : 0));
      this.m_Speed.setMag(this.m_DefaultSpeed);
      this.m_InWorldPosition.add(this.m_Speed);
      Constrain();
      } // Move()

   // This function moves the object with the specified speed.
   public void Move(final int Speed)
      {
      this.m_Speed.set((this.m_DirectionHMap.get(MoveDir_ch.EAST) ?  Speed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.WEST) ?  Speed : 0),
                       (this.m_DirectionHMap.get(MoveDir_ch.SOUTH) ? Speed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.NORTH) ? Speed : 0));
      this.m_Speed.setMag(Speed);
      this.m_InWorldPosition.add(this.m_Speed);
      Constrain();
      } // Move()

   // This function returns the move direction according to a key.
   private MoveDir_ch MoveDirFromKey(final int KeyCode)
      {
      if (KeyCode == UP || KeyCode == 'w' || KeyCode == 'W')
         return (MoveDir_ch.NORTH);
      else if (KeyCode == DOWN || KeyCode == 's' || KeyCode == 'S')
         return (MoveDir_ch.SOUTH);
      else if (KeyCode == LEFT || KeyCode == 'a' || KeyCode == 'A')
         return (MoveDir_ch.WEST);
      else if (KeyCode == RIGHT || KeyCode == 'd' || KeyCode == 'D')
         return (MoveDir_ch.EAST);
      return (MoveDir_ch.NULL);
      } // MoveDirFromKey

   // This function returns the position of the object.
   public PVector InWorldPosition()
      {
      return (this.m_InWorldPosition);
      } // PositionInWorld()

   // This function sets the value of a direction.
   public void SetDirection(final int KeyCode, final boolean Active)
      {
      MoveDir_ch MoveDir = MoveDirFromKey(KeyCode);
      this.m_DirectionHMap.replace(MoveDir, Active);
      if (!Active)
         {
         UpdateLastMoveDir(MoveDir);
         m_MotionIdxFlt = 0.0f;
         }
      } // SetDirection

   // This function updates the last move direction of the object. To be used only when the object is not moving.
   public void UpdateLastMoveDir(final MoveDir_ch LastMoveDir)
      {
      this.m_LastMoveDir = LastMoveDir;
      } // UpdateLastMoveDir()

   // This function converts the perso in world position to the screen position for the X coordinate.
   public float WorldToScreenPositionX(final PVector ScreenPosition)
      {
      return (abs(this.m_InWorldPosition.x - ScreenPosition.x));
      } // WorldToScreenPositionX()

   // This function converts the perso in world position to the screen position for the Y coordinate.
   public float WorldToScreenPositionY(final PVector ScreenPosition)
      {
      return (abs(this.m_InWorldPosition.y - ScreenPosition.y));
      } // WorldToScreenPositionY()

   } // class ObjMovableObject_p


public class ObjMainCharacter_c extends ObjMovableObject_p
   {
   
   public ObjMainCharacter_c(final float x, final float y, final MathRect_c BoundRect, final MathRect_c HitBox)
      {
      super(x, y, BoundRect, HitBox);
      } // ObjMainCharacter_c()

   public void Display(final PVector ScreenPosition, final TileSetSprites_c Sprite)
      {
      fill (255, 0, 0);
      noStroke();

      int TileIndex = int_NULL;
      boolean IsMoving = false;
      for (Map.Entry<MoveDir_ch,Boolean> Entry : super.m_DirectionHMap.entrySet())
         {
         if (Entry.getValue())
            {
            TileIndex = Sprite.GetMotionTileIdx(Entry.getKey(), PApplet.parseInt(m_MotionIdxFlt) % Sprite.MotionCount());
            IsMoving = true;
            }
         }
      if (!IsMoving)
         TileIndex = Sprite.GetMotionLessTileIdx(super.m_LastMoveDir);

      image(Sprite.GetTileByGlobalIdx(TileIndex), super.WorldToScreenPositionX(ScreenPosition), super.WorldToScreenPositionY(ScreenPosition));
      m_MotionIdxFlt += 0.15f;
      //rect(super.WorldToScreenPositionX(ScreenPosition), super.WorldToScreenPositionY(ScreenPosition), super.m_HitBox.Width(), super.m_HitBox.Height());
      } // Display()

   } // class ObjMainCharacter_c


// This component represents a generic tile set.
public abstract class TileSet_p
   {
   // The name of the json file holding the tile set information. Question: Does it contains ".json" ?
   protected String m_JsonFileName = "";
   // The tile set image.
   protected PImage m_Image = null;
   // The number of column in the tile set.
   protected int m_ColumnCount = int_NULL;
   // The index of the first tile.
   protected int m_FirstTileIdx = int_NULL;
   // The margin of the tile set. It represents the number of margin pixel on the side of the tile set.
   protected int m_Margin = int_NULL;
   // The spacing of the tile set. It represents the number of pixel between two tiles of the tile set.
   protected int m_Spacing = int_NULL;
   // The number of tile in the tile set.
   protected int m_TileCount = int_NULL;
   // The height of tiles in the tile set.
   protected int m_TileHeight = int_NULL;
   // The index of the tile set.
   protected int m_TileSetIdx = int_NULL;
   // The width of tiles in the tile set.
   protected int m_TileWidth = int_NULL;

   // This function returns the folder in which the tile set is saved.
   public abstract String GetPath();

   // Constructor
   public TileSet_p(final String JsonFileName, final int TileSetIdx, final int FirstTileIdx)
      {
      this.m_JsonFileName = JsonFileName;
      this.m_TileSetIdx = TileSetIdx;
      this.m_FirstTileIdx = FirstTileIdx;
      } // TileSet_p()

   // This function returns whether a tile is contain in the tile set given its global index.
   public boolean ContainsTile(final int GlobalTileIdx)
      {
      return (GlobalTileIdx >= this.m_FirstTileIdx && GlobalTileIdx < this.m_FirstTileIdx + this.m_TileCount);
      } // ContainsTile()

   // This function returns the tile image given a global tile index.
   public PImage GetTileByGlobalIdx(final int GlobalTileIdx)
      {
      int LocalTileIdx = this.GlobalToLocalTileIdx(GlobalTileIdx);
      int PixelX = this.m_Margin + this.GetTileColumn(LocalTileIdx) * (this.m_Spacing + this.m_TileWidth);
      int PixelY = this.m_Margin + this.GetTileRow(LocalTileIdx) * (this.m_Spacing + this.m_TileHeight);
      return (this.m_Image.get(PixelX, PixelY, this.m_TileWidth, this.m_TileHeight));
      } // GetTileByGlobalIdx()

   // This function returns the column index of the tile from its local index. Column index start at 0.
   private int GetTileColumn(final int LocalTileIdx)
      {
      return (PApplet.parseInt((LocalTileIdx - 1) % this.m_ColumnCount));
      } // GetTileColumn()

   // This function returns the row index of the tile from its local index. Row index start at 0.
   private int GetTileRow(final int LocalTileIdx)
      {
      return (PApplet.parseInt((LocalTileIdx - 1) / this.m_ColumnCount));
      } // GetTileRow()

   // This function convert a global tile index to a local tile index.
   private int GlobalToLocalTileIdx(final int GlobalTileIdx)
      {
      return (GlobalTileIdx - this.m_FirstTileIdx + 1);
      } // GlobalToLocalTileIdx()

   // This function initializes the tile set by reading the json file.
   protected void InitializeBase(final JSONObject TileSetJson)
      {
      this.m_ColumnCount = TileSetJson.getInt("columns");
      this.m_Margin = TileSetJson.getInt("margin");
      this.m_Spacing = TileSetJson.getInt("spacing");
      this.m_TileCount = TileSetJson.getInt("tilecount");
      this.m_TileHeight = TileSetJson.getInt("tileheight");
      this.m_TileWidth = TileSetJson.getInt("tilewidth");
      this.m_Image = loadImage(GetPath() + TileSetJson.getString("image"));
      } // InitializeBase()

   } // abstract class TileSet_p

// This class represents a tile set for map.
public class TileSetMap_c extends TileSet_p
   {
   
   // This array contains whether tiles are blocked and should be considered as obstacles.
   private boolean[] m_IsBlockedArray = null;

   // Constructor
   public TileSetMap_c(final String JsonFileName, final int TileSetIdx, final int FirstTileIdx)
      {
      super(JsonFileName, TileSetIdx, FirstTileIdx);
      JSONObject TileSetJson = loadJSONObject(GetPath() + this.m_JsonFileName);
      InitializeBase(TileSetJson);
      InitializeBlockedTiles(TileSetJson);
      } // TileSetMap_c()

   // This function adds a tile as a blocked tile.
   private void AddBlockedTile(final int TileIdx)
      {
      if (this.m_IsBlockedArray == null)
         {
         this.m_IsBlockedArray = new boolean[this.m_TileCount];
         for (int i = 0; i < this.m_IsBlockedArray.length; i++)
            this.m_IsBlockedArray[i] = false;
         }

      if (TileIdx >= 0 && TileIdx < this.m_IsBlockedArray.length)
         this.m_IsBlockedArray[TileIdx] = true;
      } // AddBlockedTile()

   // implement TileSet_p::GetPath()
   public String GetPath()
      {
      return (TILESET_FOLDER_MAP);
      } // GetPath()

   // This function initializes the blocked tiles array.
   private void InitializeBlockedTiles(final JSONObject TileSetJson)
      {
      if (TileSetJson.isNull("tiles"))
         return;
      
      JSONArray TilesJsonArray = TileSetJson.getJSONArray("tiles");
      for (int i = 0; i < TilesJsonArray.size(); i++)
         {
         JSONObject TileJsonObject = TilesJsonArray.getJSONObject(i);
         if (TileJsonObject.isNull("properties"))
            continue;

         JSONArray TilePropJsonArray = TileJsonObject.getJSONArray("properties");
         if (GetBoolProperty(TilePropJsonArray, "blocked", false))
            AddBlockedTile(TileJsonObject.getInt("id"));
         } // for (int i = 0; i < TilesJsonArray.size(); i++)
      } // InitializeBlockedTiles()

   // This function returns whether a tile is blocked or not.
   public boolean IsTileBlocked(final int GlobalTileIdx)
      {
      if (this.m_IsBlockedArray == null)
         return (false);

      int LocalTileIdx = GlobalTileIdx - this.m_FirstTileIdx;
      if (LocalTileIdx >= 0 && LocalTileIdx < this.m_IsBlockedArray.length)
         return (this.m_IsBlockedArray[LocalTileIdx]);
      return (false);
      } // IsTileBlocked()

   } // class TileSetMap_c

// This class represents a link between a move direction and a list of sprites.
public class SpritesForMoveDir_c
   {

   // The move direction of the sprites.
   private MoveDir_ch m_MoveDir = MoveDir_ch.NULL;
   // The list of tile index for the motion sprites.
   private int[] m_MotionTileIdxArray = null;
   // The tile index for the motion-less sprite.
   private int m_MotionLessTileIdx = int_NULL;

   //Constructor
   public SpritesForMoveDir_c(final MoveDir_ch MoveDir, final int MotionSpriteCount)
      {
      this.m_MoveDir = MoveDir;
      this.m_MotionTileIdxArray = new int[MotionSpriteCount];
      for (int i = 0; i < this.m_MotionTileIdxArray.length; i++)
         this.m_MotionTileIdxArray[i] = int_NULL;
      } // SpritesForMoveDir_c()

   // This function returns the tile index of the motion-less sprite.
   public int GetMotionLessTileIdx()
      {
      return (this.m_MotionLessTileIdx);
      } //GetMotionLessTileIdx()

   // This function reutrns the tile index for a motion sprite.
   public int GetMotionTileIdx(final int MotionIdx)
      {
      if (MotionIdx < 0 || MotionIdx >= this.m_MotionTileIdxArray.length)
         return (int_NULL);

      return (this.m_MotionTileIdxArray[MotionIdx]);
      } // GetMotionTileIdx()

   // This function sets the tile index of the motion-less sprite.
   public void SetMotionLessTileIdx(final int TileIdx)
      {
      this.m_MotionLessTileIdx = TileIdx;
      } //SetMotionLessTileIdx()

   // This function sets the tile index for a motion sprite.
   public void SetMotionTileIdx(final int MotionIdx, final int TileIdx)
      {
      if (MotionIdx < 0 || MotionIdx >= this.m_MotionTileIdxArray.length)
         return;

      this.m_MotionTileIdxArray[MotionIdx] = TileIdx;
      } // SetMotionTileIdx()

   } // class SpritesForMoveDir_c


// This class represents a tile set used for sprites.
public class TileSetSprites_c extends TileSet_p
   {

   private int m_MotionCount = 0;
   private HashMap<MoveDir_ch,SpritesForMoveDir_c> m_SpriteForMoveDirHMap;

   // Constructor
   public TileSetSprites_c(final String JsonFileName, final int TileSetIdx, final int FirstTileIdx)
      {
      super(JsonFileName, TileSetIdx, FirstTileIdx);
      JSONObject TileSetJson = loadJSONObject(GetPath() + this.m_JsonFileName);
      InitializeBase(TileSetJson);
      InitializeSpritesByMoveDir(TileSetJson);
      } // TileSetSprites_c()

   // This function returns the motion count of the sprite.
   private int GetMotionCount(final JSONObject TileSetJson)
      {
      if (TileSetJson.isNull("properties"))
         return (0);
      
      JSONArray TileSetPropArray = TileSetJson.getJSONArray("properties");
      return (GetIntProperty(TileSetPropArray, "motionCount", 0 /*DefaultValue*/));
      } // GetMotionCount()

   // This function returns the tile index of the motion-less sprite.
   public int GetMotionLessTileIdx(final MoveDir_ch MoveDir)
      {
      if (!this.m_SpriteForMoveDirHMap.containsKey(MoveDir))
         return (int_NULL);

      return (this.m_SpriteForMoveDirHMap.get(MoveDir).GetMotionLessTileIdx());
      } //GetMotionLessTileIdx()

   // This function reutrns the tile index for a motion sprite.
   public int GetMotionTileIdx(final MoveDir_ch MoveDir, final int MotionIdx)
      {
      if (!this.m_SpriteForMoveDirHMap.containsKey(MoveDir))
         return (int_NULL);

      return (this.m_SpriteForMoveDirHMap.get(MoveDir).GetMotionTileIdx(MotionIdx));
      } // GetMotionTileIdx()

   // implement TileSet_p::GetPath()
   public String GetPath()
      {
      return (TILESET_FOLDER_SPRITES);
      } // GetPath()

   // This function initializes the sprites by move direction structure.
   private void InitializeSpritesByMoveDir(final JSONObject TileSetJson)
      {
      this.m_SpriteForMoveDirHMap = new HashMap<MoveDir_ch,SpritesForMoveDir_c>()
         {
            {
            put(MoveDir_ch.NORTH, null);
            put(MoveDir_ch.SOUTH, null);
            put(MoveDir_ch.EAST, null);
            put(MoveDir_ch.WEST, null);
            }
         };
      this.m_MotionCount = GetMotionCount(TileSetJson);
      JSONArray TilesJsonArray = TileSetJson.getJSONArray("tiles");
      for (int i = 0; i < TilesJsonArray.size(); i++)
         {
         JSONObject TileJson = TilesJsonArray.getJSONObject(i);
         int TileIdx = TileJson.getInt("id");
         JSONArray TilePropJsonArray = TileJson.getJSONArray("properties");
         int MotionIdx = GetIntProperty(TilePropJsonArray, "id", int_NULL);
         MoveDir_ch MoveDirection = StringToMoveDir(GetStringProperty(TilePropJsonArray, "direction", ""));
         if (this.m_SpriteForMoveDirHMap.containsKey(MoveDirection) && MotionIdx != int_NULL)
            {
            if (this.m_SpriteForMoveDirHMap.get(MoveDirection) == null)
               this.m_SpriteForMoveDirHMap.replace(MoveDirection, new SpritesForMoveDir_c(MoveDirection, this.m_MotionCount));

            if (MotionIdx == 0)
               this.m_SpriteForMoveDirHMap.get(MoveDirection).SetMotionLessTileIdx(TileIdx);
            else
               this.m_SpriteForMoveDirHMap.get(MoveDirection).SetMotionTileIdx(MotionIdx - 1, TileIdx);
            }
         }
      } // InitializeSpritesByMoveDir()

   // This function returns the motion count.
   public int MotionCount()
      {
      return (this.m_MotionCount);
      } // MotionCount()

   // This function returns the move direction given a string direction.
   private MoveDir_ch StringToMoveDir(final String MoveDirStr)
      {
      if (MoveDirStr.equals("north"))
         return (MoveDir_ch.NORTH);
      else if (MoveDirStr.equals("south"))
         return (MoveDir_ch.SOUTH);
      else if (MoveDirStr.equals("east"))
         return (MoveDir_ch.EAST);
      else if (MoveDirStr.equals("west"))
         return (MoveDir_ch.WEST);
      else
         return (MoveDir_ch.NULL);
      } // StringToMoveDir()

   } // class TileSetSprites_c

// This class is used to handle multiple tile set.
public class TileSetMapHandler_c
   {

   // The list of tile sets.
   private ArrayList<TileSetMap_c> m_TileSetMapList = null;

   // Constructor
   public TileSetMapHandler_c()
      {
      this.m_TileSetMapList = new ArrayList<TileSetMap_c>();
      } // TileSetMapHandler_c()

   // This function adds a new tile set.
   public void AddTileSet(final String JsonFileName, final int FirstTileIdx)
      {
      int NewTileSetIdx = this.m_TileSetMapList.size();
      TileSetMap_c TileSet = new TileSetMap_c(JsonFileName, NewTileSetIdx, FirstTileIdx);
      this.m_TileSetMapList.add(TileSet);
      } // AddTileSet()

   // This function returns the tile image given a global tile index.
   public PImage GetTileByGlobalIdx(final int GlobalTileIdx)
      {
      for (int i = 0; i < this.m_TileSetMapList.size(); i++)
         {
         if (this.m_TileSetMapList.get(i).ContainsTile(GlobalTileIdx))
            return (this.m_TileSetMapList.get(i).GetTileByGlobalIdx(GlobalTileIdx));
         }
      return (null);
      } // GetTileByGlobalIdx()

   // This function returns whether the tile is blocked or not given a global tile index.
   public boolean IsTileBlocked(final int GlobalTileIdx)
      {
      for (int i = 0; i < this.m_TileSetMapList.size(); i++)
         {
         if (this.m_TileSetMapList.get(i).ContainsTile(GlobalTileIdx))
            return (this.m_TileSetMapList.get(i).IsTileBlocked(GlobalTileIdx));
         }
      return (false);
      } // IsTileBlocked()

   } // class TileSetMapHandler_c


// This class represents a tiled layer of a tiled map.
public class TmapTiledLayer_c
   {

   // The Height of the layer. Should be the same height as the map.
   private int m_Height = int_NULL;
   // The index of the layer. Deepest layer should have the smaller index.
   private int m_Index = int_NULL;
   // The width of the layer. Should be the same width as the map.
   private int m_Width = int_NULL;
   // Tile index array. The array containing the tiles global indexes. An index 0 corresponds to no tile.
   private int[] m_TileIdxArray = null;

   // Constructor
   public TmapTiledLayer_c(final JSONObject LayerJson, final int Index)
      {
      this.m_Index = Index;
      this.m_Width = LayerJson.getInt("width");
      this.m_Height = LayerJson.getInt("height");

      JSONArray LayerData = LayerJson.getJSONArray("data");
      this.m_TileIdxArray = new int[LayerData.size()];
      for (int i = 0; i < this.m_TileIdxArray.length; i++)
         this.m_TileIdxArray[i] = LayerData.getInt(i);
      } // TmapTiledLayer_c()

   // This function returns the global tile index for a set of coordinates that corresponds to a case on the map.
   // The origin of the coordinates is the upper left corner.
   public int GetGlobalTileIndex(final int XCoord, final int YCoord)
      {
      if (XCoord < 0 || XCoord >= this.m_Height || YCoord < 0 || YCoord >= this.m_Width)
         return (TMAP_DEFAULT_EMPTY_TILE_VALUE);

      int ArrayIdx = YCoord * this.m_Width + XCoord;
      if (ArrayIdx < 0 || ArrayIdx >= this.m_TileIdxArray.length)
         return (TMAP_DEFAULT_EMPTY_TILE_VALUE);

      return (this.m_TileIdxArray[ArrayIdx]);
      } // GetGlobalTileIndex()

   // This function returns the index of the tiled layer.
   public int Index()
      {
      return (this.m_Index);
      } // Index()

   // This function returns the height of the layer.
   public int Height()
      {
      return (this.m_Height);
      } // Height()

   // This function returns the width of the layer.
   public int Width()
      {
      return (this.m_Width);
      } // Width()

   } // class TmapTiledLayer_c

// This class implements the comparator function for the object TmapTiledLayer_c
private class TmapSortTiledLayer_c implements Comparator<TmapTiledLayer_c> 
   { 
   // Used for sorting in ascending order of index.
   public int compare(TmapTiledLayer_c Lhs, TmapTiledLayer_c Rhs) 
      { 
      return (Lhs.Index() - Rhs.Index()); 
      } // compare()
   } // class TmapSortTiledLayer_c

// This component represents a tiled map.
public class TmapTiledMap_c
   {

   // The position of this object is the upper left corner of the screen.
   private PVector m_ScreenPosition;
   // The height of the tiled map.
   private int m_Height = int_NULL;
   // The width of the tiled map.
   private int m_Width = int_NULL;
   // The tile set handler.
   private TileSetMapHandler_c m_TileSetHandler = null;
   // The list of tiled layer.
   private ArrayList<TmapTiledLayer_c> m_TiledLayerList = null;
   // The number of tiles on the X axis.
   private int m_TileCountX;
   // The number of tiles on the Y axis.
   private int m_TileCountY;

   // Constructor
   public TmapTiledMap_c(final String JsonFileName)
      {
      JSONObject MapJson = loadJSONObject(JsonFileName);
      this.m_Height = MapJson.getInt("height");
      this.m_Width = MapJson.getInt("width");
      InitializeTiledLayers(MapJson.getJSONArray("layers"));
      InitializeTiledSets(MapJson.getJSONArray("tilesets"));
      this.m_TileCountX = floor(width / TMAP_TILE_SIZE) + 1;
      this.m_TileCountY = floor(height / TMAP_TILE_SIZE) + 1;
      this.m_ScreenPosition = new PVector(0, 0);
      } // TmapTiledMap_c()

   // This function displays the layers from FirstLayer (included) to LastLayer (included).
   public void DisplayLayers(final int FirstLayer, final int LastLayer)
      {
      int FirstTileX = PApplet.parseInt(this.m_ScreenPosition.x / 32) - 1;
      int FirstTileY = PApplet.parseInt(this.m_ScreenPosition.y / 32) - 1;
      float OffsetX = FirstTileX * 32 - this.m_ScreenPosition.x;
      float OffsetY = FirstTileY * 32 - this.m_ScreenPosition.y;

      for (int LayerIdx = FirstLayer; LayerIdx <= LastLayer; LayerIdx++)
         {
         TmapTiledLayer_c TiledLayer = this.m_TiledLayerList.get(LayerIdx);
         for (int i = 0; i < this.m_TileCountX + 2; i++)
            {
            for (int j = 0; j < this.m_TileCountY + 2; j++)
               {
               int GlobalTileIdx = TiledLayer.GetGlobalTileIndex(i + FirstTileX, j + FirstTileY);
               if (GlobalTileIdx == TMAP_DEFAULT_EMPTY_TILE_VALUE)
                  continue;

               PImage TileImage = this.m_TileSetHandler.GetTileByGlobalIdx(GlobalTileIdx);
               image(TileImage, i * TMAP_TILE_SIZE + OffsetX, j * TMAP_TILE_SIZE + OffsetY);

               if (this.m_TileSetHandler.IsTileBlocked(GlobalTileIdx))
                  {
                  stroke(0, 0, 255);
                  noFill();
                  rect(i * TMAP_TILE_SIZE + OffsetX + 1, j * TMAP_TILE_SIZE + OffsetY + 1, TMAP_TILE_SIZE - 2, TMAP_TILE_SIZE - 2);
                  }
               }
            }
         }
      } // DisplayLayers()

   // This function initializes the tiled layers.
   private void InitializeTiledLayers(final JSONArray LayersJson)
      {
      this.m_TiledLayerList = new ArrayList<TmapTiledLayer_c>();
      for (int i = 0; i < LayersJson.size(); i++)
         {
         JSONObject LayerJson = LayersJson.getJSONObject(i);
         if (!LayerJson.isNull("objects"))
            continue;

         this.m_TiledLayerList.add(new TmapTiledLayer_c(LayerJson, i));
         }

      // Sort the tiled layer by increasing order of index.
      Collections.sort(this.m_TiledLayerList, new TmapSortTiledLayer_c());
      } // InitializeTiledLayers()

   // This function initializes the tiled sets.
   private void InitializeTiledSets(final JSONArray TileSetsJson)
      {
      this.m_TileSetHandler = new TileSetMapHandler_c();
      for (int i = 0; i < TileSetsJson.size(); i++)
         {
         JSONObject TileSetJson = TileSetsJson.getJSONObject(i);
         this.m_TileSetHandler.AddTileSet(TileSetJson.getString("source"), TileSetJson.getInt("firstgid"));
         }
      } // InitializeTiledSets()

   // This function returns the height of the map.
   public float MapHeight()
      {
      return (this.m_Height * TMAP_TILE_SIZE);
      } // MapHeight()

   // This function returns the width of the map.
   public float MapWidth()
      {
      return (this.m_Width * TMAP_TILE_SIZE);
      } // MapWidth()

   // This function returns the screen position on the map.
   public PVector ScreenPosition()
      {
      return (this.m_ScreenPosition);
      } // ScreenPosition()

   // This function updates the screen position on the map according to the main character's position.
   public void UpdateScreenPosition(final ObjMainCharacter_c Perso)
      {
      this.m_ScreenPosition.x = constrain(Perso.InWorldPosition().x - 0.5f * width, 0, MapWidth() - width);
      this.m_ScreenPosition.y = constrain(Perso.InWorldPosition().y - 0.5f * height, 0, MapHeight() - height);
      } // UpdateScreenPosition()

   } // class TmapTiledMap_c


// This class implements a pair of values that can be of different types.
class UtilPair_c<X,Y>
   {

   private X m_First;
   private Y m_Second;

   // Constructor
   public UtilPair_c(final X First, final Y Second)
      {
      this.m_First = First;
      this.m_Second = Second;
      } // UtilPair_c()

   // This function overrides the equals function.
   // param: Rhs - an other object to test the equality.
   @Override
   public boolean equals(Object Rhs)
      {
      if (Rhs == null)
         return (false);
      if (Rhs == this)
         return (true);
      if (this.getClass() != Rhs.getClass())
         return (false);

      UtilPair_c RhsPair = (UtilPair_c)Rhs;
      return (this.m_First.equals(RhsPair.First()) && this.m_Second.equals(RhsPair.Second()));
      } // equals()

   // This function returns the first value of the pair.
   public X First()
      {
      return (this.m_First);
      } // First()

   // This function returns a hash for the current object.
   @Override
   public int hashCode()
      {
      return (Objects.hash(this.m_First, this.m_Second));
      } // hashCode()

   // This function returns the second value of the pair.
   public Y Second()
      {
      return (this.m_Second);
      } // Second()

   } // class UtilPair_c<X,Y>



public static boolean GetBoolProperty(final JSONArray PropJsonArray, final String PropertyName, final boolean DefaultValue)
   {
   for (int i = 0; i < PropJsonArray.size(); i++)
      {
      JSONObject PropJson = PropJsonArray.getJSONObject(i);
      if (PropJson.getString("name").equals(PropertyName) && PropJson.getString("type").equals("bool"))
         return (PropJson.getBoolean("value"));
      }
   return (DefaultValue);
   } // GetBoolProperty()

public static int GetIntProperty(final JSONArray PropJsonArray, final String PropertyName, final int DefaultValue)
   {
   for (int i = 0; i < PropJsonArray.size(); i++)
      {
      JSONObject PropJson = PropJsonArray.getJSONObject(i);
      if (PropJson.getString("name").equals(PropertyName) && PropJson.getString("type").equals("int"))
         return (PropJson.getInt("value"));
      }
   return (DefaultValue);
   } // GetIntProperty()

public static String GetStringProperty(final JSONArray PropJsonArray, final String PropertyName, final String DefaultValue)
   {
   for (int i = 0; i < PropJsonArray.size(); i++)
      {
      JSONObject PropJson = PropJsonArray.getJSONObject(i);
      if (PropJson.getString("name").equals(PropertyName) && PropJson.getString("type").equals("string"))
         return (PropJson.getString("value"));
      }
   return (DefaultValue);
   } // GetStringProperty()
static int int_MAX = 2147483647;
static int int_MIN = -2147483647;
static int int_NULL = -2147483648;

static ArrayList<Integer> s_PersoKeyCodeList = new ArrayList(Arrays.asList(UP, DOWN, LEFT, RIGHT, Integer.valueOf('W'), Integer.valueOf('A'), Integer.valueOf('S'), Integer.valueOf('D')));

// TILESET
public String TILESET_FOLDER_MAP = "TileSets/Maps/";
public String TILESET_FOLDER_SPRITES = "TileSets/Sprites/";

// TMAP
public int TMAP_TILE_SIZE = 32;
public int TMAP_DEFAULT_EMPTY_TILE_VALUE = 0;

// GUI
public String GUI_FOLDER = "Gui/";
public int GUI_MOUSE_OVER_BUTTON_ALPHA = 210;
  public void settings() {  size(1200, 900);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
