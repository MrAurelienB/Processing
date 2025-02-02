
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

   void Initialize()
      {
      this.m_EventHandler.OnInitializeEngineStart();
      this.m_CurrentMap = "mainMap.json";
      m_TileMapHandler.GetOrCreateMap(this.m_CurrentMap);
      this.m_EventHandler.OnInitializeEngineEnd();
      }

   void DisplayMap()
      {
      TileMap_c TileMap = m_TileMapHandler.GetOrCreateMap("mainMap.json");
      if (TileMap == null)
         return;
      TileMap.Display(this.m_CoordSystem);
      }

   } // public class GameEngine_c