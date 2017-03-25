unit gULIB;

interface

uses controls,stdctrls,messages;

     procedure MakeRound(Control : TWinControl);
     procedure MakeRect(Control : TWinControl);
     function NumberIn(s : string;v : string = ''; w : integer = 200;h : integer = 60) : double;
     function NumberInModal(s : string;v : string = ''; w : integer = 200;h : integer = 60) : double;     
     function TextIn(s : string;v : string = ''; lc : TEditCharCase = ecNormal; w : integer = 350;h : integer = 60) : string;
     function MaskIn(s : string;v : string = ''; m : string = ''; w : integer = 350;h : integer = 60) : string;
     function MemoIn(s : string;v : string = ''; w : integer = 500;h : integer = 450) : string;
     function DateIn(s : string;v : string = ''; w : integer = 0; h : integer = 0) : TDate;
     function TimeIn(s : string;v : string = ''; w : integer = 200; h : integer = 60) : TTime;
const
     NO_TEMPS  : string = 'no és un temps vàlid.';
     NO_NOMBRE : string = 'no és un nombre.';

implementation

uses forms, sysutils, windows ,dialogs, extctrls, mcedit, mask, types, classes;

procedure MakeRound(control : TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
     with control do
     begin
     R := ClientRect;
     rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 7, 7);
     Perform(EM_GETRECT, 0, lParam(@r));
     InflateRect(r, 5, 5);
     Perform(EM_SETRECTNP, 0, lParam(@r));
     SetWindowRgn(Handle, rgn, True);
     end;
end;

