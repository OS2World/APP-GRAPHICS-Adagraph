-- 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
-- �    View Adagraph.mov file in PM OS/2                          �
-- �                                                               �
-- �  Author: Leonid Dulman                                        �
-- �                                                               �
-- �   Adagraph - graphic extension Ada 95 ( GNAT 3.05) OS/2       �
-- �             1996                                              �
-- 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�

with Os2; Use Os2;
with Os2.pmcp; Use Os2.pmcp;
with Win;
with GPI;
with Ada.direct_io;
with Text_Io;
with builtin; use builtin;

procedure bantview is
  print:text_io.file_type;
  Hab            : Win.Anchor_Block_Handle_Type;
  Queue          : Win.Queue_Handle_Type;
  Queue_Message  : Win.Queue_Message_Pointer_Type;
  Button_Pressed : Win.MB_Response_Type;
  Frame_Cf       : Win.Frame_Control_Flags_Type;
  New_Win        : PHWND;
  Pop_Up_Menu    : HWND := Win.Null_Window;
  Frame_Win      : HWND;
  Window_Style   : Win.Class_Styles_Type := (others => False);
  Key_Info       : Win.Key_Press_Info_Type;
  Point          : Win.Point_Type := (10, 350);
  Added          : Boolean := False;
  Id_Window      : constant Win.Id_Type         := 200;
  Id_Pop_Up      : constant Win.Id_Type         := 201;
  Id_Draw        : constant Win.Command_Id_Type := 300;
  Id_Lines       : constant Win.Command_Id_Type := 301;
  Id_Arcs        : constant Win.Command_Id_Type := 302;
  Id_Rectangles  : constant Win.Command_Id_Type := 303;
  Id_Clear       : constant Win.Command_Id_Type := 304;
  Id_Added       : constant Win.Command_Id_Type := 310;
  Start_Point    : Os2.Pointl :=(x=>0,y=>0);
  End_Point      : Os2.Pointl :=(x=>0,y=>0);
  Empty_Str  : String (1 .. 1) := " ";
--  Run_Pgm    : String (1 .. 22) := "c:\pm_binding\menu.exe";
  Launch     : Boolean := False;
  cons,acadfile:text_io.file_type;
  type mov_out is array(1..20) of float;
  package dirmv is new Ada.direct_io(mov_out); use dirmv;
  fi:string(1..12):=(others=>' ');
  movfile:dirmv.file_type;
  buffer  :mov_out;
  position:integer        :=21;
  x,y,z,xl,yl:float;
  motor:integer            :=0;
  npen :integer            :=1;
  nmf:varing;
  l:natural ;

  ------------------------------------------------------------------
   procedure Draw_Arcs (Window : HWND) is
      Ps           : Win.Ps_Type;
     begin

       Ps := Win.Get_Ps (Window);

       GPI.Set_Background_Mix (Ps, GPI.Bm_Overpaint);
       GPI.Set_Background_Color (Ps, GPI.Clr_Background);
       GPI.Set_Color (Ps, GPI.Clr_Blue);
       GPI.Char_String_At (
                              Ps    => Ps,
                              Point => (400, 350),
                              Text  => "Arcs");

            --A Circle
       GPI.Set_Color (Ps, GPI.Clr_White);
       Gpi.Full_Arc (
                 Ps            => Ps,
                 Center        => (420, 75),
                 Arc_Params    => (1, 1, 0, 0),
                 Outline_Style => Gpi.Dro_Outline,
                 Multiplier    => 50);

            --A Width Ellipse
       GPI.Set_Color (Ps, GPI.Clr_Brown);
       Gpi.Full_Arc (
                 Ps            => Ps,
                 Center        => (420, 200),
                 Arc_Params    => (1, 2, 0, 0),
                 Outline_Style => Gpi.Dro_Fill,
                 Multiplier    => 25);

            --A Tall Ellipse
       GPI.Set_Color (Ps, GPI.Clr_Yellow);
       Gpi.Full_Arc (
                 Ps            => Ps,
                 Center        => (420, 305),
                 Arc_Params    => (2, 1, 0, 0),
                 Outline_Style => Gpi.Dro_Outline_Fill,
                 Multiplier    => 25);

       Win.Release_Ps (Ps);
    end Draw_Arcs;

  ------------------------------------------------------------------

    procedure Draw_Rectangles (Window : in HWND) is
        Ps           : Win.Ps_Type;
      begin

        Ps := Win.Get_Ps (Window);

        GPI.Set_Background_Mix (Ps, GPI.Bm_Overpaint);
        GPI.Set_Background_Color (Ps, GPI.Clr_Background);
        GPI.Set_Color (Ps, GPI.Clr_Blue);
        GPI.Char_String_At (
                              Ps    => Ps,
                              Point => (200, 350),
                              Text  => "Rectangles");

        GPI.Set_Color (Ps, GPI.Clr_Red);
        Gpi.Box (Ps            => Ps,
                    Start_Corner    => (200, 50),
                    End_Corner      => (300, 125),
                    Outline_Style   => Gpi.Dro_Fill,
                    Horz_Rounding   => 0,
                    Vert_Rounding   => 0);

        GPI.Set_Color (Ps, GPI.Clr_Blue);
        Gpi.Box (Ps            => Ps,
                    Start_Corner  => (200, 175),
                    End_Corner    => (300, 250),
                    Outline_Style => Gpi.Dro_Outline,
                    Horz_Rounding => 10,
                    Vert_Rounding => 10);

        GPI.Set_Color (Ps, GPI.Clr_Dark_Green);
        Gpi.Box (Ps            => Ps,
                    Start_Corner  => (200, 265),
                    End_Corner    => (300, 340),
                    Outline_Style => Gpi.Dro_Outline_Fill,
                    Horz_Rounding => 30,
                    Vert_Rounding => 30);
        Win.Release_Ps (Ps);
   end Draw_Rectangles;

