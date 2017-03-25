unit UText;

interface

uses classes,graphics, controls,dialogs,stdctrls,messages,windows,fpanel, ULabel;

type THKControl = class(TControl);

type TTabStopper = (tsNone,tsUp,tsDown);

type TUTextStyle = class(TPersistent)
     private
          VOwner : TComponent;
          VColor : TColor;
          VFont  : TFont;
          FOnColorChange : TNotifyEvent;
     protected
          procedure SetVFont(F : TFont);
          procedure SetVColor(c : TColor);
     public
          procedure   Assign(Source : TUTextStyle);
          constructor Create(AOwner : TComponent); overload;
          destructor  Destroy; override;
     published
          property Color : TColor read VColor write SetVColor;
          property Font  : TFont read VFont write SetVFont;
          property OnColorChange : TNotifyEvent read FOnColorChange write FOnColorChange;
end;


type TStyleApplied = (taDefault,taMouseOver,taSelected);

type TSimpleUText = class(TCustomStaticText)
     published
          property Align;
          property BevelInner;
          property BevelOuter;
          property BevelEdges;
          property BevelKind;
          property Alignment;
          property Anchors;
          property Caption;
          property Color;
          property BorderStyle;
          property Transparent;
          property Font;
          property TabOrder;
          property TabStop;
          property ParentColor;
          property ParentFont;
          property ShowHint;
end;

type TCustomUText = class(TCustomStaticText)
     private
          VRounded          : boolean;
          VLinkedControl    : TControl;
          VStyleApplied     : TStyleApplied;
          VDefaultTs        : TUTextStyle;
          VSelectedTs       : TUTextStyle;
          VMouseOverTs      : TUTextStyle;
          VReactandActive   : boolean;
          VDefaultReact     : boolean;
          VSelectAndNext    : boolean;
          VAcceptMouseWheel : boolean;
          VPassColor        : boolean;
          VTabStopper       : TTabStopper;
          VActLikeLabel     : boolean;
          FOnReact          : TNotifyEvent;
          procedure OnColorChange(sender : TObject);
          procedure OnFontChange(sender : TObject);
          procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
     protected
          procedure ApplyStyle(ts : TUTextStyle);
          procedure Click; override;
          procedure KeyDown(var Key: Word; Shift: TShiftState); override;
          procedure SetVRounded(R : boolean);
          procedure SetVMouseOverTs(ts : TUTextStyle);
          procedure SetVSelectedTs (ts : TUTextStyle);
          procedure SetVDefaultTs  (ts : TUTextStyle);
          procedure SetVLinkedControl(c : TControl);
          procedure SetVGetStylesFrom(u : TCustomUText);
          function  VGetStylesFrom : TCustomUText;
          procedure SetEnabled(Value : boolean); override;
          procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
          procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
          procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
          procedure CMKillFocus  (var Message: TMessage); message WM_KILLFOCUS;
     public
          selected  : boolean;
          MouseOver : boolean;
          procedure   ApplySelectedStyle;
          procedure   ApplyMouseOverStyle;
          procedure   ApplyDefaultStyle;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          procedure   React; dynamic;
          procedure   SetFocus; override;
          procedure   AfterConstruction; override;
          function    DoMouseWheel(Shift: TShiftState; WheelDelta : integer; MousePos: TPoint): Boolean; override;
          procedure   Select;
          procedure   SelectNoReact;
          procedure   Deselect;
     published
          property Align;
          property Alignment;
          property Anchors;
          property Caption;
          property Color;
          property OnEnter;
          property OnClick;
          property OnKeyDown;
          property ActLikeLabel : boolean read VActLikeLabel write VActLikeLabel;
          property Rounded : boolean read VRounded write SetVRounded;
          property DefaultReact : boolean read VDefaultReact write VDefaultReact;
          property ReactAndActive : boolean read VReactAndActive write VReactAndActive;
          property LinkedControl : TControl read VLinkedControl write SetVLinkedControl;
          property OnReact : TNotifyEvent read FOnReact write FOnReact;
          property TextStyleDefault   : TUTextStyle read VDefaultTS write SetVDefaultTS;
          property TextStyleSelected  : TUTextStyle read VSelectedTs  write SetVSelectedTs;
          property TextStyleMouseOver : TUTextStyle read VMouseOverTs write SetVMouseOverTs;
          property BorderStyle;
          property Transparent;
          property Font;
          property TabOrder;
          property TabStop;
          property TabStopper : TTabStopper read VTabStopper write VTabStopper default tsNone;
          property ParentColor;
          property ParentFont;
          property ShowHint;
          property SelectAndNext : boolean read VSelectAndNext write VSelectAndNext;
          property GetStylesFrom : TCustomUText read VGetStylesFrom write SetVGetStylesFrom;
          property AcceptMouseWheel : boolean read VAcceptMouseWheel write VAcceptMouseWheel;
          property PassColor : boolean read VPassColor write VPassColor;
