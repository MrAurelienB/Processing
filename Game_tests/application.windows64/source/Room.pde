/*/****************************************************
This class represents a room linked to a cell of a map.
*******************************************************/
class Room_c
{

  private Cell_c m_Cell = null;
  
  Room_c(Cell_c Cell)
    {
    this.m_Cell = Cell;
    } // Room_c()

  /*
  This function prints a room at specified coordinates.
  */
  public void Print()
    {
    fill(0);
    if (this.m_Cell.IsWall(WallSide_ch.TOP))
      rect(0.5 * width, 0, 0.5 * width, 50);
    if (this.m_Cell.IsWall(WallSide_ch.BOTTOM))
      rect(0.5 * width, 0.5 * height - 50, 0.5 * width, 50);
    if (this.m_Cell.IsWall(WallSide_ch.LEFT))
      rect(0.5 * width, 0, 50, 0.5 * height);
    if (this.m_Cell.IsWall(WallSide_ch.RIGHT))
      rect(width - 50, 0, 50, 0.5 * height);
    } // Print()

} // class Room_c
