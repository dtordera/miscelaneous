unit epressupostos;

interface

uses Windows, Menus, UDBAlter, UDBView, Controls, ExtCtrls, UText,
  Estilcolor, Llistcfg,Graphics, StdCtrls, UDBLabel, ULabel, Classes, Gradient, Forms, Dialogs, Sysutils, ComObj;

type T_epressupostos = class(TForm)
          UText1: TUText;
          dDATA: TDLabel;
          UText2: TUText;
          tNouClient: TUText;
          tEditarClient: TUText;
          tInsertarConcepte: TUText;
          tEditarConcepte: TUText;
          tEliminarConcepte: TUText;
          UText10: TUText;
          tIVA: TMUText;
          UText11: TUText;
          UText12: TUText;
          UText14: TUText;
          tMoureAmunt: TUText;
          tMoureAvall: TUText;
          btAnterior: TUText;
          btSeguent: TUText;
          btEntrar: TUText;
          dBASE: TNLabel;
          dIVA_P: TNLabel;
          dIVA: TNLabel;
          dDESCOMPTE_P: TNLabel;
          dTOTAL: TNLabel;
          dOBSERVACIONS: TXLabel;
          dSUBTOTAL: TNLabel;
          dDESCOMPTE: TNLabel;
          UDBAlterForm: TUDBAlterForm;
          GradientNC1: TGradientNC;
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
          dREALITZAT: TBLabel;
          Panel1: TPanel;
          dHORA: THLabel;
          UText4: TUText;
    dDESCOMPTE_C: TBLabel;
    Shape1: TShape;
    dTIPUS: TULabel;
    dNOM_CLI: TUDBLabel;
    vC: TUDBView;
    dREF_FACTURA_LIN: TULabel;
    dREF_FACTURA: TNLabel;
    tRef: TUText;
    tBASE: TUText;
    tSubtotal: TUText;
    tTOTAL: TUText;
    tREF_FACTURA: TUText;
    UText21: TUText;
    dATES_PER: TULabel;
    UText5: TUText;
    dN_SERIE: TXLabel;
    UText6: TUText;
    dPEU: TTLabel;
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
          procedure dDESCOMPTE_PChangeValue(sender: TObject; V: Variant;
          var Cancel: Boolean);
          procedure dDESCOMPTEChangeValue(sender: TObject; V: Variant;
          var Cancel: Boolean);
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
          procedure dPOB_CLISetInnerCaption(Sender: TObject);
          procedure dDIR_CLISetInnerCaption(Sender: TObject);
          procedure UDBAlterFormAfterLoadValues(Sender: TObject);
    procedure UDBAlterFormPostValues(Sender: TObject);
    procedure UDBAlterFormBeforePost(sender: TObject; var Stop: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure dDESCOMPTE_PClick(Sender: TObject);
    procedure dDESCOMPTEClick(Sender: TObject);
    procedure Moureamunt1Click(Sender: TObject);
    procedure Moureavall1Click(Sender: TObject);
    procedure tMoureAmuntReact(Sender: TObject);
    procedure tMoureAvallReact(Sender: TObject);
    procedure dTIPUSChange(Sender: TObject);
    procedure dNOM_CLIShowPickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
     private
          procedure TrobaObsCli;
          procedure CalculaPreus;
          procedure ColorBanda;
     public
          procedure Imprimirpressupost;
          function  NetejaReferencies : boolean;
     published
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
          procedure ComprobaCoherenciaDadesClient;
end;

implementation

{$R *.DFM}

uses personals, dmsrc, pressupostos, ADOdb, global, epersonals, econcepte, ecaixa,
  etorns, magatzem, reports, averies, ventesA, ventesB, cpressupostos;

procedure T_epressupostos.Nou;
begin
     ColorBanda;
     UDBAlterForm.New;
end;

procedure T_epressupostos.Modificar;
begin
     if _pressupostos.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else
          UDBAlterForm.Modify;
end;

function T_epressupostos.NetejaReferencies : boolean;
var
     q : TADOQuery;
     s : string;
     c : char;
begin
     result := true;

     c := Char(Copy(_pressupostos.v.FieldByName('REF_FACTURA_LIN').AsString,0,1)[1]);

     if _pressupostos.v.FieldByName('REF_FACTURA').AsInteger <> 0 then
     begin
          result := false;
          if mDlg('Aquest pressupost està referenciat a la factura #' + _pressupostos.v.FieldByName('REF_FACTURA').AsString + c +
          '. Si es continua, s''eliminarà la referència a la venta. Continuar?',mtInformation,[mbYes,mbNo]) = mrYes then
          begin
               result := true;
               q := TADOQuery.Create(nil);
               q.Connection := dm.CG;
               q.Active := false;
               q.SQL.Text := 'select * from ventes'+ c +  ' where REF_PRESSUPOST = ' + _pressupostos.v.FieldByName('id').AsString;
               q.Active := true;
               s := AnsiQuotedStr(StringReplace(q.FieldByName('OBSERVACIONS').AsString,'(factura de pressupost #' + _pressupostos.v.FieldByName('id').AsString + ') ','',[rfReplaceALl]),'''');
               q.Active := false;
               q.SQL.Text := 'update ventes' + c + ' set REF_PRESSUPOST = 0, OBSERVACIONS = ' + s + ' where REF_PRESSUPOST = ' + _pressupostos.v.FieldByName('id').AsString;
               q.ExecSQL;
               q.SQL.Text := 'update pressupostos set REF_FACTURA = 0,REF_FACTURA_LIN = '''' where id = ' + _pressupostos.v.FieldByName('id').AsString;
               q.ExecSQL;
               q.Free;
          end;
     end;

     _pressupostos.v.Refresh;

     case c of
     'A' : _ventesA.Refresh;
     'B' : _ventesB.Refresh;
     end;
end;

procedure T_epressupostos.Eliminar;
begin
     if _pressupostos.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a eliminar',mtInformation,[mbOk])
     else
     if NetejaReferencies
     then
          UDBAlterForm.Delete;
end;

procedure T_epressupostos.FormActivate(Sender: TObject);
begin
     vC.Data.Connection := dm.CT;
     vC.Data.Table := 'c_conceptes_tmp';

     vC.AssignColumnInfo(CInfo[ctc_general],VisFields[ctc_general]);

     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_epressupostos.TrobaObsCli;
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

procedure T_epressupostos.dNIF_CLISetInnerCaption(Sender: TObject);
begin
     lbNIF.Visible := dNIF_CLI.Caption <> '';
     dID_CLI.Left   := dNOM_CLI.Left + dNOM_CLI.Width;

     lbNIF.Left := dID_CLI.Left + dID_CLI.Width;
     dNIF_CLI.Left := lbNIF.Left + lbNIF.Width;
end;

procedure T_epressupostos.dTEL_CLISetInnerCaption(Sender: TObject);
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

procedure T_epressupostos.ComprobaCoherenciaDadesClient;
var
     q : TADOQuery;
begin
     if (dID_CLI.Value = 0) or (dID_CLI.Value = -999999) then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from personals where id = ' + floattostr(dID_CLI.Value) + ' and id <> -999999';
     q.Active := true;

     if (q.RecordCount = 0)
     then
     begin
          if mDlg('Atenció! La referència #' + dID_CLI.caption + ' no es troba a la taula de personals. Crear nou client ' +
          ' amb les dades de la pressupost?',mtWarning,[mbYes,mbNo]) = mrYes
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
        'al pressupost:'#13#10#13#10+
        'pressupost : '#13#10+
        dID_CLI.Caption + '  ' + dNOM_CLI.Caption + ' ' + dNIF_CLI.Caption + #13#10#13#10+
        'taula personals : '#13#10+
        dID_CLI.Caption + '  ' + q.FieldByName('NOM').AsString + ' ' + q.FieldByName('NIF').AsString,mtWarning,[mbOk]);

        mDlg('Es recomana editar el client o bé les dades de client de la pressupost per tal de que no hi '+
        'hagi incoherències.',mtInformation,[mbOk]);
        end;

     q.Free;
end;

procedure T_epressupostos.dCP_CLISetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_CLI.Caption) <> '';
     lbGUIO.Left    := dPOB_CLI.Left + dPOB_CLI.Width;
     dCP_CLI.Left   := lbGUIO.Left + lbGUIO.Width;

     ComprobaCoherenciaDadesClient;

     TrobaObsCli; // es posa aqui per executar-se l'últim després de carregar client
