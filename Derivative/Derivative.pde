

void setup(){
  
  Function_p fct0 = Clean(new Sum_c(new Val_c(5), new Var_c()));
  PrintFctAndDerivative(fct0);

  Function_p fct1 = Clean(new Sum_c(new Var_c(), new Var_c()));
  PrintFctAndDerivative(fct1);

  Function_p fct2 = Clean(new Prod_c(new Val_c(5), new Var_c()));
  PrintFctAndDerivative(fct2);

  Function_p fct3 = Clean(new Prod_c(fct1, fct2));
  PrintFctAndDerivative(fct3);
  
  Function_p fct4 = Clean(new Prod_c(fct0, fct0));
  PrintFctAndDerivative(fct4);
  
  Function_p fct5 = Clean(new Power_c(new Prod_c(new Val_c(3), new Var_c()), 5));
  PrintFctAndDerivative(fct5);
  
  Function_p fct6 = Clean(new Prod_c(new Val_c(3), new Power_c(new Var_c(), 5)));
  PrintFctAndDerivative(fct6);
  
  Function_p fct7 = Clean(new Power_c(fct4, 6));
  PrintFctAndDerivative(fct7);
}

void PrintFctAndDerivative(Function_p fct){
  if (fct == null)
    println("null");
  else
    {
    fct.Print();
    println();
    Function_p Deriv = fct.Derivate();
    if (Deriv == null)
      println("null");
    else
      {
      Deriv.Print();
      println();
      }
    }
  println();
}
