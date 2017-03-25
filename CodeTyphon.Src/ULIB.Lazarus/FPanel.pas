unit FPanel;

interface

uses controls, classes, graphics, windows, extctrls;

type TOBorderAt = (N,S,E,W);
type TOBordersAt = set of TOBorderAt;
type TFPanel = class(TCustomPanel)
     private
          VBorderColor : TColor;
          VBorders     : TOBordersAt;
          FAControl     : TWinControl;
     protected
     public
          constructor Create(AOwner : TComponent); override;
          procedure Paint; override;
          procedure SetVBorders(B : TOBordersAt);
          procedure SetVBorderColor(C : TColor);
     published
          property Align;
          property Color;
          property ActiveControl : TWinControl read FAControl write FAControl;
          property Borders : TOBordersAt read VBorders write SetVBorders;
          property BorderColor : TColor read VBorderColor write SetVBorderColor;
          property Enabled;
          property Font;
          property Name;
          property Caption;
          property TabStop;
          property TabOrder;
          property Visible;
          property OnKeyDown;
end;

procedure Register;

implementation

uses forms;

procedure Register;
begin
     RegisterComponents('pkULIB', [TFPanel]);
end;

constructor TFPanel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
     csSetCaption, csOpaque, csDoubleClicks, csReplicatable];

     Width := 250;
     Height := 100;

     ParentCtl3D := false;
     Ctl3D := false;
     BevelInner := bvNone;
     BevelOuter := bvNone;
     BorderStyle := bsNone;
     Caption := '';

     Borders := [N,S,E,W];
end;

procedure TFPanel.SetVBorders(B : TOBordersAt);
begin
     VBorders := B;
     invalidate;
end;

procedure TFPanel.SetVBorderColor(C : TColor);
begin
     VBorderColor := C;
     invalidate;
end;

procedure TFPanel.Paint;
begin
     inherited;

     Canvas.Pen.Color := BorderColor;
     if N in Borders then begin Canvas.MoveTo(0,0); Canvas.LineTo(Width,0); end;
     if S in Borders then begin Canvas.MoveTo(0,Height-1); Canvas.LineTo(Width,Height-1); end;
     if E in Borders then begin Canvas.MoveTo(Width-1,0); Canvas.LineTo(Width-1,Height); end;
     if W in Borders then begin Canvas.MoveTo(0,0); Canvas.LineTo(0,Height); end;
end;

end.
