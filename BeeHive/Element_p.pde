class Element_p
{
  PVector m_Pos;
  float m_Size; // diameter
  color m_Color;
  
  Element_p(final PVector Pos, final float Size, final color Color)
    {
    this.m_Pos = Pos;
    this.m_Size = Size;
    this.m_Color = Color;
    }
    
  void Show()
    {
    fill(this.m_Color);
    noStroke();
    ellipse(this.m_Pos.x, this.m_Pos.y, this.m_Size, this.m_Size);
    }
}
