

void setup(){
  
  CSRMatrix octa = new CSRMatrix(2048);
  
  String[] lines = loadStrings("octa.txt");
  
  String FullFile = "";
  for (String line : lines)
    FullFile += line;
    
  println(FullFile);  
  
  String[] lines2 = FullFile.split("$");
  
  println(lines2.length);
  
  
}
