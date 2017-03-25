unit ULabel;

interface

uses classes,graphics, controls,dialogs,stdctrls,messages,windows,mcedit,gulib,forms,filectrl;

type THKControl = class(TControl);
type TChangeValueEvent = procedure (sender : TObject;V : variant; var Cancel : boolean) of object;
type TCustomULabel = class(TCustomLabel)
     private
          VBackColor : TColor;
          VColorMouseOver : TColor;
          VNoClick : boolean;
          VNoClickMessage : string;
          VLinkedControl : TControl;
          VPassColors : boolean;
          FOnChange : TNotifyEvent;
          FOnChangeValue : TChangeValueEvent;
          FOnSetInnerCaption : TNotifyEvent;
          FOnValueToCaption  : TNotifyEvent;
     protected
          procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
          procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
          procedure SetEnabled(Value : boolean); override;
          procedure SetVNoClick(b : boolean);
          procedure SetInnerCaption(c : string);
          function  GetInnerCaption : string;
     public
          constructor Create(AOwner : TComponent); override;
          procedure Click; override;
          procedure HighLight;
          procedure NormalLight;
          procedure PassToLinked;
     published
          property ColorMouseOver : Tcolor read VColorMouseOver write VColorMouseOver;
          property ColorRestore   : TColor read VBackColor      write VBackColor;
          property Autosize;
          property Alignment;
          property Anchors;
          property Color;
          property Caption : string read GetInnerCaption write SetInnerCaption;
          property Transparent;
          property Visible;
          property WordWrap;
          property Enabled;
          property OnClick;
          property NoClickMessage : string read VNoClickMessage write VNoClickMessage;
          property OnChange : TNotifyEvent read FOnChange write FOnChange;
          property OnChangeValue : TChangeValueEvent read FOnChangeValue write FOnChangeValue;
          property OnSetInnerCaption : TNotifyEvent read FOnSetInnerCaption write FOnSetInnerCaption;
          property OnValueToCaption  : TNotifyEvent read FOnValueToCaption  write FOnValueToCaption;
          property Font;
          property NoClick : boolean read VNoClick write SetVNoClick;
          property LinkedControl : TControl read VLinkedControl write VLinkedControl;
          property PassColors : boolean read VPassColors write VPassColors;
end;

type TULabel = class(TCustomULabel)
end;

type TNumType = (ntInt,ntFloat);
type TNLabel = class(TCustomULabel)
     private
          VValue   : double;
          VFormat  : string;
          VNumType : TNumType;
          VQuestion : string;
     protected
          procedure SetVFormat(F : string);
          procedure SetVValue(V : double);
     public
          procedure Click; override;
     published
          property Question : string read VQuestion write VQuestion;
          property Format : string read VFormat write SetVFormat;
          property Value : double read VValue write SetVValue;
          property NumType : TNumType read VNumType write VNumType;
end;

type TMLabel = class(TCustomULabel)
     private
          FItems : TStrings;
          FIndex : integer;
     protected
          procedure SetFItems(s : TStrings);
          procedure SetFIndex(i : integer);
     public
          procedure   Click; override;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
     published
          property Items     : TStrings read FItems write SetFItems;
          property ItemIndex : integer  read FIndex write SetFIndex;
end;

type TTLabel = class(TCustomULabel)
     private
          VQuestion : string;
          VQWidth : integer;
          VLabelCase : TEditCharCase;
     protected
     public
          constructor Create(AOwner : TComponent); override;
          procedure SetVLabelCase(lc : TEditCharCase);
          procedure Click; override;
     published
          property Question : string read VQuestion write VQuestion;
          property QWidth : integer read VQWidth write VQWidth;
          property LabelCase : TEditCharCase read VLabelCase write SetVLabelCase;
end;

type TKLabel = class(TCustomULabel)
     private
          VQuestion : string;
          VQWidth   : integer;
          VMask     : string;
     protected
     public
          constructor Create(AOwner : TComponent); override;
          procedure Click; override;
     published
          property Question : string read VQuestion write VQuestion;
          property QWidth : integer read VQWidth write VQWidth;
          property Mask : string read VMask write VMask;
