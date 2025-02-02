/*************************************************************************************************/
// Classes:
//   IntPair_c
//   Matrix_p
//   FullMatrix_c
//   CSRMatrix_c
/*************************************************************************************************/

import java.util.Objects;

/*************************************************************************************************/
// class IntPair_c
class IntPair_c
   {
   private int m_First;
   private int m_Second;

   public IntPair_c()
      { this(0,0); }

   public IntPair_c(final int First, final int Second)
      {
      this.m_First = First;
      this.m_Second = Second;
      }

   public boolean equals(IntPair_c Rhs)
      {
      if (Rhs == null)
         return (false);
      if (Rhs == this)
         return (true);
      return this.m_First == Rhs.First() && this.m_Second == Rhs.Second();
      } // equals()

   public int First()
      { return this.m_First; }

   @Override public int hashCode()
      { return Objects.hash(this.m_First, this.m_Second); }

   public int Second()
      { return this.m_Second; }

   public void SetFirst(final int Val)
      { this.m_First = Val; }

   public void SetSecond(final int Val)
      { this.m_Second = Val; }

   } // class IntPair_c

/*************************************************************************************************/
// class Matrix_p
abstract public class Matrix_p
   {
   private int m_Height = int_NULL;
   private int m_Width = int_NULL;

   Matrix_p(final int Width, final int Height)
      {
      this.m_Height = Height;
      this.m_Width = Width;
      }

   public abstract IntPair_c Get(final int i, final int j);
   public abstract void Set(final int i, final int j, final IntPair_c Value);
   public abstract void SetFirst(final int i, final int j, final int Value);
   public abstract void SetSecond(final int i, final int j, final int Value);

   } // public class Matrix_p


/*************************************************************************************************/
// class FullMatrix_c
public class FullMatrix_c extends Matrix_p
   {
   private IntPair_c[][] m_Values = null;

   FullMatrix_c(final int Width, final int Height)
      {
      super(Width, Height);
      this.m_Values = new IntPair_c[Height][Width];
      for (int i = 0; i < Height; i++)
         {
         for (int j = 0; j < Width; j++)
            this.m_Values[i][j] = new IntPair_c();
         }
      }

   public IntPair_c Get(final int i, final int j)
      { return this.m_Values[i][j]; }

   public void Set(final int i, final int j, final IntPair_c Value)
      { this.m_Values[i][j] = Value; }

   public void SetFirst(final int i, final int j, final int Value)
      { this.m_Values[i][j].SetFirst(Value); }

   public void SetSecond(final int i, final int j, final int Value)
      { this.m_Values[i][j].SetSecond(Value); }

   } // public class FullMatrix_c

/*************************************************************************************************/
// class CSRMatrix_c
/*
public class CSRMatrix_c extends Matrix_p
   {

   private IntPair_c[][] m_Values = null;
   private IntPair_c[][] m_ColIdx = null;
   private IntPair_c[][] m_RowIdx = null;

   CSRMatrix_c(final int Width, final int Height, int ValCount)
      {
      super(Width, Height);
      }

   } // public class CSRMatrix_c
*/