
ArrayList<Food_c> FoodList = new ArrayList<Food_c>();
ArrayList<Water_c> WaterList = new ArrayList<Water_c>();

void setup()
{
size(1280,720);
background(255);

for (int i = 0; i < 100; i++)
  {
  FoodList.add(new Food_c(RandomizePos()));
  WaterList.add(new Water_c(RandomizePos()));
  }
}



void draw()
{
background(255);

for (Food_c Food : FoodList)
  Food.Show();
  
for (Water_c Water : WaterList)
  Water.Show();
}

PVector RandomizePos()
{
return (new PVector(random(20, width - 20), random(20, height - 20)));
}
