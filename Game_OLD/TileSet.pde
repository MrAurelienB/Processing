import java.util.HashMap;

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
      return (int((LocalTileIdx - 1) % this.m_ColumnCount));
      } // GetTileColumn()

   // This function returns the row index of the tile from its local index. Row index start at 0.
   private int GetTileRow(final int LocalTileIdx)
      {
      return (int((LocalTileIdx - 1) / this.m_ColumnCount));
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
