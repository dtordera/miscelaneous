unit UDBGlobal;

interface

uses stdctrls, classes, controls, sysutils, typinfo, graphics, dialogs;

type THKPersistent = class(TPersistent);

function  GetObject(c : TObject; s : string): TObject;
function  GetMethod(c : TObject; s : string) : TMethod;
procedure ExecMethod(c : TObject; s : string; sender : TObject);
function  NegLumColor(c : TColor; dark : Tcolor = clGray; light : TColor = clWhite) : TColor;
function  DifLum(c1,c2 : TColor) : integer;
function  mDlg(s : string; t : TMsgDlgType; b : TMsgDlgButtons) : TModalResult;

implementation

function mDlg(s : string; t : TMsgDlgType; b : TMsgDlgButtons) : TModalResult;
var
     o : TButton;
begin
     with CreateMessageDialog(s,t,b) do
     begin
          o := FindComponent('Yes') as TButton;

          if Assigned(o) then o.Caption := '&Sí';

          o := FindComponent('Cancel') as TButton;
          if Assigned(o) then o.Caption := '&Cancelar';

          result := ShowModal;
     end;
end;

function Lum(c : TColor) : integer;
var
     r,g,b : integer;
begin
     r := (c mod $0100);
     g := (c mod $010000) div $0100;
     b := (c div $010000);

     result := (r+g+b) div 3;
end;

function DifLum(c1,c2 : TColor) : integer;
begin
     result := Lum(c1) - Lum(c2);

     if result < 0 then result := -result;
end;

function NegLumColor(c : TColor; dark : Tcolor = clGray; light : TColor = clWhite) : TColor;
begin
     if Lum(c) < 150 then result := Light else result := Dark;
end;

function GetObject(c : TObject; s : string): TObject;
var
     n : integer;
begin
     s := trim(s);
     n := Pos('.',s);
     result := nil;

     if s = '' then result := c;
     if c = nil then c := THKPersistent(c).GetOwner;

     if n <> 0 then
     result := GetObject(GetObject(c,Copy(s,0,n-1)),Copy(s,n+1,Length(s)-n));

     if result = nil then
     try
          result := typinfo.GetObjectProp(c,s);
     except
          result := nil;
     end;

     if result = nil then
     try
          result := (c as TComponent).FindComponent(s);
     except
          result := nil;
     end;
end;

function GetMethod(c : TObject; s : string) : TMethod;
var
     o : TObject;
     ael,lst : string;
begin
     s := trim(s);
     result.code := nil;
     result.data := nil;
     if pos('.',s) = 0 then
     begin
          lst := s;
          o := c;
     end
     else
     begin
          lst := strRscan(PChar(s),'.')+1;
          ael := Copy(s,0,Length(s)-length(lst));
          o := GetObject(c,ael);
     end;

     try
     result := GetMethodProp(o,lst);
     except
     result.code := nil;
     result.data := nil;
     end;

     if result.code = nil then
     try
     result.data := Pointer(o);
     result.code := o.MethodAddress(lst);
     except
     result.code := nil;
     result.data := nil;
     end;
end;

procedure ExecMethod(c : TObject; s : string; sender : TObject);
type
   TExec = procedure (sender : TObject) of object;
var
     m : TMethod;
     Exec : TExec;
begin
      m := GetMethod(c,s);

      if assigned(m.code) then
      begin
        Exec := TExec(m);
        Exec(sender);
      end;
end;


end.
