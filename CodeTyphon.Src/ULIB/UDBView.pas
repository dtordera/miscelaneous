unit UDBView;

interface

uses classes, ADOdb, controls, graphics, windows,db, dialogs,
sysutils, urForm, messages, extctrls, stdctrls, forms, SFilter, UDBVAux,
UDBGlobal, ComObj, buttons, gulib, ulabel,variants, menus;

type TUDBData = class(TPersistent)
     private
          Owner          : TComponent;
          VActive        : boolean;
          VSFilterKind   : TSFilterKind;
          VTable         : string;
          VFilter        : string;
          VFixedFilter   : string;
          VVisibleFields : string;
          VFixedOrder    : string;
          VOrderBy       : string;
          VOrderColumn   : integer;
          VOrderDESC     : boolean;
          VPrimaryKey    : string;
          VTitles        : TStrings;
          VQuery         : TADOQuery;
          VTotalRecords  : integer;
          VTotalFields   : integer;
          VConnection    : TADOConnection;
          NoSQLLocate_   : boolean;
          procedure ActivarData(A : Boolean = true);
          procedure IAfterDelete(Dataset : TDataset);
          procedure IAfterPost(Dataset : TDataset);
     protected
          procedure SetVTable(T : string);
          procedure SetVActive(A : boolean);
          procedure SetVTitles(T : TStrings);
          procedure SetVFixedOrder(O : string);
          procedure SetVOrderBy(O : string);
          procedure SetVFixedFilter(F : string);
          procedure SetVFilter(F : string);
          procedure SetVVisibleFields(V : string);
          procedure SetVConnection(C : TADOConnection);
          function  GetDataset : TDataset;
     public
          DoingSQL : boolean;
          function    GetNewId : integer;
          function    SQLText : string;
          procedure   Refresh;
          property    Active : boolean read VActive write SetVActive;
          property    Filter : string read VFilter write SetVFilter;
          property    TotalRecords : integer read VTotalRecords;
          property    TotalFields  : integer read VTotalFields;
          property    OrderBy : string read VOrderBy write SetVOrderBy;
          property    Dataset : TDataset read GetDataset;
          procedure   DoSQL; overload;
          procedure   DoSQL(s : string); overload;
          procedure   ApplyOrder(C : integer = -1);
          constructor Create(AOwner : TComponent);
          destructor  Destroy; override;
     published
          property FixedOrder : string read VFixedOrder write SetVFixedOrder;
          property Connection : TADOConnection read VConnection write SetVConnection;
          property Table : string read VTable write SetVTable;
          property Titles : TStrings read VTitles write SetVTitles;
          property PrimaryKey : string read VPrimaryKey write VPrimaryKey;
          property FixedFilter : string read VFilter write SetVFixedFilter;
          property SFilterKind : TSFilterKind read VSFilterKind write VSFilterKind;
          property VisibleFields : string read VVisibleFields write SetVVisibleFields;
end;

type TUDBView = class(TCustomControl)
     private
          VEscClose            : boolean;
          VRounded             : boolean;
          VKind                : TUDBViewKind;
          VLoseFocus           : boolean;
          VCaption             : TUDBCaption;
          VLook                : TUDBLook;
          VFilterForm          : TForm;
          HBar                 : boolean;
          VHBar,
          VVBar                : TScrollBar;
          VData                : TUDBData;
          VRecNoFocused        : integer;
          VFirstDrawRec        : integer;
          VFirstDrawCol        : integer;
          VColFocused          : integer;
          VDateTimeFormat      : string;
          VFloatFormat         : string;
          VDblClickAsEnter     : boolean;
          FOnBuildColumns      : TBuildColumnsEvent;
          FOnDrawRow           : TDrawRowEvent;
          FOnGetFocus          : TNotifyEvent;
          FOnLoseFocus         : TNotifyEvent;
          FOnReturn            : TNotifyEvent;
          FOnDelete            : TNotifyEvent;
          FOnInsert            : TNotifyEvent;
          FOnEscape            : TNotifyEvent;
          TotalWidth_          : integer;
          SettingRecNo_        : boolean;
          procedure PopupF8  (sender : TObject);
          procedure PopupF9  (sender : TObject);
          procedure PopupF11 (sender : TObject);
     protected
          function  GetColumn(x : integer) : integer;
          function  GetColOffset(c : integer) : integer;
          procedure ResizeCols(C : integer);
          procedure CreateFilterForm;
          procedure VFilterFormActivate(Sender : TObject);
          procedure VFilterFormOnTimer(sender : TObject);
          procedure VFilterFormClose(Sender: TObject; var Action: TCloseAction);
          procedure ApplyFilterOnChange(sender : TObject);
          procedure DrawBorder;
          procedure DrawFixedRow;
          procedure Click; override;
          procedure DblClick; override;
          procedure TitleClick(C : integer);
          procedure DrawData;
          procedure DrawBar;
          procedure PushKey(k : word);
          function  DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;MousePos: TPoint): Boolean; override;
          procedure SetColumnsTitles;
          procedure SetVRounded(R : boolean);
          procedure SetVDateTimeFormat(F : string);
          procedure SetVFloatFormat(F : string);
          procedure SetVRecNoFocused(R : integer);
          procedure SetVColFocused(C : integer);
          procedure SetVFirstDrawRec(I : integer);
          procedure SetVFirstDrawCol(C : integer);
          procedure VVBarChange(sender : TObject);
          procedure VHBarChange(sender : TObject);
          procedure SetHBar(V : boolean);
          procedure   SetLook(U : TUDBView);
          function    GetLook : TUDBView;
     public
          VisibleRecs_         : integer;
          VisibleCols_         : integer;
          Columns    : TColumnsInfo;
          TotalColumns : integer;
          InnerPopupMenu       : TPopupMenu;
          function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;
          function TotalColWidth : integer;
          function TotalWidth : integer;
          function FieldByName(f : string) : TField;
          procedure   CallFilter;
          procedure   CallColumnFilter;
          procedure   ClearFilter;
          procedure   SaveColumnFile(n : string);
          procedure   LoadColumnFile(n : string);
          procedure   Refresh;
          procedure Loaded; override;
          procedure PushReturn;
          procedure PushInsert;
          procedure PushDelete;
          procedure Up;
          procedure Down;
          procedure Left;
          procedure Right;
          procedure Prior;
          procedure Next;
          procedure Home;
          procedure CtrlHome;
          procedure _End;
          procedure CtrlEnd;
          procedure   BuildColumns;
          procedure   AssignColumnInfo(c : TColumnsInfo; s : string = '*'); overload;
          procedure   AssignColumnInfo(c : TColumnsInfo30; s : string = '*'); overload;
          procedure   MouseMove(Shift: TShiftState; X, Y: Integer); override;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          procedure   Paint; override;
          procedure   SetFocus; override;
          procedure   CurrentUp;
          procedure   CurrentDown;
          procedure   ApplyFilter(f : string);
          procedure   KeyDown(var Key : Word; Shift : TShiftState); override;
          procedure   WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
          procedure   WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
          procedure   WMSetFocus(var message : TMessage); message WM_SETFOCUS;
          function    ExportToXLS(s : string; a : TRawData; open : boolean) : string;
          property    RecNoFocused : integer read VRecNoFocused write SetVRecNoFocused;
          property    ColFocused : integer read VColFocused write SetVColFocused;
          property    FirstDrawRec : integer read VFirstDrawRec write SetVFirstDrawRec;
          property    FirstDrawCol : integer read VFirstDrawCol write SetVFirstDrawCol;
     published
          property GetLookFrom : TUDBView read GetLook write SetLook;
          property LoseFocus : boolean read VLoseFocus write VLoseFocus;
          property ShowHBar : boolean read HBar write SetHBar;
          property Rounded : boolean read VRounded write SetVRounded;
          property Kind                : TUDBViewKind read VKind write VKind;
          property Align;
          property Data                : TUDBData  read VData                write VData;
          property DateTimeFormat      : string    read VDateTimeFormat      write SetVDateTimeFormat;
          property FloatFormat         : string    read VFloatFormat         write SetVFloatFormat;
          property OnBuildColumns : TBuildColumnsEvent read FOnBuildColumns write FOnBuildColumns;
          property OnDrawRow : TDrawRowEvent read FOnDrawRow write FOnDrawRow;
          property OnClick;
          property OnDblClick;
          property OnReturn : TNotifyEvent read FOnReturn write FOnReturn;
          property OnDelete : TNotifyEvent read FOnDelete write FOnDelete;
          property OnInsert : TNotifyEvent read FOnInsert write FOnInsert;
          property OnEscape : TNotifyEvent read FOnEscape write FOnEscape;
          property EscClose : boolean read VEscClose write VEscClose;
          property PopupMenu;
          property OnMouseDown;
          property OnMouseMove;
          property OnMouseUp;
          property OnKeyDown;
          property OnGetFocus  : TNotifyevent read FOnGetFocus  write FOnGetFocus;
          property OnLoseFocus : TNotifyevent read FOnLoseFocus write FOnLoseFocus;
          property TabOrder;
          property TabStop;
          property Caption : TUDBCaption read VCaption write VCaption;
          property Look : TUDBLook read VLook write VLook;
          property DblClickAsEnter : boolean read VDblClickAsEnter write VDblClickAsEnter;