end;

type TXLabel = class(TCustomULabel)
     private
          VQuestion : string;
          VQHeight : integer;
          VQWidth  : integer;
     protected
     public
          constructor Create(AOwner : TComponent); override;
          procedure Click; override;
     published
          property Question : string read VQuestion write VQuestion;
          property QHeight : integer read VQHeight write VQHeight;
          property QWidth : integer read VQWidth write VQWidth;
end;

type TOpenDialogConfig = class(TPersistent)
     private
          FDefaultExt,
          FFileName,
          FFilter,
          FInitialDir,
          FTitle : string;
          FOptions : TOpenOptions;
     published
          property DefaultExt : string read FDefaultExt write FDefaultExt;
          property FileName   : string read FFileName   write FFileName;
          property Filter     : string read FFilter     write FFilter;
          property InitialDir : string read FInitialDir write FInitialDir;
          property Title      : string read FTitle      write FTitle;
          property Options    : TOpenOptions read FOptions write FOptions;
end;

type TLoadEvent = procedure (sender : TObject; var Accept : boolean) of object;
type TSaveEvent = procedure (sender : TObject; var Accept : boolean) of object;

type TLLabel = class(TCustomULabel)
     private
          FOpenDialog : TOpenDialogConfig;
          FDirOnly : boolean;
     protected
          FOnLoad : TLoadEvent;
     public
          procedure   Click; override;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
     published
          property OnLoad : TLoadEvent read FOnLoad write FOnLoad;
          property Dialog : TOpenDialogConfig read FOpenDialog write FOpenDialog;
          property DirectoriesOnly : boolean read FDirOnly write FDirOnly default false;
end;

type TSLabel = class(TCustomULabel)
     private
          FSaveDialog : TSaveDialog;
     protected
          FOnSave : TSaveEvent;
     public
          procedure   Click; override;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
     published
          property OnSave : TSaveEvent read FOnSave write FOnSave;
          property Dialog : TSaveDialog read FSaveDialog write FSaveDialog;
end;

type TBoolShow = (bsOnlyTrue,bsOnlyFalse,bsBoth);
type TBLabel = class(TCustomULabel)
     private
          VValue    : boolean;
          VBoolAlignment  : TAlignment;
          VColorTrue  : TColor;
          VColorFalse : TColor;
          VBoolShow : TBoolShow;
          FOnChangeValue : TChangeValueEvent;
     protected
          procedure SetVValue(v : boolean);
          procedure SetVColorFalse(f : TColor);
          procedure SetVColorTrue(t : TColor);
          procedure SetVBoolShow(b : TBoolShow);
          procedure SetVBoolAlignment(a : TAlignment);
     public
          constructor Create(AOwner : TComponent); override;
          procedure Paint; override;
          procedure Click; override;
     published
          property Value : boolean read VValue write SetVValue;
          property ColorTrue  : TColor read VColorTrue  write SetVColorTrue;
          property ColorFalse : TColor read VColorFalse write SetVColorFalse;
          property BoolShow : TBoolShow read VBoolShow write SetVBoolShow default bsOnlyTrue;
          property BoolAlignment : TAlignment read VBoolAlignment write SetVBoolAlignment;
          property OnChangeValue : TChangeValueEvent read FOnChangeValue write FOnChangeValue;
end;

type TDLabel = class(TCustomULabel)
     private
          VDate : TDate;
          VFormat : string;
          VQuestion : string;
     protected
          procedure SetVDate(d : TDate);
          procedure SetVFormat(f : string);
     public
          procedure Click; override;
          constructor Create(AOwner : TComponent); override;
     published
          property Date : TDate read VDate write SetVDate;
          property Format : string read VFormat write SetVFormat;
          property Question : string read VQuestion write VQuestion;
end;

type THLabel = class(TCustomULabel)
     private
          VTime : TTime;
          VFormat : string;
          VQuestion : string;
     protected
          procedure SetVTime(t : TTime);
          procedure SetVFormat(f : string);
     public
          procedure Click; override;
          constructor Create(AOwner : TComponent); override;
     published
          property Time : TTime read VTime write SetVTime;
          property Format : string read VFormat write SetVFormat;
          property Question : string read VQuestion write VQuestion;
