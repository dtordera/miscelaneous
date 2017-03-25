unit UDBAlter;

interface

uses classes, UDBView, stdctrls, db, controls, forms, UText;

type THKCustomedit = class(TCustomEdit);
type THKControl = class(TControl);

type TUDBAlterMessages = class(TPersistent)
     private
          VError,
          VSave,
          VBadValue,
          VDelete,
          VNotAllowPost   : string;
     public
          constructor Create;
     published
          property ErrorMsg  : string read VError    write VError;
          property SaveMsg   : string read VSave     write VSave;
          property BadValue  : string read VBadValue write VBadValue;
          property DeleteMsg : string read VDelete   write VDelete;
          property NotAllowPost : string read VNotAllowPost write VNotAllowPost;
end;

type TUDBAlterEvent = procedure (sender : TObject; var Stop : boolean) of object;
type TUDBAlterGetNewIdEvent = procedure (sender : TObject; var Id : integer) of object;
type TUDBDetailTableEvent = procedure (sender : TObject; Id : string) of object;
type TUDBDeleteDetailEvent = procedure (sender : TObject; id : string; var Stop : boolean) of object;

type TUDBAlterState = (asLoading,asPosting,asDeleting,asDoingNothing);

type TUDBAlterForm = class(TComponent)
     private
          VU              : TUDBView;
          VNext,VPrior,
          VOk             : TControl;
          VNextClick,
          VPriorClick,
          VOkClick          : TNotifyEvent;
          VNotAllowPost     : boolean;
          VControlPrefix    : char;
          VDataModified     : boolean;
          VBeforeLoadValues : TNotifyEvent;
          VAfterLoadValues  : TNotifyEvent;
          VOnBeforePost     : TUDBAlterEvent;
          VOnPostValues     : TNotifyEvent;
          VLoadDefValues    : TNotifyEvent;
          VMessages         : TUDBAlterMessages;
          VPrimaryField     : string;
          VBackOwnerClose   : TCloseEvent;
          VAllowedNilFields : string;
          VOnDelete         : TUDBAlterEvent;
          VOnNew            : TUDBAlterEvent;
          VOnModify         : TUDBAlterEvent;
          VOnGetNewId       : TUDBAlterGetNewIdEvent;
          VDropTempDetailTables : TUDBDetailTableEvent;
          VCreateTempDetailTables : TUDBDetailTableEvent;
          VDeleteDetailValues : TUDBDeleteDetailEvent;
          VInsertDetailValues : TUDBDetailTableEvent;
          VId               : string;
     protected
          NewRegister : boolean;
          procedure LoadValues;
          procedure SetVNext(btNext : TControl);
          procedure SetVPrior(btPrior : TControl);
          procedure SetVOk(btOk : TControl);
          procedure SetVDataModified(B : boolean);
          procedure SetOnChangeDataModified(sender : TObject);
          procedure OwnerClose(Sender: TObject; var Action: TCloseAction);
          procedure SetVNotAllowPost(b : boolean);
     public
          State : TUDBAlterState;
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          function  AskForPost : TModalResult;
          procedure BeforeDestruction; override;
          procedure AfterConstruction; override;
          procedure Next(sender : TObject);
          procedure Prior(sender : TObject);
          procedure Ok(sender : TObject);
          procedure ApplyOnChange;
          procedure DeApplyOnChange;
          function  PostChanges : boolean;
          procedure ClearAllControls;
          function  New : TModalResult;
          function  Modify : TModalResult; overload;
          function  Modify(id : integer): TModalResult; overload;
          function  ModifyNoShow : boolean;
          function  Delete : TModalResult; overload;
          function  Delete(id : integer) : TModalResult; overload;
          property  DataModified : boolean read VDataModified write SetVDataModified;
          property  Id : string read VId;
     published
          property UDBView : TUDBView read VU write VU;
          property NextButton  : TControl read VNext  write SetVNext;
          property PriorButton : TControl read VPrior write SetVPrior;
          property OkButton    : TControl read VOk    write SetVOk;
          property ControlPrefix : char read VControlPrefix write VControlPrefix default #64;
          property NotAllowPost : boolean read VNotAllowPost write VNotAllowPost;
          property BeforeLoadValues : TNotifyEvent read VBeforeLoadvalues write VBeforeLoadValues;
          property AfterLoadValues : TNotifyEvent read VAfterLoadValues write VAfterLoadValues;
          property OnBeforePost : TUDBAlterEvent read VOnBeforePost write VOnBeforePost;
          property OnPostValues : TNotifyEvent read VOnPostValues write VOnPostValues;
          property OnNew        : TUDBAlterEvent read VOnNew    write VOnNew;
          property OnModify     : TUDBAlterEvent read VOnModify write VOnModify;
          property OnDelete     : TUDBAlterEvent read VOnDelete write VOnDelete;
          property OnGetNewId   : TUDBAlterGetNewIdEvent read VOnGetNewId write VOnGetNewId;
          property LoadDefValues : TNotifyEvent read VLoadDefValues write VLoadDefValues;
          property Messages : TUDBAlterMessages read VMessages write VMessages;
          property PrimaryField : string read VPrimaryField write VPrimaryField;
          property AllowedNilFields : string read VAllowedNilFields write VAllowedNilFields;
          property DropTempDetailTables : TUDBDetailTableEvent read VDropTempDetailTables write VDropTempDetailTables;
          property DeleteDetailValues : TUDBDeleteDetailEvent read VDeleteDetailValues write VDeleteDetailValues;
          property InsertDetailValues : TUDBDetailTableEvent read VInsertDetailValues write VInsertDetailValues;
          property CreateTempDetailTables : TUDBDetailTableEvent read VCreateTempDetailTables write VCreateTempDetailTables;