end;

procedure Register;

implementation

constructor TUDBView.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     DoubleBuffered := true;

     setlength(Columns,1);
     Columns[0].Width := 20;
     TotalWidth_ := 10;
     TotalColumns := 1;
     VColFocused := 1;

     VData := TUDBData.Create(self);
     VCaption := TUDBCaption.Create(self);
     VLook := TUDBLook.Create(self);

     VRecNoFocused := 1;
     FirstDrawRec  := 1;
     FirstDrawCol  := 1;

     VVBar := TScrollBar.Create(self);
     VVBar.Parent := self;
     VVBar.Ctl3D := false;
     VVBar.TabStop := false;
     VVBar.DoubleBuffered := true;
     VVBar.Align := alRight;
     VVBar.Kind := sbVertical;
     VVBar.OnChange := VVBarChange;
     VVBar.PageSize := 1;
     VVBar.SmallChange := 1;

     VHBar := TScrollBar.Create(self);
     VHBar.Parent := self;
     VHBar.Ctl3D := false;
     VHBar.TabStop := false;
     VHBar.DoubleBuffered := true;
     VHBar.Align := alBottom;
     VHBar.Kind  := sbHorizontal;
     VHBar.OnChange := VHBarChange;
     VHBar.PageSize := 1;
     VHBar.SmallChange := 1;

     InnerPopupMenu := TPopupMenu.Create(self);
     InnerPopupMenu.Items.Add(TMenuItem.Create(InnerPopupMenu));
     InnerPopupMenu.Items.Add(TMenuItem.Create(InnerPopupMenu));
     InnerPopupMenu.Items.Add(TMenuItem.Create(InnerPopupMenu));

     InnerPopupMenu.Items[0].Caption := 'Aplicar filtre a columna (F8)';
     InnerPopupMenu.Items[1].Caption := 'Aplicar filtre a taula (F9)';
     InnerPopupMenu.Items[2].Caption := 'Eliminar filtre / actualitzar (F11)';

     InnerPopupMenu.Items[0].OnClick := PopupF8;
     InnerPopupMenu.Items[1].OnClick := PopupF9;
     InnerPopupMenu.Items[2].OnClick := PopupF11;

     PopupMenu := InnerPopupMenu;

     CreateFilterForm;
end;

destructor  TUDBView.Destroy;
begin
     setlength(Columns,0);

     if Assigned(InnerPopupMenu) then InnerPopupMenu.Free;

     if Assigned(VVBar) then VVBar.Free;
     if Assigned(VHBar) then VHBar.Free;

     if Assigned(VLook)    then VLook.Free;
     if Assigned(VCaption) then VCaption.Free;
     if Assigned(VData)    then VData.Free;

     inherited Destroy;
end;

procedure TUDBView.SetVDateTimeFormat(F : string);
begin
     VDateTimeFormat := F;
     BuildColumns;
end;

function TUDBData.GetDataSet : TDataset;
begin
     result := VQuery as TDataset;
end;

procedure TUDBView.SetVFloatFormat(F : string);
begin
     VFloatFormat := F;
     BuildColumns;
end;

procedure TUDBView.SetColumnsTitles;
var
     i : integer;
begin
     for i := 0 to VData.VQuery.FieldCount - 1 do
     if VData.VTitles.IndexOfName(VData.VQuery.Fields[i].FieldName) > -1
     then Columns[i+1].Title := VData.VTitles.Values[VData.VQuery.Fields[i].FieldName]
     else Columns[i+1].Title := VData.VQuery.Fields[i].FieldName;
end;

procedure TUDBView.BuildColumns;
var
     i : integer;
begin
//     if (csReading in ComponentState) then exit;

     if not Assigned(VData.VQuery) or (VData.VQuery.Active = false) or (VData.VConnection.Connected = false)
     then
     begin
          setlength(Columns,1);
          TotalColumns := 1;
          TotalWidth_ := 10;
     end
     else
     begin
          setlength(Columns,VData.VQuery.FieldCount+1);
          TotalColumns := length(Columns);
          TotalWidth_ := 10;

          SetColumnsTitles;

          for i := 1 to VData.VQuery.FieldCount do
          begin
               Columns[i].FieldType   := VData.VQuery.Fields[i-1].DataType;

               case Columns[i].FieldType of
               ftInteger,ftWord,ftLargeInt,ftAutoInc,ftSmallint :
               begin
                    Columns[i].Width := 80;
                    Columns[i].Alignment := taRightJustify;
               end;
               ftDate,ftTime,ftDateTime:
               begin
                    Columns[i].Width := 100;
                    Columns[i].Format := DateTimeFormat;
                    Columns[i].Alignment := taCenter;
               end;
               ftFloat,ftCurrency :
               begin
                    Columns[i].Width  := 80;
                    Columns[i].Format := FloatFormat;
                    Columns[i].Alignment := taRightJustify;
               end;
               ftString,ftWideString :
               begin
                    Columns[i].Width  := VData.VQuery.Fields[i-1].DisplayWidth * Canvas.TextWidth('X');
                    Columns[i].Alignment := taLeftJustify;
               end;
               ftBoolean :
               begin
                    Columns[i].Width := 60;
                    Columns[i].Alignment := taCenter;
               end;
               ftMemo :
               begin
                    Columns[i].Width := 300;
                    Columns[i].Alignment := taLeftJustify;
               end;
               end;

               if Columns[i].Width < 20  then
               begin
                    Columns[i].Width := 20;
                    Columns[i].Alignment := taCenter;
               end
               else
               if Columns[i].Width > 350 then Columns[i].Width := 350;

               if Assigned(FOnBuildColumns) then FOnBuildColumns(self,VData.VQuery.Fields[i-1],Columns[i]);

               TotalWidth_ := TotalWidth_ + Columns[i].Width;
          end;
     end;

     invalidate;
end;


procedure TUDBView.DrawFixedRow;
var
     i,
     va,
     dx,
     ha : integer;
     R     : TRect;
