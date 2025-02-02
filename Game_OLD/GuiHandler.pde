// This class handles the Gui menus.
public class GuiMenuHandler_c
   {
   // The list of menus the GuiHandler has to handle.
   private ArrayList<GuiMenu_c> m_MenuList;

   // Constructor.
   public GuiMenuHandler_c()
      {
      this.m_MenuList = new ArrayList<GuiMenu_c>();
      } // GuiMenuHandler_c

   // Adds a menu to the list of menus.
   public void AddMenu(GuiMenu_c Menu)
      {
      this.m_MenuList.add(Menu);
      } // AddMenu()

   // Display the menus that need to be displayed.
   public void Display()
      {
      for (GuiMenu_c Menu : this.m_MenuList)
         {
         if (Menu.IsDisplayed()) // Should be displayed in order. Maybe constructed in the same order ???
            Menu.Display();
         }
      } // Display()

   // Called when the mouse is pressed. It calls the MousePressed on the active menu the mouse is over.
   public void MousePressed()
      {
      for (GuiMenu_c Menu : this.m_MenuList)
         {
         if (Menu.IsDisplayed() && Menu.IsActive() && Menu.IsMouseOver())
            Menu.MousePressed();
         }
      } // MousePressed()

   } // class GuiMenuHandler_c

// This class represents a Gui menu.
public class GuiMenu_c
   {
   // The background color.
   private color m_BackgroundColor = color(0, 0, 0);
   // The list of buttons of the menu.
   private ArrayList<GuiImageButton_c> m_ButtonList;
   // Indicates whether the menu is active or not.
   private boolean m_IsActive;
   // Indicates whether the menu is displayed or not.
   private boolean m_IsDisplayed;
   // The rectangle in which the menu wil be displayed.
   private MathRect_c m_MenuRect;

   // Constructor.
   public GuiMenu_c(final MathRect_c MenuRect)
      {
      this.m_ButtonList = new ArrayList<GuiImageButton_c>();
      this.m_MenuRect = MenuRect;
      this.m_IsActive = false;
      this.m_IsDisplayed = false;
      } // GuiMenu_c()

   // Adds a button to the menu.
   public void AddButton(GuiImageButton_c Button)
      {
      this.m_ButtonList.add(Button);
      } // AddButton()

   // Displays the menu.
   public void Display()
      {
      if (!this.m_IsDisplayed)
         return;

      fill(this.m_BackgroundColor);
      rect(this.m_MenuRect.OriginX(), this.m_MenuRect.OriginY(), this.m_MenuRect.Width(), this.m_MenuRect.Height());

      final boolean IsOver = this.IsMouseOver();
      for (GuiImageButton_c Button : this.m_ButtonList)
         Button.Display(IsOver, this.m_IsActive);
      } // Display()

   // This function hides the menu (active = false and displayed = false)
   public void Hide()
      {
      SetIsActive(false);
      SetIsDisplayed(false);
      } // Hide()

   // Indicates whether the menu is active or not. A menu can be displayed but inactive because an other menu is displayed above it.
   public boolean IsActive()
      {
      return (this.m_IsActive);
      } // IsActive()

   // Indicates whether a menu is displayed or not.
   public boolean IsDisplayed()
      {
      return (this.m_IsDisplayed);
      } // IsDisplayed()

   // Indicates whether the mouse is over the menu or not.
   public boolean IsMouseOver()
      {
      return (this.m_MenuRect.IsPointInside(mouseX, mouseY));
      } // IsMouseOver()

   // Returns the menu rectangle
   public MathRect_c MenuRect()
      {
      return (this.m_MenuRect);
      } // MenuRect()

   // Called when the mouse is pressed over the active and displayed menu.
   public void MousePressed()
      {
      if (!this.m_IsDisplayed || !this.m_IsActive)
         return;

      for (GuiImageButton_c Button : this.m_ButtonList)
         {
         if (Button.IsMouseOver())
            {
            Button.MousePressed();
            break; // The mouse cannot be over more than one button.
            }
         }
      } // MousePressed()

   // Sets the background color.
   public void SetBackgroundColor(final color BackgroundColor)
      {
      this.m_BackgroundColor = BackgroundColor;
      } // SetBackgroundColor()

   // Sets whether the menu is active or not.
   public void SetIsActive(final boolean IsActive)
      {
      this.m_IsActive = IsActive;
      } // SetIsActive()

   // Sets whether the button is displayed or not.
   public void SetIsDisplayed(final boolean IsDisplayed)
      {
      this.m_IsDisplayed = IsDisplayed;
      } // SetIsDisplayed()

   // This function shows the menu (active = true and displayed = true)
   public void Show()
      {
      SetIsActive(true);
      SetIsDisplayed(true);
      } // Show()
   } // class GuiMenu_c

// This class represents a generic button.
public class GuiImageButton_c
   {
   // The rectangle of the button.
   private MathRect_c m_ButtonRect = null;
   // The menu on which is the button.
   private GuiMenu_c m_Menu = null;
   // The image of the button.
   private PImage m_Image = null;
   // The image file name.
   private String m_ImageFileName = "";

   private GuiMenu_c m_MenuToHide = null;
   private GuiMenu_c m_MenuToShow = null;

   // Constructor.
   public GuiImageButton_c(final String ImagePath, GuiMenu_c Menu, final PVector Offset)
      {
      this.m_ImageFileName = ImagePath;
      this.m_Image = loadImage(ImagePath);
      this.m_Menu = Menu;
      this.m_ButtonRect = new MathRect_c(this.m_Menu.MenuRect().OriginX() + Offset.x, this.m_Menu.MenuRect().OriginY() + Offset.y, this.m_Image.width, this.m_Image.height);
      } // GuiImageButton_c()

   // Displays the button.
   public void Display(final boolean IsMousePossiblyOver, final boolean IsActive)
      {
      if (IsActive && IsMousePossiblyOver && this.IsMouseOver())
         tint(255, GUI_MOUSE_OVER_BUTTON_ALPHA);
      image(this.m_Image, this.m_ButtonRect.OriginX(), this.m_ButtonRect.OriginY());
      noTint();
      } // Display()

   // Indicates whether the mouse is over the button or not.
   public boolean IsMouseOver()
      {
      return (this.m_ButtonRect.IsPointInside(mouseX, mouseY));
      } // IsMouseOver()

   // Called when the mouse is pressed over the button.
   public void MousePressed()
      {
      if (this.m_MenuToHide != null)
         this.m_MenuToHide.Hide();
      if (this.m_MenuToShow != null)
         this.m_MenuToShow.Show();
      } // MousePressed()

   // This function sets the menu to hide (active = false and displayed = false) when the button is pressed.
   public void SetMenuToHide(final GuiMenu_c MenuToHide)
      {
      this.m_MenuToHide = MenuToHide;
      } // SetMenuToHide()

   // This function sets the menu to show (active = true and displayed = true) when the button is pressed.
   public void SetMenuToShow(final GuiMenu_c MenuToShow)
      {
      this.m_MenuToShow = MenuToShow;
      } // SetMenuToShow()
   } // class GuiImageButton_c