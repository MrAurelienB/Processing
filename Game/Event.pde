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
   private int Iter = 0;

   EventHandler_c()
      {
      this.m_LogFile = createWriter("C:/Users/aurel/Documents/Processing/Projects/Game/log.txt"); // TODO
      }

   void LogMessage(final String Message)
      {
      if (!DEBUG)
         return;
      for (int i = 0; i < IndentSize; i++)
         this.m_LogFile.print(" ");
      this.m_LogFile.println(Message);
      this.m_LogFile.flush();
      }

   void OnDraw()
      {
      if (Iter == DEBUG_FRAME_RATE_ITER)
         {
         println(frameRate);
         Iter = 0;
         return;
         }
      Iter++;
      }

   void OnExit()
      {
      LogMessage("Exit");
      this.m_LogFile.close();
      }

   void OnCreatedTileSetImage(final String TileSetFileName)
      { LogMessage("Created tile set image: " + TileSetFileName); }

   void OnCreatedTileMap(final String MapFileName)
      { LogMessage("Created tile map: " + MapFileName); }

   void OnInitializeStart()
      {
      LogMessage("Initialize");
      IndentSize += 3;
      LogMessage("Screen size " + width + " x " + height);
      }

   void OnInitializeEnd()
      {
      IndentSize -= 3;
      LogMessage("Done");
      }

   void OnInitializeEngineStart()
      {
      LogMessage("Initialize engine");
      IndentSize += 3;
      }

   void OnInitializeEngineEnd()
      {
      IndentSize -= 3;
      LogMessage("Done");
      }

   } // public class EventHandler_c