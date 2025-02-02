import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Objects; 
import java.util.HashMap; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Game extends PApplet {


///////////////////////////////////// Set up the environment //////////////////////////////////////
EventHandler_c EventHandler = new EventHandler_c();
GameEngine_c GameEngine = new GameEngine_c(EventHandler);
UsrEventHandler_c UsrEventHandler = new UsrEventHandler_c();

public void settings()
   {
   size(SCREEN_W, SCREEN_H);
   }

public void setup()
   {
   EventHandler.OnInitializeStart();
   Initialize();
   EventHandler.OnInitializeEnd();
   }

public void Initialize()
   {
   background(255);
   smooth();
   rectMode(CORNER);
   GameEngine.Initialize();
   }

public void exit()
   {
   EventHandler.OnExit();
   super.exit();
   }

///////////////////////////////////////// Drawing loop ////////////////////////////////////////////
int It = 0;
public void draw()
   {
   background(255);
   noStroke();
   GameEngine.DisplayMap();
   if (It == 50)
      {
      println(frameRate);
      It = 0;
      }
   It++;
   }

///////////////////////////////// Processing User event functions /////////////////////////////////
public void keyPressed()
   { UsrEventHandler.KeyPressed(); }
 
public void keyReleased()
   { UsrEventHandler.KeyReleased(); }

public void mousePressed()
   { UsrEventHandler.MousePressed(); }
/*************************************************************************************************/
// class:
//   CoordSystem_c
/*************************************************************************************************/

/*************************************************************************************************/
// class CoordSystem_c
public class CoordSystem_c
   {
   // We define two sets of coordinates:
   //   - The coordinates of the map in-game
   //   - The coordinates on the screen

   // In-game map coordinates.
   //   - The world map defines the coordinates to use.
   final private ShpRect_c m_WorldShape = new ShpRect_c(0, 0, WRLD_WORLD_MAP_W, WRLD_WORLD_MAP_H);
   //   - The area of the map that we want to display. Its position is relative to the world map.
   //   --> It moves on the world map.
   private ShpRect_c m_DisplayedWorldShape = new ShpRect_c(0, 0, WRLD_DISPLAYED_MAP_W, WRLD_DISPLAYED_MAP_H);

   // On-screen coordinates.
   //   - The screen coordinates.
   final private ShpRect_c m_ScreenShape = new ShpRect_c(0, 0, (float)SCREEN_W, (float)SCREEN_H);
   //   - The coordnates of the displayed world shape on the screen.
   final private ShpRect_c m_DisplayedWorldOnScreenShape = new ShpRect_c(WRLD_DISPLAYED_MAP_X, WRLD_DISPLAYED_MAP_Y, WRLD_DISPLAYED_MAP_W, WRLD_DISPLAYED_MAP_H);

   CoordSystem_c()
      {}

   // We want to be able to convert a coordinates from the world to the screen.
   // --> It means to do the conversion between m_WorldShape to m_DisplayedWorldOnScreenShape.
   public float WorldToScreen_X(final float x_world)
      { return x_world - this.m_DisplayedWorldShape.X() + this.m_DisplayedWorldOnScreenShape.X(); }
   
   public float WorldToScreen_Y(final float y_world)
      { return y_world - this.m_DisplayedWorldShape.Y() + this.m_DisplayedWorldOnScreenShape.Y(); }

   // We want to be able to convert a coordinates from the screen to the world.
   // --> It means to do the conversion between m_ScreenShape and m_WorldShape.
   public float ScreenToWorld_X(final float x_screen)
      { return x_screen + this.m_DisplayedWorldShape.X() - this.m_DisplayedWorldOnScreenShape.X(); }
   
   public float ScreenToWorld_Y(final float y_screen)
      { return y_screen + this.m_DisplayedWorldShape.Y() - this.m_DisplayedWorldOnScreenShape.Y(); }

   } // public class CoordSystem_c
/*************************************************************************************************/
// Classes:
//   EventHandler_c
/*************************************************************************************************/

/*************************************************************************************************/
// class EventHandler_c
public class EventHandler_c
   {
   private PrintWriter m_LogFile = null;
   private int IndentSize = 0;

   EventHandler_c()
      {
      this.m_LogFile = createWriter("C:/Users/aurel/Documents/Processing/Projects/Game/log.txt"); // TODO
      }

   public void LogMessage(final String Message)
      {
      if (!DEBUG)
         return;
      for (int i = 0; i < IndentSize; i++)
         this.m_LogFile.print(" ");
      this.m_LogFile.println(Message);
      this.m_LogFile.flush();
      }

   public void OnExit()
      {
      LogMessage("Exit");
      this.m_LogFile.close();
      }

   public void OnCreatedTileSetImage(final String TileSetFileName)
      { LogMessage("Created tile set image: " + TileSetFileName); }

   public void OnCreatedTileMap(final String MapFileName)
      { LogMessage("Created tile map: " + MapFileName); }

   public void OnInitializeStart()
      {
      LogMessage("Initialize");
      IndentSize += 3;
      LogMessage("Screen size " + width + " x " + height);
      }

   public void OnInitializeEnd()
      {
      IndentSize -= 3;
      LogMessage("Done");
      }

   public void OnInitializeEngineStart()
      {
      LogMessage("Initialize engine");
      IndentSize += 3;
      }

   public void OnInitializeEngineEnd()
      {
      IndentSize -= 3;
      LogMessage("Done");
      }

   } // public class EventHandler_c

/*************************************************************************************************/
// class:
//   GameEngine_c
/*************************************************************************************************/

/*************************************************************************************************/
// class GameEngine_c
public class GameEngine_c
   {
   EventHandler_c m_EventHandler = null;

   CoordSystem_c m_CoordSystem = null;
   PhysCollisionEvaluator_c m_CollisionEvaluator = null;

   TileMapHandler_c m_TileMapHandler = null;
   TileSetImageHandler_c m_TileSetImageHandler = null;

   private String m_CurrentMap = "";

   GameEngine_c(EventHandler_c EventHandler)
      {
      this.m_EventHandler = EventHandler;
      this.m_CoordSystem = new CoordSystem_c();
      this.m_CollisionEvaluator = new PhysCollisionEvaluator_c();
      this.m_TileSetImageHandler = new TileSetImageHandler_c(EventHandler);
      this.m_TileMapHandler = new TileMapHandler_c(this.m_TileSetImageHandler, EventHandler);
      }

   public void Initialize()
      {
      this.m_EventHandler.OnInitializeEngineStart();
      this.m_CurrentMap = "mainMap.json";
      m_TileMapHandler.GetOrCreateMap(this.m_CurrentMap);
      this.m_EventHandler.OnInitializeEngineEnd();
      }

   public void DisplayMap()
      {
      TileMap_c TileMap = m_TileMapHandler.GetOrCreateMap("mainMap.json");
      if (TileMap == null)
         return;
      TileMap.Display(this.m_CoordSystem);
      }

   } // public class GameEngine_c
/*************************************************************************************************/
// Classes:
//   IntPair_c
//   Matrix_p
//   FullMatrix_c
//   CSRMatrix_c
/*************************************************************************************************/



/*************************************************************************************************/
// class IntPair_c
class IntPair_c
   {
   private int m_First;
   private int m_Second;

   public IntPair_c()
      { this(0,0); }

   public IntPair_c(final int First, final int Second)
      {
      this.m_First = First;
      this.m_Second = Second;
      }

   public boolean equals(IntPair_c Rhs)
      {
      if (Rhs == null)
         return (false);
      if (Rhs == this)
         return (true);
      return this.m_First == Rhs.First() && this.m_Second == Rhs.Second();
      } // equals()

   public int First()
      { return this.m_First; }

   @Override public int hashCode()
      { return Objects.hash(this.m_First, this.m_Second); }

   public int Second()
      { return this.m_Second; }

   public void SetFirst(final int Val)
      { this.m_First = Val; }

   public void SetSecond(final int Val)
      { this.m_Second = Val; }

   } // class IntPair_c

/*************************************************************************************************/
// class Matrix_p
abstract public class Matrix_p
   {
   private int m_Height = int_NULL;
   private int m_Width = int_NULL;

   Matrix_p(final int Width, final int Height)
      {
      this.m_Height = Height;
      this.m_Width = Width;
      }

   public abstract IntPair_c Get(final int i, final int j);
   public abstract void Set(final int i, final int j, final IntPair_c Value);
   public abstract void SetFirst(final int i, final int j, final int Value);
   public abstract void SetSecond(final int i, final int j, final int Value);

   } // public class Matrix_p


/*************************************************************************************************/
// class FullMatrix_c
public class FullMatrix_c extends Matrix_p
   {
   private IntPair_c[][] m_Values = null;

   FullMatrix_c(final int Width, final int Height)
      {
      super(Width, Height);
      this.m_Values = new IntPair_c[Height][Width];
      for (int i = 0; i < Height; i++)
         {
         for (int j = 0; j < Width; j++)
            this.m_Values[i][j] = new IntPair_c();
         }
      }

   public IntPair_c Get(final int i, final int j)
      { return this.m_Values[i][j]; }

   public void Set(final int i, final int j, final IntPair_c Value)
      { this.m_Values[i][j] = Value; }

   public void SetFirst(final int i, final int j, final int Value)
      { this.m_Values[i][j].SetFirst(Value); }

   public void SetSecond(final int i, final int j, final int Value)
      { this.m_Values[i][j].SetSecond(Value); }

   } // public class FullMatrix_c

/*************************************************************************************************/
// class CSRMatrix_c
/*
public class CSRMatrix_c extends Matrix_p
   {

   private IntPair_c[][] m_Values = null;
   private IntPair_c[][] m_ColIdx = null;
   private IntPair_c[][] m_RowIdx = null;

   CSRMatrix_c(final int Width, final int Height, int ValCount)
      {
      super(Width, Height);
      }

   } // public class CSRMatrix_c
*/
/*************************************************************************************************/
// Classes:
//   PhysCollisionEvaluator_c
/*************************************************************************************************/

/*************************************************************************************************/
// class PhysCollisionEvaluator_c
public class PhysCollisionEvaluator_c
   {

   PhysCollisionEvaluator_c()
      {}

   public boolean CheckCollision(final ShpCircle_c c1, final ShpCircle_c c2)
      { return dist(c1.X(), c1.Y(), c2.X(), c2.Y()) <= c1.R() + c2.R(); }

   public boolean CheckCollision(final ShpRect_c r1, final ShpRect_c r2)
      {
      if (r2.X() > r1.X() + r1.W())
         return false;
      if (r2.X() + r2.W() < r1.X())
         return false;
      if (r2.Y() > r1.Y() + r1.H())
         return false;
      if (r2.Y() + r2.H() < r1.Y())
         return false;
      return true;
      }

   public boolean CheckCollision(final ShpCircle_c c, final ShpRect_c r)
      {
      float d1 = dist(c.X(), c.Y(), r.X(), r.Y());
      float d2 = dist(c.X(), c.Y(), r.X() + r.W(), r.Y());
      float d3 = dist(c.X(), c.Y(), r.X(), r.Y() + r.H());
      float d4 = dist(c.X(), c.Y(), r.X() + r.W(), r.Y() + r.H());
      float d = min(d1, min(d2, min(d3, d4)));
      return d <= c.R();
      }

   } // public class PhysCollisionEvaluator_c
/*************************************************************************************************/
// component:
//    ShpShape_p
//
// class:
//   ShpCircle_c
//   ShpRect_c
/*************************************************************************************************/


/*************************************************************************************************/
// component ShpShape_p
public abstract class ShpShape_p
   {
   protected float m_X, m_Y;

   ShpShape_p(float XCoord, float YCoord)
      {
      this.m_X = XCoord;
      this.m_Y = YCoord;
      }

   public abstract void DisplayBorders();
   public abstract float H(); // Height
   public abstract float W(); // Width
   
   public void SetX(final float x)
      { this.m_X = x; }

   public void SetY(final float y)
      { this.m_Y = y; }

   public float X()
      { return this.m_X; }

   public float Y()
      { return this.m_Y; }

   } // public abstract class ShpShape_p

/*************************************************************************************************/
// class ShpCircle_c
// The (x,y) coordinates of a circle is its center.
public class ShpCircle_c extends ShpShape_p
   {
   private float m_R;

   ShpCircle_c(float XCoord, float YCoord, float Radius)
      {
      super(XCoord, YCoord);
      this.m_R = Radius;
      }

   public void DisplayBorders()
      { circle(X(), Y(), R()); }

   public float H()
      { return 2 * this.m_R; }

   public float R()
      { return this.m_R; }

   public float W()
      { return 2 * this.m_R; }

   } // public class ShpCircle_c

/*************************************************************************************************/
// class ShpRect_c
// The (x,y) coordinates of a rectangle is its top left corner.
public class ShpRect_c extends ShpShape_p
   {
   private float m_H, m_W;

   ShpRect_c(float XCoord, float YCoord, float Width, float Height)
      {
      super(XCoord, YCoord);
      this.m_W = Width;
      this.m_H = Height;
      }

   public void DisplayBorders()
      { rect(X(), Y(), W(), H()); }

   public float H()
      { return this.m_H; }

   public float W()
      { return this.m_W; }

   public float MiddleX()
      { return X() + 0.5f * W(); }

   public float MiddleY()
      { return Y() + 0.5f * H(); }

   } // public class ShpRect_c
/*************************************************************************************************/
// Classes:
//   TileSetImage_c
//   TileSetImageHandler_c
//   TileSetLayer_c
//   TileMap_c
//   TileMapHandler_c
/*************************************************************************************************/



/*************************************************************************************************/
// class TileSetImage_c
public class TileSetImage_c
   {
   private PImage m_Image = null;
   private int m_ColumnCount = int_NULL;
   private int m_Margin = int_NULL;
   private int m_Spacing = int_NULL;
   private int m_TileCount = int_NULL;
   private int m_TileHeight = int_NULL;
   private int m_TileWidth = int_NULL;
   private int m_Idx = int_NULL;

   TileSetImage_c(final String FileName, final int Idx)
      {
      Initialize(TILE_SET_PATH + FileName);
      this.m_Idx = Idx;
      }

   public boolean ContainsTile(final int TileIdx)
      { return (TileIdx < this.m_TileCount); }

   public PImage GetTileByIdx(final int TileIdx)
      {
      if (!ContainsTile(TileIdx))
         return null;
         
      int PixelX = this.m_Margin + this.GetTileColumn(TileIdx) * (this.m_Spacing + this.m_TileWidth);
      int PixelY = this.m_Margin + this.GetTileRow(TileIdx) * (this.m_Spacing + this.m_TileHeight);
      return (this.m_Image.get(PixelX, PixelY, this.m_TileWidth, this.m_TileHeight));
      }

   private int GetTileColumn(final int TileIdx)
      { return (PApplet.parseInt(TileIdx % this.m_ColumnCount)); }

   private int GetTileRow(final int TileIdx)
      { return (PApplet.parseInt(TileIdx / this.m_ColumnCount)); }

   private int Index()
      { return this.m_Idx; }

   private boolean Initialize(final String TileFileName)
      {
      JSONObject TileSetJson = loadJSONObject(TileFileName);
      return this.InitializeBase(TileSetJson);
      } // Initialize

   // This function initializes the tile set by reading the json file.
   private boolean InitializeBase(final JSONObject TileSetJson)
      {
      this.m_ColumnCount = TileSetJson.getInt("columns");
      this.m_Margin = TileSetJson.getInt("margin");
      this.m_Spacing = TileSetJson.getInt("spacing");
      this.m_TileCount = TileSetJson.getInt("tilecount");
      this.m_TileHeight = TileSetJson.getInt("tileheight");
      this.m_TileWidth = TileSetJson.getInt("tilewidth");
      this.m_Image = loadImage(TILE_SET_PATH + TileSetJson.getString("image"));
      return true;
      } // InitializeBase()

   } // public class TileSetImage_c

/*************************************************************************************************/
// class TileSetImageHandler_c
public class TileSetImageHandler_c
   {
   private EventHandler_c m_EventHandler = null;
   private ArrayList<TileSetImage_c> m_TileSetImageArray = new ArrayList<TileSetImage_c>();
   private HashMap<String, TileSetImage_c> m_TileSetImageMap = new HashMap<String, TileSetImage_c>();

   TileSetImageHandler_c(EventHandler_c EventHandler)
      {
      this.m_EventHandler = EventHandler;
      }

   public TileSetImage_c GetOrCreateTileSetImage(final String TileSetFileName)
      {
      if (this.m_TileSetImageMap.containsKey(TileSetFileName))
         return this.m_TileSetImageMap.get(TileSetFileName);
      TileSetImage_c TileSetImage = new TileSetImage_c(TileSetFileName, this.m_TileSetImageArray.size());
      this.m_TileSetImageArray.add(TileSetImage);
      this.m_TileSetImageMap.put(TileSetFileName, TileSetImage);
      this.m_EventHandler.OnCreatedTileSetImage(TileSetFileName);
      return this.m_TileSetImageMap.get(TileSetFileName);
      }

   } // public class TileSetImageHandler_c

/*************************************************************************************************/
// class TileSetLayer_c
public class TileSetLayer_c
   {
   private boolean m_IsInitialized = false;

   private int m_Width = int_NULL;
   private int m_Height = int_NULL;
   private int m_Priority = int_NULL; // 1 is the layer to draw first.
   private FullMatrix_c m_TileIdxMatrix = null; // matrix of pairs ( idx of tileSet images, idx of tile )

   TileSetLayer_c(final int Priority,
                  final int Width,
                  final int Height)
      {
      this.m_Priority = Priority;
      this.m_Width = Width;
      this.m_Height = Height;
      this.m_TileIdxMatrix = new FullMatrix_c(Width, Height);
      }

   public void SetTileIdx(final int i, final int j,
                   final int TileSetIdx, final int TileIdx)
      {
      this.m_TileIdxMatrix.SetFirst(i, j, TileSetIdx);
      this.m_TileIdxMatrix.SetFirst(i, j, TileIdx);
      }

   public int TileSetIdx(final int i, final int j)
      { return this.m_TileIdxMatrix.Get(i,j).First(); }

   public int TileIdx(final int i, final int j)
      { return this.m_TileIdxMatrix.Get(i,j).Second(); }

   } // public class TileSetLayer_c

/*************************************************************************************************/
// class TileMap_c
public class TileMap_c
   {
   private int m_Idx = int_NULL;
   private String m_MapFileName = null;
   private ArrayList<TileSetLayer_c> m_LayerList = new ArrayList<TileSetLayer_c>();

   TileMap_c(final String MapFileName,
             final int    Idx)
      {
      this.m_Idx = Idx;
      this.m_MapFileName = MapFileName;
      }

   public void AddLayer(final TileSetLayer_c Layer)
      {
      m_LayerList.add(Layer);
      // TODO: SORT IN PRIORITY ORDER.
      }

   public void Display(final CoordSystem_c CoordSystem)
      {
      
      }

   } // public class TileMap_c

/*************************************************************************************************/
// class TileMapHandler_c
public class TileMapHandler_c
   {
   private EventHandler_c m_EventHandler = null;
   private TileSetImageHandler_c m_TileSetImageHandler = null;
   private ArrayList<TileMap_c> m_MapList = new ArrayList<TileMap_c>();
   private HashMap<String, TileMap_c> m_TileMapMap = new HashMap<String, TileMap_c>();

   TileMapHandler_c(TileSetImageHandler_c TileSetImageHandler,
                    EventHandler_c        EventHandler)
      {
      this.m_EventHandler = EventHandler;
      this.m_TileSetImageHandler = TileSetImageHandler;
      }

   public TileMap_c GetOrCreateMap(final String MapFileName)
      {
      if (m_TileMapMap.containsKey(MapFileName))
         return m_TileMapMap.get(MapFileName);

      if (CreateTileMap(MapFileName))
         return this.m_TileMapMap.get(MapFileName);
      else
         return null;
      }

   private boolean CreateTileMap(final String MapFileName)
      {
      TileMap_c Map = new TileMap_c(MapFileName, this.m_MapList.size());

      JSONObject MapJson = loadJSONObject(TILE_MAP_PATH + MapFileName);
      JSONArray TileSetsJson = MapJson.isNull("tilesets") ? null : MapJson.getJSONArray("tilesets");
      JSONArray LayersJson = MapJson.isNull("layers") ? null : MapJson.getJSONArray("layers");
      if (TileSetsJson == null || LayersJson == null)
         return false;

      ArrayList<Integer> FirstIdxList = new ArrayList<Integer>();
      ArrayList<TileSetImage_c> TileSetImageList = new ArrayList<TileSetImage_c>();
      for (int i = 0; i < TileSetsJson.size(); i++)
         {
         JSONObject TileSetJson = TileSetsJson.getJSONObject(i);
         if (TileSetJson.isNull("firstgid") || TileSetJson.isNull("source"))
            return false;

         FirstIdxList.add(TileSetJson.getInt("firstgid"));
         TileSetImage_c TileSetImage = m_TileSetImageHandler.GetOrCreateTileSetImage(TileSetJson.getString("source"));
         TileSetImageList.add(TileSetImage);
         }

      for (int i = 0; i < LayersJson.size(); i++)
         {
         JSONObject LayerJson = LayersJson.getJSONObject(i);
         if (LayerJson.isNull("width") || LayerJson.isNull("height") || LayerJson.isNull("data"))
            return false;

         int Width = LayerJson.getInt("width");
         int Height = LayerJson.getInt("height");
         TileSetLayer_c Layer = new TileSetLayer_c(i /*Priorirty*/, Width, Height);

         JSONArray DataJson = LayerJson.getJSONArray("data");
         for (int j = 0; j < DataJson.size(); j++)
            {
            int Id = DataJson.getInt(j);
            int TileSetListIdx = -1;
            for (int k = 0; k < FirstIdxList.size(); k++)
               {
               if (FirstIdxList.get(k) > Id)
                  break;
               if (FirstIdxList.get(k) < Id)
                  TileSetListIdx++;
               }

            if (TileSetListIdx < 0)
               continue;

            int Y = j % Width;
            int X = j / Width;
            int TileIdx = Id - FirstIdxList.get(TileSetListIdx) - 1;
            Layer.SetTileIdx(X, Y, TileSetImageList.get(TileSetListIdx).Index(), TileIdx);
            }

         Map.AddLayer(Layer);
         }

      this.m_TileMapMap.put(MapFileName, Map);
      this.m_EventHandler.OnCreatedTileMap(TILE_MAP_PATH + MapFileName);
      return true;
      }

   } // public class TileMapHandler_c
/*************************************************************************************************/
// class:
//   UsrEventHandler_c
/*************************************************************************************************/

/*************************************************************************************************/
// class UsrEventHandler_c
public class UsrEventHandler_c
   {
   UsrEventHandler_c()
      {} // UsrEventHandler_c

   public void KeyPressed()
      { println("press", keyCode); }

   public void KeyReleased()
      { println("release", keyCode); }

   public void MousePressed()
      { println("mousePressed:", mouseX, mouseY); }

   } // public class UsrEventHandler_c
public void circle(float x, float y, float r)
   { ellipse(x, y, 2 * r, 2 * r); }
// APP
static int int_MAX = 2147483647;
static int int_MIN = -2147483647;
static int int_NULL = -2147483648;
static boolean DEBUG = true;

// WORLD
final public float WRLD_WORLD_MAP_W = 6000;
final public float WRLD_WORLD_MAP_H = 6000;
final public float WRLD_DISPLAYED_MAP_W = 500;
final public float WRLD_DISPLAYED_MAP_H = 500;
final public float WRLD_DISPLAYED_MAP_X = 64;
final public float WRLD_DISPLAYED_MAP_Y = 64;

// SCREEN
// Limitation: on ne peut pas utiliser des variables pour la fonction size().
final public int SCREEN_W = 1200;
final public int SCREEN_H = 900;

// TILE
final public String TILE_SET_PATH = "Resources/TileSets/";
final public String TILE_MAP_PATH = "Resources/TileMaps/";
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
