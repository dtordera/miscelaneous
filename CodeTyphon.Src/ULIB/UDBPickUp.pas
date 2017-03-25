unit UDBPickUp;

interface

uses classes, dialogs, UDBView, UDBVAux, Forms, controls, dbgrids, windows, db;

type TPickUpEvent = procedure (sender : TObject; dataset : TDataSet;var AllowClose : boolean) of object;
type TShowPickFormEvent = procedure (sender : TObject; F : TCustomForm;U : TUDBView) of object;

type TUDBPickUp = class(TComponent)
     private
          VLook      : TUDBLook;
          VData      : TUDBData;
          VOnPickUp  : TPickUpEvent;
          VPickAndOk : boolean;
          FOnShow    : TShowPickFormEvent;
     protected
          procedure PreparaForm;
     public
          U : TUDBView;
          F : TForm;
          procedure   PickUpFromGrid(sender : TObject);
          procedure   KeyDownGrid(Sender: TObject; var Key: Word; Shift: TShiftState);
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          function    PickModal : TModalResult;
          procedure   Pick;
     published
          property OnShowPickForm : TShowPickFormevent read FOnShow write FOnShow;
          property Look      : TUDBLook   read VLook write VLook;
          property Data      : TUDBData   read VData   write VData;
          property OnPickUp  : TPickUpEvent   read VOnPickUp write VOnPickUp;
          property PickAndOk : boolean        read VPickAndOk write VPickAndOk;

end;

procedure Register;

implementation

uses UDBLabel;

procedure Register;
begin
     RegisterComponents('pkULIB',[TUDBPickUp]);
end;

constructor TUDBPickUp.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     RegisterClasses([TForm]);

     F := TForm.Create(nil);

     U := TUDBView.Create(nil);
     U.Align  := alClient;
     U.Parent := F;

     VLook := U.Look;
     VData   := U.Data;
end;

destructor TUDBPickUp.Destroy;
begin
     U.Free;
     F.Free;
     inherited Destroy;
end;

procedure TUDBPickUp.PreparaForm;
begin
     U.Data.Active := true;
     U.Kind := uvPick;

     U.OnDblClick := PickUpFromGrid;
     U.OnKeyDown  := KeyDownGrid;

     F.ClientWidth  := U.TotalWidth;
     F.ClientHeight := U.Look.DataRowHeight * 26 + U.Look.FixedRowHeight;

     if F.Height > Screen.Height then F.Height := Screen.Height;
     if F.Width  > Screen.Width  then F.Width := Screen.Width;
     F.Position  := poDesktopCenter;

     F.ActiveControl := U;
     F.BringToFront;
end;

procedure TUDBPickUp.PickUpFromGrid(sender : TObject);
var
     ac : boolean;
begin
     ac := true;

     if Assigned(OnPickUp) then OnPickUp(sender,U.Data.Dataset,ac);
     if PickAndOk and ac then begin F.ModalResult := mrOk; F.Close; end;
end;

procedure TUDBPickUp.KeyDownGrid(Sender: TObject; var Key: Word; Shift: TShiftState);
var
     ac : boolean;
begin
     ac := True;

     case Key of
     VK_RETURN : begin
                    if Assigned(OnPickUp) then OnPickUp(sender,U.Data.Dataset,ac);
                    if PickAndOk and ac then begin F.ModalResult := mrOk; F.Close; end;
                    Key := 0;
                 end;
     VK_ESCAPE : begin
                    F.modalresult := mrCancel;
                    F.close;
                 end;
     end;
end;

function  TUDBPickUp.PickModal : TModalResult;
var
     s : string;
     v : variant;
begin
     PreparaForm;
     if F.Visible then F.Close;

     if Assigned(FOnShow) then FOnShow(self,F,U);

     if (Owner is TUDBLabel) then
     begin
          s := (Owner as TUDBLabel).Field;
          v := (Owner as TUDBLabel).Caption;

          try U.Locate(s,v,[]);
          except
          end;
     end;

     F.ClientWidth := U.TotalWidth;
     result := F.ShowModal;
end;

procedure TUDBPickUp.Pick;
begin
     PreparaForm;

     if Assigned(FOnShow) then FOnShow(self,F,U);

     if (Owner is TUDBLabel) then
     try  U.Data.Dataset.Locate((Owner as TUDBLabel).Field,(Owner as TUDBLabel).caption,[]);
     except
     end;

     F.ClientWidth := U.TotalWidth;
     F.Show;
end;

end.
