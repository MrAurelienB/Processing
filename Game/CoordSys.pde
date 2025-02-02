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