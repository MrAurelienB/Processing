import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Map; 
import java.util.Stack; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Game extends PApplet {

MapGenerator_c MapGenerator;
Map_c Map;
RoomManager_c RoomManager;

MenuHandler_c MenuHandler;

public void setup()
{
  
  
  colorMode(RGB, 255, 255, 255, 255);
  rectMode(CORNER);
  
  ShowBackground();
  
  MenuHandler = new MenuHandler_c();
  
  MapGenerator = new MapGenerator_c();
  Map = MapGenerator.GenerateMap(128,72);
  RoomManager = new RoomManager_c(Map);

} // setup()


int i = 0, j = 0;

public void draw()
{
  TestMenu();
}



public void TestMenu()
{
  ShowBackground();
  MenuHandler.CheckAndShow();
}


public void TestMap()
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


public void ShowBackground()
{
  background(255);
  fill(0 , 0, 255, 50);
  rect(-10, -10, width + 10, height + 10);
}
/******************************************************
This class represents a canvas to display in a menu.
A canvas can contains multiple displayable objects and
is linked to a menu.
*******************************************************/
class Canvas_c extends Rect_c
{
  
  ArrayList<Rect_c> m_ObjectsToDisplayList = new ArrayList<Rect_c>();
  
  Canvas_c()
    {
    super();
    } // Canvas_c()

  public void AddObject(Rect_c Obj)
    {
    this.m_ObjectsToDisplayList.add(Obj);
    } // AddObject()

  public void Check()
    {
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      {
      if (Obj instanceof NavigationButton_c)
        ((NavigationButton_c) Obj).Check();
      }
    } // Check()

  public void Enable()
    {
    super.Enable();
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      Obj.Enable();
    } // Enable()
    
  public void Disable()
    {
    super.Disable();
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      Obj.Disable();
    } // Disable()

  public void Show()
    {
    super.Show();
    
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      Obj.Show();
    } // Show()

} // class Canvas_c
/******************************************************
This class represents a displayable rectangle.
*******************************************************/
class Rect_c
{

  protected String m_Identifer = "";
  
  protected boolean m_IsEnabled = true;
  
  private float m_Width = 200;
  private float m_Height = 50;
  private float m_XCoord = 0;
  private float m_YCoord = 0;
  private float m_Curve = 0;
  private float m_StrokeWeight = 1;
  
  private int m_CurrentFillColor = color(255);
  private int m_CurrentStrokeColor = color(0);
  
  Rect_c()
    {

    } // Rect_c()
    
  public void Enable()
    {
    this.m_IsEnabled = true;
    } // Enable()
    
  public void Disable()
    {
    this.m_IsEnabled = false;
    } // Disable()
    
  public float Height()
    {
    return (this.m_Height);
    } // Height()
    
  public boolean IsEnabled()
    {
    return (this.m_IsEnabled);
    } // IsEnabled()
    
  public boolean IsMouseOver()
    {
    return (mouseX > this.m_XCoord &&
            mouseX < this.m_XCoord + this.m_Width &&
            mouseY > this.m_YCoord &&
            mouseY < this.m_YCoord + this.m_Height);
    } // IsMouseOver

  public void SetCoord(final float XCoord,
                       final float YCoord)
    {
    this.m_XCoord = XCoord;
    this.m_YCoord = YCoord;
    } // SetCoord()
  
  public void SetCurrentFillColor(final int FillColor)
    {
    this.m_CurrentFillColor = FillColor;
    } // SetCurrentFillColor()
  
  public void SetCurrentStrokeColor(final int StrokeColor)
    {
    this.m_CurrentStrokeColor = StrokeColor;
    } // SetCurrentStrokeColor()
  
  public void SetCurve(final float Curve)
    {
    this.m_Curve = Curve;
    } // SetCurve()
  
  public void SetId(final String Identifier)
    {
    this.m_Identifer = Identifier;
    } // SetId()
  
  public void SetSize(final float Width,
                      final float Height)
    {
    this.m_Width = Width;
    this.m_Height = Height;
    } // SetSize()
    
  public void SetStrokeWeight(final float StrokeWeight)
    {
    this.m_StrokeWeight = StrokeWeight;
    } // SetStrokeWeight()

  public void Show()
    { 
    stroke(this.m_CurrentStrokeColor);
    strokeWeight(this.m_StrokeWeight);
    fill(this.m_CurrentFillColor);
    rect(this.m_XCoord, this.m_YCoord, this.m_Width, this.m_Height, this.m_Curve);
    } // Show()
    
  public float Width()
    {
    return (this.m_Width);
    } // Width()
    
  public float X()
    {
    return (this.m_XCoord);
    } // X()

  public float Y()
    {
    return (this.m_YCoord);
    } // Y()

} // class Rect_c

/*********************************************************************************************************************************************************************/

/******************************************************
This class represents a rectangle with text.
*******************************************************/
class TextObject_c extends Rect_c
{

  private float m_TextSize = 32; 
  private int m_CurrentTextColor = color(0);
  private String m_Text = "Default";
  
  TextObject_c()
    {
    super();
    } // TextObject_c()

  public void SetText(final String Text)
    {
    this.m_Text = Text;
    } // SetText()

  public void SetCurrentTextColor(final int TextColor)
    {
    this.m_CurrentTextColor = TextColor;
    } // SetCurrentTextColor()

  public void SetTextSize(final float TextSize)
    {
    this.m_TextSize = TextSize;
    } // SetTextSize()

  public void Show()
    { 
    super.Show();
    
    fill(this.m_CurrentTextColor);
    textSize(this.m_TextSize);
    textAlign(CENTER, CENTER);
    text(this.m_Text, super.m_XCoord, super.m_YCoord, super.m_Width, super.m_Height);
    } // Show()

} // class TextObject_c

/*********************************************************************************************************************************************************************/

/******************************************************
This class represents a generic button.
*******************************************************/
class Button_c extends TextObject_c
{

  private int m_DefaultFillColor = color(255);
  private int m_DefaultStrokeColor = color(0);
  private int m_DefaultTextColor = color(0);
  private int m_HoverFillColor = color(200);
  private int m_HoverStrokeColor = color(255, 0, 0);
  private int m_HoverTextColor = color(0, 255, 0);
  
  Button_c()
    {
    super();
    } // Button_c()
  
  @Override
  public void Show()
    {
    if (!super.m_IsEnabled)
      return;
      
    boolean IsOver = super.IsMouseOver();
    super.SetCurrentFillColor(IsOver ? this.m_HoverFillColor : this.m_DefaultFillColor);
    super.SetCurrentStrokeColor(IsOver ? this.m_HoverStrokeColor : this.m_DefaultStrokeColor);
    super.SetCurrentTextColor(IsOver ? this.m_HoverTextColor : this.m_DefaultTextColor);
    super.Show();
    } // Show()

  public void SetDefaultColor(final int FillColor,
                              final int StrokeColor,
                              final int TextColor)
    {
    this.m_DefaultFillColor = FillColor;
    this.m_DefaultStrokeColor = StrokeColor;
    this.m_DefaultTextColor = TextColor;
    } // SetDefaultColor()
    
  public void SetHoverColor(final int FillColor,
                            final int StrokeColor,
                            final int TextColor)
    {
    this.m_HoverFillColor = FillColor;
    this.m_HoverStrokeColor = StrokeColor;
    this.m_HoverTextColor = TextColor;
    } // SetHoverColor()

} // class Button_c

/*********************************************************************************************************************************************************************/

/******************************************************
This class represents a button to navigate through
canvas in a menu.
*******************************************************/
class NavigationButton_c extends Button_c
{

  Canvas_c CanvasToEnableOnClick = null;
  Canvas_c CanvasToDisableOnClick = null;
  
  NavigationButton_c()
    {
    super();
    } // NavigationButton_c()

  public void SetCanvasToEnableOnClick(Canvas_c Canvas)
    {
    this.CanvasToEnableOnClick = Canvas;
    } // SetCanvasToEnableOnClick()

  public void SetCanvasToDisableOnClick(Canvas_c Canvas)
    {
    this.CanvasToDisableOnClick = Canvas;
    } // SetCanvasToDisableOnClick()

  public void Check()
    {
    if (super.IsMouseOver() && mousePressed)
      {
      println("Button Clicked : " + this.m_Identifer);
      if (this.CanvasToEnableOnClick != null)
        this.CanvasToEnableOnClick.Enable();
      if (this.CanvasToDisableOnClick != null)
        this.CanvasToDisableOnClick.Disable();
      }
    } // Check()

} // class NavigationButton_c


/*************************************
This class represents a cell of a map.
**************************************/
class Cell_c
{
  private int m_XCoord = int_NULL; // The X coordinate of the cell.
  private int m_YCoord = int_NULL; // The Y coordinate of the cell.
  
  private boolean m_IsVisited  = false; // Whether the cell has been visited or not.
  private Map<WallSide_ch,Boolean> m_Walls = new HashMap<WallSide_ch,Boolean>() { // This array contains whether each wall exists or not.
    {
      put(WallSide_ch.BOTTOM, true);
      put(WallSide_ch.TOP, true);
      put(WallSide_ch.LEFT, true);
      put(WallSide_ch.RIGHT, true);
    }
  };
  
  Cell_c(final int XCoord,
         final int YCoord)
    {
    this.m_XCoord = XCoord;
    this.m_YCoord = YCoord;
    } // Cell_c()
    
  /*
   * This function returns whether the cell has been visited or not.
   */
  public boolean IsVisited()
    {
    return (this.m_IsVisited);
    } // IsVisited()
    
  /*
  This function returns whether the specified wall exists or not.
  */
  public boolean IsWall(final WallSide_ch WallSide)
    {
    return (this.m_Walls.get(WallSide));
    } // IsWall()

  /*
   * This function removes a wall of the cell.
   */
  public void RemoveWall(final WallSide_ch WallSide)
    {
    this.m_Walls.replace(WallSide, false);
    } // RemoveWall()
    
  /*
   * This function sets whether the cell has been visited or not.
   */
  public void SetIsVisited(final boolean IsVisited)
    {
    this.m_IsVisited = IsVisited;
    } // SetIsVisited()

  /*
   * This function returns the X coordinate of the cell.
   */
  public int XCoord()
    {
    return (this.m_XCoord);
    } // XCoord()

  /*
   * This function returns the Y coordinates of the cell.
   */
  public int YCoord()
    {
    return (this.m_YCoord);
    } // YCoord()
    
  /*
  This function prints a cell.
  */
  public void Print()
    {
    if (this.m_Walls.get(WallSide_ch.BOTTOM))
      plotLine(this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize,
               this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize);
    if (this.m_Walls.get(WallSide_ch.TOP))
      plotLine(this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize,
               this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize);
    if (this.m_Walls.get(WallSide_ch.LEFT))
      plotLine(this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize,
               this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize);
    if (this.m_Walls.get(WallSide_ch.RIGHT))
      plotLine(this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize,
               this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize);
    } // Print()
    
} // class Cell_c

/*********************************************************************************************************************************************************************/

/***********************************************
This class represents a map.
A map is a grid of cells that represents a maze.
************************************************/
class Map_c
{
  private int m_Width = 1; // The width of the map.
  private int m_Height = 1; // The height of the map.
  
  // (0,2) (1,2) (2,2)
  // (0,1) (1,1) (2,1)
  // (0,0) (1,0) (2,0)
  private Cell_c[][] m_Grid; // The gris of cells.
  
  Map_c(final int Width,
        final int Height)
    {
    this.m_Width = Width;
    this.m_Height = Height;
    this.m_Grid = new Cell_c[Width][Height];
    for (int i = 0; i < this.m_Grid.length; i++)
      {
      for (int j = 0; j < this.m_Grid[i].length; j++)
        {
        this.m_Grid[i][j] = new Cell_c(i,j);
        }
      }
    } // Map_c()

  /*
   * This function returns the cell at the specified coordinates.
   */
  public Cell_c GetCell(final int XCoord,
                        final int YCoord)
    {
    if (IsCoordValid(XCoord, YCoord))
      return (this.m_Grid[XCoord][YCoord]);
      
    println("Cell_c::GetCell(" + XCoord + "," + YCoord + ") is null.");
    return (null);
    } // GetCell()

  /*
   * This function returns a list containing the unvisited neighbors of the cell at coordinates (XCoord,YCoord).
   */
  public ArrayList<Cell_c> GetUnvisitedNeighbors(final int XCoord,
                                                 final int YCoord)
    {
    ArrayList<Cell_c> NeighborList = new ArrayList<Cell_c>();
    if (XCoord > 0)
      {
      Cell_c LeftCell = this.m_Grid[XCoord - 1][YCoord];
      if (!LeftCell.IsVisited())
        NeighborList.add(LeftCell);
      }
    if (YCoord > 0)
      {
      Cell_c BottomCell = this.m_Grid[XCoord][YCoord-1];
      if (!BottomCell.IsVisited())
        NeighborList.add(BottomCell);
      }
    if (XCoord < this.m_Width - 1)
      {
      Cell_c RigthCell = this.m_Grid[XCoord + 1][YCoord];
      if (!RigthCell.IsVisited())
        NeighborList.add(RigthCell);
      }
    if (YCoord < this.m_Height - 1)
      {
      Cell_c TopCell = this.m_Grid[XCoord][YCoord + 1];
      if (!TopCell.IsVisited())
        NeighborList.add(TopCell);
      }
    return (NeighborList);
    } // GetUnvisitedNeighbors()

  /*
  This function returns the height of the map.
  */
  public int Height()
    {
    return (this.m_Height);
    } // Height()

  /*
   * This function returns whether the coordinates (XCoord,YCoord) is valid for the grid.
   */
  private boolean IsCoordValid(final int XCoord,
                               final int YCoord)
    {
    return (XCoord >= 0 && XCoord < this.m_Width && YCoord >= 0 && YCoord < this.m_Height);
    } // IsCoordValid()
    
  /*
   * This function remove the wall between two cells.
   */
  public void RemoveWall(Cell_c FirstCell,
                         Cell_c SecondCell)
    {
    if (FirstCell.XCoord() == SecondCell.XCoord() - 1)
      {
      FirstCell.RemoveWall(WallSide_ch.RIGHT);
      SecondCell.RemoveWall(WallSide_ch.LEFT);
      }
    else if (FirstCell.XCoord() == SecondCell.XCoord() + 1)
      {
      FirstCell.RemoveWall(WallSide_ch.LEFT);
      SecondCell.RemoveWall(WallSide_ch.RIGHT);
      }
    else if (FirstCell.YCoord() == SecondCell.YCoord() - 1)
      {
      FirstCell.RemoveWall(WallSide_ch.TOP);
      SecondCell.RemoveWall(WallSide_ch.BOTTOM);
      }
    else if (FirstCell.YCoord() == SecondCell.YCoord() + 1)
      {
      FirstCell.RemoveWall(WallSide_ch.BOTTOM);
      SecondCell.RemoveWall(WallSide_ch.TOP);
      }
    } // RemoveWall()

  /*
  This function prints a map.
  */
  public void Print()
    {
    for (int i = 0; i < this.m_Width; i++)
      {
      for (int j = 0; j < this.m_Height; j++)
        {
        this.m_Grid[i][j].Print();
        }
      }
    } // Print()
    
  /*
  This function returns the width of the map.
  */
  public int Width()
    {
    return (this.m_Width);
    } // Width()

} // class Map_c


/*
This class is used to generate a map.
*/
class MapGenerator_c
{
  
  MapGenerator_c()
    {
      
    } // MapGenerator_c()

  /*
  This function generates a maze using the backtracker algorithm.
  */
  public Map_c GenerateMap(final int Width, final int Height)
    {
    Map_c Map = new Map_c(Width, Height);
    
    Cell_c CurrentCell = Map.GetCell(0,0);
    CurrentCell.SetIsVisited(true);
    int UnvisitedCellCount = Width * Height - 1;
    Stack<Cell_c> CellStack = new Stack<Cell_c>();
    while (UnvisitedCellCount > 0)
      {
      ArrayList<Cell_c> UnvisitedNeighborCellList = Map.GetUnvisitedNeighbors(CurrentCell.XCoord(), CurrentCell.YCoord());
      if (UnvisitedNeighborCellList.size() > 0)
        {
        Cell_c NextCell = UnvisitedNeighborCellList.get(PApplet.parseInt(random(UnvisitedNeighborCellList.size())));
        CellStack.push(CurrentCell);
        Map.RemoveWall(CurrentCell, NextCell);
        CurrentCell = NextCell;
        NextCell.SetIsVisited(true);
        UnvisitedCellCount--;
        }
      else if (!CellStack.empty())
        CurrentCell = CellStack.pop();
      }
    return (Map);
    } // GenerateMap()

} // class MapGenerator_c
/******************************************************
This class represents a generic menu.
*******************************************************/
class Menu_c
{

  private ArrayList<Canvas_c> m_CanvasList;
  
  Menu_c()
    {
    this.m_CanvasList = new ArrayList<Canvas_c>();
    } // Menu_c()

  public void AddCanvas(final Canvas_c Canvas)
    {
    this.m_CanvasList.add(Canvas);
    } // AddCanvas()
    
  public void CheckAndShow() // TEMPORARY
    {
    for (Canvas_c Canvas : this.m_CanvasList)
      {
      if (Canvas.IsEnabled())
        {
        Canvas.Check();
        Canvas.Show();
        }
      }
    }

} // class Menu_c
/******************************************************
This class represents a menu generator that generates
menu from a json file.
*******************************************************/
class MenuHandler_c
{

  private ArrayList<Menu_c> MenuList;
  
  private Menu_c m_StartMenu = null;
  
  MenuHandler_c()
    {
    this.MenuList = new ArrayList<Menu_c>();
    } // MenuHandler_c()

  public void CheckAndShow() // TEMPORARY
    {
    for (Menu_c Menu : this.MenuList)
      Menu.CheckAndShow();
    }

} // class MenuHandler_c
class Pair_c
{

  private float m_First, m_Second;
  
  Pair_c(float x, float y)
    {
    this.m_First = x;
    this.m_Second = y;
    } // Pair_c()
    
  public float First()
    {
    return (this.m_First);
    } // X()
    
  public float Second()
    {
    return (this.m_Second);
    } // Y()

} // class Pair_c
/*/****************************************************
This class represents a room linked to a cell of a map.
*******************************************************/
class Room_c
{

  private Cell_c m_Cell = null;
  
  Room_c(Cell_c Cell)
    {
    this.m_Cell = Cell;
    } // Room_c()

  /*
  This function prints a room at specified coordinates.
  */
  public void Print()
    {
    fill(0);
    if (this.m_Cell.IsWall(WallSide_ch.TOP))
      rect(0.5f * width, 0, 0.5f * width, 50);
    if (this.m_Cell.IsWall(WallSide_ch.BOTTOM))
      rect(0.5f * width, 0.5f * height - 50, 0.5f * width, 50);
    if (this.m_Cell.IsWall(WallSide_ch.LEFT))
      rect(0.5f * width, 0, 50, 0.5f * height);
    if (this.m_Cell.IsWall(WallSide_ch.RIGHT))
      rect(width - 50, 0, 50, 0.5f * height);
    } // Print()

} // class Room_c
/*******************************************
This class is used to manage rooms of a map.
/*******************************************/
class RoomManager_c
{

  private Map_c m_Map = null;
  private Room_c[][] m_Rooms = null;
  
  RoomManager_c(Map_c Map)
    {
    this.m_Map = Map;
    this.m_Rooms = new Room_c[Map.Width()][Map.Height()];
    for (int i = 0; i < Map.Width(); i++)
      {
      for (int j = 0; j < Map.Height(); j++)
        this.m_Rooms[i][j] = new Room_c(Map.GetCell(i, j));
      }
    } // RoomManager_c()

  /*
  This function prints a room at specified coordinates.
  */
  public void PrintRoom(int i, int j)
    {
    this.m_Rooms[i][j].Print();
    } // PrintRoom()

} // class RoomManager_c

static int int_MAX = 2147483647;
static int int_MIN = -2147483647;
static int int_NULL = -2147483648;

static float test_CellSize = 5;
public enum WallSide_ch
  {
  BOTTOM,
  LEFT,
  RIGHT,
  TOP
  } // enum WallSide_ch


public float XConvertIntervalToCanvas(float x)
{
return (x);
}

public float YConvertIntervalToCanvas(float y)
{
return (height - y);
}


public void plotLine(float x1, float y1, float x2, float y2)
{
line(XConvertIntervalToCanvas(x1),
     YConvertIntervalToCanvas(y1),
     XConvertIntervalToCanvas(x2),
     YConvertIntervalToCanvas(y2));
}
  public void settings() {  size(1280,720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
