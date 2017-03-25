unit UDBLabel;

interface

uses classes, UDBPickUp, db, stdctrls, Ulabel, Forms,UDBView,UDBVAux, comctrls;

type TUDBPickUpStyle = (psNoModal,psModal,psModalOnePick);

type TUDBLabel = class(TCustomULabel)
     private
          P  : TUDBPickUp;
          D  : TUDBData;
          C  : TUDBLook;
          PS : TUDBPickUpStyle;
          VField   : string;
          VDFields : TStrings;
     protected
          procedure   PickUp;
          procedure   OnPick(sender : TObject; dataset : TDataSet; var AllowClose : boolean);
          procedure   SetOnShowPickFormEvent(S : TShowPickFormEvent);
          function    GetOnShowPickFormEvent : TShowPickFormEvent;
     public
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          procedure   Click; override;
          procedure   ApplyDerivedfields(dataset : TDataSet);
          procedure   SetVDFields(D : TStrings);
     published
          property Data      : TUDBData read D write D;
          property Look      : TUDBLook read C write C;
          property PickStyle     : TUDBPickUpStyle read PS write PS;
          property Field         : string read VField write VField;
          property DerivedFields : TStrings read VDFields write SetVDFields;
          property OnShowPickForm : TShowPickFormEvent read GetOnShowPickFormEvent write SetOnShowPickFormEvent;
end;

procedure Register;

implementation

uses sysutils;

procedure  TUDBLabel.SetVDFields(D: TStrings);
begin
     VDFields.Assign(D);
end;

constructor TUDBLabel.Create(AOwner : TComponent);
begin
     P := TUDBPickUp.Create(self);
     P.OnPickUp := OnPick;
     D := P.Data;
     C := P.Look;

     VDFields := TStringList.Create;

     inherited Create(AOwner);
end;

destructor TUDBLabel.Destroy;
begin
     if Assigned(VDFields) then VDFields.Free;
     if Assigned(P) then P.Free;
     inherited Destroy;
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TUDBLabel]);
end;

procedure TUDBLabel.PickUp;
begin
     case PickStyle of
     psNoModal :      begin
                           P.PickAndOk := false;
                           P.Pick;
                      end;
     psModal   :      begin
                           P.PickAndOk := false;
                           P.PickModal;
                      end;
     psModalOnePick : begin
                           P.PickAndOk := true;
                           P.PickModal;
                      end;
     end;
end;

procedure TUDBLabel.OnPick(sender : TObject; dataset : TDataSet;
var AllowClose : boolean);
var
     Stop : boolean;
     s : string;
begin
     Stop := false;
     s := DataSet.FieldByName(field).AsString;

     if Assigned(OnChangeValue) then OnChangeValue(self,s,Stop);
     if Assigned(OnChange) then OnChange(self);

     if Stop then exit;

     Caption := s;
     if Assigned(OnValueToCaption) then OnValueToCaption(self);

     ApplyDerivedFields(dataset);
end;

procedure TUDBLabel.SetOnShowPickFormEvent(S : TShowPickFormEvent);
begin
     P.OnShowPickForm := S;
end;

function  TUDBLabel.GetOnShowPickFormEvent : TShowPickFormEvent;
begin
     result := P.OnShowPickForm;
end;

procedure TUDBLabel.Click;
begin
     inherited;
     PickUp;
end;

procedure TUDBLabel.ApplyDerivedfields(dataset : TDataSet);
var
     i : integer;
     p,s,v : string;
     o : TObject;
begin
     for i := 0 to DerivedFields.Count - 1 do
     begin
          try
               p := DerivedFields[i];
               s := Trim(Copy(p,0,Pos('=',p) - 1));
               v := Trim(Copy(p,Pos('=',p) + 1,Length(p) - Pos('=',p)));

               o := (Owner as TComponent).FindComponent(s);

               if o is TCustomEdit  then (o as TCustomEdit).Text := DataSet.FieldByName(v).AsString
               else
               if o is TLabel then (o as TLabel).Caption := DataSet.FieldByName(v).AsString
               else
               if o is TDateTimePicker then (o as TDateTimePicker).Date := DataSet.FieldByName(v).AsDateTime
               else
               if o is TCheckBox then (o as TCheckBox).Checked := DataSet.FieldByName(v).AsBoolean;

     {ULABELS}
               if o is TNLabel then
               (o as TNLabel).Value := DataSet.FieldByName(v).AsFloat
               else
               if o is TBLabel then
               (o as TBLabel).Value := DataSet.FieldByName(v).AsBoolean
               else
               if o is THLabel then
               (o as THLabel).Time  := DataSet.FieldByName(v).AsDateTime
               else
               if o is TDLabel then
               (o as TDLabel).Date  := DataSet.FieldByName(v).AsDateTime
               else
               if o is TCustomULabel then
               (o as TCustomULabel).Caption := DataSet.FieldByName(v).AsString
          except
               raise exception.Create('Error UDBLabel: ' + p);
          end;
      end;
end;

end.