end;

procedure Register;

implementation

uses sysutils;

procedure Register;
begin
     RegisterComponents('pkULIB',
     [TULabel,TNLabel,TMLabel,TTLabel,TXLabel,TLLabel,TSLabel,TBLabel,TDLabel,THLabel,TKLabel]);
end;

constructor THLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     Format := 'hh:nn';
     Time := now;
end;

procedure THLabel.Click;
begin
     inherited;
     Time := TimeIn(VQuestion,timetostr(Time));
end;

procedure THLabel.SetVTime(t : TTime);
var
     Stop : boolean;
begin
     Stop := false;
     if t <> Time then if Assigned(FOnChangeValue) then FOnChangeValue(self,t,Stop);

     if Stop then exit else VTime := t;

     Caption := FormatDateTime(VFormat,VTime);
     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
end;

procedure THLabel.SetVFormat(f : string);
begin
     VFormat := f;
     Caption := FormatDateTime(VFormat,VTime);
end;

constructor TDLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     Format := 'ddddd';
     Date := now;
end;

procedure TDLabel.Click;
begin
     inherited;
     Date := DateIn(VQuestion,datetostr(Date));
end;

procedure TDLabel.SetVDate(d : TDate);
var
     Stop : boolean;
begin
     Stop := false;
     if d <> VDate then if Assigned(FOnChangeValue) then FOnChangeValue(self,d,stop);

     if stop then exit else VDate := d;

     if VDate = 0
     then Caption := ''
     else Caption := FormatDateTime(VFormat,VDate);

     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
end;

procedure TDLabel.SetVFormat(f : string);
begin
     VFormat := f;
     if VDate <> 0
     then Caption := FormatDateTime(VFormat,VDate)
     else Caption := '';
end;

constructor TBLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     autosize := false;
     ColorTrue  := clBlue;
     ColorFalse := clRed;
end;

procedure TBLabel.SetVBoolShow(b : TBoolShow);
begin
     VBoolShow := b;
     invalidate;
end;

procedure TBLabel.Paint;
const
     c : array [boolean] of char = ('û','ü');
begin
     inherited;

     if VValue and (BoolShow = bsOnlyFalse) then exit;
     if (not VValue) and (BoolShow = bsOnlyTrue) then exit;

     Canvas.Font.Name := 'WingDings';
     Canvas.Font.Style := Canvas.Font.Style + [fsBold];

     if Font.Color = ColorMouseOver then
     Canvas.Font.Color := ColorMouseOver
     else
     if Value
     then Canvas.Font.Color := ColorTrue
     else Canvas.Font.Color := ColorFalse;

     case VBoolAlignment of
     taLeftJustify :
     Canvas.TextOut(1,0,C[VValue]);
     taRightJustify :
     Canvas.TextOut(ClientWidth - Canvas.TextWidth(c[VValue]),0,C[VValue]);
     taCenter :
     Canvas.TextOut((ClientWidth - canvas.TextWidth(c[VValue])) div 2,0,C[VValue]);
     end;
end;

procedure TBLabel.Click;
begin
     inherited;
     Value := not Value;
     invalidate;
end;

procedure TBLabel.SetVValue(v : boolean);
var
     cancel : boolean;
begin
     cancel := false;

     if v <> VValue then
     begin
          if Assigned(FOnChangeValue) then FOnChangeValue(self,v,cancel);
          if Assigned(OnChange) then OnChange(self);
          Caption := Caption;
     end;

     if Cancel then exit;

     VValue := v;
     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);

     invalidate;
end;

procedure TBLabel.SetVColorFalse(f : TColor);
begin
     VColorFalse := f;
     invalidate;
end;

procedure TBLabel.SetVColorTrue(t : TColor);
begin
     VColorTrue := t;
     invalidate;
end;

procedure TLLabel.Click;
var
     od : TOpenDialog;
     bk : string;
     ok : boolean;
     cc : string;
