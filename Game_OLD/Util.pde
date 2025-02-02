import java.util.Objects;

// This class implements a pair of values that can be of different types.
class UtilPair_c<X,Y>
   {

   private X m_First;
   private Y m_Second;

   // Constructor
   public UtilPair_c(final X First, final Y Second)
      {
      this.m_First = First;
      this.m_Second = Second;
      } // UtilPair_c()

   // This function overrides the equals function.
   // param: Rhs - an other object to test the equality.
   @Override
   public boolean equals(Object Rhs)
      {
      if (Rhs == null)
         return (false);
      if (Rhs == this)
         return (true);
      if (this.getClass() != Rhs.getClass())
         return (false);

      UtilPair_c RhsPair = (UtilPair_c)Rhs;
      return (this.m_First.equals(RhsPair.First()) && this.m_Second.equals(RhsPair.Second()));
      } // equals()

   // This function returns the first value of the pair.
   public X First()
      {
      return (this.m_First);
      } // First()

   // This function returns a hash for the current object.
   @Override
   public int hashCode()
      {
      return (Objects.hash(this.m_First, this.m_Second));
      } // hashCode()

   // This function returns the second value of the pair.
   public Y Second()
      {
      return (this.m_Second);
      } // Second()

   } // class UtilPair_c<X,Y>



public static boolean GetBoolProperty(final JSONArray PropJsonArray, final String PropertyName, final boolean DefaultValue)
   {
   for (int i = 0; i < PropJsonArray.size(); i++)
      {
      JSONObject PropJson = PropJsonArray.getJSONObject(i);
      if (PropJson.getString("name").equals(PropertyName) && PropJson.getString("type").equals("bool"))
         return (PropJson.getBoolean("value"));
      }
   return (DefaultValue);
   } // GetBoolProperty()

public static int GetIntProperty(final JSONArray PropJsonArray, final String PropertyName, final int DefaultValue)
   {
   for (int i = 0; i < PropJsonArray.size(); i++)
      {
      JSONObject PropJson = PropJsonArray.getJSONObject(i);
      if (PropJson.getString("name").equals(PropertyName) && PropJson.getString("type").equals("int"))
         return (PropJson.getInt("value"));
      }
   return (DefaultValue);
   } // GetIntProperty()

public static String GetStringProperty(final JSONArray PropJsonArray, final String PropertyName, final String DefaultValue)
   {
   for (int i = 0; i < PropJsonArray.size(); i++)
      {
      JSONObject PropJson = PropJsonArray.getJSONObject(i);
      if (PropJson.getString("name").equals(PropertyName) && PropJson.getString("type").equals("string"))
         return (PropJson.getString("value"));
      }
   return (DefaultValue);
   } // GetStringProperty()