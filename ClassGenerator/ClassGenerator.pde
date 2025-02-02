
import Test.*;

void setup()
{

Test_c test = new Test_c();
  
String ClassName = "Point_c";


PrintWriter pw = createWriter("out.txt");

pw.println("class " + ClassName);
pw.println("{");
pw.println("");
pw.println("  " + ClassName + "()");
pw.println("    {");
pw.println("");
pw.println("    } // " + ClassName + "()");
pw.println("");
pw.println("} // class " + ClassName);


pw.flush();
pw.close();

launch(sketchPath("")+"out.txt");
exit();
}