end;

procedure T_epressupostos.tNouClientReact(Sender: TObject);
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

procedure T_epressupostos.tEditarClientReact(Sender: TObject);
begin
     if dID_CLI.Value = -999999 then
     begin
          mDlg('Pressupost directe. No es pot editar el client',mtError,[mbOk]);
          exit;
     end;

     if (dID_CLI.Value = 0) then
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

procedure T_epressupostos.UDBAlterFormCreateTempDetailTables(
  sender: TObject; Id: String);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;
     dm.CT.Connected := true;

     q.Active := false;
     q.SQL.Text := 'insert into c_conceptes_tmp select c_pressupostos.* from c_pressupostos in ''' + dm.CR['database'] + ''' where (id_ref = ' + id + ')';
     q.ExecSQL;

     q.Free;
end;

procedure T_epressupostos.UDBAlterFormDropTempDetailTables(sender: TObject;
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

procedure T_epressupostos.vCDelete(Sender: TObject);
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

procedure T_epressupostos.vCReturn(Sender: TObject);
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

procedure T_epressupostos.vCInsert(Sender: TObject);
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

procedure T_epressupostos.Editarconcepte1Click(Sender: TObject);
begin
     vC.PushReturn;
end;

procedure T_epressupostos.tEditarConcepteReact(Sender: TObject);
begin
     vC.PushReturn;
end;

procedure T_epressupostos.Insertar1Click(Sender: TObject);
begin
     vC.PushInsert;
end;

procedure T_epressupostos.tInsertarConcepteReact(Sender: TObject);
begin
     vC.PushInsert;
end;

procedure T_epressupostos.Eliminarconcepte1Click(Sender: TObject);
begin
     vC.PushDelete;
end;

procedure T_epressupostos.tEliminarConcepteReact(Sender: TObject);
begin
     vC.PushDelete;
end;

procedure T_epressupostos.CalculaPreus;
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
     0 : begin dSUBTOTAL.Value := q.FieldByName('suma').AsFloat; dBASE.Value := dSUBTOTAL.Value / (1 + dIVA_P.Value/100); end;
     1 : begin dBASE.Value     := q.FieldByName('suma').AsFloat; dSUBTOTAL.Value := dBASE.Value * (1 + dIVA_P.Value/100); end;
     end;

     dIVA.Value := dBASE.Value * dIVA_P.Value /100;

     q.Free;

     dDESCOMPTE_P.OnChangeValue := nil;
     dDESCOMPTE.OnChangeValue   := nil;

     case dDESCOMPTE_C.Value of
     true  : dDESCOMPTE.Value   := dDESCOMPTE_P.Value * dSUBTOTAL.Value / 100;
     false : try    dDESCOMPTE_P.Value := 100 * dDESCOMPTE.Value / dSUBTOTAL.Value;
             except dDESCOMPTE_P.Value := 0;
             end;
     end;

     dTOTAL.Value := dSUBTOTAL.Value - dDESCOMPTE.Value;

     dDESCOMPTE_P.OnChangeValue := dDESCOMPTE_PChangeValue;
     dDESCOMPTE.OnChangeValue   := dDESCOMPTEChangeValue;
end;

procedure T_epressupostos.dDESCOMPTE_PChangeValue(sender: TObject;
  V: Variant; var Cancel: Boolean);
begin
     if (UDBAlterForm.State = asLoading) or not visible then exit;

     if dDESCOMPTE_C.Value then
          dDESCOMPTE.Value := dSUBTOTAL.Value * V / 100;
end;

procedure T_epressupostos.dDESCOMPTEChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     if (UDBAlterForm.State = asLoading) or not visible then exit;

     if not dDESCOMPTE_C.Value then
     try dDESCOMPTE_P.Value := 100 * V / dSUBTOTAL.Value
     except dDESCOMPTE_P.Value := 0;
     end;

     dTOTAL.Value := dSUBTOTAL.Value - V;
end;

procedure T_epressupostos.dIVA_PValueToCaption(Sender: TObject);
begin
     CalculaPreus;
end;

procedure T_epressupostos.tIVAReact(Sender: TObject);
begin
     CalculaPreus;
end;

procedure T_epressupostos.vCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     107 : begin vC.PushInsert; Key := 0; end;
     109 : begin vC.PushDelete; Key := 0; end;
     end;
end;

procedure T_epressupostos.UDBAlterFormDeleteDetailValues(sender: TObject;
  id: String; var Stop: Boolean);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     try
     q.Active := false;
     q.SQL.Text := 'delete * from c_pressupostos where id_ref = ' + id;
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

procedure T_epressupostos.UDBAlterFormInsertDetailValues(sender: TObject;
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
          q2.SQL.Text := 'select max(id) as NewId from c_pressupostos';
          q2.Active := true;

          idori := q2.FieldByName('NewId').AsInteger;

          q2.Active := false;
          q2.SQL.Text := 'select * from c_pressupostos';
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

               q.Next;
          end;
     except
     on E:EOleException do
          mDlg(Format('Error insertant detalls de ref. #'+id + #13#10 + 'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q2.Free;
     q.Free;

     _pressupostos.vC.Refresh;
     _cpressupostos.v.Refresh;
end;

procedure T_epressupostos.UDBAlterFormLoadDefValues(Sender: TObject);
var
     ss : TStrings;
begin
     dDATA.Date   := date;

     dBASE.Value  := 0;
     dIVA_P.Value := strtofloat(dm.CR['IVA_A']);
     dIVA.Value   := 0;
     dSUBTOTAL.Value := 0;
     dDESCOMPTE_P.Value := 0;
     dDESCOMPTE.Value := 0;
     dTOTAL.Value := 0;

     dOBSERVACIONS.Caption := '';
     dREF_FACTURA.Value   := 0;

     dATES_PER.Caption := Treballadors;

     ss := TStringList.Create;
     
     try    ss.LoadFromFile(BINDIR + 'STP\pi.inf');
            dPEU.Caption := ss.Text;
     except dPEU.Caption := '';
     end;
     
     ss.Free;
end;

procedure T_epressupostos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
//   VK_F1 : ajuda
     end;
end;

procedure T_epressupostos.UText3React(Sender: TObject);
begin
     vC.SetFocus;
end;

procedure T_epressupostos.dPOB_CLISetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_CLI.Caption) <> '';
     lbGUIO.Left    := dPOB_CLI.Left + dPOB_CLI.Width;
     dCP_CLI.Left   := lbGUIO.Left + lbGUIO.Width;
end;

procedure T_epressupostos.dDIR_CLISetInnerCaption(Sender: TObject);
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

procedure T_epressupostos.ColorBanda;
var
     c : TColor;
     s : string;
begin
     c := clBtnFace;

     if dREALITZAT.Value
     then
     begin
          c := C_REALITZATS;
          s := 'Pressupost ja realitzat';
     end;

     Panel1.Visible := c <> clBtnFace;
     Panel1.Font.Color := NegLumColor(c);
     Panel1.Color := c;
     Panel1.caption := s;
end;

procedure T_epressupostos.UDBAlterFormAfterLoadValues(Sender: TObject);
begin
     ColorBanda;
     CalculaPreus;
end;

procedure T_epressupostos.UDBAlterFormPostValues(Sender: TObject);
begin
     _personals.ActualitzarDades(Round(dID_CLI.Value));
     _personals.Refresh;     
     Imprimirpressupost;
end;

procedure T_epressupostos.Imprimirpressupost;
begin
     if mDlg('Veure pressupost?',mtInformation,[mbYes,mbNo]) = mrYes
     then T_reports.Create(self).Veurepressupost;
end;

procedure T_epressupostos.UDBAlterFormBeforePost(sender: TObject;
  var Stop: Boolean);
begin
     dHORA.Time := time;

     if ((dID_CLI.Value = 0) or (dID_CLI.Caption = '')) and (dNOM_CLI.Caption = '') then
     begin
          case mDlg('No s''ha entrat client. Pressupost directe?',mtInformation,
          [mbYes,mbNo]) of
          mrYes : begin
                         dID_CLI.Value := -999999;
                         dNOM_CLI.Caption := '<pressupost directe>';
                         dNIF_CLI.Caption := '';
                         dDIR_CLI.Caption := '';
                         dTEL_CLI.Caption := '';
                         dPOB_CLI.Caption := '';
                         dCP_CLI.Caption  := '';
                  end
          else Stop := true;
          end;
     end;
end;

procedure T_epressupostos.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
     dNOM_CLI.Data.Connection := dm.CG;     
end;

procedure T_epressupostos.dDESCOMPTE_PClick(Sender: TObject);
begin
     dDESCOMPTE_C.Value := true;
end;

procedure T_epressupostos.dDESCOMPTEClick(Sender: TObject);
begin
     dDESCOMPTE_C.Value := false;
end;

procedure T_epressupostos.Moureamunt1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentUp;
end;

procedure T_epressupostos.Moureavall1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentDown;
end;

procedure T_epressupostos.tMoureAmuntReact(Sender: TObject);
begin
     vC.CurrentUp;
end;

procedure T_epressupostos.tMoureAvallReact(Sender: TObject);
begin
     vC.CurrentDown;
end;

procedure T_epressupostos.dTIPUSChange(Sender: TObject);
var
     s : string;
begin
     if (UDBAlterForm.State = asLoading) then exit;

     if dTIPUS.Caption = 'P' then s := 'proveedor'
     else
     if dTIPUS.Caption = 'R' then s := 'reparador';

     if (dTIPUS.Caption = 'P') or (dTIPUS.Caption = 'R') then
     mDlg('Les dades escollides estan marcades com ' + s,mtInformation,[mbOK]);
end;

procedure T_epressupostos.dNOM_CLIShowPickForm(sender: TObject;
  F: TCustomForm; U: TUDBView);
begin
     U.Look.Assign(_personals.v.Look);
     U.AssignColumnInfo(CInfo[ctPersonals_p],VisFields[ctPersonals_p]);
end;

end.

