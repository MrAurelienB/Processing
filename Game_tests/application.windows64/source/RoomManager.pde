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
