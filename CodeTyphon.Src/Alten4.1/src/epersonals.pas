unit epersonals;

interface

uses Windows, UDBAlter, Controls, ExtCtrls, StdCtrls, UText, UDBLabel,
  LlistCfg,ULabel, Classes, Gradient, Forms, estilcolor, UDBView, Dialogs, sysutils,Graphics;

type TTipusDades = (tdClient,tdReparador,tdProveedor,tdGeneral);

type
  T_epersonals = class(TForm)
    Bevel1: TBevel;
    UDBAlterForm: TUDBAlterForm;
    UText1: TUText;
    UText2: TUText;
    UText3: TUText;
    UText4: TUText;
    UText5: TUText;
    UText6: TUText;
    UText7: TUText;
    dNOM: TTLabel;
    dTEL: TTLabel;
    dDIR: TTLabel;
    dOBS: TXLabel;
    dULTIMA_ACCIO: TDLabel;
    btEntrar: TUText;
    btSeguent: TUText;
    btAnterior: TUText;
    btCancel: TButton;
    dNIF: TKLabel;
    GradientNC1: TGradientNC;
    dID: TNLabel;
    Panel1: TPanel;
    dA_COMPTE: TNLabel;
    dEN_DEUTE: TNLabel;
    dREPETIT: TNLabel;
    lbGuio: TULabel;
    dCP: TULabel;
    UText8: TUText;
    dTIPUS: TMLabel;
    dTIPUS_DESCR: TULabel;
    UText9: TUText;
    UText10: TUText;
    UText11: TUText;
    UText12: TUText;
    UText13: TUText;
    dPOB: TUDBLabel;
    procedure UDBAlterFormAfterLoadValues(Sender: TObject);
    procedure UDBAlterFormLoadDefValues(Sender: TObject);
    procedure dNOMChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dTELChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dDIRChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dNIFChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dNOMValueToCaption(Sender: TObject);
    procedure dNIFValueToCaption(Sender: TObject);
    procedure dDIRValueToCaption(Sender: TObject);
    procedure dTELValueToCaption(Sender: TObject);
    procedure UText5React(Sender: TObject);
    procedure dPOBValueToCaption(Sender: TObject);
    procedure dCPSetInnerCaption(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure UDBAlterFormBeforePost(sender: TObject; var Stop: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure dTIPUSValueToCaption(Sender: TObject);
    procedure dPOBShowPickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
  private
     VCampFocus : string;
     VTipusDades : TTipusDades;
     procedure BuscaFocused;
  public
     procedure ColorBanda;
     procedure SetVCampFocus(s : string);
  published
     property  CampFocus : string read VCampFocus write SetVCampFocus;
     function  Nou_Client : TModalResult;
     function  Nou_Reparador : TModalResult;
     function  Nou_Proveedor : TModalResult;
     procedure Nou;
     procedure Modificar;
     function  Modificar_per_id(id : integer) : TModalResult;
     procedure Eliminar;
  end;

implementation

{$R *.DFM}

uses personals, normalit, global, dmsrc, ADOdb, epoblacions, poblacions;

function T_epersonals.Nou_Client : TModalResult;
begin
     VTipusDades := tdClient;
     result := UDBAlterForm.New;
end;

function T_epersonals.Nou_Reparador : TModalResult;
begin
     VTipusDades := tdReparador;
     result := UDBAlterForm.New;
end;

function T_epersonals.Nou_Proveedor : TModalResult;
begin
     VTipusDades := tdProveedor;
     result := UDBAlterForm.New;
end;

procedure T_epersonals.Nou;
begin
     VTipusDades := tdGeneral;
     UDBAlterForm.New;
end;

procedure T_epersonals.SetVCampFocus(s : string);
var
     o : TObject;
     i : integer;
begin
     VCampFocus := s;

     o := FindComponent('d'+VCampFocus);

     for i := 0 to ControlCount - 1 do
     if (Controls[i] is TUText) and ((Controls[i] as TUText).LinkedControl = o) then
     (Controls[i] as TUText).SetFocus;
end;

procedure T_epersonals.BuscaFocused;
var
     i : integer;
begin
     for i := 0 to ControlCount - 1 do
     if (Controls[i] is TUText) then (Controls[i] as TUText).ApplyDefaultStyle;

     if (ActiveControl is TUText) then (ActiveControl as TUText).ApplyMouseOverStyle;
end;

procedure T_epersonals.Modificar;
begin
     BuscaFocused;

     if _personals.RegistreAssociat
     and (mDlg('Aquest registre t� dades associades (averies, pressupostos, ventes, entrades). No s''actualitzaran les dades associades. Continuar?',mtWarning,[mbYes,mbNo]) <> mrYes)
     then exit;

     if _personals.v.Data.DataSet.RecordCount > 0
     then UDBAlterForm.Modify
     else mDlg('No hi ha registres a modificar',mtInformation,[mbOk]);
end;

function T_epersonals.Modificar_per_id(id : integer) : TModalResult;
begin
     // codis no v�lids??

     result := UDBAlterForm.Modify(id);
end;

procedure T_epersonals.Eliminar;
begin
     if _personals.RegistreAssociat then
     begin
          mDlg('Aquest registre t� altres dades associades, per lo que no es pot eliminar.',mtError,[mbOk]);
          exit;
     end;

     if _personals.v.Data.DataSet.RecordCount > 0
     then UDBAlterForm.Delete
     else mDlg('No hi ha registres a eliminar',mtInformation,[mbOk]);
end;

procedure T_epersonals.ColorBanda;
var
     c : TColor;
     s : string;
begin
     c := clBtnFace;

     if dREPETIT.Value > 1 then
     case Round(dREPETIT.Value) of
     2 : begin c := C_REPETIT_2; s := 'personal repetit a dos de nom, direcci�, NIF o tel�fon'; end;
     3 : begin c := C_REPETIT_3; s := 'personal repetit a 3 o m�s camps identificadors. Probablement personal registrat 2 o m�s cops.'; end;
     4 : begin c := C_REPETIT_4; s := 'personal entrat varis cops (nom, direcci�, NIF i tel�fon repetit)'; end;
     end
     else
     if (dULTIMA_ACCIO.Caption = '') then c := clBtnFace
     else
     if (date - dULTIMA_ACCIO.Date > 730) then
     begin
          c := C_MESDOSANYS;
          s := 'personal inactiu dos o m�s anys';
     end;

     Panel1.Visible := c <> clBtnFace;
     Panel1.Color := c;
     Panel1.Font.Color := NegLumColor(c);
     Panel1.caption := s;
end;

procedure T_epersonals.UDBAlterFormAfterLoadValues(Sender: TObject);
const
     S : array [0..3] of string = ('(client)','(reparador)','(proveedor)','(general)');
begin
     UDBAlterForm.DeApplyOnChange;
     ColorBanda;
     dTIPUS.ItemIndex := dTIPUS.Items.IndexOf(dTIPUS.Caption);
     UDBAlterForm.ApplyOnChange;
end;

procedure T_epersonals.UDBAlterFormLoadDefValues(Sender: TObject);
begin
     Panel1.Visible := false;
     dTIPUS.ItemIndex := integer(VTipusDades);

     dA_COMPTE.Value := 0;
     dEN_DEUTE.Value := 0;
     dREPETIT.Value  := 0;
     dNOM.Caption := '(NOM)';
     dNIF.Caption := '(N.I.F.)';
     dDIR.Caption := '(DIRECCI�)';
     dPOB.Caption := '(POBLACI� - C.P.)';
     dTEL.Caption := '(TEL�FON; E.MAIL)';
     dOBS.Caption := '(OBSERVACIONS)';
end;

procedure T_epersonals.dNOMChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
var
     q : TADOQuery;
     s : string;
begin
     if V = '' then exit;
     V := AnsiQuotedStr('%'+V+'%','''');

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from personals where NOM like ' + V + ' and (id <> ' + dID.Caption + ')';
     q.Active   := true;

     if q.RecordCount > 0 then
     begin
          q.First;
          s := '';
          while not q.Eof do
          begin
               s := s + #13#10 + q.FieldByName('id').AsString + ' - ' + q.FieldByName('nom').AsString + ' (' +
               q.FieldByName('NIF').AsString + ') - ' + q.FieldByName('dir').AsString + '; ' + q.FieldByName('tel').AsString +
               '; ' + q.FieldByName('POB').AsString + ' - ' + q.FieldByName('cp').AsString;
               q.Next;
          end;

          Cancel := mDlg('S''han trobat registres ja existents amb nom similar:'+s+#13#10#13#10+'Continuar?',mtInformation,
          [mbYes,mbNo]) <> mrYes;

          if not Cancel then dREPETIT.Value := dREPETIT.Value + 1;
     end;

     q.Free;
end;

procedure T_epersonals.dTELChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
var
     q : TADOQuery;
     s : string;
begin
     if V = '' then exit;
     V := AnsiQuotedStr('%'+V+'%','''');

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from personals where TEL like ' + V + ' and (id <> ' + dID.Caption + ')';
     q.Active   := true;

     if q.RecordCount > 0 then
     begin
          q.First;
          s := '';
          while not q.Eof do
          begin
               s := s + #13#10 + q.FieldByName('id').AsString + ' - ' + q.FieldByName('nom').AsString + ' (' +
               q.FieldByName('NIF').AsString + ') - ' + q.FieldByName('dir').AsString + '; ' + q.FieldByName('tel').AsString +
               '; ' + q.FieldByName('POB').AsString + ' - ' + q.FieldByName('cp').AsString;
               q.Next;
          end;

          Cancel := mDlg('S''han trobat registres ja existents amb tel�fon similar:'+s+#13#10#13#10+'Continuar?',mtInformation,
          [mbYes,mbNo]) <> mrYes;

          if not Cancel then dREPETIT.Value := dREPETIT.Value + 1;
     end;

     q.Free;
end;

procedure T_epersonals.dDIRChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
var
     q : TADOQuery;
     s : string;
begin
     if V = '' then exit;
     V := AnsiQuotedStr('%'+V+'%','''');

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from personals where DIR like ' + V + ' and (id <> ' + dID.Caption + ')';
     q.Active   := true;

     if q.RecordCount > 0 then
     begin
          q.First;
          s := '';
          while not q.Eof do
          begin
               s := s + #13#10 + q.FieldByName('id').AsString + ' - ' + q.FieldByName('nom').AsString + ' (' +
               q.FieldByName('NIF').AsString + ') - ' + q.FieldByName('dir').AsString + '; ' + q.FieldByName('tel').AsString +
               '; ' + q.FieldByName('POB').AsString + ' - ' + q.FieldByName('cp').AsString;
               q.Next;
          end;

          Cancel := mDlg('S''han trobat registres ja existents amb direcci� similar:'+s+#13#10#13#10+'Continuar?',mtInformation,
          [mbYes,mbNo]) <> mrYes;

          if not Cancel then dREPETIT.Value := dREPETIT.Value + 1;
     end;

     q.Free;
end;

procedure T_epersonals.dNIFChangeValue(sender: TObject;V: Variant;
  var Cancel: Boolean);
var
     q : TADOQuery;
     s : string;
begin
     V := AnsiUppercase(Trim(NoDblSpace(stringreplace(V,' ','',[rfReplaceAll]))));
     V := StringReplace(V,'-','',[rfReplaceAll]);

     if V = '' then exit;

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from personals where NIF like ''' + '%' + V + '%' + ''' and (id <> ' + dID.Caption + ')';
     q.Active   := true;

     if q.RecordCount > 0 then
     begin
          q.First;
          s := '';
          while not q.Eof do
          begin
               s := s + #13#10 + q.FieldByName('id').AsString + ' - ' + q.FieldByName('nom').AsString + ' (' +
               q.FieldByName('NIF').AsString + ') - ' + q.FieldByName('dir').AsString + '; ' + q.FieldByName('tel').AsString +
               '; ' + q.FieldByName('POB').AsString + ' - ' + q.FieldByName('cp').AsString;
               q.Next;
          end;

          Cancel := mDlg('S''han trobat registres ja existents amb el mateix N.I.F.:'+s+#13#10#13#10+'Continuar?',mtInformation,
          [mbYes,mbNo]) <> mrYes;

          if not Cancel then dREPETIT.Value := dREPETIT.Value + 1;
     end;

     q.Free;
end;

procedure T_epersonals.dNOMValueToCaption(Sender: TObject);
begin
     dNOM.Caption := NormalitzaNom(dNOM.Caption);
end;

procedure T_epersonals.dNIFValueToCaption(Sender: TObject);
begin
     dNIF.Caption := NormalitzaNIF(dNIF.Caption);
end;

procedure T_epersonals.dDIRValueToCaption(Sender: TObject);
begin
     dDIR.Caption := NormalitzaDIR(dDIR.Caption);
end;

procedure T_epersonals.dTELValueToCaption(Sender: TObject);
begin
     dTEL.Caption := NormalitzaTEL(dTEL.Caption);
end;

procedure T_epersonals.dPOBValueToCaption(Sender: TObject);
begin
     dPOB.Caption := NormalitzaPOB(dPOB.Caption);
end;

procedure T_epersonals.UText5React(Sender: TObject);
begin
     if T_epoblacions.Create(Application).Nou_ = mrOk then
     begin
          dPOB.Caption := _poblacions.v.FieldByName('POBLACIO').AsString;
          dCP.Caption  := _poblacions.v.FieldByName('CP').AsString;
     end;
end;

procedure T_epersonals.dCPSetInnerCaption(Sender: TObject);
begin
     lbGuio.Visible := dCP.Caption <> '';
     lbGuio.Left := dPOB.Left + dPOB.Width;

     dCP.Left := lbGuio.Left + lbGuio.Width;
end;

procedure T_epersonals.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
     end;
end;

procedure T_epersonals.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,false);
     dPOB.Data.Connection := dm.CG;
end;

procedure T_epersonals.UDBAlterFormBeforePost(sender: TObject;
  var Stop: Boolean);
begin
     if dNOM.Caption = '(NOM)' then dNOM.Caption := '';
     if dNIF.Caption = '(N.I.F.)' then dNIF.Caption := '';
     if dDIR.Caption = '(DIRECCI�)' then dDIR.Caption := '';
     if dPOB.Caption = '(POBLACI� - C.P.)' then dPOB.Caption := '';
     if dTEL.Caption = '(TEL�FON; E.MAIL)' then dTEL.Caption := '';
     if dOBS.Caption = '(OBSERVACIONS)' then dOBS.Caption := '';
end;

procedure T_epersonals.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_epersonals.dTIPUSValueToCaption(Sender: TObject);
const
     S : array [0..3] of string = ('(client)','(reparador)','(proveedor)','(general)');
begin
     dTIPUS_DESCR.Caption := S[dTIPUS.ItemIndex];
end;

procedure T_epersonals.dPOBShowPickForm(sender: TObject; F: TCustomForm;
  U: TUDBView);
begin
     U.Look.Assign(_personals.v.Look);
     U.AssignColumnInfo(CInfo[ctPoblacions],VisFields[ctPoblacions]);
end;

end.
