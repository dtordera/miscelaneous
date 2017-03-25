unit CColor;

interface

uses classes, graphics, extctrls;

type TCColor = class(TCustomPanel)
     private
     protected
          procedure SetColorS(s : String);
          function  GetColorS : string;
     public
          constructor Create(AOwner : TComponent); override;
          procedure Click; override;

     published
          property Color;
          property ColorS : string read GetColorS write SetColorS;
          property Ctl3D;
          property BorderStyle;
end;

procedure Register;

implementation

uses dialogs, controls, sysutils;

procedure Register;
begin
     RegisterComponents('pkULIB',[TCColor]);
end;

constructor TCColor.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     Width := 60;
     Height := 35;
     Cursor := crHandPoint;
end;

procedure TCColor.Click;
var
     c : TColorDialog;
begin
     c := TColorDialog.Create(self);
     c.Color := Color;
     if c.Execute then Color := c.Color;
     c.Free;
     invalidate;
end;

procedure TCColor.SetColorS(s : string);
begin
     Color := strtoint(s);
end;

function TCColor.GetColorS : string;
begin
     result := inttostr(Color);
end;

end.