begin
     with Canvas do
     begin
          Brush.Style := bsSolid;
          Brush.Color := VLook.FixedRow;

          Font.Assign(VLook.FixedRowFont);

          ha := (VLook.FixedRowHeight - TextHeight('X'));

          case VLook.FixedRowVAlign of
          vaTop    : va := 1;
          vaCenter : va := ha div 2;
          vaBottom : va := ha - 1
          else va := 0
          end;

          R.Left := 0;
          R.Top    := 0;
          R.Bottom := VLook.FixedRowHeight;
          R.Right := Columns[0].Width;

          FillRect(R);

          R.Left := R.Right;

          for i := FirstDrawCol to TotalColumns - 1 do
          begin
               R.Right  := R.Left + Columns[i].Width;

               if R.Right > (ClientWidth - VVBar.Width) then
               R.Right := (ClientWidth - VVbar.Width);

               case Columns[i].Alignment of
               taLeftJustify : ha := 2;
               taCenter : ha := (R.Right - R.Left - TextWidth(Columns[i].Title)) div 2;
               taRightJustify : ha := R.Right - 2 - R.Left - TextWidth(Columns[i].Title);
               end;

               TextRect(R,R.Left + ha ,R.Top + va,Columns[i].Title);

               if i = ColFocused then
               begin
                    Brush.Color := VLook.Focused;
                    FillRect(classes.Rect(R.Left,R.Bottom - 3,R.Right,R.Bottom));
                    Brush.Color := VLook.FixedRow;
               end;

               if (i = Data.VOrderColumn) and (Data.FixedOrder = '') then
               begin
                    if Columns[i].Alignment = taRightJustify
                    then dx := R.Left + 5
                    else dx := R.Right - 10;

                    Canvas.Pen.Color := VLook.FixedRowFont.Color;
                    Canvas.Pen.Style := psSolid;

                    if not VData.VOrderDESC then
                    begin
                         MoveTo(dx, R.Top + 5);
                         LineTo(dx+2,R.Top + 7);
                         LineTo(dx+4,R.Top + 5);
                         LineTo(dx,R.Top + 5);

                         Pixels[dx+2,R.Top + 6] := Pen.Color;
                    end
                    else
                    begin
                         MoveTo(dx, R.Top + 7);
                         LineTo(dx+2,R.Top + 5);
                         LineTo(dx+4,R.Top + 7);
                         LineTo(dx,R.Top + 7);

                         Pixels[dx+2,R.Top + 6] := Pen.Color;
                    end;
               end;

               R.Left := R.Right;
               if R.Left + 1 > (ClientWidth - VVBar.Width) then break;
          end;

          if R.Left < (ClientWidth - VVBar.Width) then
          begin
               R.Right := ClientWidth - VVBar.Width;
               FillRect(R);
          end;
     end;
end;

procedure TUDBView.DrawData;
var
     i,j   : integer;
     ha    : integer;
     va    : integer;
     s     : string;
     R     : TRect;
     BakAfter : TDatasetNotifyEvent;
begin
     ha := 0;

     if not (Data.VQuery.Active and Data.VConnection.Connected) or (Data.DoingSQL) then exit;

     BakAfter := Data.Dataset.AfterScroll;
     Data.Dataset.AfterScroll := nil;

     if Data.TotalRecords = 1 then Data.VQuery.First
     else
     if Data.TotalRecords > 0 then Data.VQuery.RecNo := FirstDrawRec
     else
     begin
          Data.Dataset.AfterScroll := BakAfter;
          exit;
     end;

     with Canvas do
     begin
          Font.Assign(VLook.DataFont);

          va := (VLook.DataRowHeight - Canvas.TextHeight('X')) div 2;

          R.Top    := VLook.FixedRowHeight;

          Pen.Style := psDot;
          Pen.Color := clBlack;

          i := 0;
          while not Data.VQuery.Eof do
          begin
               if (Data.VQuery.RecNo = RecNoFocused)
               then
               begin
                    if Focused
                    then Brush.Color := VLook.Focused
                    else Brush.Color := VLook.Selected;

                    Font.Color  := NegLumColor(Brush.Color);
               end
               else
               begin
                    if (Data.VQuery.RecNo mod 2) = 0
                    then Brush.Color := VLook.Odd
                    else Brush.Color := VLook.Even;

                    if DifLum(Brush.Color,VLook.DataFont.Color) < 100
                    then Font.Color := NegLumColor(Brush.Color,clGray,clWhite)
                    else Font.Color := VLook.DataFont.Color;
               end;

               R.Left := Columns[0].Width;

               if Assigned(FOnDrawRow) then FOnDrawRow(self,R,nil,Data.VQuery.RecNo = RecNoFocused,self.Canvas);
               FillRect(Rect(0,R.Top,Columns[0].Width,R.Top + VLook.DataRowHeight));

               VisibleCols_ := 0;
               for j := FirstDrawCol to TotalColumns - 1 do
               begin
                    R.Right  := R.Left + Columns[j].Width;
                    R.Bottom := R.Top + VLook.DataRowHeight;

                    if R.Right > (ClientWidth - VVBar.Width) then
                    R.Right := (ClientWidth - VVBar.Width);

                    s := '';

                    if (Data.VQuery.Fields[j - 1].DataType in [ftFloat,ftCurrency,ftDateTime,ftTime,ftDate,
                    ftInteger,ftSmallint,ftWord,ftAutoInc]) and (Pos('~',Columns[j].Format) <> 0)
                    then
                    begin
                         if (Data.VQuery.Fields[j-1].Value = 0)
                         then s := Copy(Columns[j].Format,Pos('~',Columns[j].Format) + 1,1000)
                         else
                         begin
                              if Data.VQuery.Fields[j-1].DataType = ftDateTime
                              then s := FormatDateTime(Copy(Columns[j].Format,0,Pos('~',Columns[j].Format) - 1),Data.VQuery.Fields[j - 1].AsDateTime)
                              else
                              s := FormatFloat(Copy(Columns[j].Format,0,Pos('~',Columns[j].Format) - 1),Data.VQuery.Fields[j - 1].AsFloat);
                         end
                    end
                    else
                    case Data.VQuery.Fields[j - 1].DataType of
                    ftFloat,ftCurrency : s := FormatFloat(Columns[j].Format,Data.VQuery.Fields[j - 1].AsFloat);
                    ftDateTime,ftTime,ftDate : if Data.VQuery.Fields[j-1].AsFloat <> 0 then s := FormatDateTime(Columns[j].Format,Data.VQuery.Fields[j - 1].AsDateTime);
                    ftBoolean : if Data.VQuery.Fields[j-1].Asboolean then s := 'ü';
                    else s := Data.VQuery.Fields[j - 1].AsString;
                    end;

                    case Columns[j].Alignment of
                    taLeftJustify : ha := 2;
                    taCenter : ha := (R.Right - R.Left - TextWidth(s)) div 2;
                    taRightJustify : ha := R.Right - 2 - R.Left - TextWidth(s);
                    end;

                    if s = 'ü' then begin Font.Name := 'wingdings'; Font.Style := [fsBold]; end;

                    if Assigned(FOnDrawRow) then FOnDrawRow(self,R,Data.VQuery.Fields[j-1],Data.VQuery.RecNo = RecNoFocused,self.Canvas);

                    TextRect(R,R.Left + ha ,R.Top + va,s);

                    if (j = ColFocused) then
                    begin
                         if (Data.VQuery.RecNo = RecNoFocused)
                         then
                         begin
                              Brush.Style := bsClear;
                              Rectangle(R);
                              Brush.Style := bsSolid;

                              if Focused
                              then Brush.Color := VLook.Focused
                              else Brush.Color := VLook.Selected;
                         end;
                    end;

                    if (TextWidth(s) > (R.Right - R.Left)) and (TextWidth(s) > TextWidth('(...)'))
                    then
                    begin
                         R.Left := R.Right - TextWidth('(...)') - 2;
                         TextRect(R, R.Left,R.Top + va,'(...)');
                    end;

                    R.Left := R.Right;

                    if s = 'ü' then begin Font.Name := VLook.DataFont.Name; Font.Style := VLook.DataFont.Style; end;

                    VisibleCols_ := VisibleCols_ + 1;

                    if R.Left + 1 > (ClientWidth - VVBar.Width) then break;
               end;

               if R.Left < (ClientWidth - VVBar.Width) then
               begin
                    R.Right := ClientWidth - VVBar.Width;
                    FillRect(R);
               end;

               if R.Top > (ClientHeight - VLook.FixedRowHeight - VHBar.Height) then break;
               R.Top := R.Bottom;

               inc(i);

               Data.VQuery.Next;
          end;

          VisibleRecs_ := i;
     end;

     Data.VQuery.RecNo := RecNoFocused;
     Data.Dataset.AfterScroll := BakAfter;