end;

type TUText = class(TCustomUText)
          property Alignment;
          property Anchors;
          property Caption;
          property OnEnter;
          property OnClick;
          property OnKeyDown;
          property DefaultReact;
          property ReactAndActive;
          property LinkedControl;
          property OnReact;
          property SelectAndNext;
          property TextStyleDefault;
          property TextStyleSelected;
          property TextStyleMouseOver;
          property BorderStyle;
end;

type TMUText = class(TUText)
     private
          FItems : TStrings;
          FIndex : integer;
          FNotAllowChange : boolean;
     protected
          procedure SetFItems(s : TStrings);
          procedure SetFIndex(i : integer);
     public
          procedure   React; override;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
     published
          property Items     : TStrings read FItems write SetFItems;
          property ItemIndex : integer  read FIndex write SetFIndex;
          property NotAllowChange : boolean read FNotAllowChange write FNotAllowChange;
end;

type TPUText = class(TCustomUText)
     private
          IBoxCaption,
          IBoxPrompt : string;
     protected
     public
          procedure React; override;
          constructor Create(AOwner : TComponent); override;
     published
          property InputBoxCaption : string read IBoxCaption write IBoxCaption;
          property InputBoxPrompt  : string read IBoxPrompt  write IBoxPrompt;
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
type TLUText = class(TCustomUText)
     private
          FOpenDialog : TOpenDialogConfig;
     protected
          FOnLoad : TLoadEvent;
     public
          procedure   React; override;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
     published
          property OnLoad : TLoadEvent read FOnLoad write FOnLoad;
          property Dialog : TOpenDialogConfig read FOpenDialog write FOpenDialog;
end;

type TGUText = class(TCustomUText)
     private
          VProgressChar  : char;
          VMaxProgress  : integer;
          VPosProgress  : integer;
          VFixedCaption : string;
     protected
          procedure SetVProgressChar(c : char);
          procedure SetVMaxProgress(m : integer);
          procedure SetVPosProgress(p : integer);
          procedure SetVFixedCaption(c : string);
          procedure SetVCaption(c : string);
          function  GetVCaption : string;
     public
          procedure Run;
          procedure Clear;
          constructor Create(AOwner : TComponent); override;
     published
          property AutoSize;
          property FixedCaption : string read VFixedCaption write SetVFixedCaption;
          property ProgressChar : char read VProgressChar write SetVProgressChar;
          property MaxProgress : integer read VMaxProgress write SetVMaxProgress;
          property PosProgress : integer read VPosProgress write SetVPosProgress;
          property Caption : string read GetVCaption write SetVCaption;
end;

procedure Register;

implementation

uses sysutils, forms, gulib;

constructor TGUText.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     VMaxProgress := 10;
     VPosProgress := 0;
     VProgressChar := '|';
end;

procedure TGUText.SetVCaption(c : string);
begin
     if (csDesigning in ComponentState) then VFixedCaption := c;
     inherited Caption := c;
end;

function TGUText.GetVCaption : string;
begin
     result := inherited Caption;
end;

procedure TGUText.SetVFixedCaption(c : string);
begin
     VFixedCaption := c;

     if (csDesigning in ComponentState) then
     Caption := VFixedCaption;