begin
     inherited;

     if FDirOnly then
     begin
          cc := Caption;

          SelectDirectory(FOpenDialog.Title,ExtractFilePath(Application.Exename),cc);
          if cc <> Caption then
          begin
               ok := true;
               if Assigned(FOnLoad) then FOnLoad(self,ok);

               if ok then
               begin
                    Caption := cc;
                    if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
               end
          end;
          exit;
     end;


     ok := true;
     bk := caption;
     od := TOpenDialog.Create(self);
     od.DefaultExt := FOpenDialog.DefaultExt;
     od.Filename   := FOpenDialog.FileName;
     od.Filter     := FOpenDialog.Filter;

     if Lowercase(FOpenDialog.InitialDir) = 'bindir' then
     od.InitialDir := ExtractFilePath(Application.ExeName)
     else
     od.InitialDir := FOpenDialog.InitialDir;

     od.Options    := FOpenDialog.Options;
     od.Title      := FOpenDialog.Title;

     if od.Execute then
     begin
          Caption := od.FileName;
          FOpenDialog.FileName := od.FileName;

          if Assigned(FOnLoad) then FOnLoad(self,ok);

          if not ok then caption := bk
          else
          if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
     end;

     od.Free;
end;

constructor TLLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     FOpenDialog := TOpenDialogConfig.Create;
     FOpenDialog.DefaultExt := '*.*';
     FOpenDialog.Filter := 'All files (*.*)|*.*';
     FOpenDialog.InitialDir := ExtractFilePath(Application.ExeName);

     Cursor := crHandPoint;
end;

destructor  TLLabel.Destroy;
begin
     if Assigned(FOpenDialog) then FOpenDialog.Free;

     inherited Destroy;
end;

constructor TXLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     QHeight := 120;
     QWidth  := 350;
end;

constructor TTLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     QWidth := 350;
end;

constructor TKLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     QWidth := 350;
end;

procedure TTLabel.SetVLabelCase(lc : TEditCharCase);
begin
     case lc of
     ecUpperCase : Caption := UpperCase(Caption);
     ecLowerCase : Caption := LowerCase(Caption);
     end;

     VLabelCase := lc;
end;

procedure TXLabel.Click;
var
     Stop : boolean;
     s : string;
begin
     Stop := false;
     inherited;
     s := MemoIn(Question,Caption,QWidth,QHeight);
     if s <> Caption then if Assigned(FOnChangeValue) then FOnChangeValue(self,s,Stop);

     if Stop then exit else Caption := s;

     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
end;

procedure TTLabel.Click;
var
     Stop : boolean;
     s : string;
begin
     Stop := false;
     inherited;

     s := TextIn(Question,Caption,VLabelCase,QWidth);
     if s <> Caption then if Assigned(FOnChangeValue) then FOnChangeValue(self,s,Stop);

     if Stop then exit else Caption := s;

     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
end;

procedure TKLabel.Click;
var
     Stop : boolean;
     s : string;
begin
     Stop := false;
     inherited;
     s := MaskIn(Question,Caption,Mask,QWidth);
     if s <> Caption then if Assigned(FOnChangeValue) then FOnChangeValue(self,s,Stop);

     if Stop then exit else Caption := s;

     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
end;

constructor TMLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     FItems := TStringList.Create;
     FIndex := 0;
end;

procedure TMLabel.SetFItems(s : TStrings);
begin
     FItems.Assign(s);
     ItemIndex := 0;
end;

procedure TMLabel.Click;
begin
     inherited;
     ItemIndex := ItemIndex + 1;
end;

procedure TMLabel.SetFIndex(i : integer);
var
     Stop : boolean;
     V    : integer;
begin
     if (csLoading in ComponentState) then exit;
     if Items.Count = 0 then exit;

     try  V := i mod Items.Count;
          Stop := false;
          if Assigned(FOnChangeValue) then FOnChangeValue(self,V,Stop);
          if Stop then exit;

          FIndex := V;
          Caption := Items[FIndex];
          if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
     except
          FIndex := i;
          Caption := '';
     end;
end;

