unit HelpInfo;

interface

uses classes, graphics, controls, forms, extctrls, stdctrls, buttons;

type THKWinControl = class(TWinControl);
type THelpInfo = class(TComponent)
     private
          FColor : TColor;
          FFont  : TFont;
          FRectColor : TColor;
          FCaption : string;
     protected
          procedure SetFFont(f : TFont);
     public
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          procedure   Info(s : string;c : array of TControl;x : integer = 0; y : integer = 0);
     published
          property Color : TColor read FColor write FColor;
          property Font : TFont read FFont write SetFFont;
          property RectColor : TColor read FRectColor write FRectColor;
          property Caption : string read FCaption write FCaption;
end;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('pkULIB',[THelpInfo]);
end;

constructor THelpInfo.Create(AOwner : Tcomponent);
begin
     inherited Create(AOwner);

     FFont      := TFont.Create;
     FColor     := clBtnFace;
     FRectColor := clYellow;
     FCaption   := 'Info';
end;

destructor THelpInfo.Destroy;
begin
     if Assigned(FFont) then FFont.Free;

     inherited Destroy;
end;

procedure THelpInfo.SetFFont(f : TFont);
begin
     if f <> nil then FFont.Assign(f);
end;

procedure THelpInfo.Info(s : string;c : array of TControl;x : integer = 0; y : integer = 0);
     function GetForm(c : TControl): TForm;
     var
          o : TWinControl;
     begin
          o := c.Parent;
          while o.ClassType <> TForm do o := o.Parent;

          result := TForm(o);
     end;

     procedure CtrlRect(c : TControl;owner : TComponent);
     var
          i : TImage;
     begin
          i := TImage.Create(owner);
          i.Parent := c.Parent;

          i.Left   := c.Left - 10;
          i.Top    := c.Top  - 10;
          i.Width  := c.Width + 20;
          i.Height := c.Height + 20;

          i.Canvas.Brush.Color := clBlack;
          i.Canvas.FillRect(Rect(0,0,i.Width,i.Height));
          i.Canvas.Pen.Color := FRectColor;
          i.Canvas.Pen.Width := 10;
          i.Picture.Bitmap.TransParentColor := clBlack;
          i.Canvas.Rectangle(Rect(0,0,i.Width,i.Height));
          i.Transparent := true;
     end;
var
     f : TForm;
     m : TMemo;
     b : TButton;
     i : integer;
begin
     f := TForm.Create(nil);
     f.BorderStyle := bsToolWindow;
     f.Caption := FCaption;

     f.Font.Assign(FFont);
     f.Color := FColor;

     if (x = 0) and (y = 0)
     then f.Position := poDeskTopCenter
     else
     begin
          f.Left := x;
          f.Top  := y;
     end;

     b := TBitBtn.Create(f);
     b.Parent := f;
     b.Width  := 30;
     b.Height := 17;
     b.Caption := '>';
     THKWinControl(b).Color := clWhite;
     b.ModalResult := mrOk;
     b.Left   := f.ClientWidth - b.Width - 4;
     b.Top    := f.ClientHeight - b.Height - 2;

     m := TMemo.Create(f);
     m.Parent := f;
     m.Ctl3D := false;
     m.BorderStyle := bsSingle;
     m.ReadOnly := true;
     m.Align := alClient;
     m.Lines.Text := s;
     m.ParentFont := true;
     m.Color := FColor;
     b.BringToFront;

     for i := 0 to Length(c) - 1 do
     CtrlRect(c[i],f);
     f.ShowModal;

     f.free;
end;


end.
