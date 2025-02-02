Function_p Clean(Function_p Fct){
  if (Fct instanceof Sum_c)
    return (CleanSum((Sum_c)Fct));
  else if (Fct instanceof Prod_c)
    return (CleanProd((Prod_c)Fct));
  else if (Fct instanceof Power_c)
    return (CleanPower((Power_c)Fct));
  else
    return (Fct);
}

//----------------------------CleanSum------------------------------//
Function_p CleanSum(Sum_c SumFct){
  Function_p SubFct1 = SumFct.SubFct1();
  Function_p SubFct2 = SumFct.SubFct2();
  if (SubFct1 == null && SubFct2 == null)
    return null;
  if (SubFct1 == null)
    return SubFct2;
  if (SubFct2 == null)
    return SubFct1;
  if (SubFct1 instanceof Val_c && SubFct2 instanceof Val_c)
    {
    Val_c ValFct1 = (Val_c)SubFct1;
    Val_c ValFct2 = (Val_c)SubFct2;
    return (new Val_c(ValFct1.Value() + ValFct2.Value()));
    }
  if (SubFct1 instanceof Var_c && SubFct2 instanceof Var_c)
    return (new ValVar_c(2));
  if (SubFct1 instanceof ValVar_c && SubFct2 instanceof ValVar_c)
    {
    ValVar_c ValFct1 = (ValVar_c)SubFct1;
    ValVar_c ValFct2 = (ValVar_c)SubFct2;
    return (new ValVar_c(ValFct1.Value() + ValFct2.Value()));
    }
  return (SumFct);
} // CleanSum

//----------------------------CleanProd------------------------------//
Function_p CleanProd(Prod_c ProdFct){
  Function_p SubFct1 = ProdFct.SubFct1();
  Function_p SubFct2 = ProdFct.SubFct2();
  if (SubFct1 == null || SubFct2 == null)
    return null;
  if (SubFct1 instanceof Val_c)
    {
    Val_c ValFct1 = (Val_c)SubFct1;
    if (SubFct2 instanceof Val_c)
      {
      Val_c ValFct2 = (Val_c)SubFct2;
      return (new Val_c(ValFct1.Value() * ValFct2.Value()));
      }
    if (SubFct2 instanceof Var_c)
      {
      return (new ValVar_c(ValFct1.Value()));
      }
    if (SubFct2 instanceof ValVar_c)
      {
      ValVar_c ValFct2 = (ValVar_c)SubFct2;
      return (new ValVar_c(ValFct1.Value() * ValFct2.Value()));
      }
    if (ValFct1.Value() == 1)
      {
      return (SubFct2);
      }
    }
  if (SubFct1 instanceof Var_c)
    {
    if (SubFct2 instanceof Val_c)
      {
      Val_c ValFct2 = (Val_c)SubFct2;
      return (new ValVar_c(ValFct2.Value()));
      }
    }
  if (SubFct1 instanceof ValVar_c)
    {
    if (SubFct2 instanceof Val_c)
      {
      Val_c ValFct2 = (Val_c)SubFct2;
      ValVar_c ValFct1 = (ValVar_c)SubFct1;
      return (new ValVar_c(ValFct1.Value() * ValFct2.Value()));
      }
    }
  return (ProdFct);
} // CleanProd

//----------------------------CleanPower------------------------------//
Function_p CleanPower(Power_c PowerFct){
  if (PowerFct.Value() == 0)
    return (new Val_c(1));
  if (PowerFct.Value() == 1)
    return (PowerFct.SubFct());
  return (PowerFct);
} // CleanPower
