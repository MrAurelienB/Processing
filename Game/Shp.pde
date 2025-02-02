/*************************************************************************************************/
// component:
//    ShpShape_p
//
// class:
//   ShpCircle_c
//   ShpRect_c
/*************************************************************************************************/


/*************************************************************************************************/
// component ShpShape_p
public abstract class ShpShape_p
   {
   protected float m_X, m_Y;

   ShpShape_p(float XCoord, float YCoord)
      {
      this.m_X = XCoord;
      this.m_Y = YCoord;
      }

   public abstract void DisplayBorders();
   public abstract float H(); // Height
   public abstract float W(); // Width
   
   public void SetX(final float x)
      { this.m_X = x; }

   public void SetY(final float y)
      { this.m_Y = y; }

   public float X()
      { return this.m_X; }

   public float Y()
      { return this.m_Y; }

   } // public abstract class ShpShape_p

/*************************************************************************************************/
// class ShpCircle_c
// The (x,y) coordinates of a circle is its center.
public class ShpCircle_c extends ShpShape_p
   {
   private float m_R;

   ShpCircle_c(float XCoord, float YCoord, float Radius)
      {
      super(XCoord, YCoord);
      this.m_R = Radius;
      }

   public void DisplayBorders()
      { circle(X(), Y(), R()); }

   public float H()
      { return 2 * this.m_R; }

   public float R()
      { return this.m_R; }

   public float W()
      { return 2 * this.m_R; }

   } // public class ShpCircle_c

/*************************************************************************************************/
// class ShpRect_c
// The (x,y) coordinates of a rectangle is its top left corner.
public class ShpRect_c extends ShpShape_p
   {
   private float m_H, m_W;

   ShpRect_c(float XCoord, float YCoord, float Width, float Height)
      {
      super(XCoord, YCoord);
      this.m_W = Width;
      this.m_H = Height;
      }

   public void DisplayBorders()
      { rect(X(), Y(), W(), H()); }

   public float H()
      { return this.m_H; }

   public float W()
      { return this.m_W; }

   public float MiddleX()
      { return X() + 0.5 * W(); }

   public float MiddleY()
      { return Y() + 0.5 * H(); }

   } // public class ShpRect_c