destructor TMLabel.Destroy;
begin
     if Assigned(FItems) then FItems.Free;
     inherited Destroy;
end;

procedure TNLabel.Click;
begin
     inherited;

     case NumType of
     ntInt   : Value := Round(NumberIn(Question,inttostr(Round(Value))));
     ntFloat : Value := NumberIn(Question,FormatFloat('0.00',Value));
     end;
end;

procedure TNLabel.SetVFormat(F : string);
begin
     VFormat := F;
     Caption := FormatFloat(VFormat,Value);
end;

procedure TNLabel.SetVValue(V : double);
var
     Stop : boolean;
begin
     Stop := false;

     if V <> VValue then
     if Assigned(FOnChangeValue)
     then FOnChangeValue(self,V,Stop);

     if Stop then exit else VValue := V;

     Caption := FormatFloat(VFormat,Value);
     if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
end;

constructor TCustomULabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     ColorMouseOver := $0080FF;
     Cursor := crHandPoint;
     ShowAccelChar := false;
end;

procedure TCustomULabel.PassToLinked;
begin
     if Assigned(VLinkedControl) and PassColors then
     begin
          THKControl(VLinkedControl).Font.Color := Font.Color;
          THKControl(VLinkedControl).Color := Color;

          if VLinkedControl is TCustomULabel then
          (VLinkedControl as TCustomULabel).Transparent := Transparent;
     end;
end;

procedure TCustomULabel.HighLight;
begin
     Font.Color := ColorMouseOver;
end;

procedure TCustomULabel.NormalLight;
begin
     Font.Color := VBackColor;
end;

procedure TCustomULabel.CMMouseEnter (var Message: TMessage);
begin
     inherited;

     if csDesigning in ComponentState then exit;
     if VNoClick then exit;

     HighLight;
end;

procedure TCustomULabel.SetVNoClick(b : boolean);
const
     c : array [boolean] of TCursor = (crHandPoint,crDefault);
begin
     VNoClick := b;
     Cursor := c[b];
end;

procedure TCustomULabel.CMMouseLeave (var Message: TMessage);
begin
     inherited;

     if csDesigning in ComponentState then exit;
     if VNoClick then exit;

     NormalLight;
end;

procedure TCustomULabel.Click;
begin
     if VNoClick then
     begin
          if NoClickMessage <> '' then
          ShowMessage(NoClickMessage);
          Abort;
     end;
     inherited;
end;

procedure TCustomULabel.SetInnerCaption(c : string);
begin
     if c <> Caption then
     begin
          inherited Caption := c;
          if Assigned(FOnChange) then FOnChange(self);
     end;

     if Assigned(FOnSetInnerCaption) then FOnSetInnerCaption(self);
end;

procedure TBLabel.SetVBoolAlignment(a : TAlignment);
begin
     VBoolAlignment := a;
     invalidate;
end;

function TCustomULabel.GetInnerCaption : string;
begin
     result := inherited Caption;
end;

procedure TCustomULabel.SetEnabled(Value : boolean);
begin
     inherited;
     Visible := Enabled;
end;

constructor TSLabel.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     FSaveDialog := TSaveDialog.Create(Self);

     FSaveDialog.DefaultExt := '*.*';
     FSaveDialog.Filter := 'All files (*.*)|*.*';
     FSaveDialog.InitialDir := ExtractFilePath(Application.ExeName);

     Cursor := crHandPoint;
end;

destructor  TSLabel.Destroy;
begin
     if Assigned(FSaveDialog) then FSaveDialog.Free;

     inherited Destroy;
end;

procedure TSLabel.Click;
var
     bk : string;
     ok : boolean;
begin
     inherited;

     ok := true;
     bk := caption;

     if FSaveDialog.InitialDir = '' then
     FSaveDialog.InitialDir := ExtractFilePath(Application.ExeName);

     if FSaveDialog.Execute then
     begin
          Caption := FSaveDialog.FileName;

          if Assigned(FOnSave) then FOnSave(self,ok);

          if not ok then caption := bk
          else
          if Assigned(FOnValueToCaption) then FOnValueToCaption(self);
     end;
end;


end.



