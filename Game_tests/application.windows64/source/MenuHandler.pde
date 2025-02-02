/******************************************************
This class represents a menu generator that generates
menu from a json file.
*******************************************************/
class MenuHandler_c
{

  private ArrayList<Menu_c> MenuList;
  
  private Menu_c m_StartMenu = null;
  
  MenuHandler_c()
    {
    this.MenuList = new ArrayList<Menu_c>();
    } // MenuHandler_c()

  public void CheckAndShow() // TEMPORARY
    {
    for (Menu_c Menu : this.MenuList)
      Menu.CheckAndShow();
    }

} // class MenuHandler_c