end;

procedure TUDBView.DrawBorder;
var
     R : TRect;
begin
     if not VLook.Border or Rounded then exit;

     Canvas.Pen.Color := VLook.BorderColor;
     Canvas.Pen.Style := psSolid;
     Canvas.Brush.Style := bsClear;

     R := ClientRect;
     R.Right := R.Right - VVBar.Width;

     if VHBar.Visible then
     R.Bottom := R.Bottom - VHBar.Height;
     
     Canvas.Rectangle(R);
end;

procedure TUDBView.DrawBar;
begin
     VVBar.PaintTo(Canvas,ClientWidth - VVBar.Width,0);
     VHBar.PaintTo(canvas,0,ClientHeight - VHBar.Height);
end;

procedure TUDBView.Paint;
begin
     Canvas.Lock;
     DrawFixedRow;
     DrawData;
     DrawBorder;
     DrawBar;
     Canvas.Unlock;
end;

constructor TUDBData.Create(AOwner : TComponent);
begin
     inherited Create;

     Owner := AOwner;

     VQuery       := TADOQuery.Create(AOwner);
     VQuery.AfterDelete := IAfterDelete;
     VQuery.AfterPost   := IAfterPost;

     VTitles      := TStringList.Create;
     VSFilterKind := fkProgressive;

     VOrdercolumn := 1;
     VOrderDESC   := false;
end;

destructor TUDBData.Destroy;
begin
     if Assigned(VTitles)     then VTitles.Free;
     if Assigned(VQuery)      then VQuery.Free;

     inherited Destroy;
end;

procedure TUDBData.SetVConnection(C : TADOConnection);
begin
     VConnection := C;
     ActivarData(VActive or (csDesigning in Owner.ComponentState));
end;

procedure TUDBData.SetVTable(T : string);
begin
     VTable := T;
     ActivarData(VActive or (csDesigning in Owner.ComponentState));
end;

procedure TUDBData.SetVTitles(T : TStrings);
begin
     VTitles.Assign(T);
     (Owner as TUDBView).SetColumnsTitles;
end;

procedure TUDBData.ActivarData(A : Boolean = true);
begin
     A := A and Assigned(VConnection) and VConnection.Connected and (VTable <> '');

     if A then
     try
          VQuery.Connection := VConnection;

          NoSQLLocate_ := true;
          DoSQL;
     except
          if not ((csDesigning in Owner.ComponentState) or (csLoading in Owner.ComponentState)) then raise;
     end
     else
     begin
          VQuery.Active := false;
     end;

     (Owner as TUDBView).BuildColumns;
end;

procedure TUDBData.SetVActive(A : boolean);
begin
     try  ActivarData(A);
          VActive := A;
     except
          raise;
     end
end;

procedure TUDBView.Loaded;
begin
     Data.Active := true;
     BuildColumns;

     if Rounded then MakeRound(self);
     VVBar.Ctl3D := false;
end;

procedure TUDBView.SetVRecNoFocused(R : integer);
begin
     if (R < 1) and (Data.TotalRecords > 0)then R := 1
     else
     if R > Data.TotalRecords then R := Data.TotalRecords;

     if Data.TotalRecords < 1 then R := -1;

     VRecNoFocused := R;

     if VRecNoFocused > 0 then
     begin
          if (VRecNoFocused >= FirstDrawRec + VisibleRecs_ ) then FirstDrawRec := VRecNoFocused - VisibleRecs_
          else
          if (VRecNoFocused < FirstDrawRec) then FirstDrawRec := VRecNoFocused;
     end;

     SettingRecNo_ := true;
     VVBar.Position := R;
     SettingRecNo_ := false;

     invalidate;

     if Data.VQuery.Active then Data.VQuery.RecNo := R;
end;

procedure TUDBView.KeyDown(var Key : word; Shift : TShiftState);
begin
     inherited KeyDown(Key,Shift);

     if ssCtrl in Shift then
     case Key of
     VK_HOME  : begin CtrlHome; Key := 0; end;
     VK_END   : begin CtrlEnd; Key := 0; end;
     end
     else
     case Key of
     VK_ESCAPE : begin
                 if Assigned(FOnEscape) then FOnEscape(self);
          
                 if EscClose then
                 begin
                    (Owner as TForm).ModalResult := mrCancel;
                    if (Owner as TForm).Visible then (Owner as TForm).Close;
                 end;
                 end;
     VK_RETURN : if Assigned(FOnReturn) then FOnReturn(self);
     VK_INSERT : if Assigned(FOnInsert) then FOnInsert(self);
     VK_DELETE : if Assigned(FOnDelete) then FOnDelete(self);
     VK_F8    : CallColumnFilter;
     VK_F9    : CallFilter;
     VK_F11   : ClearFilter;
     VK_F12   : ResizeCols(ColFocused); 
     VK_SPACE : TitleClick(ColFocused);
     VK_UP    : begin Up; Key := 0; end;
     VK_DOWN  : begin Down; Key := 0; end;
     VK_HOME  : begin Home; Key := 0; end;
     VK_END   : begin _End; Key := 0; end;
     VK_PRIOR : begin Prior; Key := 0; end;
     VK_NEXT  : begin Next; Key := 0; end;
     VK_LEFT  : begin Left; Key := 0; end;
     VK_RIGHT : begin Right; Key := 0; end;
     end;

     if Key <> 0 then
     try
     if Assigned((Owner as TForm).OnKeyDown) then (Owner as TForm).OnKeyDown((Owner as TForm),Key,Shift);
     except
     end;
end;

procedure TUDBView.SetFocus;
begin
     inherited SetFocus;
     invalidate;
end;

procedure TUDBView.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
     Msg.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS;
end;

procedure TUDBView.Prior;
begin
     FirstDrawRec := FirstDrawRec - VisibleRecs_;
     RecNoFocused  := RecNoFocused - VisibleRecs_;
end;

procedure TUDBView.Next;
begin
     FirstDrawRec := FirstDrawRec + VisibleRecs_;
     RecNoFocused := RecNoFocused + VisibleRecs_;

     if RecNoFocused > Data.TotalRecords - 1 then
          FirstDrawRec := Data.TotalRecords - VisibleRecs_;
end;

procedure TUDBView.Home;
begin
     ColFocused := 1;
     FirstDrawCol := 1;
end;

procedure TUDBView._End;
     function FirstVisibleCol : integer;
     var
          i : integer;
          w : integer;
     begin
          result := TotalColumns - 1;
          w := 0;
          for i := TotalColumns - 1 downto 0 do
          begin
               w := w + Columns[i].Width;
               result := i;
               if w > (ClientWidth - VVBar.Width) then break;
          end;
     end;
begin
     ColFocused :=  TotalColumns - 1;
     FirstDrawCol := FirstVisibleCol + 1;
end;

procedure TUDBView.Up;
begin
     if RecNoFocused < 2 then
     begin
          if VLoseFocus then PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 1, 0)
     end
     else
     RecNoFocused := RecNoFocused - 1;
end;

procedure TUDBView.Down;
begin
     if (RecNoFocused = Data.TotalRecords) or (RecNoFocused < 1) then
     begin
          if VLoseFocus then PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0)
     end
     else
     RecNoFocused := RecNoFocused + 1;
end;

procedure TUDBView.Right;
     function FirstVisibleCol : integer;
     var
          i : integer;
          w : integer;
     begin
          result := ColFocused;
          w := (ClientWidth - VVBar.Width);
          for i := ColFocused downto 0 do
          begin
               w := w - Columns[i].Width;
               result := i;
               if w < 0 then break;
          end;
     end;
