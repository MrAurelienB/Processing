import java.util.Stack;

/*
This class is used to generate a map.
*/
class MapGenerator_c
{
  
  MapGenerator_c()
    {
      
    } // MapGenerator_c()

  /*
  This function generates a maze using the backtracker algorithm.
  */
  public Map_c GenerateMap(final int Width, final int Height)
    {
    Map_c Map = new Map_c(Width, Height);
    
    Cell_c CurrentCell = Map.GetCell(0,0);
    CurrentCell.SetIsVisited(true);
    int UnvisitedCellCount = Width * Height - 1;
    Stack<Cell_c> CellStack = new Stack<Cell_c>();
    while (UnvisitedCellCount > 0)
      {
      ArrayList<Cell_c> UnvisitedNeighborCellList = Map.GetUnvisitedNeighbors(CurrentCell.XCoord(), CurrentCell.YCoord());
      if (UnvisitedNeighborCellList.size() > 0)
        {
        Cell_c NextCell = UnvisitedNeighborCellList.get(int(random(UnvisitedNeighborCellList.size())));
        CellStack.push(CurrentCell);
        Map.RemoveWall(CurrentCell, NextCell);
        CurrentCell = NextCell;
        NextCell.SetIsVisited(true);
        UnvisitedCellCount--;
        }
      else if (!CellStack.empty())
        CurrentCell = CellStack.pop();
      }
    return (Map);
    } // GenerateMap()

} // class MapGenerator_c
