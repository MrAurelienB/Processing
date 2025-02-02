/******************************************************
This class represents a displayable rectangle.
*******************************************************/
class Rect_c
{

  protected String m_Identifer = "";
  
  protected boolean m_IsEnabled = true;
  
  private float m_Width = 200;
  private float m_Height = 50;
  private float m_XCoord = 0;
  private float m_YCoord = 0;
  private float m_Curve = 0;
  private float m_StrokeWeight = 1;
  
  private color m_CurrentFillColor = color(255);
  private color m_CurrentStrokeColor = color(0);
  
  Rect_c()
    {

    } // Rect_c()
    
  public void Enable()
    {
    this.m_IsEnabled = true;
    } // Enable()
    
  public void Disable()
    {
    this.m_IsEnabled = false;
    } // Disable()
    
  public float Height()
    {
    return (this.m_Height);
    } // Height()
    
  public boolean IsEnabled()
    {
    return (this.m_IsEnabled);
    } // IsEnabled()
    
  public boolean IsMouseOver()
    {
    return (mouseX > this.m_XCoord &&
            mouseX < this.m_XCoord + this.m_Width &&
            mouseY > this.m_YCoord &&
            mouseY < this.m_YCoord + this.m_Height);
    } // IsMouseOver

  public void SetCoord(final float XCoord,
                       final float YCoord)
    {
    this.m_XCoord = XCoord;
    this.m_YCoord = YCoord;
    } // SetCoord()
  
  public void SetCurrentFillColor(final color FillColor)
    {
    this.m_CurrentFillColor = FillColor;
    } // SetCurrentFillColor()
  
  public void SetCurrentStrokeColor(final color StrokeColor)
    {
    this.m_CurrentStrokeColor = StrokeColor;
    } // SetCurrentStrokeColor()
  
  public void SetCurve(final float Curve)
    {
    this.m_Curve = Curve;
    } // SetCurve()
  
  public void SetId(final String Identifier)
    {
    this.m_Identifer = Identifier;
    } // SetId()
  
  public void SetSize(final float Width,
                      final float Height)
    {
    this.m_Width = Width;
    this.m_Height = Height;
    } // SetSize()
    
  public void SetStrokeWeight(final float StrokeWeight)
    {
    this.m_StrokeWeight = StrokeWeight;
    } // SetStrokeWeight()

  public void Show()
    { 
    stroke(this.m_CurrentStrokeColor);
    strokeWeight(this.m_StrokeWeight);
    fill(this.m_CurrentFillColor);
    rect(this.m_XCoord, this.m_YCoord, this.m_Width, this.m_Height, this.m_Curve);
    } // Show()
    
  public float Width()
    {
    return (this.m_Width);
    } // Width()
    
  public float X()
    {
    return (this.m_XCoord);
    } // X()

  public float Y()
    {
    return (this.m_YCoord);
    } // Y()

} // class Rect_c

/*********************************************************************************************************************************************************************/

/******************************************************
This class represents a rectangle with text.
*******************************************************/
class TextObject_c extends Rect_c
{

  private float m_TextSize = 32; 
  private color m_CurrentTextColor = color(0);
  private String m_Text = "Default";
  
  TextObject_c()
    {
    super();
    } // TextObject_c()

  public void SetText(final String Text)
    {
    this.m_Text = Text;
    } // SetText()

  public void SetCurrentTextColor(final color TextColor)
    {
    this.m_CurrentTextColor = TextColor;
    } // SetCurrentTextColor()

  public void SetTextSize(final float TextSize)
    {
    this.m_TextSize = TextSize;
    } // SetTextSize()

  public void Show()
    { 
    super.Show();
    
    fill(this.m_CurrentTextColor);
    textSize(this.m_TextSize);
    textAlign(CENTER, CENTER);
    text(this.m_Text, super.m_XCoord, super.m_YCoord, super.m_Width, super.m_Height);
    } // Show()

} // class TextObject_c

/*********************************************************************************************************************************************************************/

/******************************************************
This class represents a generic button.
*******************************************************/
class Button_c extends TextObject_c
{

  private color m_DefaultFillColor = color(255);
  private color m_DefaultStrokeColor = color(0);
  private color m_DefaultTextColor = color(0);
  private color m_HoverFillColor = color(200);
  private color m_HoverStrokeColor = color(255, 0, 0);
  private color m_HoverTextColor = color(0, 255, 0);
  
  Button_c()
    {
    super();
    } // Button_c()
  
  @Override
  public void Show()
    {
    if (!super.m_IsEnabled)
      return;
      
    boolean IsOver = super.IsMouseOver();
    super.SetCurrentFillColor(IsOver ? this.m_HoverFillColor : this.m_DefaultFillColor);
    super.SetCurrentStrokeColor(IsOver ? this.m_HoverStrokeColor : this.m_DefaultStrokeColor);
    super.SetCurrentTextColor(IsOver ? this.m_HoverTextColor : this.m_DefaultTextColor);
    super.Show();
    } // Show()

  public void SetDefaultColor(final color FillColor,
                              final color StrokeColor,
                              final color TextColor)
    {
    this.m_DefaultFillColor = FillColor;
    this.m_DefaultStrokeColor = StrokeColor;
    this.m_DefaultTextColor = TextColor;
    } // SetDefaultColor()
    
  public void SetHoverColor(final color FillColor,
                            final color StrokeColor,
                            final color TextColor)
    {
    this.m_HoverFillColor = FillColor;
    this.m_HoverStrokeColor = StrokeColor;
    this.m_HoverTextColor = TextColor;
    } // SetHoverColor()

} // class Button_c

/*********************************************************************************************************************************************************************/

/******************************************************
This class represents a button to navigate through
canvas in a menu.
*******************************************************/
class NavigationButton_c extends Button_c
{

  Canvas_c CanvasToEnableOnClick = null;
  Canvas_c CanvasToDisableOnClick = null;
  
  NavigationButton_c()
    {
    super();
    } // NavigationButton_c()

  public void SetCanvasToEnableOnClick(Canvas_c Canvas)
    {
    this.CanvasToEnableOnClick = Canvas;
    } // SetCanvasToEnableOnClick()

  public void SetCanvasToDisableOnClick(Canvas_c Canvas)
    {
    this.CanvasToDisableOnClick = Canvas;
    } // SetCanvasToDisableOnClick()

  public void Check()
    {
    if (super.IsMouseOver() && mousePressed)
      {
      println("Button Clicked : " + this.m_Identifer);
      if (this.CanvasToEnableOnClick != null)
        this.CanvasToEnableOnClick.Enable();
      if (this.CanvasToDisableOnClick != null)
        this.CanvasToDisableOnClick.Disable();
      }
    } // Check()

} // class NavigationButton_c