end;

procedure Register;

implementation

uses UDBGlobal, sysutils, comctrls, dialogs, ULabel, UDBVAux;

constructor TUDBAlterMessages.Create;
begin
     inherited Create;
     ErrorMsg  := 'Error posting values';
     SaveMsg   := 'Save changes?';
     BadValue  := 'Value ''%VALUE%'' is not valid for Field %FIELD%';
     DeleteMsg := 'Delete register #%PRIMARY%. Continue?';
     NotAllowPost := 'Posting not allowed';
end;

constructor TUDBAlterForm.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     VMessages := TUDBAlterMessages.Create;
end;

procedure TUDBAlterForm.BeforeDestruction;
begin
{ S'Haurien de restaurar els events originals als controls buto}


{    var
     cs : boolean;
 cs := csDesigning in ComponentState;

     if Assigned(VPrior) and not cs then
     if not (csDestroying in VPrior.ComponentState) then
     if not (csFreeNotification in VPrior.ComponentState) then
     if VPrior is TCustomUText
     then (VPrior as TCustomUText).OnReact := VPriorClick
     else THKControl(VPrior).OnClick := VPriorClick;

     if Assigned(VOk) and not cs then
     if not (csDestroying in VOk.ComponentState) then
     if not (csFreeNotification in VOk.ComponentState) then
     if VOk is TCustomUText
     then (VOk as TCustomUText).OnReact := VOkClick
     else THKControl(VOk).OnClick := VOkClick;

     if Assigned(VNext) and not cs then
     if not (csDestroying in VNext.ComponentState) then
     if not (csFreeNotification in VNext.ComponentState) then
     if VNext is TCustomUText
     then (VNext as TCustomUText).OnReact := VNextClick
     else THKControl(VNext).OnClick := VNextClick;

     if not cs then
     if not (csDestroying in (Owner as TForm).ComponentState) then
     if not (csFreeNotification in (Owner as TForm).ComponentState)
     then (Owner as TForm).OnClose := VBackOwnerClose;}
end;

destructor TUDBAlterForm.Destroy;
begin
{    Es suposa alliberament del form owner. No es restabliran
     els clicks ni l'onclose dels buttons ni del form }

     VOk := nil;
     VOkClick := nil;

     VPrior := nil;
     VPriorClick := nil;

     VNext := nil;
     VNextClick := nil;

     if Assigned(VMessages) then VMessages.Free;
     inherited Destroy;
end;

procedure TUDBAlterForm.AfterConstruction;
begin
     if not (csDesigning in ComponentState) then
     begin
          VBackOwnerClose := (Owner as TForm).OnClose;
          (Owner as TForm).OnClose := OwnerClose;
     end;
end;

procedure TUDBAlterForm.ClearAllControls;
var
     i  : integer;
     o  : TObject;
     id : integer;
begin
     State := asLoading;

     with (Owner as TForm) do
     for i := 0 to VU.Data.DataSet.FieldCount - 1 do
     begin
          o := FindComponent(ControlPrefix + VU.Data.DataSet.Fields[i].FieldName);

          if o is TCustomEdit then
          (o as TCustomEdit).Text := ''
          else
          if o is TCheckBox then
          (o as TCheckBox).Checked := false
          else
          if (o is TDateTimePicker) then
          (o as TDateTimePicker).DateTime := date
          else
          if (o is TLabel) then
          (o as TLabel).Caption := ''

          {ULABELS}

          else
          if (o is TNLabel) then
          (o as TNLabel).Value := 0
          else
          if (o is TBLabel) then
          (o as TBLabel).Value := false
          else
          if (o is TDLabel) then
          (o as TDLabel).Date := 0
          else
          if (o is THLabel) then
          (o as THLabel).Time := 0;

          if (o is TCustomULabel) then
          (o as TCustomULabel).Caption := '';
     end;

     id := VU.Data.GetNewId;
     if Assigned(OnGetNewId) then OnGetNewId(self,id);

     VId := inttostr(id);

     if Assigned(CreateTempDetailTables) then CreateTempDetailtables(self,VId);

     o := (Owner as TForm).FindComponent(ControlPrefix + PrimaryField);

     if o is TNLabel       then (o as TNLabel).Value := id
     else
     if o is TCustomULabel then (o as TCustomULabel).Caption := '('+inttostr(id)+')'
     else
     if o is TLabel then (o as TLabel).Caption := '('+inttostr(id)+')'
     else
     if o is TCustomEdit then (o as TCustomEdit).Text := '(' + inttostr(id) + ')';

     State := asDoingNothing;
end;

function TUDBAlterForm.New : TModalResult;
var
     Stop : boolean;
begin
     result := mrNone;

     Stop := false;
     DataModified := true;
     NewRegister  := true;

     ClearAllControls;

     if Assigned(LoadDefValues) then LoadDefValues(self);

     if Assigned(PriorButton) then PriorButton.Visible := false;
     if Assigned(NextButton)  then NextButton.Visible  := false;

     if Assigned(OnNew) then OnNew(self,Stop);
     if Stop then exit;

     result := (Owner as TForm).ShowModal;
     UDBView.Refresh;
end;

function TUDBAlterForm.Modify : TModalResult;
var
     Stop : boolean;
begin
     result := mrNone;
     Stop := false;
     DataModified := false;
     NewRegister  := false;

     if Assigned(PriorButton) then PriorButton.Visible := true;
     if Assigned(NextButton)  then NextButton.Visible  := true;

     LoadValues;

     if Assigned(OnModify) then OnModify(self,Stop);

     if Stop then exit;

     result := (Owner as TForm).ShowModal;
     UDBView.Refresh;
end;

function TUDBAlterForm.ModifyNoShow : boolean;
var
     Stop : boolean;
begin
     result := true;
     Stop := false;
     DataModified := false;
     NewRegister  := false;

     if Assigned(PriorButton) then PriorButton.Visible := true;
     if Assigned(NextButton)  then NextButton.Visible  := true;

     LoadValues;

     if Assigned(OnModify) then OnModify(self,Stop);

     if Stop then exit;
end;

function TUDBAlterForm.Modify(id : integer) : TModalResult;
begin
     if not VU.Data.Dataset.Locate(PrimaryField,id,[]) then
     raise exception.Create('Record #' + inttostr(id) + ' not found');

     result := Modify;
end;

function TUDBAlterForm.Delete : TModalResult;
var
     Stop : boolean;
begin
     State := asDeleting;

     Stop := false;
     result := mrCancel;

     VId := VU.Data.DataSet.FieldByName(PrimaryField).AsString;

     if mDlg(stringreplace(VMessages.VDelete,'%PRIMARY%',VId
     ,[rfReplaceAll,rfIgnoreCase]),
     mtWarning,[mbYes,mbNo]) = mrYes then
     begin
          if Assigned(OnDelete) then OnDelete(self,Stop);
          if (not stop) and Assigned(DeleteDetailValues)
          then DeleteDetailValues(self,VId,stop);

          if not Stop then
          begin
               VU.Data.Dataset.Delete;
               result := mrOk;
          end;
     end;

     State := asDoingNothing;
     UDBView.Refresh;     
end;

function TUDBAlterForm.Delete(id : integer) : TModalResult;
begin
     if not VU.Data.Dataset.Locate(PrimaryField,id,[]) then
     raise exception.Create('Record #' + inttostr(id) + ' not found');

     result := Delete;
end;

procedure TUDBAlterForm.SetVDataModified(B : boolean);
begin
     VDataModified:= B and not NotAllowPost;
     if Assigned(OkButton) then OkButton.Visible := B and not NotAllowPost;
end;

procedure TUDBAlterForm.SetOnChangeDataModified(sender : TObject);
begin
     DataModified := true;
     try  ExecMethod(owner as TForm,(sender as Tcomponent).Name + 'Change',sender);
     except
     end;
     try  ExecMethod(Owner as TForm,(sender as Tcomponent).Name + 'Click',sender);
     except
     end;
end;

procedure TUDBAlterForm.OwnerClose(Sender: TObject; var Action: TCloseAction);
begin
     if AskForPost = mrCancel then
     Action := caNone
     else
     if Assigned(VBackOwnerClose) then VBackOwnerClose(Owner as TForm,Action);
end;

procedure TUDBAlterForm.ApplyOnChange;
var
     i : integer;
begin
     with Owner as TForm do
     for i := 0 to ControlCount - 1 do
          if (Controls[i] is TCustomULabel)
          then (Controls[i] as TCustomULabel).OnChange := SetOnChangeDataModified
          else
          if (Controls[i] is TCustomEdit)
          then THKCustomEdit(Controls[i] as TCustomEdit).OnChange := SetOnChangeDataModified
          else
          if (Controls[i] is TCheckBox)   then (Components[i] as TCheckBox).OnClick := SetOnChangeDataModified;
end;

procedure TUDBAlterForm.DeapplyOnChange;
var
     i : integer;
begin
     with Owner as TForm do
     for i := 0 to ControlCount - 1 do
     begin
          if (Controls[i] is TCustomEdit)
          then THKCustomEdit(Controls[i] as TCustomEdit).OnChange := nil
          else
          if (Controls[i] is TCheckBox) then (Controls[i] as TCheckBox).OnClick :=
          TNotifyEvent(GetMethod(Owner,Controls[i].Name + 'Click'))
          else
          if (Controls[i] is TCustomULabel)
          then (Controls[i] as TCustomULabel).OnChange :=
          TNotifyEvent(GetMethod(Owner,Controls[i].Name + 'Change'));
     end;
end;

function TUDBAlterForm.PostChanges : boolean;
var
     i   : integer;
     o   : TObject;
     f   : TField;
     id  : integer;
     s   : string;
     err : string;
     v   : variant;
     ss  : TStrings;
     Stop : boolean;
     AFS  : TDatasetNotifyEvent;
begin
     result := false;
     if VNotAllowPost and (Messages.NotAllowPost <> '') then
     begin
          mDlg(Messages.NotAllowPost,mtWarning,[mbOK]);
          exit;
     end
     else
     if VNotAllowPost then exit;

     if Assigned(OnBeforePost) then OnBeforePost(self,Stop);
     if Stop then begin result := false; exit; end;

     State := asPosting;

     ss := TStringList.Create;
     ss.CommaText := VAllowedNilFields;

     err := '';

     id := -1;

     AFS := VU.Data.Dataset.AfterScroll;
     VU.Data.Dataset.AfterScroll := nil;

     if NewRegister then
     begin
          id := VU.Data.GetNewId;
          if Assigned(OnGetNewId) then OnGetNewId(self,id);

          o := (Owner as TForm).FindComponent(ControlPrefix + PrimaryField);

          if o is TCustomULabel then (o as TCustomULabel).Caption := inttostr(id)
          else
          if o is TCustomLabel then (o as TLabel).Caption := inttostr(id)
          else
          if o is TCustomEdit then (o as TCustomEdit).Text := inttostr(id);

          VU.Data.DataSet.Append;
          VU.Data.DataSet.FieldValues[PrimaryField] := id;
     end
     else
     begin
          o := (Owner as TForm).FindComponent(ControlPrefix + PrimaryField);

          if o is TCustomULabel then VId := (o as TCustomULabel).Caption
          else
          if o is TCustomLabel then VId := (o as TLabel).Caption
          else
          if o is TCustomEdit then VId := (o as TCustomEdit).Text;

          id := strtoint(VId);

          if not VU.Data.DataSet.Locate(PrimaryField,id,[]) then
          err := 'Error buscant registre amb ' + PrimaryField + ' = ' + VId
          else
          VU.Data.DataSet.Edit;
     end;

     if err = '' then
     with (Owner as TForm) do
     for i := 0 to VU.Data.DataSet.FieldCount - 1 do
     begin
          f := VU.Data.DataSet.Fields[i];
          if UpperCase(f.FieldName) = UpperCase(PrimaryField) then continue;

          o := FindComponent(ControlPrefix + f.FieldName);

          if not assigned(o) then continue;

          if o is TCustomEdit then
          v := (o as TCustomEdit).Text
          else
          if o is TCheckBox then
          v := (o as TCheckBox).Checked
          else
          if (o is TDateTimePicker) then
          v := (o as TDateTimePicker).DateTime
          else
          if (o is TLabel) then
          v := (o as TLabel).caption
          else
          {ULABELS}
          if o is TBLabel then
          v := (o as TBLabel).Value
          else
          if (o as TCustomULabel).Caption <> ''
          then
          begin
               if o is TNLabel then
               v := (o as TNLabel).Value
               else
               if o is TDLabel then
               begin
                    if (o as TDLabel).Date <> 0
                    then v := (o as TDLabel).Date
                    else begin f.clear; v := ''; end;
               end
               else
               if o is THLabel then
               v := (o as THLabel).Time
               else
               if o is TCustomULabel then
               v := (o as TCustomULabel).Caption;
          end
          else
          v := '';

          try
               f.Value := v;
          except
               if ss.Indexof(f.FieldName) = -1 then
               begin
               s := StringReplace(VMessages.VBadValue,'%FIELD%',f.FieldName,[rfReplaceAll,rfIgnoreCase]);
               s := StringReplace(s,'%VALUE%',v,[rfReplaceAll,rfIgnoreCase]);
               err := s;
               end;
               f.Clear;
          end;
     end;

     ss.Free;

     if err = '' then
     try
     VU.Data.DataSet.Post;
     except
     err := VMessages.VError;
     end;

     if err = '' then
     begin
          if Assigned(DeleteDetailValues) then DeleteDetailValues(self,inttostr(id),Stop);
          if Assigned(InsertDetailValues) then InsertDetailValues(self,inttostr(id));

          if Assigned(OnPostValues) then OnPostValues(self);

          DataModified := false;
          NewRegister  := false;
     end
     else
     begin
          if NewRegister then
          begin
               if VU.Data.Dataset.Locate(VPrimaryField,id,[]) then
               VU.Data.Dataset.Delete
               else
               mDLG('Error localitzant registre # ' + inttostr(id),mtError,[mbOk]);
          end;
          mDlg(err,mtError,[mbOk]);
     end;

     State := asDoingNothing;
     VU.Data.Dataset.AfterScroll := AFS;

     result := err = '';
end;

function TUDBAlterForm.AskForPost: TModalResult;
begin
     result := mrNo;

     if DataModified then
     result := mDLG(VMessages.VSave,mtInformation,[mbYes,mbNo,mbCancel]);

     if result = mrYes then
     if not PostChanges then result := mrCancel;

     if result <> mrCancel then
     if Assigned(DropTempDetailTables) then DropTempDetailTables(self,VId);
end;

procedure TUDBAlterForm.Next(sender : TObject);
begin
     if Assigned(VNextClick) then VNextClick(sender);

     if AskForPost = mrCancel then exit;

     if Assigned(VU) and (VU.Data.DataSet.RecNo < VU.Data.DataSet.RecordCount)
     then VU.Down;

     LoadValues;
end;

procedure TUDBAlterForm.Prior(sender : TObject);
begin
     if Assigned(VPriorClick) then VPriorClick(sender);

     if AskForPost = mrCancel then exit;

     if Assigned(VU) and (VU.Data.DataSet.RecNo > 1)
     then VU.Up;

     LoadValues;
end;

procedure TUDBAlterForm.Ok(sender : TObject);
begin
     if Assigned(VOkClick) then VOkClick(sender);
     if PostChanges then (owner as TForm).modalresult := mrOk;
end;

procedure TUDBAlterForm.SetVNext(btNext : TControl);
var
     cs : boolean;
begin
     if btNext = VNext then exit;

     if (csDesigning in ComponentState) then
     begin
          VNext := btNext;
          exit;
     end;

     cs := not (csDesigning in ComponentState);

     // restaurem control
     if Assigned(VNext) and cs then
     begin
          if (VNext is TCustomUText)
          then (VNext as TCustomUText).OnReact := VNextClick
          else THKControl(VNext).OnClick := VNextClick;
     end;

     // salvem event del nou
     if Assigned(btNext) and cs then
     begin
          if (btNext is TCustomUText)
          then VNextClick := (btNext as TCustomUText).OnReact
          else VNextClick := THKControl(btNext).OnClick;
     end;

     // assignem
     VNext := btNext;

     // coloquem nou evente
     if Assigned(VNext) and cs then
     begin
          if (VNext is TCustomUText)
          then (VNext as TCustomUText).OnReact := Next
          else THKControl(VNext).OnClick := Next;
     end;
end;

procedure TUDBAlterForm.SetVOk(btOk : TControl);
var
     cs : boolean;
begin
     if btOk = VOk then exit;

     if (csDesigning in ComponentState) then
     begin
          VOk := btOk;
          exit;
     end;

     cs := not (csDesigning in ComponentState);

     // restaurem control
     if Assigned(VOk) and cs then
     begin
          if (VOk is TCustomUText)
          then (VOk as TCustomUText).OnReact := VOkClick
          else THKControl(VPrior).OnClick := VOkClick;
     end;

     // salvem evente del nou
     if Assigned(btOk) and cs then
     begin
          if (btOk is TCustomUText)
          then VOkClick := (btOk as TCustomUText).OnReact
          else VOkClick := THKControl(btOk).OnClick;
     end;

     // assignem
     VOk := btOk;

     // coloquem nou evente
     if Assigned(VOk) and cs then
     begin
          if (VOk is TCustomUText)
          then (VOk as TCustomUText).OnReact := Ok
          else THKControl(VOk).OnClick := Ok;
     end;
end;

procedure TUDBAlterForm.SetVPrior(btPrior : TControl);
var
     cs : boolean;
begin
     if btPrior = VPrior then exit;

     if (csDesigning in ComponentState) then
     begin
          VPrior := btPrior;
          exit;
     end;

     cs := not (csDesigning in ComponentState);

     // restaurem control
     if Assigned(VPrior) and cs then
     begin
          if (VPrior is TCustomUText)
          then (VPrior as TCustomUText).OnReact := VPriorClick
          else THKControl(VPrior).OnClick := VPriorClick;
     end;

     // salvem evente del nou
     if Assigned(btPrior) and cs then
     begin
          if (btPrior is TCustomUText)
          then VPriorClick := (btPrior as TCustomUText).OnReact
          else VPriorClick := THKControl(btPrior).OnClick;
     end;

     // assignem
     VPrior := btPrior;

     // coloquem nou evente
     if Assigned(VPrior) and cs then
     begin
          if (VPrior is TCustomUText)
          then (VPrior as TCustomUText).OnReact := Prior
          else THKControl(VPrior).OnClick := Prior;
     end;
end;

procedure TUDBAlterForm.LoadValues;
var
     i : integer;
     f : TField;
     o : TObject;
begin
     if not Assigned(VU) then exit;

     State := asLoading;

     DeApplyOnChange;

     for i := 0 to VU.Data.DataSet.FieldCount - 1 do
     begin
          f := VU.Data.DataSet.Fields[i];
          o := (Owner as TForm).FindComponent(ControlPrefix + f.FieldName);

          if UpperCase(VPrimaryField) = UpperCase(f.FieldName) then
          VId := f.AsString;

          if o is TCustomEdit then
          (o as TCustomEdit).Text := f.AsString
          else
          if o is TCheckBox then
          (o as TCheckBox).Checked := f.AsBoolean
          else
          if (o is TDateTimePicker) then
          (o as TDateTimePicker).DateTime := f.AsDateTime
          else
          if (o is TLabel) then
          (o as TLabel).Caption := f.AsString;

          {ULABELS}

          if o is TBLabel then
          (o as TBLabel).Value := f.AsBoolean
          else
          if o is TNLabel then
          (o as TNLabel).Value := f.AsFloat
          else
          if o is TCustomULabel then
          (o as TCustomULabel).Caption := f.AsString;

          if f.AsString <> '' then
          if o is TDLabel then
          (o as TDLabel).Date := f.AsDateTime
          else
          if o is THLabel then
          (o as THLabel).Time := f.AsDateTime
     end;

     ApplyOnChange;

     if Assigned(CreateTempDetailTables) then CreateTempDetailtables(self,VId);

     DataModified       := false;

     if Assigned(OkButton) then OkButton.Visible   := false;

     if Assigned(AfterLoadValues) then AfterLoadValues(self);

     State := asDoingNothing;
end;

procedure TUDBAlterForm.SetVNotAllowPost(b : boolean);
begin
     VNotAllowPost := b;
     DataModified := DataModified;
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TUDBAlterForm]);
end;

end.
