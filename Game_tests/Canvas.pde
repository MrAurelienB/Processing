/******************************************************
This class represents a canvas to display in a menu.
A canvas can contains multiple displayable objects and
is linked to a menu.
*******************************************************/
class Canvas_c extends Rect_c
{
  
  ArrayList<Rect_c> m_ObjectsToDisplayList = new ArrayList<Rect_c>();
  
  Canvas_c()
    {
    super();
    } // Canvas_c()

  void AddObject(Rect_c Obj)
    {
    this.m_ObjectsToDisplayList.add(Obj);
    } // AddObject()

  void Check()
    {
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      {
      if (Obj instanceof NavigationButton_c)
        ((NavigationButton_c) Obj).Check();
      }
    } // Check()

  public void Enable()
    {
    super.Enable();
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      Obj.Enable();
    } // Enable()
    
  public void Disable()
    {
    super.Disable();
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      Obj.Disable();
    } // Disable()

  void Show()
    {
    super.Show();
    
    for (Rect_c Obj : this.m_ObjectsToDisplayList)
      Obj.Show();
    } // Show()

} // class Canvas_c
