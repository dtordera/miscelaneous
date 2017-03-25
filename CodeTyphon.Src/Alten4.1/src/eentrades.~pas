unit eentrades;

interface

uses Windows, Menus, UDBAlter, UDBView, Controls, ExtCtrls, UText,
  StdCtrls, Graphics, UDBLabel, ULabel, Classes, Gradient, Forms, Dialogs, sysutils, comobj,llistcfg;

type T_eentrades = class(TForm)
          UText1: TUText;
          dDATA: TDLabel;
          Bevel1: TBevel;
          UText2: TUText;
          tNouproveedor: TUText;
          tEditarproveedor: TUText;
          tInsertarConcepte: TUText;
          tEditarConcepte: TUText;
          tEliminarConcepte: TUText;
          UText10: TUText;
          tIVA: TMUText;
          UText14: TUText;
          tMoureAmunt: TUText;
          tMoureAvall: TUText;
          btAnterior: TUText;
          btSeguent: TUText;
          btEntrar: TUText;
          dBASE: TNLabel;
          dIVA_P: TNLabel;
          dIVA: TNLabel;
          dTOTAL: TNLabel;
          dOBSERVACIONS: TXLabel;
          UDBAlterForm: TUDBAlterForm;
          GradientNC1: TGradientNC;
          dID: TNLabel;
          dID_PRV: TNLabel;
          lbNIF: TULabel;
          lbTEL: TULabel;
          lbPunticoma: TULabel;
          lbGuio: TULabel;
          dNIF_PRV: TULabel;
          dDIR_PRV: TULabel;
          dTEL_PRV: TULabel;
          dPOB_PRV: TULabel;
          dCP_PRV: TULabel;
    PopupMenu: TPopupMenu;
          Insertar1: TMenuItem;
          Editarconcepte1: TMenuItem;
          Eliminarconcepte1: TMenuItem;
          N1: TMenuItem;
          Moureamunt1: TMenuItem;
          Moureavall1: TMenuItem;
          UText3: TUText;
          dPAGADA: TBLabel;
          Panel1: TPanel;
    dHORA: THLabel;
    UText4: TUText;
    UText5: TUText;
    dREF_ALBARA: TTLabel;
    dTIPUS: TULabel;
    dNOM_PRV: TUDBLabel;
    vC: TUDBView;
    UText6: TUText;
    tBASE: TUText;
    UText7: TUText;
          procedure FormActivate(Sender: TObject);
          procedure dNIF_PRVSetInnerCaption(Sender: TObject);
          procedure dTEL_PRVSetInnerCaption(Sender: TObject);
          procedure dCP_PRVSetInnerCaption(Sender: TObject);
          procedure tNouproveedorReact(Sender: TObject);
          procedure tEditarproveedorReact(Sender: TObject);
          procedure UDBAlterFormCreateTempDetailTables(sender: TObject;
          Id: String);
          procedure UDBAlterFormDropTempDetailTables(sender: TObject;
          Id: String);
          procedure Insertar1Click(Sender: TObject);
          procedure vCInsert(Sender: TObject);
          procedure vCDelete(Sender: TObject);
          procedure vCReturn(Sender: TObject);
          procedure Editarconcepte1Click(Sender: TObject);
          procedure Eliminarconcepte1Click(Sender: TObject);
          procedure tInsertarConcepteReact(Sender: TObject);
          procedure tEditarConcepteReact(Sender: TObject);
          procedure tEliminarConcepteReact(Sender: TObject);
          procedure dIVA_PValueToCaption(Sender: TObject);
          procedure tIVAReact(Sender: TObject);
          procedure vCKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
          procedure UDBAlterFormDeleteDetailValues(sender: TObject; id: String;
          var Stop: Boolean);
          procedure UDBAlterFormInsertDetailValues(sender: TObject; Id: String);
          procedure UDBAlterFormLoadDefValues(Sender: TObject);
          procedure FormKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
          procedure UText3React(Sender: TObject);
          procedure dPOB_PRVSetInnerCaption(Sender: TObject);
          procedure dDIR_PRVSetInnerCaption(Sender: TObject);
          procedure UDBAlterFormAfterLoadValues(Sender: TObject);
    procedure UDBAlterFormPostValues(Sender: TObject);
    procedure UDBAlterFormBeforePost(sender: TObject; var Stop: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure dNOM_PRVCreatePickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
    procedure Moureamunt1Click(Sender: TObject);
    procedure Moureavall1Click(Sender: TObject);
    procedure tMoureAmuntReact(Sender: TObject);
    procedure tMoureAvallReact(Sender: TObject);
    procedure dTIPUSChange(Sender: TObject);
     private
          procedure TrobaObsCli;
          procedure CalculaPreus;
          procedure ColorBanda;
     public
     published
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
          procedure ComprobaCoherenciaDadesproveedor;
end;

var
  _eentrades: T_eentrades;

implementation

{$R *.DFM}

uses personals, dmsrc, entrades, ADOdb, global, epersonals, econcepte,
  magatzem, estilcolor, centrades;

procedure T_eentrades.Nou;
begin
     ColorBanda;
     UDBAlterForm.New;
end;

procedure T_eentrades.Modificar;
begin
     if _entrades.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else
          UDBAlterForm.Modify;
end;

procedure T_eentrades.Eliminar;
begin
     if _entrades.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a eliminar',mtInformation,[mbOk])
     else
          UDBAlterForm.Delete;
end;

procedure T_eentrades.FormActivate(Sender: TObject);
begin
     vC.Data.Connection := dm.CT;
     vC.Data.Table := 'c_conceptes_tmp';

     vC.AssignColumnInfo(CInfo[ctc_general],VisFields[ctc_general]);

     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_eentrades.TrobaObsCli;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select obs from personals where id = ' + floattostr(dID_PRV.Value);
     q.Active   := true;

     if (q.RecordCount > 0) and (q.FieldByName('OBS').AsString <> '') then
     mDlg('Obs. a proveedor : ' + q.FieldByName('OBS').AsString,mtInformation,[mbOk]);

     q.Free;
end;

procedure T_eentrades.dNIF_PRVSetInnerCaption(Sender: TObject);
begin
     lbNIF.Visible := dNIF_PRV.Caption <> '';
     dID_PRV.Left   := dNOM_PRV.Left + dNOM_PRV.Width;

     lbNIF.Left := dID_PRV.Left + dID_PRV.Width;
     dNIF_PRV.Left := lbNIF.Left + lbNIF.Width;
end;

procedure T_eentrades.dTEL_PRVSetInnerCaption(Sender: TObject);
const
     P : array [boolean] of string = ('','; ');
begin
     lbTEL.Visible := Trim(dTEL_PRV.Caption) <> '';
     lbPuntiComa.Visible := lbTel.Visible and (Trim(dDIR_PRV.Caption) <> '');
     lbPuntiComa.Caption := P[lbPuntiComa.Visible];

     lbPuntiComa.Left := dDIR_PRV.Left + dDIR_PRV.Width;
     lbTEL.Left := lbPuntiComa.Left + lbPuntIComa.Width;
     dTEL_PRV.Left := lbTEL.Left + lbTEL.Width;
end;

procedure T_eentrades.ComprobaCoherenciaDadesproveedor;
var
     q : TADOQuery;
begin
     if dID_PRV.Value = 0 then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from personals where id = ' + floattostr(dID_PRV.Value) + ' and id <> -999999';
     q.Active := true;

     if (q.RecordCount = 0) and (dID_PRV.Value <> -999999)
     then
     begin
          if mDlg('Atenció! La referència #' + dID_PRV.caption + ' no es troba a la taula de personals. Crear nou proveedor ' +
          ' amb les dades de l''entrada?',mtWarning,[mbYes,mbNo]) = mrYes
          then
          begin
               q.Append;
               q.FieldValues['id'] := dID_PRV.Value;
               q.FieldValues['TIPUS'] := 'P';
               q.FieldValues['NOM'] := dNOM_PRV.Caption;
               q.FieldValues['NIF'] := dNIF_PRV.Caption;
               q.FieldValues['DIR'] := dDIR_PRV.Caption;
               q.FieldValues['TEL'] := dTEL_PRV.Caption;
               q.FieldValues['POB'] := dPOB_PRV.Caption;
               q.FieldValues['CP']  := dCP_PRV.Caption;
               q.Post;

               mDlg('Es recomana fer normalizació de registres (processos->normalitzar registres) '+
               'i actualització de repeticions (processos->Actualitzar repeticions) per tal que quedin reflectits '+
               'els canvis al nou registre de proveedor',mtInformation,[mbOk]);
          end;
     end
     else
     if (dID_PRV.Value <> -999999) and
        ((dNOM_PRV.Caption <> '''') and (Trim(q.FieldByName('NOM').AsString) <> Trim(dNOM_PRV.Caption))) or
        ((dNIF_PRV.Caption <> '''') and (Trim(q.FieldByName('NIF').AsString) <> Trim(dNIF_PRV.Caption))) then
        begin
        mDlg('Atenció! Les dades de NOM o de N.I.F. a la taula proveedor són diferents de les entrades '+
        'a la entrada:'#13#10#13#10+
        'entrada : '#13#10+
        dID_PRV.Caption + '  ' + dNOM_PRV.Caption + ' ' + dNIF_PRV.Caption + #13#10#13#10+
        'taula personals : '#13#10+
        dID_PRV.Caption + '  ' + q.FieldByName('NOM').AsString + ' ' + q.FieldByName('NIF').AsString,mtWarning,[mbOk]);

        mDlg('Es recomana editar el proveedor o bé les dades de proveedor de la entrada per tal de que no hi '+
        'hagi incoherències.',mtInformation,[mbOk]);
        end;

     q.Free;
end;

procedure T_eentrades.dCP_PRVSetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_PRV.Caption) <> '';
     lbGUIO.Left    := dPOB_PRV.Left + dPOB_PRV.Width;
     dCP_PRV.Left   := lbGUIO.Left + lbGUIO.Width;

     ComprobaCoherenciaDadesproveedor;

     TrobaObsCli; // es posa aqui per executar-se l'últim després de carregar proveedor
end;

procedure T_eentrades.tNouproveedorReact(Sender: TObject);
begin
     case T_epersonals.Create(self).Nou_Proveedor of
     mrOk :    with _personals.v.Data.DataSet do
               begin
                    dID_PRV.Value    := FieldByName('ID').AsInteger;
                    dNOM_PRV.Caption := FieldByName('NOM').AsString;
                    dNIF_PRV.Caption := FieldByName('NIF').AsString;
                    dDIR_PRV.Caption := FieldByName('DIR').AsString;
                    dTEL_PRV.Caption := FieldByName('TEL').AsString;
                    dPOB_PRV.Caption := FieldByName('POB').AsString;
                    dCP_PRV.Caption  := FieldByName('CP' ).AsString;
               end;
     end;
end;

procedure T_eentrades.tEditarproveedorReact(Sender: TObject);
begin
     if dID_PRV.Value = -999999 then
     begin
          mDlg('Entrada de normalització. No es pot editar el client',mtError,[mbOk]);
          exit;
     end;

     if dID_PRV.Value = 0 then
     mDlg('Codi de proveedor no assignat. No es pot editar. Per referenciar aquest proveedor ('+
     dNOM_PRV.Caption + ' ' + dNIF_PRV.Caption + ') es recomana anar a processos i escollir '+
     '''Establir referències perdudes''',mtWarning,[mbOK])
     else
     case T_epersonals.Create(self).Modificar_per_id(Round(dID_PRV.Value)) of
     mrOk :    with _personals.v.Data.DataSet do
               begin
                    dID_PRV.Value    := FieldByName('ID').AsInteger;
                    dNOM_PRV.Caption := FieldByName('NOM').AsString;
                    dNIF_PRV.Caption := FieldByName('NIF').AsString;
                    dDIR_PRV.Caption := FieldByName('DIR').AsString;
                    dTEL_PRV.Caption := FieldByName('TEL').AsString;
                    dPOB_PRV.Caption := FieldByName('POB').AsString;
                    dCP_PRV.Caption  := FieldByName('CP' ).AsString;
               end;
     end;
end;

procedure T_eentrades.UDBAlterFormCreateTempDetailTables(
  sender: TObject; Id: String);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;
     dm.CT.Connected := true;

     q.Active := false;
     q.SQL.Text := 'insert into c_conceptes_tmp select c_entrades.* from c_entrades in ''' + dm.CR['database'] + ''' where (id_ref = ' + id + ')';
     q.ExecSQL;

     q.Free;
end;

procedure T_eentrades.UDBAlterFormDropTempDetailTables(sender: TObject;
  Id: String);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;

     q.Active := false;
     q.SQL.Text := 'delete * from c_conceptes_tmp';
     q.ExecSQL;

     q.Free;
end;

procedure T_eentrades.vCDelete(Sender: TObject);
var
     r : TModalResult;
begin
     r := mrCancel;
     if vC.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a eliminar',mtInformation,[mbOk])
     else r := T_econcepte.Create(Application).Eliminar(vC);

     if r = mrOk then
     begin
          CalculaPreus;
          UDBAlterForm.DataModified := true;
     end;
end;

procedure T_eentrades.vCReturn(Sender: TObject);
var
     r : TModalResult;
begin
     r := mrCancel;

     if vC.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else r := T_econcepte.Create(Application).Modificar(vC);

     if r = mrOK then
     begin
          CalculaPreus;
          UDBAlterForm.DataModified := true;
     end;
end;

procedure T_eentrades.vCInsert(Sender: TObject);
var
     r : TModalResult;
begin
     r := T_econcepte.Create(Application).Nou(vC);

     if r = mrOk then
     begin
          CalculaPreus;
          UDBAlterForm.DataModified := true;
     end;
end;

procedure T_eentrades.Editarconcepte1Click(Sender: TObject);
begin
     vC.PushReturn;
end;

procedure T_eentrades.tEditarConcepteReact(Sender: TObject);
begin
     vC.PushReturn;
end;

procedure T_eentrades.Insertar1Click(Sender: TObject);
begin
     vC.PushInsert;
end;

procedure T_eentrades.tInsertarConcepteReact(Sender: TObject);
begin
     vC.PushInsert;
end;

procedure T_eentrades.Eliminarconcepte1Click(Sender: TObject);
begin
     vC.PushDelete;
end;

procedure T_eentrades.tEliminarConcepteReact(Sender: TObject);
begin
     vC.PushDelete;
end;

procedure T_eentrades.CalculaPreus;
var
     q : TADOQuery;
begin
     if (UDBAlterForm.State = asLoading) or not Visible then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;

     q.Active   := false;
     q.SQL.Text := 'select sum(import) as suma from c_conceptes_tmp';
     q.Active   := true;

     case tIVA.ItemIndex of
     0 : begin dTOTAL.Value := q.FieldByName('suma').AsFloat; dBASE.Value := dTOTAL.Value / (1 + dIVA_P.Value/100); end;
     1 : begin dBASE.Value  := q.FieldByName('suma').AsFloat; dTOTAL.Value := dBASE.Value * (1 + dIVA_P.Value/100); end;
     end;

     dIVA.Value := dBASE.Value * dIVA_P.Value /100;

     q.Free;
end;

procedure T_eentrades.dIVA_PValueToCaption(Sender: TObject);
begin
     CalculaPreus;
end;

procedure T_eentrades.tIVAReact(Sender: TObject);
begin
     CalculaPreus;
end;

procedure T_eentrades.vCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     107 : begin vC.PushInsert; Key := 0; end;
     109 : begin vC.PushDelete; Key := 0; end;
     end;
end;

procedure T_eentrades.UDBAlterFormDeleteDetailValues(sender: TObject;
  id: String; var Stop: Boolean);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     try
     q.Active := false;
     q.SQL.Text := 'select * from c_entrades where id_ref = ' + id;
     q.Active := true;
     q.First;

     while not q.Eof do
     begin
          magatzem.TreuDeMagatzem(q.FieldByName('concepte').AsString,q.FieldByName('id_elem').AsInteger,q.FieldByName('uts').AsInteger,dDATA.Date);
          q.Delete;
     end;

     except
     on E:EOleException do
     begin
          Stop := true;
          mDlg(Format('Error eliminant detalls de ref. #'+id+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;
     end;

     _magatzem.v.Refresh;
     q.Free;
end;

procedure T_eentrades.UDBAlterFormInsertDetailValues(sender: TObject;
  Id: String);
var
     q : TADOQuery;
     q2 : TADOQuery;
     idori : integer;
begin
     q  := TADOQuery.Create(nil);
     q2 := TADOQuery.Create(nil);

     try  q.Connection := dm.CT;
          q.Active := false;
          q.SQL.Text := 'select * from c_conceptes_tmp';
          q.Active := true;
          q.First;

          q2.Connection := dm.CG;
          q2.Active := false;
          q2.SQL.Text := 'select max(id) as NewId from c_entrades';
          q2.Active := true;

          idori := q2.FieldByName('NewId').AsInteger;

          q2.Active := false;
          q2.SQL.Text := 'select * from c_entrades';
          q2.Active := true;

          while not q.Eof do
          begin
               inc(idori);

               q2.Append;
               q2.FieldValues['id']       := idori;
               q2.FieldValues['id_ref']   := id;
               q2.FieldValues['id_elem']  := q.FieldByName('id_elem').AsInteger;
               q2.FieldValues['id_lin']   := q.FieldByName('id_lin').AsInteger;
               q2.FieldValues['concepte'] := q.FieldByName('concepte').AsString;
               q2.FieldValues['preu']     := q.FieldByName('preu').AsFloat;
               q2.FieldValues['uts']      := q.FieldByName('uts').AsFloat;
               q2.FieldValues['import']   := q.FieldByName('import').AsFloat;
               q2.Post;

               if q.FieldByName('uts').asFloat < 0 then
                    mDlg('Les unitats del concepte ' + q.FieldByName('concepte').AsString + ' són ' + q.FieldByName('uts').AsString +
                    '. Es considera abonament i es treuen de magatzem.',mtInformation,[mbOk]);

               magatzem.PosaAMagatzem(q.FieldByName('concepte').AsString,q.FieldByName('id_elem').AsInteger,q.FieldByName('uts').AsFloat,dDATA.Date);
               q.Next;
          end;
     except
     on E:EOleException do
          mDlg(Format('Error insertant detalls de ref. #'+id + #13#10 + 'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q2.Free;
     q.Free;

     _entrades.vC.Refresh;
     _magatzem.v.Refresh;
     _centrades.v.Refresh;
end;

procedure T_eentrades.UDBAlterFormLoadDefValues(Sender: TObject);
begin
     dDATA.Date   := date;

     dBASE.Value  := 0;
     dIVA_P.Value := strtofloat(dm.CR['IVA_ARTICLES']);
     dIVA.Value   := 0;
     dTOTAL.Value := 0;
     dPAGADA.Value := false;

     dOBSERVACIONS.Caption := '';
end;

procedure T_eentrades.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
//   VK_F1 : ajuda
     end;
end;

procedure T_eentrades.UText3React(Sender: TObject);
begin
     vC.SetFocus;
end;

procedure T_eentrades.dPOB_PRVSetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_PRV.Caption) <> '';
     lbGUIO.Left    := dPOB_PRV.Left + dPOB_PRV.Width;
     dCP_PRV.Left   := lbGUIO.Left + lbGUIO.Width;
end;

procedure T_eentrades.dDIR_PRVSetInnerCaption(Sender: TObject);
const
     P : array [boolean] of string = ('','; ');
begin
     lbTEL.Visible := Trim(dTEL_PRV.Caption) <> '';
     lbPuntiComa.Visible := lbTel.Visible and (Trim(dDIR_PRV.Caption) <> '');
     lbPuntiComa.Caption := P[lbPuntiComa.Visible];

     lbPuntiComa.Left := dDIR_PRV.Left + dDIR_PRV.Width;
     lbTEL.Left := lbPuntiComa.Left + lbPuntIComa.Width;
     dTEL_PRV.Left := lbTEL.Left + lbTEL.Width;
end;

procedure T_eentrades.ColorBanda;
var
     c : TColor;
     s : string;
begin
     c := clBtnFace;

     Panel1.Visible := c <> clBtnFace;
     Panel1.Font.Color := NegLumColor(c);
     Panel1.Color := c;
     Panel1.caption := s;
end;

procedure T_eentrades.UDBAlterFormAfterLoadValues(Sender: TObject);
begin
     ColorBanda;
     CalculaPreus;
end;

procedure T_eentrades.UDBAlterFormPostValues(Sender: TObject);
begin
     _personals.ActualitzarDades(Round(dID_PRV.Value));
     _personals.Refresh;     
end;

procedure T_eentrades.UDBAlterFormBeforePost(sender: TObject;
  var Stop: Boolean);
begin
     dHORA.Time := time;

     if ((dID_PRV.Value = 0) or (dID_PRV.Caption = '')) and (dNOM_PRV.Caption = '') then
     begin
          case mDlg('No s''ha entrat proveedor. entrada al comptat?',mtInformation,
          [mbYes,mbNo]) of
          mrYes : begin
                         dID_PRV.Value := 0;
                         dNOM_PRV.Caption := '<entrada al comptat>';
                         dNIF_PRV.Caption := '';
                         dDIR_PRV.Caption := '';
                         dTEL_PRV.Caption := '';
                         dPOB_PRV.Caption := '';
                         dCP_PRV.Caption  := '';
                  end
          else Stop := true;
          end;
     end;
end;

procedure T_eentrades.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
     dNOM_PRV.Data.Connection := dm.CG;
end;

procedure T_eentrades.dNOM_PRVCreatePickForm(sender: TObject;
  F: TCustomForm; U: TUDBView);
begin
     U.Look.Assign(_personals.v.Look);
     U.AssignColumnInfo(CInfo[ctPersonals_p],VisFields[ctPersonals_p]);
end;

procedure T_eentrades.Moureamunt1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentUp;
end;

procedure T_eentrades.Moureavall1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentDown;
end;

procedure T_eentrades.tMoureAmuntReact(Sender: TObject);
begin
     vC.CurrentUp;
end;

procedure T_eentrades.tMoureAvallReact(Sender: TObject);
begin
     vC.CurrentDown;
end;

procedure T_eentrades.dTIPUSChange(Sender: TObject);
var
     s : string;
begin
     if (UDBAlterForm.State = asLoading) then exit;

     if dTIPUS.Caption = 'C' then s := 'client'
     else
     if dTIPUS.Caption = 'R' then s := 'reparador';

     if (dTIPUS.Caption = 'C') or (dTIPUS.Caption = 'R') then
     mDlg('Les dades escollides estan marcades com ' + s,mtInformation,[mbOK]);
end;

end.
