// // This class represents a point in k dimensions.
// public interface MathPoint_i
//    {
//    // This function returns the dimension of the point.
//    public int Dimension();

//    // This function returns the value of the n-th axis. Start by index 0.
//    public float GetAxis(final int Axis);
//    } // interface MathPoint_i

// // This class implements the comparator function to sort points according to the n-th dimension.
// private class MathSortPoint_c implements Comparator<MathPoint_i> 
//    {
   
//    private int m_Axis;

//    public MathSortPoint_c(final int Axis)
//       {
//       this.m_Axis = Axis;
//       } // MathSortPoint_c()

//    // Used for sorting in ascending order of index.
//    public int compare(MathPoint_i Lhs, MathPoint_i Rhs) 
//       {
//       float Diff = Lhs.GetAxis(this.m_Axis) - Rhs.GetAxis(this.m_Axis);
//       return (Diff < 0 ? -1 : (Diff > 0 ? 1 : 0)); 
//       } // compare()
//    } // class MathSortPoint_c


// // This class represents a kd-tree.
// public class AlgoKdTree_c
//    {

//    // The depth of the tree.
//    private int m_Depth = int_NULL;
//    // The current point of the tree.
//    private MathPoint_i m_CurrentPoint = null;
//    // The left tree.
//    private AlgoKdTree_c m_LeftTree = null;
//    // The right tree.
//    private AlgoKdTree_c m_RightTree = null;
//    // The number of node in the tree.
//    private int m_NodeCount = 0;

//    // Constructor
//    // PointList should never be empty.
//    public AlgoKdTree_c(final int Dimension, final ArrayList<MathPoint_i> PointList)
//       {
//       this.m_Depth = 0;
//       this.m_NodeCount = PointList.size();
//       Initialize(PointList);
//       } // AlgoKdTree_c()

//    // Constructor
//    // PointList should never be empty.
//    public AlgoKdTree_c(final ArrayList<MathPoint_i> PointList, final int Depth)
//       {
//       this.m_Depth = Depth;
//       Initialize(PointList);
//       } // AlgoKdTree_c()

//    // This function initilizes the tree.
//    private void Initialize(final ArrayList<MathPoint_i> PointList)
//       {
//       if (PointList.size() == 1)
//          {
//          this.m_CurrentPoint = PointList.get(0);
//          return;
//          }

//       int Dimension = PointList.get(0).Dimension();
//       int Axis = this.m_Depth % Dimension;
//       Collections.sort(PointList, new MathSortPoint_c(Axis));

//       int MedianIndex = ceil(PointList.size() / 2);
//       this.m_CurrentPoint = PointList.get(MedianIndex);

//       // If the median is at index 0, there is no left tree.
//       if (MedianIndex > 0)
//          {
//          ArrayList<MathPoint_i> LeftList = new ArrayList<MathPoint_i>(PointList.subList(0 /*Included*/, MedianIndex /*Excluded*/));
//          this.m_LeftTree = new AlgoKdTree_c(LeftList, this.m_Depth + 1);
//          }

//       // If the median is at index PointList.size() - 1, there is no right tree.
//       if (MedianIndex < PointList.size() - 1)
//          {
//          ArrayList<MathPoint_i> RigtList = new ArrayList<MathPoint_i>(PointList.subList(MedianIndex + 1 /*Included*/, PointList.size() /*Excluded*/));
//          this.m_RightTree = new AlgoKdTree_c(RigtList, this.m_Depth + 1);
//          }
//       } // Initialize()

//    } // class AlgoKdTree_c

// // This class is used to build a kd-tree for rectangles.
// public class AlgoKdTreeForRect_c extends AlgoKdTree_c
//    {

//    public AlgoKdTreeForRect_c(final ArrayList<MathPoint_i> PointList)
//       {
//       super(PointList, 0 /*Depth*/);
//       } // AlgoKdTreeForRect_c()

//    public ArrayList<MathPoint_i> GetIntersetingRectangles(final MathPoint_i Query)
//       {
//       ArrayList<MathPoint_i> PointList = new ArrayList<MathPoint_i>();

//       if (/*Intersect current point*/)
//          PointList.add(m_CurrentPoint);

//       int Axis = this.m_Depth % 4;
//       if (Axis == 0)
//          {

//          }
//       else if (Axis == 1)
//          {}
//       else if (Axis == 2)
//          {}
//       else // Axis == 3
//          {}

//       return (PointList);
//       } // GetIntersetingRectangles()

//    } // class AlgoKdTreeForRect_c