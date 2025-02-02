import java.util.Map;

/*************************************
This class represents a cell of a map.
**************************************/
class Cell_c
{
  private int m_XCoord = int_NULL; // The X coordinate of the cell.
  private int m_YCoord = int_NULL; // The Y coordinate of the cell.
  
  private boolean m_IsVisited  = false; // Whether the cell has been visited or not.
  private Map<WallSide_ch,Boolean> m_Walls = new HashMap<WallSide_ch,Boolean>() { // This array contains whether each wall exists or not.
    {
      put(WallSide_ch.BOTTOM, true);
      put(WallSide_ch.TOP, true);
      put(WallSide_ch.LEFT, true);
      put(WallSide_ch.RIGHT, true);
    }
  };
  
  Cell_c(final int XCoord,
         final int YCoord)
    {
    this.m_XCoord = XCoord;
    this.m_YCoord = YCoord;
    } // Cell_c()
    
  /*
   * This function returns whether the cell has been visited or not.
   */
  public boolean IsVisited()
    {
    return (this.m_IsVisited);
    } // IsVisited()
    
  /*
  This function returns whether the specified wall exists or not.
  */
  public boolean IsWall(final WallSide_ch WallSide)
    {
    return (this.m_Walls.get(WallSide));
    } // IsWall()

  /*
   * This function removes a wall of the cell.
   */
  public void RemoveWall(final WallSide_ch WallSide)
    {
    this.m_Walls.replace(WallSide, false);
    } // RemoveWall()
    
  /*
   * This function sets whether the cell has been visited or not.
   */
  public void SetIsVisited(final boolean IsVisited)
    {
    this.m_IsVisited = IsVisited;
    } // SetIsVisited()

  /*
   * This function returns the X coordinate of the cell.
   */
  public int XCoord()
    {
    return (this.m_XCoord);
    } // XCoord()

  /*
   * This function returns the Y coordinates of the cell.
   */
  public int YCoord()
    {
    return (this.m_YCoord);
    } // YCoord()
    
  /*
  This function prints a cell.
  */
  public void Print()
    {
    if (this.m_Walls.get(WallSide_ch.BOTTOM))
      plotLine(this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize,
               this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize);
    if (this.m_Walls.get(WallSide_ch.TOP))
      plotLine(this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize,
               this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize);
    if (this.m_Walls.get(WallSide_ch.LEFT))
      plotLine(this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize,
               this.m_XCoord * test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize);
    if (this.m_Walls.get(WallSide_ch.RIGHT))
      plotLine(this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize,
               this.m_XCoord * test_CellSize + test_CellSize,
               this.m_YCoord * test_CellSize + test_CellSize);
    } // Print()
    
} // class Cell_c

/*********************************************************************************************************************************************************************/

/***********************************************
This class represents a map.
A map is a grid of cells that represents a maze.
************************************************/
class Map_c
{
  private int m_Width = 1; // The width of the map.
  private int m_Height = 1; // The height of the map.
  
  // (0,2) (1,2) (2,2)
  // (0,1) (1,1) (2,1)
  // (0,0) (1,0) (2,0)
  private Cell_c[][] m_Grid; // The gris of cells.
  
  Map_c(final int Width,
        final int Height)
    {
    this.m_Width = Width;
    this.m_Height = Height;
    this.m_Grid = new Cell_c[Width][Height];
    for (int i = 0; i < this.m_Grid.length; i++)
      {
      for (int j = 0; j < this.m_Grid[i].length; j++)
        {
        this.m_Grid[i][j] = new Cell_c(i,j);
        }
      }
    } // Map_c()

  /*
   * This function returns the cell at the specified coordinates.
   */
  public Cell_c GetCell(final int XCoord,
                        final int YCoord)
    {
    if (IsCoordValid(XCoord, YCoord))
      return (this.m_Grid[XCoord][YCoord]);
      
    println("Cell_c::GetCell(" + XCoord + "," + YCoord + ") is null.");
    return (null);
    } // GetCell()

  /*
   * This function returns a list containing the unvisited neighbors of the cell at coordinates (XCoord,YCoord).
   */
  public ArrayList<Cell_c> GetUnvisitedNeighbors(final int XCoord,
                                                 final int YCoord)
    {
    ArrayList<Cell_c> NeighborList = new ArrayList<Cell_c>();
    if (XCoord > 0)
      {
      Cell_c LeftCell = this.m_Grid[XCoord - 1][YCoord];
      if (!LeftCell.IsVisited())
        NeighborList.add(LeftCell);
      }
    if (YCoord > 0)
      {
      Cell_c BottomCell = this.m_Grid[XCoord][YCoord-1];
      if (!BottomCell.IsVisited())
        NeighborList.add(BottomCell);
      }
    if (XCoord < this.m_Width - 1)
      {
      Cell_c RigthCell = this.m_Grid[XCoord + 1][YCoord];
      if (!RigthCell.IsVisited())
        NeighborList.add(RigthCell);
      }
    if (YCoord < this.m_Height - 1)
      {
      Cell_c TopCell = this.m_Grid[XCoord][YCoord + 1];
      if (!TopCell.IsVisited())
        NeighborList.add(TopCell);
      }
    return (NeighborList);
    } // GetUnvisitedNeighbors()

  /*
  This function returns the height of the map.
  */
  public int Height()
    {
    return (this.m_Height);
    } // Height()

  /*
   * This function returns whether the coordinates (XCoord,YCoord) is valid for the grid.
   */
  private boolean IsCoordValid(final int XCoord,
                               final int YCoord)
    {
    return (XCoord >= 0 && XCoord < this.m_Width && YCoord >= 0 && YCoord < this.m_Height);
    } // IsCoordValid()
    
  /*
   * This function remove the wall between two cells.
   */
  public void RemoveWall(Cell_c FirstCell,
                         Cell_c SecondCell)
    {
    if (FirstCell.XCoord() == SecondCell.XCoord() - 1)
      {
      FirstCell.RemoveWall(WallSide_ch.RIGHT);
      SecondCell.RemoveWall(WallSide_ch.LEFT);
      }
    else if (FirstCell.XCoord() == SecondCell.XCoord() + 1)
      {
      FirstCell.RemoveWall(WallSide_ch.LEFT);
      SecondCell.RemoveWall(WallSide_ch.RIGHT);
      }
    else if (FirstCell.YCoord() == SecondCell.YCoord() - 1)
      {
      FirstCell.RemoveWall(WallSide_ch.TOP);
      SecondCell.RemoveWall(WallSide_ch.BOTTOM);
      }
    else if (FirstCell.YCoord() == SecondCell.YCoord() + 1)
      {
      FirstCell.RemoveWall(WallSide_ch.BOTTOM);
      SecondCell.RemoveWall(WallSide_ch.TOP);
      }
    } // RemoveWall()

  /*
  This function prints a map.
  */
  public void Print()
    {
    for (int i = 0; i < this.m_Width; i++)
      {
      for (int j = 0; j < this.m_Height; j++)
        {
        this.m_Grid[i][j].Print();
        }
      }
    } // Print()
    
  /*
  This function returns the width of the map.
  */
  public int Width()
    {
    return (this.m_Width);
    } // Width()

} // class Map_c
