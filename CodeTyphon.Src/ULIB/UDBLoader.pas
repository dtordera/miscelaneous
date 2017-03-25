unit UDBLoader;

interface

uses classes, db, controls, ULabel;

type THKControl = class(TControl);

type TUDBStopEvent = procedure (sender : TObject; var Stop : boolean) of object;
type TUDBLoader = class(TComponent)
     private
          FControlPrefix : string;
          FPrimaryField  : string;
          FDataSet       : TDataSet;
          FBeforeLoad    : TUDBStopEvent;
          FAfterLoad     : TNotifyEvent;
          FBeforePost    : TUDBStopEvent;
          FAfterPost     : TNotifyEvent;
          FFormatFloat   : string;
     protected
     public
          procedure LoadFromDataSet;
          procedure ClearControls;
          procedure PostToDataSet;
     published
          property ControlPrefix : string read FControlPrefix write FControlPrefix;
          property DataSet : TDataSet read FDataSet write FDataSet;
          property BeforeLoad : TUDBStopEvent read FBeforeLoad write FBeforeLoad;
          property AfterLoad  : TNotifyEvent read FAfterLoad write FAfterLoad;
          property BeforePost : TUDBStopEvent read FBeforePost write FBeforePost;
          property AfterPost  : TNotifyEvent read FAfterPost write FAfterPost;
          property PrimaryField : string read FPrimaryField write FPrimaryField;
          property FloatFormat : string read FFormatFloat write FFormatFloat;
end;

procedure Register;

implementation

uses sysutils, stdctrls;

procedure TUDBLoader.ClearControls;
var
     i : integer;
     o : TObject;
begin
     if not Assigned(DataSet) then exit;

     for i := 0 to DataSet.FieldCount - 1 do
     begin
          o := FindComponent(FControlPrefix + DataSet.Fields[i].FieldName);

{          if o is TNEdit then
          (o as TNedit).Value := 0
          else}
          if o is TCustomEdit then
          (o as TCustomEdit).Text := ''
          else
          if o is TCheckBox then
          (o as TCheckBox).Checked := false
          else
{          if (o is TDateTimePicker) then
          (o as TDateTimePicker).DateTime := date
          else                                   }
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
end;

procedure TUDBLoader.PostToDataSet;
var
     Stop : boolean;
     i : integer;
     o : TObject;
     v : variant;
begin
     if not Assigned(DataSet) then exit;

     Stop := false;
     if Assigned(BeforePost) then BeforePost(Self,Stop);
     if Stop then exit;

     DataSet.Edit;
     for i := 0 to DataSet.FieldCount - 1 do
     begin
          if UpperCase(DataSet.Fields[i].FieldName) =
             UpperCase(PrimaryField) then continue;

          o := Owner.FindComponent(ControlPrefix + DataSet.Fields[i].FieldName);
          if not (Assigned(o) and (o is TControl)) then continue;

          if o is TCustomEdit then
               v := (o as TCustomEdit).Text
          else
          if o is TNLabel then
               v := (o as TNLabel).Value
          else
          if o is TDLabel then
               v := (o as TDLabel).Date
          else
          if o is THLabel then
               v := (o as THLabel).Time
          else
          if o is TCustomULabel then
               v := (o as TCustomULabel).Caption
          else
          if o is TCustomLabel then
               v := THKControl(o).Caption;

          if o is TCheckBox then
               DataSet.Fields[i].Value := (o as TCheckBox).Checked;

          if v = '' then
          DataSet.Fields[i].Clear
          else
          DataSet.Fields[i].Value := v;
     end;
     DataSet.Post;
     DataSet.Refresh;

     if Assigned(AfterPost) then AfterPost(self);
end;

procedure TUDBLoader.LoadFromDataSet;
var
     Stop : boolean;
     i : integer;
     o : TObject;
     v : variant;
begin
     if not Assigned(DataSet) then exit;

     Stop := false;
     if Assigned(BeforeLoad) then BeforeLoad(Self,Stop);
     if Stop then exit;

     for i := 0 to DataSet.FieldCount - 1 do
     begin
          o := Owner.FindComponent(ControlPrefix + DataSet.Fields[i].FieldName);
          if not (Assigned(o) and (o is TControl)) then continue;

          v := DataSet.Fields[i].Value;

          if (o is TNLabel) then try (o as TNLabel).Value := v except (o as TNLabel).Value := 0; end
          else
          if (o is TDLabel) then try (o as TDLabel).Date := v except (o as TDLabel).Date := 0; end
          else
          if (o is THLabel) then try (o as THLabel).Time := v except (o as THLabel).Time := 0; end
          else
          if (o is TBLabel) then try (o as TBLabel).Value := v except (o as TBLabel).Value := false; end
          else
          if (o is TCustomULabel) then (o as TCustomULabel).Caption := v
          else
          if o is TCheckBox
          then (o as TCheckBox).Checked := v = 'true'
          else
          if o is TCustomLabel
          then THKControl(o).Caption := v;
     end;

     if Assigned(AfterLoad) then AfterLoad(self);
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TUDBLoader]);
end;

end.