procedure MakeRect(control : TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
     with control do
     begin
     R := ClientRect;
     rgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
     Perform(EM_GETRECT, 0, lParam(@r));
     InflateRect(r, 5, 5);
     Perform(EM_SETRECTNP, 0, lParam(@r));
     SetWindowRgn(Handle, rgn, True);
     end;
end;

function DateIn(s : string;v : string = ''; w : integer = 0;h : integer = 0) : TDate;
var
     f : TForm;
     e : TMCEdit;
     c : TButton;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.AutoSize := true;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TMCEdit.Create(f);
     e.Parent := f;
     e.AutoSize := true;
     e.AutoSize := false;
     e.Align := alClient;

     if v = ''
     then e.Date := date
     else e.Date := strtodate(v);

     c := TButton.Create(f);
     c.Parent := f;
     c.Width := 0;
     c.Height := 0;
     c.Cancel := true;
     c.ModalResult := mrCancel;

     result := 0;
     case f.ShowModal of
     mrOk :     result := e.Date;
     mrCancel : result := strtodate(v);
     end;

     f.Release;
end;

function NumberIn(s : string;v : string = ''; w : integer = 200;h : integer = 60) : double;
var
     f : TForm;
     e : TEdit;
     b,c : TButton;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TEdit.Create(f);
     e.Parent := f;
     e.Width  := f.ClientWidth - 10;
     e.Height := 19;
     e.Left := (f.ClientWidth - e.Width) div 2;
     e.Top  := (f.ClientHeight - e.Height) div 2;
     e.Ctl3D := false;
     e.Text := v;
     e.SelectAll;

     b := TButton.Create(f);
     b.Parent := f;
     b.Width := 0;
     b.Height := 0;
     b.Default := true;
     b.ModalResult := mrOk;

     c := TButton.Create(f);
     c.Parent := f;
     c.Width := 0;
     c.Height := 0;
     c.Cancel := true;
     c.ModalResult := mrCancel;

     result := 0;
     case f.ShowModal of
     mrOk : begin
                  e.Text := StringReplace(e.Text,',',DecimalSeparator,[]);
                  e.Text := StringReplace(e.Text,'.',DecimalSeparator,[]);
                  try result := strtofloat(e.Text);
                  except raise exception.Create(e.Text + ' ' + NO_NOMBRE);
                  end;
             end;
     mrCancel : try result := strtofloat(v) except result := 0; end;
     end;

     f.Release;
end;

function NumberInModal(s : string;v : string = ''; w : integer = 200;h : integer = 60) : double;
var
     f : TForm;
     e : TEdit;
     b,c : TButton;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TEdit.Create(f);
     e.Parent := f;
     e.Width  := f.ClientWidth - 10;
     e.Height := 19;
     e.Left := (f.ClientWidth - e.Width) div 2;
     e.Top  := (f.ClientHeight - e.Height) div 2;
     e.Ctl3D := false;
     e.Text := v;
     e.SelectAll;

     b := TButton.Create(f);
     b.Parent := f;
     b.Width := 0;
     b.Height := 0;
     b.Default := true;
     b.ModalResult := mrOk;

     c := TButton.Create(f);
     c.Parent := f;
     c.Width := 0;
     c.Height := 0;
     c.Cancel := true;
     c.ModalResult := mrCancel;

     result := 0;
     case f.ShowModal of
     mrOk : begin
                  e.Text := StringReplace(e.Text,',',DecimalSeparator,[]);
                  e.Text := StringReplace(e.Text,'.',DecimalSeparator,[]);
                  try result := strtofloat(e.Text);
                  except raise exception.Create(e.Text + ' ' + NO_NOMBRE);
                  end;
             end;
     mrCancel : result := -999999;
     end;

     f.Release;
end;

function TimeIn(s : string;v : string = ''; w : integer = 200;h : integer = 60) : TTime;
var
     f : TForm;
     e : TMaskEdit;
     b,c : TButton;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TMaskEdit.Create(f);
     e.Parent := f;
     e.Width  := f.ClientWidth - 10;
     e.Height := 19;
     e.Left := (f.ClientWidth - e.Width) div 2;
     e.Top  := (f.ClientHeight - e.Height) div 2;
     e.Ctl3D := false;
     e.EditMask := '!90:00;1;_';
     e.Text := v;
     e.SelectAll;

     b := TButton.Create(f);
     b.Parent := f;
     b.Width := 0;
     b.Height := 0;
     b.Default := true;
     b.ModalResult := mrOk;

     c := TButton.Create(f);
     c.Parent := f;
     c.Width := 0;
     c.Height := 0;
     c.Cancel := true;
     c.ModalResult := mrCancel;

     result := 0;
     case f.ShowModal of
     mrOk : begin
                  try result := strtotime(e.Text);
                  except raise exception.Create(e.Text + ' ' + NO_TEMPS);
                  end;
             end;
     mrCancel : try result := strtofloat(v) except result := 0; end;
     end;

     f.Release;
end;

function TextIn(s : string;v : string = ''; lc : TEditCharCase = ecNormal; w : integer = 350;h : integer = 60) : string;
var
     f : TForm;
     e : TEdit;
     b,c : TButton;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TEdit.Create(f);
     e.Parent := f;
     e.Width  := f.ClientWidth - 10;
     e.Height := 19;
     e.Left := (f.ClientWidth - e.Width) div 2;
     e.Top  := (f.ClientHeight - e.Height) div 2;
     e.Ctl3D := false;
     e.Text := v;
     e.SelectAll;
     e.CharCase := lc;

     b := TButton.Create(f);
     b.Parent := f;
     b.Width := 0;
     b.Height := 0;
     b.Default := true;
     b.ModalResult := mrOk;

     c := TButton.Create(f);
     c.Parent := f;
     c.Width := 0;
     c.Height := 0;
     c.Cancel := true;
     c.ModalResult := mrCancel;

     case f.ShowModal of
     mrOk     : result := trim(e.Text);
     mrCancel : result := v;
     end;

     f.Release;
end;

function MaskIn(s : string;v : string = ''; m : string = ''; w : integer = 350;h : integer = 60) : string;
var
     f : TForm;
     e : TMaskEdit;
     b,c : TButton;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TMaskEdit.Create(f);
     e.Parent := f;
     e.Width  := f.ClientWidth - 10;
     e.Height := 19;
     e.Left := (f.ClientWidth - e.Width) div 2;
     e.Top  := (f.ClientHeight - e.Height) div 2;
     e.Ctl3D := false;

     if m <> '' then e.EditMask := m;

     e.Text := v;
     e.SelectAll;

     b := TButton.Create(f);
     b.Parent := f;
     b.Width := 0;
     b.Height := 0;
     b.Default := true;
     b.ModalResult := mrOk;

     c := TButton.Create(f);
     c.Parent := f;
     c.Width := 0;
     c.Height := 0;
     c.Cancel := true;
     c.ModalResult := mrCancel;

     case f.ShowModal of
     mrOk     : result := e.Text;
     mrCancel : result := v;
     end;

     f.Release;
end;

function MemoIn(s : string;v : string = ''; w : integer = 500;h : integer = 450) : string;
var
     f : TForm;
     e : TMemo;
     b,c : TButton;
     p : TPanel;
begin
     f := TForm.Create(nil);
     f.Width := w;
     f.Height := h;
     f.FormStyle   := fsStayOnTop;
     f.BorderStyle := bsToolWindow;
     f.Position := poDesktopCenter;
     f.Caption := s;

     e := TMemo.Create(f);
     e.Parent := f;
     e.Ctl3D := false;
     e.BorderStyle := bsNone;
     e.align := alClient;
     e.Lines.Text := v;
     e.ScrollBars := ssVertical;
     e.SelectAll;

     p := TPanel.Create(f);
     p.Parent := f;
     p.Ctl3D := false;
     p.BevelOuter := bvNone;
     p.BorderStyle := bsNone;
     p.Caption := '';
     p.Height := 28;
     p.Color := $00FFFFFF;
     p.Align := alBottom;

     b := TButton.Create(f);
     b.Parent := p;
     b.Default := true;
     b.Left := p.ClientWidth - b.Width - 2;
     b.Top := p.ClientHeight - b.Height - 2;
     b.caption := '&Ok';
     b.ModalResult := mrOk;

     c := TButton.Create(f);
     c.Parent := p;
     c.Cancel := true;
     c.ModalResult := mrCancel;
     c.Left := b.Left - 2 - c.Width;
     c.Top  := b.Top;
     c.Caption := '&Cancel·lar';

     result := v;
     case f.ShowModal of
     mrOk     : result := trim(e.Text);
     mrCancel : result := v;
     end;

     f.Release;
end;

end.
