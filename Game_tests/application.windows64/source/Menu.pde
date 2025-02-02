/******************************************************
This class represents a generic menu.
*******************************************************/
class Menu_c
{

  private ArrayList<Canvas_c> m_CanvasList;
  
  Menu_c()
    {
    this.m_CanvasList = new ArrayList<Canvas_c>();
    } // Menu_c()

  public void AddCanvas(final Canvas_c Canvas)
    {
    this.m_CanvasList.add(Canvas);
    } // AddCanvas()
    
  public void CheckAndShow() // TEMPORARY
    {
    for (Canvas_c Canvas : this.m_CanvasList)
      {
      if (Canvas.IsEnabled())
        {
        Canvas.Check();
        Canvas.Show();
        }
      }
    }

} // class Menu_c