begin
     if ColFocused < TotalColumns - 1 then ColFocused := ColFocused + 1;

     FirstDrawCol := FirstVisibleCol + 2;
end;

procedure TUDBView.Left;
begin
     if ColFocused > 1 then ColFocused := ColFocused - 1;
     if ColFocused + 1 = FirstDrawCol  then FirstDrawCol := FirstDrawCol - 1;
end;

procedure TUDBView.CtrlEnd;
begin
     RecNoFocused  := Data.TotalRecords;
     FirstDrawRec  := Data.TotalRecords - VisibleRecs_ + 2;
end;

procedure TUDBView.CtrlHome;
begin
     RecNoFocused := 1;
     FirstDrawRec := 1;
end;

procedure TUDBView.SetVColFocused(C : integer);
begin
     if C < 1 then VColFocused := 0
     else
     if C > TotalColumns - 1 then VColFocused := TotalColumns - 1
     else
     VColFocused := C;

     VHBar.Position := VColFocused;

     invalidate;
end;

procedure TUDBView.Click;
var
     P : TPoint;
     i : integer;
     c : integer;
begin
     if not Focused then SetFocus;

     P := ScreenToClient(Mouse.CursorPos);

     c := GetColumn(P.x);

     if (P.Y < VLook.FixedRowHeight) then begin TitleClick(C); exit; end;

     i := ((P.Y - VLook.FixedRowHeight) div VLook.DataRowHeight) + FirstDrawRec;

     if i < 1 then i := 1;
     if i > Data.TotalRecords then i := Data.TotalRecords;

     if c < 1 then c := 1;

     if P.X + Columns[c].Width > ClientWidth - VVBar.Width
     then FirstDrawCol := C - 1
     else
     if P.x < Columns[0].Width then FirstDrawCol := FirstDrawCol - 1;

     RecNoFocused := i;

     if (FirstDrawCol = C) and (C > 1) then FirstDrawCol := C - 1;

     ColFocused   := c;

     inherited;
end;

function TUDBView.DoMouseWheel(Shift: TShiftState; WheelDelta : integer; MousePos: TPoint): Boolean;
begin
     result := true;

     if ssCtrl in Shift then
     begin
          if WheelDelta > 0 then Prior
          else
          if WheelDelta < 0 then Next;
     end
     else
     if ssShift in Shift then
     begin
          if WheelDelta > 0 then Left
          else
          if WheelDelta < 0 then Right;
     end
     else
     if WheelDelta > 0 then Up
     else
     if WheelDelta < 0 then Down;

     invalidate;
end;

procedure TUDBView.SetVFirstDrawRec(I : integer);
begin
     VFirstDrawRec := I;

     if (VFirstDrawRec > VRecNoFocused) then VFirstDrawrec := VRecNoFocused;

     if VFirstDrawRec < 1 then VFirstDrawRec := 1;

     if VFirstDrawRec < VRecNoFocused - VisibleRecs_ - 1 then VFirstDrawRec := VRecNoFocused - VisibleRecs_ - 1;

     if VRecNoFocused = Data.TotalRecords then VFirstDrawRec := Data.TotalRecords - VisibleRecs_ + 1;
end;

procedure TUDBView.SetVFirstDrawCol(C : integer);
begin
     if C < 1 then C := 1
     else
     if C > TotalColumns then C := TotalColumns;

     VFirstDrawCol := C;
end;

procedure TUDBData.DoSQL;
var
     VF : string;
     FF : string;
     VO : string;
begin
     if not Assigned(VConnection) or
     not (VConnection.Connected) then exit;

     if VVisibleFields = '' then VF := '*' else VF := VVisibleFields;

     FF := VFixedFilter;

     if FF <> '' then
     begin
          if VFilter <> '' then FF := ' and (' + FF + ')'
          else FF := ' where (' + FF + ')';
     end;

     if VFixedOrder = ''
     then VO := VOrderBy
     else VO := ' order by ' + VFixedOrder;

     if (VO = '') and (VPrimaryKey <> '') then VO := ' order by ' + VPrimaryKey;

     DoSQL('select ' + VF + ' from ' + VTable + ' ' + VFilter + FF + VO);
end;

procedure TUDBData.DoSQL(s : string);
var
     id : variant;
begin
     DoingSQL := true;

     (Owner as TUDBView).VVBar.OnChange := nil;
     (Owner as TUDBView).VHBar.OnChange := nil;

     if VQuery.connection = nil then VQuery.Connection := VConnection;

     if not NoSQLLocate_ then
     try
     id := 0;
     if VQuery.Active then id := VQuery.FieldValues[VPrimaryKey];
     except
     end;

     VQuery.Active   := false;
     VQuery.SQL.Text := s;
     VQuery.Active   := true;

     if not NoSQLLocate_ then
     try
          VQuery.Locate(VPrimaryKey,id,[])
     except
     end;

     VTotalRecords := VQuery.RecordCount;
     VTotalFields  := VQuery.FieldCount;

     with owner as TUDBView do
     begin
          VisibleRecs_ := (ClientHeight - VLook.FixedRowHeight + 1) div VLook.DataRowHeight;
          if VTotalRecords < VisibleRecs_ then VisibleRecs_ := VTotalRecords;

          DoingSQL := false;
          NoSQLLocate_ := true;

          Invalidate;
     end;

     with (Owner as TUDBView).VVBar do
     begin
          Min := 1;
          try    Max := VTotalRecords;
          except Max := 2;
          end;

          LargeChange := (Owner as TUDBView).VisibleRecs_ div 2;
          OnChange := (owner as TUDBView).VVBarChange;
     end;

     with (Owner as TUDBView).VHBar do
     begin
          Min := 1;
          try Max := VQuery.FieldCount
          except Max := 2;
          end;

          LargeChange := 1;
          OnChange := (Owner as TUDBView).VHBarChange;
     end;

     (Owner as TUDBView).RecNoFocused := VQuery.RecNo;
end;

procedure TUDBData.SetVOrderBy(O : string);
begin
     NoSQLLocate_ := false;
     VOrderBy := ' order by ' + O;
     DoSQL;
end;

procedure TUDBData.SetVFixedOrder(O : string);
begin
     NoSQLLocate_ := false;
     VOrderBy := '';
     VFixedOrder := O;
     DoSQL;
end;

procedure TUDBData.SetVFixedFilter(F : string);
begin
     VFixedFilter := F;
     NoSQLLocate_ := true;
     DoSQL;
end;

procedure TUDBData.SetVFilter(F : string);
begin
     VFilter := F;
     NoSQLLocate_ := true;
     DoSQL;

     if Assigned(Dataset.AfterScroll) then Dataset.AfterScroll(Dataset);
end;

procedure TUDBData.SetVVisibleFields(V : string);
begin
     VVisibleFields := V;
     NOSQLLocate_ := true;
     DoSQL;
end;

function TUDBView.ExportToXLS(s : string; a : TRawData; open : boolean) : string;
var
     q : TADOQuery;
     excel : variant;
     sd : TSaveDialog;
     order,
     sn : string;
     o  : string;
     i,j  : integer;
     rw   : boolean;
     total : string;
     f : string;
     c : TColumnInfo;
