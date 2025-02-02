import java.util.*;

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