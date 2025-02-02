abstract class Function_p{
  Function_p(){}
  abstract Function_p Derivate();
  abstract void Print();
}

//--------------------------------Val_c-----------------------------------//
class Val_c extends Function_p{

  private int m_Value;
  
  Val_c(int value){
    super();
    this.m_Value = value;
  }
  
  void Print(){
    print(this.m_Value);
  }
  
  Function_p Derivate(){
    return (null);
  }
  
  int Value(){
    return (this.m_Value);
  }

} // Val_c

//--------------------------------Var_c-----------------------------------//
class Var_c extends Function_p{
  
  Var_c(){
    super();
  }
  
  void Print(){
    print("x");
  }
  
  Function_p Derivate(){
    return (new Val_c(1));
  }

} // Var_c

//--------------------------------ValVar_c-----------------------------------//
class ValVar_c extends Function_p{
  
  int m_Value;
  
  ValVar_c(int value){
    super();
    this.m_Value = value;
  }
  
  void Print(){
    print(this.m_Value + "x");
  }
  
  Function_p Derivate(){
    return (new Val_c(this.m_Value));
  }
    
  int Value(){
    return (this.m_Value);
  }

} // ValVar_c

abstract class TwoMemberFct_p extends Function_p{
  protected Function_p m_SubFct1 = null;
  protected Function_p m_SubFct2 = null;
  
  TwoMemberFct_p(Function_p SubFct1, Function_p SubFct2){
    super();
    this.m_SubFct1 = SubFct1;
    this.m_SubFct2 = SubFct2;
  }
  
  Function_p SubFct1(){
    return (this.m_SubFct1);
  }
  
  Function_p SubFct2(){
    return (this.m_SubFct2);
  }
}

//--------------------------------Sum_c-----------------------------------//
class Sum_c extends TwoMemberFct_p{
  
  Sum_c(Function_p SubFct1, Function_p SubFct2){
    super(SubFct1, SubFct2);
  }
  
  void Print(){
    print("(");
    this.m_SubFct1.Print();
    print(" + ");
    this.m_SubFct2.Print();
    print(")");
  }
  
  Function_p Derivate(){
    return (Clean(new Sum_c(this.m_SubFct1.Derivate(), this.m_SubFct2.Derivate())));
  }

} // Sum_c

//--------------------------------Prod_c-----------------------------------//
class Prod_c extends TwoMemberFct_p{
  
  Prod_c(Function_p SubFct1, Function_p SubFct2){
    super(SubFct1, SubFct2);
    if (SubFct2 instanceof Val_c)
      {
      Function_p fct2 = m_SubFct2;
      this.m_SubFct2 = this.m_SubFct1;
      this.m_SubFct1 = fct2;
      }
  }
  
  void Print(){
    print("(");
    this.m_SubFct1.Print();
    print(" * ");
    this.m_SubFct2.Print();
    print(")");
  }
  
  Function_p Derivate(){
    if (this.m_SubFct1 == null || this.m_SubFct2 == null)
      return (null);
    return (Clean(new Sum_c(Clean(new Prod_c(this.m_SubFct1.Derivate(), this.m_SubFct2)),  Clean(new Prod_c(this.m_SubFct1, this.m_SubFct2.Derivate())))));
  }

} // Prod_c

//--------------------------------Power_c-----------------------------------//
class Power_c extends Function_p{
  
  int m_Value;
  Function_p m_SubFct = null;
  
  Power_c(Function_p SubFct, int value){
    super();
    this.m_Value = value;
    this.m_SubFct = SubFct;
  }
  
  int Value(){
    return (this.m_Value);
  }
  
  Function_p SubFct(){
    return (this.m_SubFct);
  }
  
  void Print(){
    print("(");
    this.m_SubFct.Print();
    print(" ^ " + this.m_Value + ")");
  }
  
  Function_p Derivate(){
    if (this.m_SubFct == null)
      return null;
    return (Clean(new Prod_c(Clean(new Prod_c(new Val_c(this.m_Value), this.m_SubFct.Derivate())), Clean(new Power_c(this.m_SubFct, this.m_Value - 1)))));
  }

} // Power_c
