unit UDBVAux;

interface

uses db, classes, types, graphics, controls, forms;

type TUDBViewKind = (uvNormal, uvPick);

type THKCustomControl = class(TCustomControl);
type THKControl = class(TControl);

type TRawData = (rwAsk,rwRawData,rwNoRaw);

type TColumnInfo = packed Record
     Alignment   : TAlignment;
     Title       : string;
     Format      : string;
     Width       : integer;
     FieldType   : TFieldType;
end;

type TColumnsInfo = array of TColumnInfo;
     TColumnsInfo30 = array [0..30] of TColumnInfo;

type TBuildColumnsEvent = procedure (sender : TObject; F : TField; var C : TColumnInfo) of object;
type TDrawRowEvent = procedure (sender : TObject; R : TRect; F : TField; FS : boolean; C : TCanvas) of object;

type TVAlign = (vaTop,vaCenter,vaBottom);

type TSFilterKind = (fkNoFilter,fkProgressive,fkNormal);

type TUDBCaption = class(TPersistent)
     private
          Owner : TComponent;
          VFixed : string;
          VVariable  : string;
          VSeparator : string;
          VCaption   : string;
          VControl : TControl;
     protected
          procedure SetVFixed(F : string);
          procedure SetVVariable(V : string);
          procedure SetVSeparator(S : String);
          procedure SetVControl(C : TControl);
          procedure ComposeCaption;
     public
          constructor Create(AOwner : TComponent);
          property Caption : string read VCaption;
     published
          property Fixed : string read VFixed write SetVFixed;
          property Variable : string read VVariable write SetVVariable;
          property Separator : string read VSeparator write SetVSeparator;
          property Control : TControl read VControl write SetVControl;
end;

type TUDBLook = class(TPersistent)
     private
          VOwner           : TComponent;
          VBorder          : boolean;
          VBorderColor     : TColor;
          VFixedRowFont    : TFont;
          VFixedRowVAlign  : TVAlign;
          VFixedRowHeight  : integer;
          VFixedRow      : TColor;
          VDataRowHeight   : integer;
          VOdd             : TColor;
          VEven            : TColor;
          VFocused         : TColor;
          VSelected        : TColor;
     protected
          procedure FontChange(Sender : TObject);
          procedure SetVBackColor(C : Tcolor);
          function  GetVBackColor : TColor;
          procedure SetVFixedRow(C : TColor);
          procedure SetVFixedRowHeight(H : integer);
          procedure SetVFixedRowFont(F : TFont);
          procedure SetVOdd(C : TColor);
          procedure SetVEven(C : TColor);
          procedure SetVDataRowHeight(H : integer);
          procedure SetVFixedRowVAlign(A : TVAlign);
          procedure SetVBorder(B : boolean);
          procedure SetVBorderColor(C : TColor);
          procedure SetVFocused(C : TColor);
          procedure SetVSelected(C : TColor);
          procedure SetVDataFont(F : TFont);
          function  GetVDataFont : TFont;
     public
          constructor    Create(AOwner : Tcomponent);
          destructor     Destroy; override;
          procedure      Invalidate;
          procedure      Assign(L : TUDBLook); overload;
     published
          property FixedRowVAlign : TVAlign   read VFixedRowVAlign write SetVFixedRowVAlign;
          property FixedRow       : TColor    read VFixedRow       write SetVFixedRow;
          property FixedRowHeight : integer   read VFixedRowHeight write SetVFixedRowHeight;
          property FixedRowFont   : TFont     read VFixedRowFont   write SetVFixedRowFont;
          property Odd            : TColor    read VOdd            write SetVOdd;
          property Even           : TColor    read VEven           write SetVEven;
          property DataRowHeight  : integer   read VDataRowHeight  write SetVDataRowHeight;
          property DataFont       : TFont     read GetVDataFont    write SetVDataFont;
          property Border         : boolean   read VBorder         write SetVBorder;
          property BorderColor    : TColor    read VBorderColor    write SetVBorderColor;
          property Focused        : TColor    read VFocused        write SetVFocused;
          property Selected       : TColor    read VSelected       write SetVSelected;
          property BackColor      : TColor    read GetVBackColor   write SetVBackColor;
end;

implementation

procedure TUDBLook.SetVDataFont(F : TFont);
begin
     THKCustomControl(VOwner).Font.Assign(F);
end;

function TUDBLook.GetVDataFont : TFont;
begin
     result := THKCustomControl(VOwner).Font;
end;

procedure TUDBLook.SetVOdd(C : TColor);
begin
     VOdd := C;
     invalidate;
