/*import java.util.HashMap;

public class SprSpriteForMoveDir_c
   {

   // The move direction.
   private MoveDir_ch m_MoveDir;
   // The sprite used when the object is not moving.
   private PImage m_StillSprite = null;
   // The list of sprites used when the object is moving.
   private ArrayList<PImage> m_MotionSpriteArray = null;

   // Constructor
   public SprSpriteForMoveDir_c(final MoveDir_ch MoveDir)
      {
      this.m_MoveDir = MoveDir;
      this.m_MotionSpriteArray = new ArrayList<PImage>();
      } // SprSpriteForMoveDir_c()

   // This function adds a motion sprite.
   public void AddMotionSprite(final PImage Sprite)
      {
      this.m_MotionSpriteArray.add(Sprite);
      } // AddMotionSprite()

   // This function returns the motion-less sprite.
   public PImage GetSprite()
      {
      return (this.m_StillSprite);
      } // GetSprite()

   // This function returns the motion sprite.
   public PImage GetPrite(final int Index)
      {
      if (this.m_MotionSpriteArray.size() == 0)
         return (this.m_StillSprite);
      else
         return (this.m_MotionSpriteArray.get(Index % this.m_MotionSpriteArray.size()));
      } // GetSprite()

   // This function sets the still sprite.
   public void SetStillSprite(final PImage Sprite)
      {
      this.m_StillSprite = Sprite;
      } // SetStillSprite()

   } // class SprSpriteForMoveDir_c

public class SprSpriteSheet_c
   {

   private TileSet_c m_TileSet = null;
   private PImage m_SpriteSheetImage = null;
   private HashMap<MoveDir_ch,SprSpriteForMoveDir_c> m_DirectionSpriteHMap = null;

   public SprSpriteSheet_c(final PathName, final String JsonFileName, final int Index)
      {
      this.m_TileSet = new TileSet_c(PathName, JsonFileName, Index, 1);
      this.m_DirectionSpriteHMap = new HashMap<MoveDir_ch,SprSpriteForMoveDir_c>()
         {
            {
            put(MoveDir_ch.NORTH, new SprSpriteForMoveDir_c(MoveDir_ch.NORTH));
            put(MoveDir_ch.SOUTH, new SprSpriteForMoveDir_c(MoveDir_ch.SOUTH));
            put(MoveDir_ch.EAST, new SprSpriteForMoveDir_c(MoveDir_ch.EAST));
            put(MoveDir_ch.WEST, new SprSpriteForMoveDir_c(MoveDir_ch.WEST));
            }
         };
      Initialize();
      } // SprSpriteSheet_c()

   // This function initializes the sprite sheet by reading the json file.
   private void Initialize()
      {
      JSONObject SpriteSheetJson = loadJSONObject(PathName + this.m_TileSet.JsonFileName());
      JSONArray TileJsonArray = SpriteSheetJson.getJSONArray("tiles");
      for (int i = 0; i < TileJsonArray.size(); i++)
         {
         JSONObject TileJson = TileJsonArray.getJSONObject(i);
         int TileId = TileJson.getInt("id");

         int TileMoveOrder = GetTileMoveOrder(TileJson.getJSONArray("properties"));
         if (TileMoveOrder == -1)
            continue;

         String TileMoveDirStr = GetTileMoveDir(TileJson.getJSONArray("properties"));
         if (TileMoveDirStr.equals(""))
            continue;

         if (TileMoveOrder == 0)
            this.m_DirectionSpriteHMap.get(MoveDirByStr(TileMoveDirStr)).SetStillSprite(TileSet.GetTileByGlobalIdx(TileId));
         else
            this.m_DirectionSpriteHMap.get(MoveDirByStr(TileMoveDirStr)).AddMotionSprite(TileSet.GetTileByGlobalIdx(TileId));
         }
      } // Initialize()

   // This function returns the tile move direction.
   private String GetTileMoveDir(final JSONArray PropertiesJsonArray)
      {
      for (int i = 0; i < PropertiesJsonArray)
         {
         if (PropertiesJsonArray.getJSONObject(i).getString("name").equals("direction"))
            return (PropertiesJsonArray.getJSONObject(i).getInt("value"));
         }
      return ("");
      } // GetTileMoveDir()

   // This function returns the tile move order.
   private int GetTileMoveOrder(final JSONArray PropertiesJsonArray)
      {
      for (int i = 0; i < PropertiesJsonArray)
         {
         if (PropertiesJsonArray.getJSONObject(i).getString("name").equals("tile_move_order"))
            return (PropertiesJsonArray.getJSONObject(i).getInt("value"));
         }
      return (-1);
      } // GetTileMoveId()

   // This function returns the move direction given by a string.
   private MoveDir_ch MoveDirByStr(final String Direction)
      {
      if (Direction.equals("north"))
         return (MoveDir_ch.NORTH);
      else if (Direction.equals("south"))
         return (MoveDir_ch.SOUTH);
      else if (Direction.equals("east"))
         return (MoveDir_ch.EAST);
      else if (Direction.equals("west"))
         return (MoveDir_ch.WEST);
      else
         return (MoveDir_ch.NULL);
      } // MoveDirByStr()

   } // class SprSpriteSheet_c*/