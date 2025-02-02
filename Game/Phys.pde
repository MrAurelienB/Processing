/*************************************************************************************************/
// Classes:
//   PhysCollisionEvaluator_c
/*************************************************************************************************/

/*************************************************************************************************/
// class PhysCollisionEvaluator_c
public class PhysCollisionEvaluator_c
   {

   PhysCollisionEvaluator_c()
      {}

   public boolean CheckCollision(final ShpCircle_c c1, final ShpCircle_c c2)
      { return dist(c1.X(), c1.Y(), c2.X(), c2.Y()) <= c1.R() + c2.R(); }

   public boolean CheckCollision(final ShpRect_c r1, final ShpRect_c r2)
      {
      if (r2.X() > r1.X() + r1.W())
         return false;
      if (r2.X() + r2.W() < r1.X())
         return false;
      if (r2.Y() > r1.Y() + r1.H())
         return false;
      if (r2.Y() + r2.H() < r1.Y())
         return false;
      return true;
      }

   public boolean CheckCollision(final ShpCircle_c c, final ShpRect_c r)
      {
      float d1 = dist(c.X(), c.Y(), r.X(), r.Y());
      float d2 = dist(c.X(), c.Y(), r.X() + r.W(), r.Y());
      float d3 = dist(c.X(), c.Y(), r.X(), r.Y() + r.H());
      float d4 = dist(c.X(), c.Y(), r.X() + r.W(), r.Y() + r.H());
      float d = min(d1, min(d2, min(d3, d4)));
      return d <= c.R();
      }

   } // public class PhysCollisionEvaluator_c