end;

procedure TUDBLook.SetVEven(C : TColor);
begin
     VEven := C;
     invalidate;
end;

procedure TUDBLook.SetVDataRowHeight(H : integer);
begin
     VDataRowHeight := H;
     invalidate;
end;

procedure TUDBLook.SetVFixedRow(C : TColor);
begin
     VFixedRow := C;
     invalidate;
end;

procedure TUDBLook.SetVFixedRowHeight(H : integer);
begin
     VFixedRowHeight := H;
     invalidate;
end;

procedure TUDBLook.FontChange(sender : TObject);
begin
     invalidate;
end;

procedure TUDBLook.SetVFixedRowFont(F : TFont);
begin
     VFixedRowFont.Assign(F);
end;

procedure TUDBLook.SetVFixedRowVAlign(A : TVAlign);
begin
     VFixedRowVAlign := A;
     invalidate;
end;
procedure TUDBLook.SetVBorder(B : boolean);
begin
     VBorder := B;
     invalidate;
end;

procedure TUDBLook.SetVBorderColor(C : TColor);
begin
     VBorderColor := C;
     invalidate;
end;

procedure TUDBLook.SetVFocused(C : TColor);
begin
     VFocused := C;
     invalidate;
end;

procedure TUDBLook.SetVSelected(C : TColor);
begin
     VSelected := C;
     invalidate;
end;

function TUDBLook.GetVBackColor : TColor;
begin
     result := THKCustomControl(VOwner).Color;
end;

procedure TUDBLook.SetVBackColor(C : TColor);
begin
     THKCustomControl(VOwner).Color := C;
end;

constructor TUDBLook.Create(AOwner : TComponent);
begin
     inherited Create;

     VOwner := AOwner;

     VFixedRowFont := TFont.Create;
     VFixedRowFont.Name  := 'MS Sans Serif';
     VFixedRowFont.Size  := 7;
     VFixedRowFont.Color := clWhite;
     VFixedRowFont.OnChange := FontChange;

     VFixedRowHeight := 23;
     VFixedRow  := clNavy;

     VEven    := $00CEE3E8;
     VOdd     := $00C8DFE6;
     VDataRowHeight       := 18;
     VFocused := $0080FF;

     VSelected     := clNavy;

     THKCustomControl(VOwner).Font.Name := 'Arial';
     THKCustomControl(VOwner).Font.Size := 8;
     THKCustomControl(VOwner).Font.Color := $00A0A0A0;
     THKCustomControl(VOwner).Font.OnChange := FontChange;
end;

destructor TUDBLook.Destroy;
begin
     if Assigned(VFixedRowFont) then VFixedRowFont.Free;
     inherited Destroy;
end;

procedure TUDBLook.Invalidate;
begin
     THKCustomControl(VOwner).Invalidate;
end;

procedure TUDBCaption.SetVFixed(F : String);
begin
     VFixed := F;
     ComposeCaption;
end;

procedure TUDBCaption.SetVVariable(V : string);
begin
     VVariable := V;
     ComposeCaption;
end;

procedure TUDBCaption.SetVSeparator(S : String);
begin
     VSeparator := S;
     ComposeCaption;
end;

procedure TUDBCaption.SetVControl(C : TControl);
begin
     VControl := C;
     ComposeCaption;
end;

procedure TUDBLook.Assign(L : TUDBLook);
begin
     Border := L.Border;
     BorderColor := L.BorderColor;

     FixedRowHeight := L.FixedRowHeight;
     FixedRow  := L.FixedRow;
     FixedRowVAlign := L.FixedRowVAlign;
     FixedRowFont.Assign(L.FixedRowFont);

     Odd  := L.Odd;
     Even := L.Even;
     Focused := L.Focused;
     Selected  := L.Selected;
     DataRowHeight    := L.DataRowHeight;
     DataFont.Assign(L.DataFont);

     BackColor := L.BackColor;
end;

procedure TUDBCaption.ComposeCaption;
var
     p : string;
begin
     VCaption := VFixed;

     if VCaption = '' then p := '' else p := VSeparator;

     if VVariable <> '' then VCaption := VCaption + p + VVariable;

     if Assigned(VControl) and (VControl.Visible) and (VControl.Parent.Visible) then THKControl(VControl).Caption := VCaption
     else
     try
          ((Owner as TComponent).Owner as TCustomForm).Caption := VCaption;
     except
     end;
end;

constructor TUDBCaption.Create(AOwner : TComponent);
begin
     inherited Create;
     Owner := AOwner;
end;

end.
