/*************************************************************************************************/
// class:
//   UsrEventHandler_c
/*************************************************************************************************/

/*************************************************************************************************/
// class UsrEventHandler_c
public class UsrEventHandler_c
   {
   UsrEventHandler_c()
      {} // UsrEventHandler_c

   void KeyPressed()
      { println("press", keyCode); }

   void KeyReleased()
      { println("release", keyCode); }

   void MousePressed()
      { println("mousePressed:", mouseX, mouseY); }

   } // public class UsrEventHandler_c