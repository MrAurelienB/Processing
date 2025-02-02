import java.util.*;

// This class represents a range. It is composed of two values, the first and the last.
public class MathRange_c
   {

   private int m_FromValue;
   private int m_ToValue;

   // Constructor
   public MathRange_c(final int FromValue, final int ToValue)
      {
      this.m_FromValue = FromValue;
      this.m_ToValue = ToValue;
      } // MathRange_c()

   // This function returns the from value of the range.
   public int FromValue()
      {
      return (this.m_FromValue);
      } // FromValue()

   // This function returns the range size.
   public int RangeSize()
      {
      return (this.m_ToValue - this.m_FromValue);
      } // RangeSize()

   // This function returns the to value of the range.
   public int ToValue()
      {
      return (this.m_ToValue);
      } // FromValue()

   } // class MathRange_c

// This class represents a rectangle with four values.
// The origin corrdinates (upper left corner), the width and the height.
public class MathRect_c
   {

   private float m_Height;
   private float m_OriginX;
   private float m_OriginY;
   private float m_Width;

   // Constructor
   public MathRect_c(final float OriginX, final float OriginY, final float Width, final float Height)
      {
      this.m_Height = Height;
      this.m_OriginX = OriginX;
      this.m_OriginY = OriginY;
      this.m_Width = Width;
      } // MathRect_c()

   // This function returns the value constrained in the rectangle.
   public void Constrain(final PVector Vector)
      {
      Vector.x = constrain(Vector.x, this.m_OriginX, this.m_OriginX + this.m_Width);
      Vector.y = constrain(Vector.y, this.m_OriginY, this.m_OriginY + this.m_Height);
      } // Constrain()

   // This function returns the height of the rectangle.
   public float Height()
      {
      return (this.m_Height);
      } // Height()

   // This function indicates whether the point of coordinates (XCoord,YCoord) is inside the rectangle or not.
   public boolean IsPointInside(final float XCoord, final float YCoord)
      {
      return (XCoord >= this.m_OriginX && XCoord <= this.m_OriginX + this.m_Width &&
              YCoord >= this.m_OriginY && YCoord <= this.m_OriginY + this.m_Height);
      } // IsPointInside()

   // This function returns the X coordinate of the origin.
   public float OriginX()
      {
      return (this.m_OriginX);
      } // OriginX()

   // This function returns the Y coordinate of the origin.
   public float OriginY()
      {
      return (this.m_OriginY);
      } // OriginY()

   // This function resets the rectangle.
   public void Reset(final float OriginX, final float OriginY, final float Width, final float Height)
      {
      this.m_Height = Height;
      this.m_OriginX = OriginX;
      this.m_OriginY = OriginY;
      this.m_Width = Width;
      } // Reset()

   // This function sets the height of the rectangle.
   public void SetHeight(final float Height)
      {
      this.m_Height = Height;
      } // SetHeight()

   // This function sets the X coordinate of the origin.
   public void SetOriginX(final float OriginX)
      {
      this.m_OriginX = OriginX;
      } // SetOriginX()

   // This function sets the Y coordinate of the origin.
   public void SetOriginY(final float OriginY)
      {
      this.m_OriginY = OriginY;
      } // SetOriginY()

   // This function sets the width of the rectangle.
   public void SetWidth(final float Width)
      {
      this.m_Width = Width;
      } // SetWidth()

   // This function returns the width of the rectangle.
   public float Width()
      {
      return (this.m_Width);
      } // Width()

   } // class MathRect_c