begin
     result := '';
     o := Trim(Caption.Fixed);

     if o = '' then o := Trim(Data.VTable);

     if Caption.Variable <> '' then o := Trim(o + '_' + Caption.Variable);

     if s = '' then
     begin
          sd := TSaveDialog.Create(self);
          sd.Filename := stringreplace(Trim(Caption.Fixed + ' ' + FormatDateTime('dd-mm-yyyy',date)),' ','_',[rfReplaceAll,rfIgnoreCase])+'.xls';
          sd.InitialDir := ExtractFilePath(Application.ExeName);
          sd.Title := o;
          sd.Filter := 'Fitxers Excel (*.xls)|*.xls|Tots els fitxer (*.*)|*.*';

          if not sd.execute then begin sd.free; exit; end;
          s := sd.Filename;
          sd.Free;
     end;

     if FileExists(s) then
     with CreateMessageDialog(s + ' existeix. Sobreescriure?',mtInformation,[mbYes,mbNo]) do
     begin
          (FindComponent('Yes') as TButton).Caption := '&Sí' ;
          if ShowModal = mrNo then exit
          else
          try    DeleteFile(s)
          except raise exception.create('Error guardant ' + s);
          end;
     end;

     rw := a = rwRawData;
     if a = rwAsk then rw := mDLG('Guardar només les dades? (sense colors, sense format)',mtInformation,[mbYes,mbNo]) = mrYes;

     if Data.OrderBy = '' then order := '' else order := Data.OrderBy;

     q := TADOQuery.Create(self);
     q.Connection := Data.Connection;

     if VData.VisibleFields = ''
     then sn := '*'
     else sn := VData.VisibleFields;

     try
     q.Active := false;
     q.SQL.Text := 'select ' + sn + ' into ["Excel 8.0;Database='+s+'"].['+o+'] from ' + Data.Table + ' ' + Data.VFilter + order;
     q.ExecSQL;
     q.Active := false;
     q.SQL.Text := 'select ' + sn + ' from ' + Data.Table + ' ' + Data.VFilter;
     q.Active := true;
     except
     mDlg('Error intentant pasar base de dades a format .XLS',mtError,[mbOk]);
     q.Free;
     end;

     if not Assigned(q) then exit;

     total := inttostr(q.RecordCount);
     q.Free;

     try    Excel := CreateOleObject('Excel.Application');
     except
          mDlg('El fitxer ' + s + ' està creat, però es requereix tenir Excel instal·lat per fer canvis de format',mtWarning,[mbOk]);
          exit;
     end;

     Excel.WorkBooks.Open(s);
     Excel.Visible := false;

     Excel.Rows.Font.Size  := 9;
     Excel.Rows.Font.Color := clBlack;
     Excel.Rows.Font.Name  := 'arial';

     if not rw then
     begin
          Excel.Rows[1].Insert;
          Excel.Rows[1].Insert;
          Excel.Rows[1].Insert;
          Excel.Rows[1].Insert;

          Excel.Rows.Font.Color := $222222;
          Excel.Rows.Font.Name  := Font.Name;

          for i := 1 to Totalcolumns + 1 do
          begin
               Excel.Cells[4,i].Font.Bold  := true;
               Excel.Cells[4,i].Font.Size  := Font.Size;
               Excel.Cells[4,i].Font.Color := clGray;
               Excel.Cells[4,i].Interior.Color := VLook.FixedRow;

               Excel.Cells[5,i].Font.Italic := true;
               Excel.Cells[5,i].Font.Size := 8;
               Excel.Cells[5,i].Font.Color := clGray;
               Excel.Cells[5,i].Interior.Color := $DFDFDF;
          end;

          for j := 1 to TotalColumns - 1 do
          begin
               c.Alignment := Columns[j].Alignment;
               c.Title     := Columns[j].Title;
               c.Format    := Columns[j].Format;
               c.FieldType := Columns[j].FieldType;

               Application.ProcessMessages;

               Excel.Cells[4,j].Value := c.Title;

               Excel.Cells[4,j].Font.Color := VLook.FixedRowFont.Color;
               Excel.Cells[4,j].Font.Size  := VLook.FixedRowFont.Size;
               if Excel.Cells[4,j].Font.Size < 8
               then Excel.Cells[4,j].Font.Size  := 8;

               Excel.Cells[4,j].Font.Bold  := fsBold in VLook.FixedRowFont.Style;
               Excel.Cells[4,j].Font.Italic := fsItalic in VLook.FixedRowFont.Style;
               Excel.Cells[4,j].Font.Underline := fsUnderline in VLook.FixedRowFont.Style;

               case c.FieldType of
               ftSmallInt,ftInteger,ftWord,ftAutoinc,
               ftLargeInt,ftFloat,ftCurrency :
               begin
                    if pos('~',c.Format) <> 0 then
                    f := Copy(c.Format,0,pos('~',c.Format)-1)
                    else
                    f := c.Format;

                    f := stringreplace(f,'%','',[rfReplaceAll]);

                    Excel.Columns[j].NumberFormat := stringReplace(f,'.',',',[rfReplaceAll,rfIgnoreCase]);
               end;
               end;
          end;
     end;

     Excel.WorkBooks[1].WorkSheets[1].Columns.Autofit;

     if not rw then
     begin
          Excel.Cells[1,1].Font.Bold := true;
          Excel.Cells[1,1].Font.Italic := true;
          Excel.Cells[1,1].Font.Color  := clBlack;
          Excel.Cells[1,1].Font.Size   := 10;
          Excel.Cells[1,1] := '''' + Trim(Caption.Caption) + ' (.XLS)' + ' (' + datetostr(date) + ')';

          Excel.Cells[3,1].Font.Color  := clGray;
          Excel.Cells[3,1] := '''' + 'registres : ' + total;
     end
     else
     begin
          Excel.Rows[1].Font.Bold := true;
          Excel.Rows[1].Interior.Color := $DDDDDD;
     end;

     Excel.Rows[1].Insert;
     Excel.Rows[1].Insert;
     Excel.Columns[1].Insert;
     Excel.Columns[1].ColumnWidth := 10;

     Excel.WorkBooks[1].Save;

     if open and (mDLG('Obrir ' + s + ' a Excel ara?',mtInformation,[mbYes,mbNo]) = mrYes)
     then Excel.Visible := true
     else Excel.quit;

     Excel := variants.unassigned;

     result := s;
end;

procedure TUDBView.CreateFilterForm;
var
     e : TEdit;
     b,
     c : TButton;
     t : TTimer;
begin
     VFilterForm := TForm.Create(self);
     with VFilterForm do
     begin
          Width    := 310;
          Position := poDesktopCenter;
          BorderStyle := bsToolWindow;
     end;

     b := TButton.Create(self);
     c := TButton.Create(self);
     e := TEdit.Create(self);
     t := TTimer.Create(VFilterForm);
     t.Interval := 700;
     t.Name    := 'timer';
     t.Enabled := false;
     t.OnTimer  := VFilterFormOnTimer;

     e.Name   := 'filter';
     e.Text   := '';
     e.Width  := VFilterForm.ClientWidth - 10;
     e.Left   := 5;
     e.Top    := 5;
     e.OnChange := ApplyFilterOnChange;

     b.ModalResult := mrOk;
     b.Default := true;
     b.Width := 0;

     c.ModalResult := mrCancel;
     c.Cancel  := True;
     c.Width := 0;

     VFilterForm.InsertControl(b);
     VFilterForm.InsertControl(e);
     VFilterForm.InsertControl(c);
     VFilterForm.ClientHeight := e.Top + e.Height + 5;
     VFilterForm.Caption    := 'Filtrar per ...';
     VFilterForm.OnActivate := VFilterFormActivate;
     VFilterForm.OnClose    := VFilterFormClose;
     VFilterForm.ActiveControl := e;
     VFilterForm.Tag := 1;
     e.Ctl3D  := False;
end;

procedure TUDBView.ApplyFilterOnChange(sender : TObject);
var
     t : TTimer;
begin
     if not (sender as TCustomEdit).Focused then exit;

     Caption.Variable := (sender as TCustomEdit).Text;

     t := VFilterForm.FindComponent('timer') as TTimer;
     t.Enabled := Data.SFilterKind in [fkProgressive,fkNormal];

     VFilterForm.Tag := 1;
end;

procedure TUDBView.VFilterFormActivate(sender : TObject);
var
     s : string;