end;

procedure TGUText.SetVPosProgress(p : integer);
begin
     VPosProgress := p mod VMaxProgress;
     invalidate;
end;

procedure TGUText.Run;
     function __(c : char; n : integer) : string;
     var
          i : integer;
     begin
          result := '';
          for i := 0 to n - 1 do
          result := result + c;
     end;
begin
     Caption := VFixedCaption + ' ' + __(VProgressChar,PosProgress);
     PosProgress := PosProgress + 1;
end;

procedure TGUText.Clear;
begin
     PosProgress := 0;
     Caption := VFixedCaption;
end;

procedure TGUText.SetVMaxProgress(m : integer);
begin
     VMaxProgress := m;
     if VMaxProgress < 1 then VMaxProgress := 1;
     PosProgress := PosProgress;
     
// invalidate al setvposprogress
end;

procedure TGUText.SetVProgressChar(c : char);
begin
     VProgressChar := c;
     invalidate;
end;

constructor TMUText.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     FItems := TStringList.Create;
     FIndex := 0;
     Cursor := crHandPoint;
end;

procedure TMUText.SetFItems(s : TStrings);
begin
     FItems.Assign(s);
     ItemIndex := 0;
end;

procedure TMUText.React;
begin
     if NotAllowChange then exit;

     ItemIndex := ItemIndex + 1;

     inherited React;
end;

procedure TMUText.SetFIndex(i : integer);
begin
     try  FIndex := i mod Items.Count;
          Caption := Items[FIndex];
     except
          FIndex := i;
          Caption := '';
     end;
end;

destructor TMUText.Destroy;
begin
     if Assigned(FItems) then FItems.Free;
     inherited Destroy;
end;

constructor TPUText.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     cursor     := crHandPoint;
end;

procedure TPUText.React;
begin
     Caption := InputBox(IBoxCaption,IBoxPrompt,Caption);

     inherited React;
end;

procedure TLUText.React;
var
     od : TOpenDialog;
     bk : string;
     ok : boolean;
begin
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

          if not ok then caption := bk;
     end;

     od.Free;

     inherited React;
end;

constructor TLUText.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     FOpenDialog := TOpenDialogConfig.Create;
     FOpenDialog.DefaultExt := '*.*';
     FOpenDialog.Filter := 'All files (*.*)|*.*';
     FOpenDialog.InitialDir := ExtractFilePath(Application.ExeName);

     Cursor := crHandPoint;
end;

destructor  TLUText.Destroy;
begin
     if Assigned(FOpenDialog) then FOpenDialog.Free;

     inherited Destroy;
end;

constructor TUTextStyle.Create(AOwner : TComponent);
begin
     inherited Create;
     VOwner := AOwner;

     VFont := TFont.Create;

     VFont.Color := clBlack;
     VColor := clBtnFace;
end;

procedure TUTextStyle.Assign(Source : TUTextStyle);
begin
     Color := Source.Color;
     Font.Assign(Source.Font);
end;

destructor TUTextStyle.Destroy;
begin
     if Assigned(VFont) then VFont.Free;
     inherited;
end;

procedure TUTextStyle.SetVFont(F : TFont);
begin
     VFont.Assign(F);
end;

procedure TUTextStyle.SetVColor(C : TColor);
begin
     VColor := C;
     if Assigned(FOnColorChange) then FOnColorChange(Self);
end;

procedure TCustomUText.SetVMouseOverTs(ts : TUTextStyle);
begin
     VMouseOverTs.Assign(ts);
end;

procedure TCustomUText.SetVSelectedTs(ts : TUTextStyle);
begin
     VSelectedTs.Assign(ts);
end;

procedure TCustomUText.CMFontChanged(var Message: TMessage);
begin
     invalidate;
end;

procedure TCustomUText.SetVDefaultTs(ts : TUTextStyle);
begin
     VDefaultTS.Assign(ts);

     if csDesigning in ComponentState then
     begin
          inherited Font.Assign(VDefaultTS.Font);
          inherited Color := VDefaultTS.Color;
     end;
