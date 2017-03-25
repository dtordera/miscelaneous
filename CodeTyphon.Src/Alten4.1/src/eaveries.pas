unit eaveries;

interface

uses Classes, Menus, UDBAlter, UDBView, Controls, ExtCtrls, StdCtrls,
  UText, ComObj, ULabel, UDBLabel, Gradient, Forms, estilcolor, db,
  graphics, Dialogs, sysutils, llistcfg;

type T_eaveries = class(TForm)
          UText1: TUText;
          dDATA: TDLabel;
          UText2: TUText;
          tNouClient: TUText;
          tEditarClient: TUText;
          tInsertarConcepte: TUText;
          tEditarConcepte: TUText;
          tEliminarConcepte: TUText;
          UText14: TUText;
          tAmuntArt: TUText;
          tAvallArt: TUText;
          dNOM_CLI: TUDBLabel;
          btAnterior: TUText;
          btSeguent: TUText;
          btEntrar: TUText;
          dOBSERVACIONS: TXLabel;
          UDBAlterForm: TUDBAlterForm;
          dID: TNLabel;
          dID_CLI: TNLabel;
          lbNIF: TULabel;
          lbTEL: TULabel;
          lbPunticoma: TULabel;
          lbGuio: TULabel;
          dNIF_CLI: TULabel;
          dDIR_CLI: TULabel;
          dTEL_CLI: TULabel;
          dPOB_CLI: TULabel;
          dCP_CLI: TULabel;
          PopupMenu: TPopupMenu;
          Insertar1: TMenuItem;
          Editarconcepte1: TMenuItem;
          Eliminarconcepte1: TMenuItem;
          N1: TMenuItem;
          Moureamunt1: TMenuItem;
          Moureavall1: TMenuItem;
          UText3: TUText;
    dREF_FACTURA: TNLabel;
          Panel1: TPanel;
    dHORA: THLabel;
    UText7: TUText;
    dANOMALIES: TXLabel;
    UText10: TUText;
    dGARANTIA: TBLabel;
    UText12: TUText;
    dDATA_ENTRADA: TDLabel;
    dDATA_ENTREGA: TDLabel;
    UText17: TUText;
    tDATA_VISITA: TUText;
    tDISP_HOR: TUText;
    UText27: TUText;
    dREP_A_DOMICILI: TBLabel;
    dDATA_VISITA: TDLabel;
    dDISP_HOR: TTLabel;
    UText4: TUText;
    tREPARADOR: TUText;
    tNouRep: TUText;
    tEditarRep: TUText;
    dREP_EXTERNA: TBLabel;
    tDATA_ENVIAMENT: TUText;
    tEnviat: TUText;
    dDATA_ENVIAMENT: TDLabel;
    dENVIAT: TBLabel;
    dID_REP: TNLabel;
    UText33: TUText;
    dREP_FINALITZADA: TBLabel;
    tDATA_REPARACIO: TUText;
    dDATA_REPARACIO: TDLabel;
    tIntMat: TUText;
    tInsertarIntMat: TUText;
    tEditarIntMat: TUText;
    tEliminarIntMat: TUText;
    tAmuntIntMat: TUText;
    tAvallIntMat: TUText;
    dNOM_REP: TUDBLabel;
    Shape1: TShape;
    vCArt: TUDBView;
    vCInt: TUDBView;
    dREF_FACTURA_LIN: TULabel;
    tRef: TUText;
    UText5: TUText;
    tVeureVisites: TUText;
    UText6: TUText;
    dREF_ORIGEN_LIN: TULabel;
    dREF_ORIGEN: TNLabel;
    UText21: TUText;
    dATES_PER: TULabel;
    UText8: TUText;
    dN_SERIE: TXLabel;
          procedure FormActivate(Sender: TObject);
          procedure dNIF_CLISetInnerCaption(Sender: TObject);
          procedure dTEL_CLISetInnerCaption(Sender: TObject);
          procedure dCP_CLISetInnerCaption(Sender: TObject);
          procedure tNouClientReact(Sender: TObject);
          procedure tEditarClientReact(Sender: TObject);
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
          procedure vCKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
          procedure UDBAlterFormDeleteDetailValues(sender: TObject; id: String;
          var Stop: Boolean);
          procedure UDBAlterFormInsertDetailValues(sender: TObject; Id: String);
          procedure UDBAlterFormLoadDefValues(Sender: TObject);
          procedure FormKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
          procedure UText3React(Sender: TObject);
          procedure dPOB_CLISetInnerCaption(Sender: TObject);
          procedure dDIR_CLISetInnerCaption(Sender: TObject);
          procedure UDBAlterFormAfterLoadValues(Sender: TObject);
    procedure UDBAlterFormPostValues(Sender: TObject);
    procedure UDBAlterFormBeforePost(sender: TObject; var Stop: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure tNouRepReact(Sender: TObject);
    procedure tEditarIntMatReact(Sender: TObject);
    procedure tEliminarIntMatReact(Sender: TObject);
    procedure dNOM_REPSetInnerCaption(Sender: TObject);
    procedure dREP_A_DOMICILIChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dREP_EXTERNAChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dREP_FINALITZADAChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dENVIATChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure tAmuntArtReact(Sender: TObject);
    procedure tAvallArtReact(Sender: TObject);
    procedure Moureamunt1Click(Sender: TObject);
    procedure Moureavall1Click(Sender: TObject);
    procedure dNOM_CLIShowPickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
    procedure tEditarRepReact(Sender: TObject);
    procedure tInsertarIntMatReact(Sender: TObject);
    procedure tAmuntIntMatReact(Sender: TObject);
    procedure tAvallIntMatReact(Sender: TObject);
    procedure tVeureVisitesReact(Sender: TObject);
     private
          procedure TrobaObsCli;
          procedure ColorBanda;
     public
          procedure Imprimiraveria;
          function  NetejaReferencies : boolean;          
     published
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
          procedure ComprobaCoherenciaDadesClient;
end;


implementation

{$R *.DFM}

uses personals, dmsrc, averies, ADOdb, global, epersonals, econcepte, ecaixa,
  etorns, magatzem, reports, pressupostos, ventesA, ventesB, caveries;

procedure T_eaveries.Nou;
begin
     ColorBanda;
     UDBAlterForm.New;
end;

procedure T_eaveries.Modificar;
begin
     if _averies.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else
          UDBAlterForm.Modify;
end;

function T_eaveries.NetejaReferencies : boolean;
var
     q : TADOQuery;
     s : string;
     c : char;
begin
     result := true;

     c := Char(Copy(_averies.v.FieldByName('REF_FACTURA_LIN').AsString,0,1)[1]);

     if _averies.v.FieldByName('REF_FACTURA').AsInteger <> 0 then
     begin
          result := false;
          if mDlg('Aquesta averia està referenciada a la factura #' + _averies.v.FieldByName('REF_FACTURA').AsString + c +
          '. Si es continua, s''eliminarà la referència a la venta. Continuar?',mtInformation,[mbYes,mbNo]) = mrYes then
          begin
               result := true;
               q := TADOQuery.Create(nil);
               q.Connection := dm.CG;
               q.Active := false;
               q.SQL.Text := 'select * from ventes' + c + ' where REF_AVERIA = ' + _averies.v.FieldByName('id').AsString;
               q.Active := true;
               s := AnsiQuotedStr(StringReplace(q.FieldByName('OBSERVACIONS').AsString,'(factura d''averia #' + _averies.v.FieldByName('id').AsString + ') ','',[rfReplaceAll]),'''');
               q.Active := false;
               q.SQL.Text := 'update ventes' + c + ' set REF_AVERIA = 0, OBSERVACIONS = ' + s + ' where REF_AVERIA = ' + _averies.v.FieldByName('id').AsString;
               q.ExecSQL;
               q.SQL.Text := 'update averies set REF_FACTURA = 0,REF_FACTURA_LIN = '''' where id = ' + _averies.v.FieldByName('id').AsString;
               q.ExecSQL;
               q.Free;
          end;
     end;

     _averies.v.Refresh;

     case c of
     'A' : _ventesA.Refresh;
     'B' : _ventesB.Refresh;
     end;
end;

procedure T_eaveries.Eliminar;
begin
     if _averies.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a eliminar',mtInformation,[mbOk])
     else
     if NetejaReferencies
     then
          UDBAlterForm.Delete;
end;

procedure T_eaveries.FormActivate(Sender: TObject);
begin
     vCArt.Data.Connection := dm.CT;
     vCArt.Data.Table := 'c_aveart_tmp';
     vCArt.AssignColumnInfo(CInfo[ctAveArt_p],VisFields[ctAveArt_p]);

     vCInt.Data.Connection := dm.CT;
     vCInt.Data.Table := 'c_aveint_tmp';
     vCInt.AssignColumnInfo(CInfo[ctAveInt_p],VisFields[ctAveInt_p]);     

     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_eaveries.TrobaObsCli;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select obs from personals where id = ' + floattostr(dID_CLI.Value);
     q.Active   := true;

     if (q.RecordCount > 0) and (q.FieldByName('OBS').AsString <> '') then
     mDlg('Obs. a client : ' + q.FieldByName('OBS').AsString,mtInformation,[mbOk]);

     q.Free;
end;

procedure T_eaveries.dNIF_CLISetInnerCaption(Sender: TObject);
begin
     lbNIF.Visible := dNIF_CLI.Caption <> '';
     dID_CLI.Left   := dNOM_CLI.Left + dNOM_CLI.Width;

     lbNIF.Left := dID_CLI.Left + dID_CLI.Width;
     dNIF_CLI.Left := lbNIF.Left + lbNIF.Width;
end;

procedure T_eaveries.dTEL_CLISetInnerCaption(Sender: TObject);
const
     P : array [boolean] of string = ('','; ');
begin
     lbTEL.Visible := Trim(dTEL_CLI.Caption) <> '';
     lbPuntiComa.Visible := lbTel.Visible and (Trim(dDIR_CLI.Caption) <> '');
     lbPuntiComa.Caption := P[lbPuntiComa.Visible];

     lbPuntiComa.Left := dDIR_CLI.Left + dDIR_CLI.Width;
     lbTEL.Left := lbPuntiComa.Left + lbPuntIComa.Width;
     dTEL_CLI.Left := lbTEL.Left + lbTEL.Width;
end;

procedure T_eaveries.ComprobaCoherenciaDadesClient;
var
     q : TADOQuery;
begin
     if (dID_CLI.Value = 0) or (dID_CLI.Value = -999999) then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from personals where id = ' + floattostr(dID_CLI.Value);
     q.Active := true;

     if q.RecordCount = 0
     then
     begin
          if mDlg('Atenció! La referència #' + dID_CLI.caption + ' no es troba a la taula de personals. Crear nou client ' +
          ' amb les dades de l''averia?',mtWarning,[mbYes,mbNo]) = mrYes
          then
          begin
               q.Append;
               q.FieldValues['id'] := dID_CLI.Value;
               q.FieldValues['TIPUS'] := 'C';
               q.FieldValues['NOM'] := dNOM_CLI.Caption;
               q.FieldValues['NIF'] := dNIF_CLI.Caption;
               q.FieldValues['DIR'] := dDIR_CLI.Caption;
               q.FieldValues['TEL'] := dTEL_CLI.Caption;
               q.FieldValues['POB'] := dPOB_CLI.Caption;
               q.FieldValues['CP']  := dCP_CLI.Caption;
               q.Post;

               mDlg('Es recomana fer normalizació de registres (processos->normalitzar registres) '+
               'i actualització de repeticions (processos->Actualitzar repeticions) per tal que quedin reflectits '+
               'els canvis al nou registre de client',mtInformation,[mbOk]);
          end;
     end
     else
     if ((dNOM_CLI.Caption <> '''') and (Trim(q.FieldByName('NOM').AsString) <> Trim(dNOM_CLI.Caption))) or
        ((dNIF_CLI.Caption <> '''') and (Trim(q.FieldByName('NIF').AsString) <> Trim(dNIF_CLI.Caption))) then
        begin
        mDlg('Atenció! Les dades de NOM o de N.I.F. a la taula client són diferents de les entrades '+
        'a l''averia:'#13#10#13#10 +
        'averia : '#13#10 +
        dID_CLI.Caption + '  ' + dNOM_CLI.Caption + ' ' + dNIF_CLI.Caption + #13#10#13#10 +
        'taula personals : '#13#10 +
        dID_CLI.Caption + '  ' + q.FieldByName('NOM').AsString + ' ' + q.FieldByName('NIF').AsString,mtWarning,[mbOk]);

        mDlg('Es recomana editar el client o bé les dades de client de l''averia per tal de que no hi '+
        'hagi incoherències.',mtInformation,[mbOk]);
        end;

     q.Free;
end;

procedure T_eaveries.dCP_CLISetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_CLI.Caption) <> '';
     lbGUIO.Left    := dPOB_CLI.Left + dPOB_CLI.Width;
     dCP_CLI.Left   := lbGUIO.Left + lbGUIO.Width;

     ComprobaCoherenciaDadesClient;

     TrobaObsCli; // es posa aqui per executar-se l'últim després de carregar client
end;

procedure T_eaveries.tNouClientReact(Sender: TObject);
begin
     case T_epersonals.Create(self).Nou_Client of
     mrOk :    with _personals.v.Data.DataSet do
               begin
                    dID_CLI.Value    := FieldByName('ID').AsInteger;
                    dNOM_CLI.Caption := FieldByName('NOM').AsString;
                    dNIF_CLI.Caption := FieldByName('NIF').AsString;
                    dDIR_CLI.Caption := FieldByName('DIR').AsString;
                    dTEL_CLI.Caption := FieldByName('TEL').AsString;
                    dPOB_CLI.Caption := FieldByName('POB').AsString;
                    dCP_CLI.Caption  := FieldByName('CP' ).AsString;
               end;
     end;
end;

procedure T_eaveries.tEditarClientReact(Sender: TObject);
begin
     if (dID_CLI.Value = 0) or (dID_CLI.Value = -999999) then
     mDlg('Codi de client no assignat. No es pot editar. Per referenciar aquest client ('+
     dNOM_CLI.Caption + ' ' + dNIF_CLI.Caption + ') es recomana anar a processos i escollir '+
     '''Establir referències perdudes''',mtWarning,[mbOK])
     else
     case T_epersonals.Create(self).Modificar_per_id(Round(dID_CLI.Value)) of
     mrOk :    with _personals.v.Data.DataSet do
               begin
                    dID_CLI.Value    := FieldByName('ID').AsInteger;
                    dNOM_CLI.Caption := FieldByName('NOM').AsString;
                    dNIF_CLI.Caption := FieldByName('NIF').AsString;
                    dDIR_CLI.Caption := FieldByName('DIR').AsString;
                    dTEL_CLI.Caption := FieldByName('TEL').AsString;
                    dPOB_CLI.Caption := FieldByName('POB').AsString;
                    dCP_CLI.Caption  := FieldByName('CP' ).AsString;
               end;
     end;
end;

procedure T_eaveries.UDBAlterFormCreateTempDetailTables(
  sender: TObject; Id: String);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;
     dm.CT.Connected := true;

     q.Active := false;
     q.SQL.Text := 'insert into c_aveart_tmp select c_aveart.* from c_aveart in ''' + dm.CR['database'] + ''' where (id_ref = ' + id + ')';
     q.ExecSQL;
     q.SQL.Text := 'insert into c_aveint_tmp select c_aveint.* from c_aveint in ''' + dm.CR['database'] + ''' where (id_ref = ' + id + ')';
     q.ExecSQL;

     q.Free;

     vCArt.Refresh;
     vCInt.Refresh;
end;

procedure T_eaveries.UDBAlterFormDropTempDetailTables(sender: TObject;
  Id: String);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;

     q.Active := false;
     q.SQL.Text := 'delete * from c_aveart_tmp';
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_aveint_tmp';
     q.ExecSQL;

     q.Free;
end;

procedure T_eaveries.vCDelete(Sender: TObject);
var
     r : TModalResult;
begin
     r := mrCancel;
     if (sender as TUDBView).Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a eliminar',mtInformation,[mbOk])
     else r := T_econcepte.Create(Application).Eliminar(Sender as TUDBView);

     if r = mrOk then
          UDBAlterForm.DataModified := r = mrOK;
end;

procedure T_eaveries.vCReturn(Sender: TObject);
var
     r : TModalResult;
begin
     r := mrCancel;

     if (sender as TUDBView).Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else r := T_econcepte.Create(Application).Modificar(sender as TUDBView);

     UDBAlterForm.DataModified := r = mrOk;
end;

procedure T_eaveries.vCInsert(Sender: TObject);
var
     r : TModalResult;
begin
     r := T_econcepte.Create(Application).Nou((sender as TUDBView));

     UDBAlterForm.DataModified := r = mrOk;
end;

procedure T_eaveries.Editarconcepte1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).PushReturn;
end;

procedure T_eaveries.tEditarConcepteReact(Sender: TObject);
begin
     vCArt.PushReturn;
end;

procedure T_eaveries.tEditarIntMatReact(Sender: TObject);
begin
     vCInt.PushReturn;
end;

procedure T_eaveries.Insertar1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).PushInsert;
end;

procedure T_eaveries.tInsertarConcepteReact(Sender: TObject);
begin
     vCArt.PushInsert;
end;

procedure T_eaveries.Eliminarconcepte1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).PushDelete;
end;

procedure T_eaveries.tEliminarConcepteReact(Sender: TObject);
begin
     vCArt.PushDelete;
end;

procedure T_eaveries.tEliminarIntMatReact(Sender: TObject);
begin
     vCInt.PushDelete;
end;

procedure T_eaveries.vCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     107 : begin (sender as TUDBView).PushInsert; Key := 0; end;
     109 : begin (sender as TUDBView).PushDelete; Key := 0; end;
     end;
end;

procedure T_eaveries.UDBAlterFormDeleteDetailValues(sender: TObject;
  id: String; var Stop: Boolean);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     try
     q.Active := false;
     q.SQL.Text := 'delete * from c_aveart where id_ref = ' + id;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_aveint where id_ref = ' + id;
     q.ExecSQL;

     except
     on E:EOleException do
     begin
          Stop := true;
          mDlg(Format('Error eliminant detalls de ref. #'+id+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;
     end;
     q.Free;
end;

procedure T_eaveries.UDBAlterFormInsertDetailValues(sender: TObject;
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
          q.SQL.Text := 'select * from c_aveart_tmp';
          q.Active := true;
          q.First;

          q2.Connection := dm.CG;
          q2.SQL.Text := 'select max(id) as NewId from c_aveart';
          q2.Active := true;

          idori := q2.FieldByName('NewId').AsInteger;

          q2.Active := false;
          q2.SQL.Text := 'select * from c_aveart';
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
               q2.FieldValues['uts']      := q.FieldByName('uts').AsFloat;
               q2.Post;

               q.Next;
          end;

          q.Active := false;
          q.SQL.Text := 'select * from c_aveint_tmp';
          q.Active := true;
          q.First;

          q2.Connection := dm.CG;
          q2.SQL.Text := 'select max(id) as NewId from c_aveint';
          q2.Active := true;

          idori := q2.FieldByName('NewId').AsInteger;

          q2.Active := false;
          q2.SQL.Text := 'select * from c_aveint';
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
               q2.FieldValues['uts']      := q.FieldByName('uts').AsFloat;
               q2.Post;

               q.Next;
          end;
     except
     on E:EOleException do
          mDlg(Format('Error insertant detalls de ref. #'+id + #13#10 + 'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q2.Free;
     q.Free;

     _averies.vCArt.Refresh;
     _averies.vCInt.Refresh;
     _caveries.vCArt.Refresh;
     _caveries.vCInt.Refresh;
end;

procedure T_eaveries.UDBAlterFormLoadDefValues(Sender: TObject);
begin
     dDATA.Date   := date;

     dANOMALIES.Caption   := '(ANOMALÍES)';
     dID_REP.Value := 0;

     dREF_ORIGEN.Value    := 0;
     dREF_FACTURA.Value   := 0;

     dREP_A_DOMICILI.Value := true;
     dREP_A_DOMICILI.Value := false;

     dREP_EXTERNA.Value := true;
     dREP_EXTERNA.Value := false;

     dREP_FINALITZADA.Value := true;
     dREP_FINALITZADA.Value := false;

     dOBSERVACIONS.Caption := '(OBSERVACIONS)';

     dATES_PER.Caption := Treballadors;
end;

procedure T_eaveries.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
//   VK_F1 : ajuda
     end;
end;

procedure T_eaveries.UText3React(Sender: TObject);
begin
     vCArt.SetFocus;
end;

procedure T_eaveries.dPOB_CLISetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_CLI.Caption) <> '';
     lbGUIO.Left    := dPOB_CLI.Left + dPOB_CLI.Width;
     dCP_CLI.Left   := lbGUIO.Left + lbGUIO.Width;
end;

procedure T_eaveries.dDIR_CLISetInnerCaption(Sender: TObject);
const
     P : array [boolean] of string = ('','; ');
begin
     lbTEL.Visible := Trim(dTEL_CLI.Caption) <> '';
     lbPuntiComa.Visible := lbTel.Visible and (Trim(dDIR_CLI.Caption) <> '');
     lbPuntiComa.Caption := P[lbPuntiComa.Visible];

     lbPuntiComa.Left := dDIR_CLI.Left + dDIR_CLI.Width;
     lbTEL.Left := lbPuntiComa.Left + lbPuntIComa.Width;
     dTEL_CLI.Left := lbTEL.Left + lbTEL.Width;
end;

procedure T_eaveries.ColorBanda;
var
     c : TColor;
     s : string;
begin
     c := clBtnFace;

     if dREP_FINALITZADA.Value
     then
     begin
          c := C_REP_FINALITZADA;
          s := 'reparació finalitzada';
     end;

     Panel1.Visible := c <> clBtnFace;
     Panel1.Font.Color := NegLumColor(c);
     Panel1.Color := c;
     Panel1.caption := s;
end;

procedure T_eaveries.UDBAlterFormAfterLoadValues(Sender: TObject);
begin
     ColorBanda;

     tDATA_VISITA.Enabled := dREP_A_DOMICILI.Value;
     tVeureVisites.Enabled := dREP_A_DOMICILI.Value;
     tDISP_HOR.Enabled    := dREP_A_DOMICILI.Value;
     dDATA_VISITA.Enabled := dREP_A_DOMICILI.Value;
     dDISP_HOR.Enabled    := dREP_A_DOMICILI.Value;

     tReparador.Enabled := dREP_EXTERNA.Value;
     tNouRep.Enabled := dREP_EXTERNA.Value;
     tEditarRep.Enabled := dREP_EXTERNA.Value;
     tEnviat.Enabled := dREP_EXTERNA.Value;

     dENVIAT.Enabled := dREP_EXTERNA.Value;
     dDATA_ENVIAMENT.Enabled := dREP_EXTERNA.Value and dENVIAT.Value;

     dNOM_REP.Enabled := dREP_EXTERNA.Value;
     dID_REP.Enabled := dREP_EXTERNA.Value;

     tDATA_REPARACIO.Enabled := dREP_FINALITZADA.Value;
     dDATA_REPARACIO.Enabled := dREP_FINALITZADA.Value;
end;

procedure T_eaveries.UDBAlterFormPostValues(Sender: TObject);
begin
     _personals.ActualitzarDades(Round(dID_CLI.Value));
     _personals.Refresh;     
     Imprimiraveria;
end;

procedure T_eaveries.Imprimiraveria;
begin
     if mDlg('Veure parte?',mtInformation,[mbYes,mbNo]) = mrYes
     then
          T_reports.Create(self).VeureAveries;
end;

procedure T_eaveries.UDBAlterFormBeforePost(sender: TObject;
  var Stop: Boolean);
begin
     dHORA.Time := time;

     if dANOMALIES.Caption = '(ANOMALÍES)' then dANOMALIES.Caption := '';
     if dOBSERVACIONS.Caption = '(OBSERVACIONS)' then dOBSERVACIONS.Caption := '';

     if ((dID_CLI.Value = 0) or (dID_CLI.Caption = '')) and (dNOM_CLI.Caption = '') then
     begin
          mDlg('No s''ha entrat client.',mtInformation,[mbOk]);
          Stop := true;
          exit;
     end;

     if not dREP_A_DOMICILI.Value then
     begin
          dDATA_VISITA.Date := 0;
          dDISP_HOR.Caption := '';
     end;

     if not dREP_EXTERNA.Value then
     begin
          dID_REP.Value := 0;
          dNOM_REP.Caption := '';
          dENVIAT.Value := false;
          dDATA_ENVIAMENT.Date := 0;
     end;

     if dREP_EXTERNA.Value and (dID_REP.Value = 0) then
     begin
          mDlg('Averia considerada per a reparació externa però reparador no assignat.',mtInformation,[mbOk]);
          Stop := true;
          exit;
     end;

     if not dENVIAT.Value and (dDATA_ENVIAMENT.Date <> 0)
     then dDATA_ENVIAMENT.Date := 0;

     if not dREP_FINALITZADA.Value then
          dDATA_REPARACIO.Date := 0;

     if dREP_EXTERNA.Value and (not dENVIAT.Value) and dREP_FINALITZADA.Value then
     if mDlg('Averia considerada per reparació externa i finalitzada, però sense haver estat enviada. Continuar?',mtInformation,[mbYes,mbNo]) <> mrYes then
     begin Stop := true; exit; end;

     if not dREP_FINALITZADA.Value and (vCInt.Data.DataSet.RecordCount > 0) then
     if mDlg('Hi han intervencions efectuades però no està marcat com a reparat. Continuar?',mtInformation,[mbYes,mbNo]) <> mrYes then
     begin Stop := true; exit; end;

     if dREP_FINALITZADA.Value and (dDATA_REPARACIO.Date < date) then
     if mDlg('Averia considerada com finalitzada, però data de reparació ja pasada o no establerta. Continuar?',mtInformation,[mbYes,mbNo]) <> mrYes then
     begin Stop := true; exit end;

     if dREP_A_DOMICILI.Value and (dDATA_VISITA.Date < date) and not dREP_FINALITZADA.Value then
     if mDlg('Averia considerada per reparació a domicili i amb una data de visita ja pasada. Continuar?',mtInformation,[mbYes,mbNo]) <> mrYes then
     begin Stop := true; exit; end;
end;

procedure T_eaveries.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
     dNOM_CLI.Data.Connection := dm.CG;
     dNOM_REP.Data.Connection := dm.CG;
end;

procedure T_eaveries.tNouRepReact(Sender: TObject);
begin
     case T_epersonals.Create(self).Nou_Reparador of
     mrOk :    with _personals.v.Data.DataSet do
               begin
                    dID_REP.Value    := FieldByName('ID').AsInteger;
                    dNOM_REP.Caption := FieldByName('NOM').AsString;
               end;
     end;
end;

procedure T_eaveries.dNOM_REPSetInnerCaption(Sender: TObject);
begin
     dID_REP.Left := dNOM_REP.Left + dNOM_REP.Width;
end;

procedure T_eaveries.dREP_A_DOMICILIChangeValue(sender: TObject;
  V: Variant; var Cancel: Boolean);
begin
     tDATA_VISITA.Enabled := V;
     tDISP_HOR.Enabled    := V;
     tVeureVisites.Enabled := V;

     dDATA_VISITA.Enabled := V;
     dDISP_HOR.Enabled    := V;

     if not V then dDATA_VISITA.Date := 0;
end;

procedure T_eaveries.dREP_EXTERNAChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     tReparador.Enabled := V;
     tNouRep.Enabled := V;
     tEditarRep.Enabled := V;
     tEnviat.Enabled := V;
     tDATA_ENVIAMENT.Enabled := V;

     dENVIAT.Enabled := V;
     dDATA_ENVIAMENT.Enabled := V and dENVIAT.Value;
     dNOM_REP.Enabled := V;
     dID_REP.Enabled := V;
end;

procedure T_eaveries.dREP_FINALITZADAChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     tDATA_REPARACIO.Enabled := V;
     dDATA_REPARACIO.Enabled := V;

     if V
     then dDATA_REPARACIO.Date := date
     else dDATA_REPARACIO.Date := 0;
end;

procedure T_eaveries.dENVIATChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     dDATA_ENVIAMENT.Enabled := V;

     if V
     then dDATA_ENVIAMENT.Date := date
     else dDATA_ENVIAMENT.Date := 0;
end;

procedure T_eaveries.tAmuntArtReact(Sender: TObject);
begin
     vCArt.CurrentUp;
end;

procedure T_eaveries.tAvallArtReact(Sender: TObject);
begin
     vCArt.CurrentDown;
end;

procedure T_eaveries.Moureamunt1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentUp;
end;

procedure T_eaveries.Moureavall1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentDown;
end;

procedure T_eaveries.dNOM_CLIShowPickForm(sender: TObject; F: TCustomForm;
  U: TUDBView);
begin
     U.Look.Assign(_personals.v.Look);
     U.AssignColumnInfo(CInfo[ctPersonals_p],VisFields[ctPersonals_p]);
     U.OnDrawRow := _personals.vDrawRow;
end;

procedure T_eaveries.tEditarRepReact(Sender: TObject);
begin
     if dID_REP.Value = 0 then
     mDlg('Codi de reparador no assignat. No es pot editar. Per referenciar aquest reparador ('+
     dNOM_REP.Caption + ') es recomana anar a processos i escollir '+
     '''Establir referències perdudes''',mtWarning,[mbOK])
     else
     case T_epersonals.Create(self).Modificar_per_id(Round(dID_REP.Value)) of
     mrOk :    with _personals.v.Data.DataSet do
               begin
                    dID_REP.Value    := FieldByName('ID').AsInteger;
                    dNOM_REP.Caption := FieldByName('NOM').AsString;
               end;
     end;
end;

procedure T_eaveries.tInsertarIntMatReact(Sender: TObject);
begin
     vCInt.PushInsert;
end;

procedure T_eaveries.tAmuntIntMatReact(Sender: TObject);
begin
     vCInt.CurrentUp;
end;

procedure T_eaveries.tAvallIntMatReact(Sender: TObject);
begin
     vCInt.CurrentDown;
end;

procedure T_eaveries.tVeureVisitesReact(Sender: TObject);
begin
     _averies.Visites(dDATA_VISITA.Date);
end;

end.