----------------------------------------------------------
function X_pixel(x:float) return Long is -- absolute coordinate to Pixel
pos: integer;
ret: long;
begin
pos:=Integer(20.0 + 600.0 * abs(x) / xl) ;
ret:= long(pos);
return ret;
end X_pixel;
----------------------------------------------------------
function Y_pixel(y:float) return Long is -- absolute coordinate to Pixel
pos: integer;
ret: long;
begin
pos:=Integer(20.0 + 430.0 * y / yl) ;
ret:= long(pos);
return ret;
end Y_pixel;
----------------------------------------------------------
function rd return float   is
x:float;
begin
motor:=motor+1;
if position=21 then read(movfile,buffer); position:=1;   end if;
x:=buffer(position); position:=position+1;
return x;
end rd;
---------------------------------------------------------------------

   procedure Draw_Lines (Window : in HWND) is
        Ps           : Win.Ps_Type;
        xb,yb,xe,ye  : string(1..8);
       use Win;
     begin

       Ps := Win.Get_Ps (Window);

       GPI.Set_Background_Mix (Ps, GPI.Bm_Overpaint);
       GPI.Set_Background_Color (Ps, GPI.Clr_Background);
       GPI.Set_Color (Ps, GPI.Clr_Blue);

       xl:=rd; yl:=rd;  -- get page size
       xe:=put_f(xl,8); ye:=put_f(yl,8);

       GPI.Char_String_At (
                           Ps    => Ps,
                           Point => (60, 350),
                           Text  => "Page x=" & xe & " y=" & ye);

       for j in 1..integer'last loop
          z:=rd; -- read next coordinate
          exit when z>9998.1  and z<9999.9; -- end file *.mov
          if z>=10000.0 then   -- new pen
             npen:=integer(z-10000.0);
             GPI.Set_Color (Ps, Long(npen));
             goto next;  -- not draw line
         end if;
         x:=z; z:=rd; y:=abs(z);
         if x<0.0 then  -- Start coordinate
            xb:=put_f(x,8); yb:=put_f(y,8);
            Start_Point.x := X_Pixel(x);
            Start_Point.y := Y_Pixel(y);
                  else
            xe:=put_f(x,8); ye:=put_f(y,8);
            End_Point.x := X_Pixel  (x) ;
            End_Point.y := Y_Pixel  (y);

            GPI.Char_String_At (
                               Ps    => Ps,
                               Point => (60, 330),
                               Text  => "Start  x=" & xb & " y=" & yb);

            GPI.Char_String_At (
                               Ps    => Ps,
                               Point => (60 ,310),
                               Text  => "End  x=" & xe & " y=" & ye);

            GPI.Line (Ps          => Ps,
                      Start_Point => Start_Point,
                      End_Point   => End_Point) ;
            Start_Point := End_Point;
        end if;

       <<next>> null; end loop;
       <<fin>> close(movfile);
       Win.Release_Ps (Ps);
   end Draw_Lines;
  ------------------------------------------------------------------

    procedure Check_Menu_Item (Item_Id    : in Win.Command_ID_Type;
                               By_Pointer : in Boolean) is

      Menu_Window    : HWND := Win.Null_Window;
      Result         : Boolean;
      Menu_Data      : Win.Menu_Item_Type;
      Submenu_Window : HWND := Win.Null_Window;

    begin

      Menu_Window := Win.Window_From_Id (Frame_Win, Win.Fid_Menu);

      Result      := Win.Check_Menu_Item (
                       Menu    => Menu_Window,
                       Item_Id => Item_Id,
                       Check   => By_Pointer);
      Result      := Win.Enable_Menu_Item (
                       Menu    => Menu_Window,
                       Item_Id => Item_Id,
                       Enable   => By_Pointer);

      Menu_Data := Win.Query_Menu_Item (
                     Menu    => Menu_Window,
                     Item_Id => ID_Draw);

      Text_Io.Put ("Position   => ");
      Text_io.Put_Line (Win.Menu_Position_Type'Image (Menu_Data.Position));
      Text_Io.Put ("Style      => ");
      Text_Io.Put_Line (Win.Menu_Style_Type'Image (Menu_Data.Style));
      Text_Io.Put_Line ("Attributes:");
      for I in Menu_Data.Attributes'range loop
        if Menu_Data.Attributes (I) then
          Text_Io.Put ("  ");
          Text_Io.Put_Line (Win.Menu_Attribute_Type'Image (I));
        end if;
      end loop;
      Text_Io.Put ("Item Id    => ");
      Text_Io.Put_Line (Win.Command_Id_Type'Image (Menu_Data.Item_Id));

      if Added then
         null;
         Win.Delete_Menu_Item (
             Menu    => Menu_Window,
             Item_Id => Id_Added);
         Added := False;
      else
         Submenu_Window        := Menu_Data.Sub_Menu;
         Menu_Data.Style       := Win.Mis_Text;
         Menu_Data.Sub_Menu    := Win.Null_Window;
         Menu_Data.Item_Id     := Id_Added;
         Menu_Data.Position    := 2;
         Menu_data.Item_Handle := Win.Null_Bitmap;
         Menu_Data.Attributes := (others => False);

         Win.Insert_Menu_Item (
              Menu      => Submenu_Window,
              Menu_Data => Menu_Data,
              Text      => "Added Menu Item");
         Added := True;
      end if;

    end Check_Menu_Item;

  ------------------------------------------------------------------

    procedure Erase_Screen (Window : in HWND) is
        Ps : Win.Ps_Type;
     begin

       Ps := Win.Get_Ps (Window);
       Gpi.Erase (Ps);
       Win.Release_Ps (Ps);

       Check_Menu_Item (Id_Lines, False);
       Check_Menu_Item (Id_Arcs, False);
       Check_Menu_Item (Id_Rectangles, False);

     end Erase_Screen;

  ------------------------------------------------------------------

   procedure Process_Menu (Command_Id : in Win.Command_Id_Type;
                           For_Window : in HWND;
                           By_Pointer : in Boolean) is
     begin

       case Command_Id is

         when Id_Lines      => Draw_Lines (For_Window);
--                               Check_Menu_Item (Id_Lines, By_Pointer);
                                 Launch := True;

         when Id_Arcs       => Draw_Arcs  (For_Window);
                               Check_Menu_Item (Id_Arcs, By_Pointer);

         when Id_Rectangles => Draw_Rectangles (For_Window);
                               Check_Menu_Item (Id_Rectangles, By_Pointer);

         when Id_Clear      => Erase_Screen (For_Window);

         when others        => null;
       end case;

     end Process_Menu;

  ------------------------------------------------------------------

  function Win_Test_Handler (Window  : HWND;
                             Message : Win.Message_Type;
                             MP1     : Win.Parameter_Type;
                             MP2     : Win.Parameter_Type)
                                           return ULong is
    Result       : Boolean;
    Ps           : Win.Ps_Type;

    Str          : String (1 .. 1);

    Command_Info : Win.Command_Info_Type;

    Point        : Win.Point_Type;
    Options      : Win.Pop_Up_Options_Type;

    use Win;
   begin

     case Message is

      when Win.Wm_Button_1_Down =>

           Ps := Win.Get_Ps (Window);
           GPI.Set_Background_Mix (Ps, GPI.Bm_Overpaint);
           GPI.Set_Background_Color (Ps, GPI.Clr_Pale_Gray);
           GPI.Set_Color (Ps, GPI.Clr_Blue);
           GPI.Char_String_At (
                              Ps    => Ps,
                              Point => Win.Pointer_Is (MP1),
                              Text  => "Hello from GNAT");
           Win.Release_Ps (Ps);

           return 1;

      when Win.Wm_Button_2_Down =>

            if Win.Is_Null (Pop_Up_Menu) then
               Pop_Up_Menu := Win.Load_Menu (
                               Owner_Window => Window,
                               Resource     => 0   ,
                               Menu_Id      => ID_Pop_Up);
            end if;

            if Win.Is_Null (Pop_Up_Menu) then
               Text_io.Put_Line ("Pop menu does not exist");
            else

               Options := (others => False);
               Options (Win.Pu_Position_On_Item) := True;
               Options (Win.Pu_Mouse_Button_1)   := True;
               Options (Win.Pu_Keyboard)         := True;

               Point   := Win.Pointer_Is (MP1);

               Result := Win.Pop_Up_Menu (
                     Window       => Window,
                     Frame_Window => Frame_Win,
                     Menu_Window  => Pop_Up_Menu,
                     X            => Point.X,
                     Y            => Point.Y,
                     Item_Id      => Id_Arcs,
                     Options      => Options);

               if Result then
                  Text_Io.Put_Line ("It should have worked");
               else
                  Text_Io.Put_Line ("It Failed");
               end if;

            end if;

            return 1;

      when Win.Wm_Char =>
           Key_Info := Win.Key_Info_Is (Mp1, Mp2);

           if (Key_Info.Flags (Win.Kc_Char) and then
               not Key_Info.Flags (Win.Kc_Virtual_Key)) or else
                (Key_Info.Flags (Win.Kc_Virtual_Key) and then
                   Key_Info.Virtual_Key = Win.Vk_Space and then
                    not Key_Info.Flags (Win.Kc_Key_Up)) then

             Str (1) := Character'Val (Integer (Key_Info.Character_Code));

             Ps := Win.Get_Ps (Window);

             GPI.Set_Background_Mix (Ps, GPI.Bm_Overpaint);
             GPI.Set_Background_Color (Ps, GPI.Clr_Background);
             GPI.Char_String_At (
                              Ps    => Ps,
                              Point => Point,
                              Text  => Str);
             Win.Release_Ps (Ps);

             Point.X := Point.X + 11;

             if Point.X > 200 then
                Point.X := 10;
                Point.Y := Point.Y - 18;
             end if;

           elsif key_Info.Flags (Win.Kc_Virtual_Key) and then
                 not Key_Info.Flags (Win.Kc_Key_Up) then
             null;
           end if;

           return Win.Default_Window_Procedure (Window, Message, Mp1, Mp2);

      when Win.Wm_Command =>

         Command_Info := Win.Command_Info_Is (Mp1, Mp2);

         case Command_Info.Source is

           when Win.Cmd_Src_Menu =>
             Process_Menu (Command_Info.Id, Window, Command_Info.By_Pointer);

           when Win.Cmd_Src_Accelerator =>
             Process_Menu (Command_Info.Id, Window, Command_Info.By_Pointer);

           when others => null;
         end case;


         return 1;

      when Win.Wm_Erase_Background =>
           return 1;

      when Win.Wm_Close =>
        Result := Win.Post_Message (Window, Win.Wm_Quit, 0, 0);

      when others =>
            return Win.Default_Window_Procedure (Window, Message, Mp1, Mp2);
     end case;

     return 0;

   end Win_Test_Handler;

  ------------------------------------------------------------------

   procedure Show_Error (Message : String) is
     begin
       Button_Pressed := Win.Message_Box (
                        Parent_Window  => Win.Desktop_Window,
                        Request_Owner  => Win.Null_Window,
                        Message        => Message,
                        Title          => " Error ",
                        Help_Id        => 1,
                        Buttons        => Win.MB_Ok,
                        Icons          => Win.Mb_Icon_Hand,
                        Default_Action => Win.Mb_Default_On_Button_1);
     end Show_Error;
  ------------------------------------------------------------------
  begin

    overlay(fi,1,"adagraph.mov"); l:=12;
    dirmv.open (file=>movfile,name =>fi,mode => in_file);
    text_io.create(file=>print,name=>"bantview.prn",mode=>text_io.out_file);
    text_io.set_output(print);
    New_Win       := new HWND;
    Queue_Message := new Win.Queue_Message_Type;

    Win.Initialize (Win.System_Default, Hab);

    Win.Create_Message_Queue (Hab, Win.System_Default, Queue);

    Window_Style (Win.Cs_Size_Redraw) := True;

    Win.Register_Class (
                        Anchor_Block    => Hab,
                        Class_Name      => "My_Window_Class",
                        Message_Handler => Win_Test_Handler'address, -- access
                        Class_Style     => Window_Style,
                        Extra_Storage   => 0);

    Frame_CF :=
       (Win.Fcf_Title_Bar     => True,
        Win.Fcf_System_Menu   => True,
        Win.Fcf_Min_Max       => True,
        Win.Fcf_Sizing_Border => True,
        Win.Fcf_Task_List     => True,
        Win.Fcf_Menu          => True,
        Win.Fcf_Accel_Table   => True,
        others                => False);

    Frame_Win := Win.Create_Standard_Window (
             Parent_Window       => Win.Desktop_Window,
             Window_Styles       => Win.Use_Class_Styles,
             Frame_Control_Flags => Frame_CF,
             Class_Name          => "My_Window_Class",
             Window_Title        => "Select Image for view Adagraph.mov",
             Class_Style         => Window_Style,
             Resource            => 0   ,   -- Null
             Resource_ID         => 200,
             New_Window          => New_Win);

    if Win.Is_Null (Frame_Win) then
       Show_Error ("The window was not created");
       text_io.new_line; put_edit(" Error Create Window ",
       integer(WinGetLastError(Win.Desktop_Window))); goto fin;
    else

       Win.Set_Window_Position (
               Window           => Frame_Win,
               Behind_Window    => Win.Top_Window,
               X                => 20,
               Y                => 20,
               Width            => 600,
               Height           => 430,
               Position_Options => Win.Show_Window);

       loop

          exit when not Win.Get_Message
                         (Hab, Queue_Message, Win.Null_Window, 0, 0);


          Win.Dispatch_Message (Hab, Queue_Message);

       end loop;

    end if;
 <<fin>>
    Win.Destroy_Message_Queue (Queue);
    Win.Terminate_App (Hab);

  end bantview;
