/*************************************************************************************************/
// Classes:
//   TileSetImage_c
//   TileSetImageHandler_c
//   TileSetLayer_c
//   TileMap_c
//   TileMapHandler_c
/*************************************************************************************************/

import java.util.HashMap;

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
      { return (int(TileIdx % this.m_ColumnCount)); }

   private int GetTileRow(final int TileIdx)
      { return (int(TileIdx / this.m_ColumnCount)); }

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

   TileSetImage_c GetOrCreateTileSetImage(final String TileSetFileName)
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

   void SetTileIdx(final int i, final int j,
                   final int TileSetIdx, final int TileIdx)
      {
      this.m_TileIdxMatrix.SetFirst(i, j, TileSetIdx);
      this.m_TileIdxMatrix.SetFirst(i, j, TileIdx);
      }

   int TileSetIdx(final int i, final int j)
      { return this.m_TileIdxMatrix.Get(i,j).First(); }

   int TileIdx(final int i, final int j)
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

   void AddLayer(final TileSetLayer_c Layer)
      {
      m_LayerList.add(Layer);
      // TODO: SORT IN PRIORITY ORDER.
      }

   void Display(final CoordSystem_c CoordSystem)
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