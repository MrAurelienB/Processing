import java.util.*;

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
      int FirstTileX = int(this.m_ScreenPosition.x / 32) - 1;
      int FirstTileY = int(this.m_ScreenPosition.y / 32) - 1;
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
      this.m_ScreenPosition.x = constrain(Perso.InWorldPosition().x - 0.5 * width, 0, MapWidth() - width);
      this.m_ScreenPosition.y = constrain(Perso.InWorldPosition().y - 0.5 * height, 0, MapHeight() - height);
      } // UpdateScreenPosition()

   } // class TmapTiledMap_c