begin
     s := (VFilterForm.FindChildControl('filter') as TEdit).Text;
     (VFilterForm.FindChildControl('filter') as TEdit).Text := '';
     (VFilterForm.FindChildControl('filter') as TEdit).Text := s;
     (VFilterForm.FindChildControl('filter') as TEdit).SelectAll;
end;

procedure TUDBView.VFilterFormClose(Sender: TObject; var Action: TCloseAction);
begin
     (VFilterForm.FindComponent('timer') as TTimer).Enabled := false;
end;

procedure TUDBView.VFilterFormOnTimer(sender : TObject);
var
     e : TCustomEdit;
begin
     if not (Data.SFilterKind in [fkProgressive,fkNormal]) then exit;

     e := VFilterForm.FindChildControl('filter') as TCustomEdit;

     ApplyFilter(e.Text);
end;

procedure TUDBView.CallFilter;
begin
     if not (Data.SFilterKind in [fkProgressive,fkNormal]) then exit;

     VFilterForm.ShowModal;

     invalidate;
end;

procedure TUDBView.ApplyFilter(f : string);
begin
     if VFilterForm.Tag = 0 then exit;
     Caption.Variable := f;
     VData.Filter := GetSQLExpression(f,VData.VQuery);
     VFilterForm.Tag := 0;
end;

procedure TUDBView.CallColumnFilter;
var
     s : string;
     op : string;
     f  : double;
     d : TDateTime;