end;

procedure TCustomUText.KeyDown(var Key: Word; Shift: TShiftState);
begin
     if not ActLikeLabel then
     case Key of
     VK_RETURN,
     VK_SPACE    : begin Click; Key := 0; end;
     end;

     inherited;

     if Key <> 0 then
     try
     if Assigned((Owner as TForm).OnKeyDown) then (Owner as TForm).OnKeyDown((Owner as TForm),Key,Shift);
     except
     end;
end;

procedure TCustomUText.Select;
var
     i : integer;
begin
     for i := 0 to (Parent as TWinControl).ControlCount - 1 do
     if ((Parent as TWinControl).Controls[i] is TCustomUText)
     and ((Parent as TWinControl).Controls[i] <> self) then
          ((Parent as TWinControl).Controls[i] as TCustomUText).Deselect;

     SetFocus;
     selected := true;

     React;

     if SelectAndNext then
     PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TCustomUText.SelectNoReact;
var
     i : integer;
begin
     for i := 0 to (Parent as TWinControl).ControlCount - 1 do
     if ((Parent as TWinControl).Controls[i] is TCustomUText)
     and ((Parent as TWinControl).Controls[i] <> self) then
          ((Parent as TWinControl).Controls[i] as TCustomUText).Deselect;

//     SetFocus;
     selected := true;
     ApplySelectedStyle;
//     React;
end;

procedure TCustomUText.Deselect;
begin
     ApplyDefaultStyle;
     selected := false;
end;

procedure TCustomUText.CMDialogChar(var Message: TCMDialogChar);
begin
     if IsAccel(Message.CharCode, Caption) and Visible and not ActLikeLabel then
     begin
          Select;
          Message.Result := 1;
     end
     else inherited;
end;

procedure TCustomUText.Click;
begin
     if ActLikeLabel then exit;

     Select;
     inherited;
end;

procedure TCustomUText.SetFocus;
begin
     if not (Enabled and TabStop and Visible) or ActLikeLabel
     then
     begin
          PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);
          exit;
     end;

     ApplyMouseOverStyle;
     inherited SetFocus;
end;

procedure TCustomUText.AfterConstruction;
begin
     AutoSize := false;
     AcceptMouseWheel := true;
     ParentFont := false;

     if csDesigning in ComponentState then
     begin
          VDefaultTS.Font.Assign(inherited Font);
          VDefaultTS.Color := inherited Color;
     end
     else ApplyDefaultStyle;
end;

procedure TCustomUText.ApplyStyle(ts : TUTextStyle);
begin
     Font.Assign(ts.Font);
     Color := ts.Color;

     if Assigned(VLinkedControl) and (VLinkedControl is TCustomULabel) and (PassColor) then
     begin
          (VLinkedControl as TCustomULabel).Transparent := Transparent;
          (VLinkedControl as TCustomULabel).Color := ts.Color;

          if ts = VDefaultTS then
          (VLinkedControl as TCustomULabel).Font.Color :=
          (VLinkedControl as TCustomULabel).ColorRestore
          else
          (VLinkedControl as TCustomULabel).Font.Color := ts.Font.Color;
          (VLinkedControl as TCustomULabel).PassToLinked;
     end;
end;

procedure TCustomUText.ApplySelectedStyle;
begin
     Transparent := false;
     VStyleApplied := taSelected;

     ApplyStyle(VSelectedTS);
end;

procedure TCustomUText.ApplyDefaultStyle;
begin
     Transparent := true;

     VStyleApplied := taDefault;

     ApplyStyle(VDefaultTS);
end;

procedure TCustomUText.ApplyMouseOverStyle;
begin
     Transparent := false;
     VStyleApplied := taMouseOver;

     ApplyStyle(VMouseOverTS);
end;

procedure TCustomUText.React;
begin
     if (not Enabled) or (not Visible) or (ActLikeLabel) then exit;

     if DefaultReact and Assigned(LinkedControl)
     then
     try
          THKControl(LinkedControl).Click;
     except
     end;

     if ReactAndActive then
     try
          (Parent as TFPanel).ActiveControl := self;
     except
     end;

     if Assigned(FOnReact) then FOnReact(self);
