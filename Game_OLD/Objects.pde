import java.util.HashMap;

public enum MoveDir_ch
   {
   NORTH,
   SOUTH,
   EAST,
   WEST,
   NULL
   } // enum MoveDir_ch

// The component represents a movable object.
public class ObjMovableObject_p
   {

   protected PVector m_InWorldPosition = null;
   private int m_DefaultSpeed = 7;
   private PVector m_Speed = new PVector(m_DefaultSpeed, m_DefaultSpeed);
   private HashMap<MoveDir_ch,Boolean> m_DirectionHMap = null;
   private MathRect_c m_WorldBoundRect = null;
   protected MathRect_c m_HitBox = null;
   protected MoveDir_ch m_LastMoveDir;
   protected float m_MotionIdxFlt = 0.0;

   // Constructor
   public ObjMovableObject_p(final float x, final float y, final MathRect_c BoundRect, final MathRect_c HitBox)
      {
      this.m_HitBox = HitBox;
      this.m_WorldBoundRect = BoundRect;
      this.m_InWorldPosition = new PVector(x, y);
      this.m_DirectionHMap = new HashMap<MoveDir_ch,Boolean>()
         {
            {
            put(MoveDir_ch.NORTH, false);
            put(MoveDir_ch.SOUTH, false);
            put(MoveDir_ch.EAST, false);
            put(MoveDir_ch.WEST, false);
            }
         };
      this.m_LastMoveDir = MoveDir_ch.SOUTH;
      } // ObjMovableObject_p()

   // This function constrain the the position to the boundaries rectangle.
   private void Constrain()
      {
      this.m_WorldBoundRect.Constrain(this.m_InWorldPosition);
      } // Constrain()

   // This function moves the object with the object speed.
   public void Move()
      {
      this.m_Speed.set((this.m_DirectionHMap.get(MoveDir_ch.EAST) ?  m_DefaultSpeed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.WEST) ?  m_DefaultSpeed : 0),
                       (this.m_DirectionHMap.get(MoveDir_ch.SOUTH) ? m_DefaultSpeed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.NORTH) ? m_DefaultSpeed : 0));
      this.m_Speed.setMag(this.m_DefaultSpeed);
      this.m_InWorldPosition.add(this.m_Speed);
      Constrain();
      } // Move()

   // This function moves the object with the specified speed.
   public void Move(final int Speed)
      {
      this.m_Speed.set((this.m_DirectionHMap.get(MoveDir_ch.EAST) ?  Speed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.WEST) ?  Speed : 0),
                       (this.m_DirectionHMap.get(MoveDir_ch.SOUTH) ? Speed : 0) - (this.m_DirectionHMap.get(MoveDir_ch.NORTH) ? Speed : 0));
      this.m_Speed.setMag(Speed);
      this.m_InWorldPosition.add(this.m_Speed);
      Constrain();
      } // Move()

   // This function returns the move direction according to a key.
   private MoveDir_ch MoveDirFromKey(final int KeyCode)
      {
      if (KeyCode == UP || KeyCode == 'w' || KeyCode == 'W')
         return (MoveDir_ch.NORTH);
      else if (KeyCode == DOWN || KeyCode == 's' || KeyCode == 'S')
         return (MoveDir_ch.SOUTH);
      else if (KeyCode == LEFT || KeyCode == 'a' || KeyCode == 'A')
         return (MoveDir_ch.WEST);
      else if (KeyCode == RIGHT || KeyCode == 'd' || KeyCode == 'D')
         return (MoveDir_ch.EAST);
      return (MoveDir_ch.NULL);
      } // MoveDirFromKey

   // This function returns the position of the object.
   public PVector InWorldPosition()
      {
      return (this.m_InWorldPosition);
      } // PositionInWorld()

   // This function sets the value of a direction.
   public void SetDirection(final int KeyCode, final boolean Active)
      {
      MoveDir_ch MoveDir = MoveDirFromKey(KeyCode);
      this.m_DirectionHMap.replace(MoveDir, Active);
      if (!Active)
         {
         UpdateLastMoveDir(MoveDir);
         m_MotionIdxFlt = 0.0;
         }
      } // SetDirection

   // This function updates the last move direction of the object. To be used only when the object is not moving.
   public void UpdateLastMoveDir(final MoveDir_ch LastMoveDir)
      {
      this.m_LastMoveDir = LastMoveDir;
      } // UpdateLastMoveDir()

   // This function converts the perso in world position to the screen position for the X coordinate.
   public float WorldToScreenPositionX(final PVector ScreenPosition)
      {
      return (abs(this.m_InWorldPosition.x - ScreenPosition.x));
      } // WorldToScreenPositionX()

   // This function converts the perso in world position to the screen position for the Y coordinate.
   public float WorldToScreenPositionY(final PVector ScreenPosition)
      {
      return (abs(this.m_InWorldPosition.y - ScreenPosition.y));
      } // WorldToScreenPositionY()

   } // class ObjMovableObject_p


public class ObjMainCharacter_c extends ObjMovableObject_p
   {
   
   public ObjMainCharacter_c(final float x, final float y, final MathRect_c BoundRect, final MathRect_c HitBox)
      {
      super(x, y, BoundRect, HitBox);
      } // ObjMainCharacter_c()

   public void Display(final PVector ScreenPosition, final TileSetSprites_c Sprite)
      {
      fill (255, 0, 0);
      noStroke();

      int TileIndex = int_NULL;
      boolean IsMoving = false;
      for (Map.Entry<MoveDir_ch,Boolean> Entry : super.m_DirectionHMap.entrySet())
         {
         if (Entry.getValue())
            {
            TileIndex = Sprite.GetMotionTileIdx(Entry.getKey(), int(m_MotionIdxFlt) % Sprite.MotionCount());
            IsMoving = true;
            }
         }
      if (!IsMoving)
         TileIndex = Sprite.GetMotionLessTileIdx(super.m_LastMoveDir);

      image(Sprite.GetTileByGlobalIdx(TileIndex), super.WorldToScreenPositionX(ScreenPosition), super.WorldToScreenPositionY(ScreenPosition));
      m_MotionIdxFlt += 0.15;
      //rect(super.WorldToScreenPositionX(ScreenPosition), super.WorldToScreenPositionY(ScreenPosition), super.m_HitBox.Width(), super.m_HitBox.Height());
      } // Display()

   } // class ObjMainCharacter_c