begin
     s := TextIn('Filtrar segons ' + Columns[ColFocused].Title);

     if Trim(s) = '' then exit;

     op := '=';

     if pos('>',s) <> 0 then op := '>';
     if pos('<',s) <> 0 then op := '<';

     s := stringreplace(s,'>','',[rfReplaceAll]);
     s := stringReplace(s,'<','',[rfReplaceAll]);

     case VData.VQuery.Fields[ColFocused - 1].DataType of
     ftInteger,ftWord,ftLargeInt,ftAutoInc,ftSmallint :
     try    strtoint(s);
     except mDlg('El camp ' + Columns[ColFocused].Title + ' és enter. Es necesita filtrar per un nombre.',mtError,[mbOk]);
     end;
     ftDate,ftTime,ftDateTime:
     try
               s := Trim(AnsiUppercase(s));
               if (s = 'AVUI') or (s = 'HOY') then s := FormatDateTime('#mm/dd/yyyy#',date)
               else
               if (s = 'AHIR') or (s = 'AYER') then s := FormatDateTime('#mm/dd/yyyy#',date - 1)
               else
               if op = '=' then
               begin
                    d := strtodate(s);
                    op := ' = ';
                    s := FormatDateTime('#mm/dd/yyyy#',d);
               end
               else
               s := FormatDateTime('#mm/dd/yyyy#',strtodate(s));

     except    mDlg('El camp ' + Columns[ColFocused].Title + ' és de temps. Es necesita escriure una data o un temps (format dd/mm/aaaa o hh:nn).',mtError,[mbOk]);
     end;
     ftFloat,ftCurrency :
     try
          s := StringReplace(s,',',DecimalSeparator,[rfReplaceAll]);
          s := StringReplace(s,'.',DecimalSeparator,[rfReplaceAll]);

          if op = '=' then
          begin
               f := strtofloat(s);
               op := '>';
               s := formatfloat('0.000',f-0.009) + ' and ' + VData.VQuery.Fields[ColFocused-1].FieldName + ' < ' + FormatFloat('0.000',f+0.009);
          end;

          s := StringReplace(s,DecimalSeparator,'.',[rfReplaceAll]);

     except    mDlg('El camp ' + Columns[ColFocused].Title + ' és numèric. Es necesita filtrar per un nombre.',mtError,[mbOk]);
     end;
     ftString,ftWideString,ftMemo :
     begin
          s := AnsiquotedStr('%'+s+'%','''');
          op := ' like ';
     end;
     ftBoolean :
     begin
          if pos('si',lowercase(s)) <> 0 then s := 'true'
          else
          if pos('no',lowercase(s)) <> 0 then s := 'false';
     end;
     end;

     Data.Filter := ' where ' + VData.VQuery.Fields[ColFocused - 1].FieldName + op + s;
     Caption.Variable := Columns[ColFocused].Title + op + s;
end;

procedure TUDBView.ClearFilter;
var
     i : variant;
begin
     Caption.Variable := '';
     i := VData.Dataset.FieldValues[VData.VPrimaryKey];
     VData.Filter := '';
     VData.Dataset.Locate(VData.VPrimaryKey,i,[]);
     RecNoFocused := VData.Dataset.RecNo;
     FirstDrawRec := RecNoFocused - (VisibleRecs_ div 2);
end;

procedure TUDBView.MouseMove(Shift: TShiftState; X, Y: Integer);
const
     C : array [boolean] of TCursor = (crHandPoint,crDefault);
begin
     if Kind = uvNormal
     then Cursor := C[Y > VLook.FixedRowHeight]
     else Cursor := crHandPoint;
end;

procedure TUDBView.TitleClick(C : integer);
var
     dy : integer;
begin
     dy := FirstDrawRec - RecNoFocused;

     if C = 0 then exit;

     if C = Data.VOrderColumn then Data.VOrderDESC := not Data.VOrderDESC
     else Data.VOrderColumn := C;

     Data.ApplyOrder;

     RecNoFocused := Data.VQuery.RecNo;
     FirstDrawRec := Data.VQuery.RecNo + dy;
end;

procedure TUDBData.ApplyOrder(C : integer = -1);
const
     D : array [boolean] of string = ('ASC','DESC');
begin
     if c = -1 then c := VOrderColumn;

     OrderBy := VQuery.Fields[C-1].FieldName + ' ' + D[VOrderDesc];
end;

procedure TUDBView.WMSetFocus(var message : TMessage);
begin
     invalidate;
     inherited;
     if Assigned(FOnGetFocus) then FOnGetFocus(self);
end;

procedure TUDBView.WMKillFocus(var message : TMessage);
begin
     if Assigned(FOnLoseFocus) then FOnLoseFocus(self);
     inherited;
     invalidate;
end;

procedure TUDBView.PushKey(k : word);
var
     v : word;
begin
     v := k;
     KeyDown(v,[]);
end;

procedure TUDBView.ResizeCols(C : integer);
begin
     with T_urForm.Create(self) do
     begin
          ColumnResizing := C;
          SetControls;
          ShowModal;
     end;
end;

procedure TUDBView.DblClick;
var
     P : TPoint;
     c : integer;
begin
     if not Focused then SetFocus;

     P := ScreenToClient(Mouse.CursorPos);

     c := GetColumn(P.x);

     if (P.Y < VLook.FixedRowHeight) then begin TitleClick(C); exit; end;

     inherited;
     if DblClickAsEnter then PushReturn;
end;

procedure TUDBView.PushReturn;
begin
     PushKey(VK_RETURN);
end;

procedure TUDBView.PushInsert;
begin
     PushKey(VK_INSERT);
end;

procedure TUDBView.PushDelete;
begin
     PushKey(VK_DELETE);
end;

procedure TUDBView.VVBarChange(sender : TObject);
begin
     if not SettingRecNo_ then
     RecNoFocused := VVBar.Position;
end;

procedure TUDBView.VHBarChange(sender : TObject);
var
     h : integer;
begin
     h := ColFocused - FirstDrawCol;
     ColFocused  := VHBar.Position;
     FirstDrawCol := ColFocused - h;
end;

procedure TUDBView.AssignColumnInfo(c : TColumnsInfo; s : string = '*');
var
     i : integer;
begin
     Data.VisibleFields := s;

     TotalColumns := Data.VQuery.FieldCount + 1;

     setlength(Columns,TotalColumns);

     for i := 1 to TotalColumns - 1 do
     begin
          Columns[i].Title     := c[i].Title;
          Columns[i].Format    := c[i].Format;
          Columns[i].Alignment := c[i].Alignment;
          Columns[i].Width     := c[i].Width;
          Columns[i].FieldType := c[i].FieldType;
     end;

     invalidate;
end;

procedure TUDBView.AssignColumnInfo(c : TColumnsInfo30; s : string = '*');
var
     i : integer;
begin
     Data.VisibleFields := s;

     TotalColumns := Data.VQuery.FieldCount + 1;

     setlength(Columns,TotalColumns);

     for i := 1 to TotalColumns - 1 do
     begin
          Columns[i].Title     := c[i].Title;
          Columns[i].Format    := c[i].Format;
          Columns[i].Alignment := c[i].Alignment;
          Columns[i].Width     := c[i].Width;
          Columns[i].FieldType := c[i].FieldType;
     end;

     invalidate;
end;

procedure TUDBView.LoadColumnFile(n : string);
var
     ss : TStrings;
     i  : integer;
     s : string;
     T,F : string;
begin
     try
     ss := TStringList.Create;

     ss.LoadFromFile(n);

     Data.VisibleFields := ss[0];

     TotalColumns := Data.VQuery.FieldCount + 1;
     setlength(Columns,TotalColumns);

     for i := 1 to TotalColumns - 1 do
     begin
          s := ss[i];
          T := Copy(s,4,Pos('|',s)-1-3);
          F := Copy(s,Pos('|',s)+1,1000);

          Columns[i].Title     := T;
          Columns[i].Format    := F;
          Columns[i].Width     := (Word(s[1]) - 40) * 2;
          Columns[i].Alignment := TAlignment(Word(s[2])-40);
          Columns[i].FieldType := TFieldType(Word(s[3])-40);
     end;

     ss.Free;

     invalidate;
     except
     raise;
     end;
end;

procedure TUDBView.SaveColumnFile(n : string);
var
     ss : TStrings;
     i  : integer;
     s  : string;
begin
     if Data.VQuery.FieldCount = 0 then exit;

     ss := TStringList.Create;

     for i := 1 to TotalColumns - 1 do
          ss.Add(Data.VQuery.Fields[i-1].FieldName);

     s := ss.CommaText;

     ss.Clear;
     ss.Add(s);

     for i := 1 to TotalColumns - 1 do
          ss.Add(Char((Columns[i].Width div 2 ) + 40) + Char(integer(Columns[i].Alignment)+40) + Char(integer(Columns[i].FieldType)+40)+Columns[i].Title + '|' + Columns[i].Format);

     ss.SaveToFile(n);

     ss.Free;
end;

function TUDBView.GetColOffset(c : integer) : integer;
var
     i : integer;
begin
     result := Columns[0].Width;
     for i := FirstDrawCol to C do
     result := result + Columns[i].Width;
end;

function TUDBView.GetColumn(x : integer) : integer;
var
     i : integer;
     w : integer;
begin
     x := x - Columns[0].Width;
     w := 0;
     result := 0;
     for i := FirstDrawCol to TotalColumns - 1 do
     begin
          result := i;
          w := w + Columns[i].Width;
          if w > x then break;
     end;
end;

function TUDBView.TotalColWidth : integer;
var
     i : integer;
begin
     result := 0;
     for i := 0 to TotalColumns - 1 do
          result := result + Columns[i].Width;
end;

function TUDBView.TotalWidth : integer;
begin
     result := TotalColWidth + VVBar.Width;
end;

function TUDBView.FieldByName(f : string) : TField;
begin
     result := Data.Dataset.FieldByName(f);
end;

procedure TUDBData.IAfterDelete(Dataset : TDataset);
begin
     VTotalrecords := VTotalRecords - 1;
     (Owner as TUDBView).RecNoFocused := VQuery.RecNo;
end;

procedure TUDBData.IAfterPost(Dataset : TDataset);
begin
     VTotalrecords := VQuery.RecordCount;
     (Owner as TUDBView).RecNoFocused := VQuery.RecNo;
end;

function TUDBData.GetNewId : integer;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(Owner);
     q.Connection := VConnection;
     q.Active   := false;
     q.SQL.Text := 'select max(' + VPrimaryKey + ') + 1 as maxim from ' + VTable;
     q.Active   := true;

     result := q.FieldByName('maxim').AsInteger;
     q.Free;
end;

procedure TUDBView.Refresh;
begin
     Data.Refresh;
end;

procedure TUDBData.Refresh;
begin
     NoSQLLocate_ := false;
     DoSQL;
     (Owner as TUDBView).Invalidate;
end;

procedure TUDBView.CurrentUp;
var
     i : variant;
     i_prior : variant;
     s : string;
     id : boolean;
begin
     if not Data.Active or (Data.DataSet.RecordCount = 0) or (Data.Dataset.Recno = 1) then exit;

     if s = '' then s := Data.PrimaryKey;

     id := Data.PrimaryKey = s;

     i := Data.DataSet.FieldByName(s).AsVariant;

     Data.Dataset.Prior;
     i_prior := Data.DataSet.FieldByName(s).AsVariant;

     Data.Dataset.Edit;
     if id
     then Data.Dataset.FieldByName(s).AsVariant := -999999999
     else Data.Dataset.FieldByName(s).Clear;
     Data.Dataset.Post;

     Data.Dataset.Next;
     Data.Dataset.Edit;
     Data.Dataset.FieldValues[s] := i_prior;
     Data.Dataset.Post;

     Data.DataSet.Prior;
     Data.Dataset.Edit;
     Data.Dataset.FieldValues[s] := i;
     Data.Dataset.Post;

     Data.ApplyOrder;
     Data.Dataset.Prior;

     RecNoFocused := Data.Dataset.RecNo;
end;

procedure TUDBView.SetVRounded(R : boolean);
begin
     if R
     then MakeRound(self)
     else MakeRect(self);

     VRounded := R;
end;

procedure TUDBView.CurrentDown;
var
     i : variant;
     i_next : variant;
     s  : string;
     id : boolean;
begin
     if not Data.Active or (Data.DataSet.RecordCount = 0) or (Data.Dataset.RecNo = Data.Dataset.RecordCount) then exit;

     if s = '' then s := Data.PrimaryKey;

     id := Data.PrimaryKey = s;

     i := Data.DataSet.FieldByName(s).AsVariant;

     Data.Dataset.Next;
     i_next := Data.DataSet.FieldByName(s).AsVariant;

     Data.Dataset.Edit;
     if id
     then Data.Dataset.FieldByName(s).AsVariant := -999999999
     else Data.Dataset.FieldByName(s).Clear;
     Data.Dataset.Post;

     Data.Dataset.Prior;
     Data.Dataset.Edit;
     Data.Dataset.FieldValues[s] := i_next;
     Data.Dataset.Post;

     Data.Dataset.Next;
     Data.Dataset.Edit;
     Data.Dataset.FieldValues[s] := i;
     Data.Dataset.Post;

     Data.ApplyOrder;
     Data.Dataset.Next;

     RecNoFocused := Data.Dataset.RecNo;
end;

function TUDBView.Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;
begin
     result := Data.Dataset.Locate(KeyFields,KeyValues,Options);
     if result then
     RecNoFocused := Data.DataSet.RecNo;
end;

procedure TUDBView.SetHBar(V : boolean);
begin
     VHBar.Visible := V;
     HBar := V;
     invalidate;
end;

function TUDBData.SQLText : string;
begin
     result := VQuery.SQL.Text;
end;

function TUDBView.GetLook : TUDBView;
begin
     result := nil;
end;

procedure TUDBView.SetLook(U : TUDBView);
begin
     if not (U is TUDBView) then exit;

     self.Look.Assign((U as TUDBView).Look);
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TUDBView]);
end;

procedure TUDBView.PopupF8(sender : TObject);
begin
     CallColumnFilter;
end;

procedure TUDBView.PopupF9(sender : TObject);
begin
     CallFilter;
end;

procedure TUDBView.PopupF11(sender : TObject);
begin
     ClearFilter;
end;

end.