end;

constructor TCustomUText.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     ControlStyle := ControlStyle - [csFramed,csOpaque];

{     Autosize     := false;}
     ParentColor  := true;
     ParentFont   := false;

     Transparent  := false;
     TabStop      := true;
     VMouseOverTs := TUTextStyle.Create(AOwner);
     VSelectedTs  := TUTextStyle.Create(AOwner);
     VDefaultTs   := TUTextStyle.Create(AOwner);
     Cursor       := crHandPoint;

     VMouseOverTs.Font.Color := clBlack;
     VMouseOverTs.Color := clWhite;

     VSelectedTS.Font.Color := clBlack;
     VSelectedTs.Color := clSilver;

     VDefaultTs.Font.Color := clBlack;
     VDefaultTs.Color := clBtnFace;

     VDefaultTS.Font.OnChange := OnFontChange;
     VDefaultTS.OnColorChange := OnColorChange;

     VSelectAndNext := true;

     Width := 70;
     Height := 19;

     doublebuffered := true;
end;

destructor TCustomUText.Destroy;
begin
     if Assigned(VDefaultTs)   then VDefaultTs.Free;
     if Assigned(VSelectedTs)  then VSelectedTs.Free;
     if Assigned(VMouseOverTs) then VMouseOverTs.Free;
     inherited;
end;

procedure TCustomUText.OnColorChange(sender : TObject);
begin
     try
     inherited Color := (sender as TUTextStyle).Color;
     except
     end;
end;

procedure TCustomUText.CMMouseEnter (var Message: TMessage);
begin
     inherited;
     if (csDesigning in ComponentState) or ActLikeLabel then exit;

     if not Selected then MouseOver := GetActiveWindow <> 0;

     if MouseOver then {ApplyMouseOverStyle;} SetFocus;
end;

procedure TCustomUText.CMMouseLeave (var Message: TMessage);
begin
     inherited;
     if (csDesigning in ComponentState) or ActLikeLabel then exit;

     if not Selected then ApplyDefaultStyle;

     MouseOver := false;
end;

procedure TCustomUText.CMKillFocus(var Message : TMessage);
begin
     inherited;

     if ActLikeLabel then exit;

     if not Selected then ApplyDefaultStyle
     else ApplySelectedStyle;
end;

procedure TCustomUText.OnFontChange(Sender : TObject);
begin
     inherited Font.Assign(sender as TFont);
end;

procedure TCustomUText.SetVLinkedControl(c : TControl);
begin
     if (VLinkedControl <> c) then VLinkedControl := c;
end;

procedure TCustomUText.SetVGetStylesFrom(u : TCustomUText);
begin
     TextStyleDefault.Assign(u.TextStyleDefault);
     TextStyleMouseOver.Assign(u.TextStyleMouseOver);
     TextStyleSelected.Assign(u.TextStyleSelected);

     Font.Assign(u.Font);
     Color := u.Color;
end;

function TCustomUText.VGetStylesFrom : TCustomUText;
begin
     result := nil;
end;

function TCustomUText.DoMouseWheel(Shift: TShiftState; WheelDelta : integer; MousePos: TPoint): Boolean;
begin
     result := false;
     if (not VAcceptMouseWheel) or ActLikeLabel then exit;

     result := true;

     if (WheelDelta > 0) and (TabStopper <> tsUp) then
     PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 1, 0)
     else
     if (WheelDelta < 0) and (TabStopper <> tsDown) then
     PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);

//     KeyDown(Key,Shift);
     invalidate;
end;

procedure TCustomUText.SetEnabled(Value : boolean);
begin
     inherited;
     Visible := Enabled;
end;

procedure TCustomUText.SetVRounded(R : boolean);
begin
     if R
     then MakeRound(self)
     else MakeRect(self);

     VRounded := R;
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TUText,TMUText,TPUText,TLUText,TGUText,TSimpleUText]);
end;

end.
