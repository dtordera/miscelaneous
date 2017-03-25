unit eventesB;

interface

uses Windows, Menus, UDBAlter, ExtCtrls, Controls, UDBView, UText,
  Graphics, LlistCfg,ComObj, Sysutils, Dialogs, StdCtrls, ULabel, UDBLabel,Forms, db, estilcolor, Classes, Gradient, ADOdb;

type TTipusVenta = (tvAbonament,tvVenta);

type T_eventesB = class(TForm)
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
          dNOM_CLI: TUDBLabel;
          vC: TUDBView;
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
          dA_COMPTE: TNLabel;
          dPENDENT: TNLabel;
          dDATA_COBRO: TDLabel;
          dPAGADA: TBLabel;
    dREF_pressupost: TNLabel;
    dREF_AVERIA: TNLabel;
          dABONAMENT_DE: TNLabel;
          Panel1: TPanel;
    dHORA: THLabel;
    dDESCOMPTE_C: TBLabel;
    Shape1: TShape;
    dTIPUS: TULabel;
    dLINEA_VENTA: TULabel;
    dID_LINEA_VENTA: TNLabel;
    UText4: TUText;
    UText5: TUText;
    UText6: TUText;
    UText7: TUText;
    UText8: TUText;
    UText9: TUText;
    UText13: TUText;
    UText15: TUText;
    UText16: TUText;
    UText17: TUText;
    UText18: TUText;
    UText19: TUText;
    UText20: TUText;
    UText21: TUText;
    dATES_PER: TULabel;
    dABONADA: TBLabel;
    UText22: TUText;
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
          procedure dTOTALSetInnerCaption(Sender: TObject);
          procedure dPENDENTSetInnerCaption(Sender: TObject);
    procedure UDBAlterFormPostValues(Sender: TObject);
    procedure UDBAlterFormBeforePost(sender: TObject; var Stop: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure dDESCOMPTE_PChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dDESCOMPTEChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dDESCOMPTE_PClick(Sender: TObject);
    procedure dDESCOMPTEClick(Sender: TObject);
    procedure Moureamunt1Click(Sender: TObject);
    procedure Moureavall1Click(Sender: TObject);
    procedure tMoureAmuntReact(Sender: TObject);
    procedure tMoureAvallReact(Sender: TObject);
    procedure dDATAChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dTIPUSChange(Sender: TObject);
    procedure dNOM_CLIShowPickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
    procedure FormDestroy(Sender: TObject);
     private
          ql : TADOQuery;
          procedure TrobaObsCli;
          procedure CalculaPreus;
          procedure ModificableONo;
          procedure LiniaArticles;
          procedure ColorBanda;
          procedure CarregaDadesVenta;
          procedure CarregaDadesAbonament;
     public
          id_abonament : integer;
          TipusVenta : TTipusVenta;
          procedure CobrarVenta;
          procedure ImprimirVenta;
          function  NetejaReferencies : boolean;
     published
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
          function Abonar(id : integer) : TModalResult;
          procedure ComprobaCoherenciaDadesClient;
end;

implementation

{$R *.DFM}

uses personals, dmsrc, ventesB, global, epersonals, econcepte, ecaixa,
  etorns, magatzem, reports, main, pressupostos, averies, cventesB;

procedure T_eventesB.Nou;
begin
     TipusVenta := tvVenta;
     Panel1.Visible := false;
     UDBAlterForm.New;
end;

procedure T_eventesB.Modificar;
begin
     if _ventesB.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else
     begin
          if _ventesB.AmbCobraments
          and (mDlg('Aquesta factura ja té cobraments fets, per lo que no es pot modificar',['&Veure','&Cancel·lar']) <> mrYes)
          then exit;

          UDBAlterForm.Modify;
     end;
end;

function T_eventesB.Abonar(id : integer) : TModalResult;
begin
     TipusVenta := tvAbonament;
     id_abonament := id;
     Panel1.Visible := false;
     result := UDBAlterForm.New;
end;

function T_eventesB.NetejaReferencies : boolean;
var
     s : string;
     q : TADOQuery;
begin
     result := true;

     s := '';

     if _ventesB.v.FieldByName('REF_pressupost').AsInteger <> 0 then s := 'l pressupost #' + _ventesB.v.FieldByName('REF_pressupost').AsString;

     if _ventesB.v.FieldByName('REF_AVERIA').AsInteger <> 0
     then
     begin
          if s <> '' then s := s + ' i a ';
          s := s + ' l''averia #' + _ventesB.v.FieldByName('REF_AVERIA').AsString;
     end;

     if s <> '' then
     begin
          result := false;
          if mDlg('Aquesta factura està referenciada a' + s + '. Si es continua s''eliminaran aquestes referències. Continuar?',mtInformation,[mbYes,mbNo]) = mrYes then
          begin
               q := TADOQuery.Create(nil);
               q.Connection := dm.CG;

               if _ventesB.v.FieldByName('REF_pressupost').AsString <> '' then
               begin
                    q.SQL.Text := 'update pressupostos set ref_factura = 0,ref_factura_lin = '''' where id = ' + _ventesB.v.FieldByName('REF_pressupost').AsString;
                    q.ExecSQL;
                    _pressupostos.v.Refresh;
               end;

               if _ventesB.v.FieldByName('REF_AVERIA').AsString <> '' then
               begin
                    q.SQL.Text := 'update averies set ref_factura = 0,ref_factura_lin = '''' where id = ' + _ventesB.v.FieldByName('REF_AVERIA').AsString;
                    q.ExecSQL;
                    _averies.v.Refresh;
               end;

               q.SQL.Text := 'update ventesB set ref_averia = 0,ref_pressupost = 0 where id = ' + _ventesB.v.FieldByName('id').AsString;
               q.ExecSQL;

               q.Free;
               result := true;
          end;
     end;
end;

procedure T_eventesB.Eliminar;
begin
     if _ventesB.v.Data.DataSet.RecordCount = 0
     then mDlg('No hi han registres a eliminar',mtInformation,[mbOk])
     else
     if _ventesB.AmbCobraments
     then mDlg('Aquesta factura ja té cobraments fets, per lo que no es pot eliminar. ',mtInformation,[mbOk])
     else
     if NetejaReferencies
     then
          UDBAlterForm.Delete;
end;

procedure T_eventesB.FormActivate(Sender: TObject);
begin
     vC.Data.Connection := dm.CT;
     vC.Data.Table := 'c_conceptes_tmp';

     vC.AssignColumnInfo(CInfo[ctc_general],VisFields[ctc_general]);

     if (ActiveControl is TCustomUText) then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_eventesB.TrobaObsCli;
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

procedure T_eventesB.dNIF_CLISetInnerCaption(Sender: TObject);
begin
     lbNIF.Visible := dNIF_CLI.Caption <> '';
     dID_CLI.Left   := dNOM_CLI.Left + dNOM_CLI.Width;

     lbNIF.Left := dID_CLI.Left + dID_CLI.Width;
     dNIF_CLI.Left := lbNIF.Left + lbNIF.Width;
end;

procedure T_eventesB.dTEL_CLISetInnerCaption(Sender: TObject);
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

procedure T_eventesB.ComprobaCoherenciaDadesClient;
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
          ' amb les dades de la venta?',mtWarning,[mbYes,mbNo]) = mrYes
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
        'a la venta:'#13#10#13#10+
        'venta : '#13#10+
        dID_CLI.Caption + '  ' + dNOM_CLI.Caption + ' ' + dNIF_CLI.Caption + #13#10#13#10+
        'taula personals : '#13#10+
        dID_CLI.Caption + '  ' + q.FieldByName('NOM').AsString + ' ' + q.FieldByName('NIF').AsString,mtWarning,[mbOk]);

        mDlg('Es recomana editar el client o bé les dades de client de la venta per tal de que no hi '+
        'hagi incoherències.',mtInformation,[mbOk]);
        end;

     q.Free;
end;

procedure T_eventesB.dCP_CLISetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_CLI.Caption) <> '';
     lbGUIO.Left    := dPOB_CLI.Left + dPOB_CLI.Width;
     dCP_CLI.Left   := lbGUIO.Left + lbGUIO.Width;

     ComprobaCoherenciaDadesClient;

     TrobaObsCli; // es posa aqui per executar-se l'últim després de carregar client
end;

procedure T_eventesB.tNouClientReact(Sender: TObject);
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

procedure T_eventesB.tEditarClientReact(Sender: TObject);
begin
     if dID_CLI.Value = -999999 then
     begin
          mDlg('Venta al comptat. No es pot editar el client',mtError,[mbOk]);
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


procedure T_eventesB.vCDelete(Sender: TObject);
var
     r : TModalResult;
begin
     if not tInsertarConcepte.Visible then exit;

     r := mrCancel;
     if vC.Data.DataSet.RecordCount = 0
     then mDlg('No hi han registres a eliminar',mtInformation,[mbOk])
     else r := T_econcepte.Create(Application).Eliminar(vC);

     if r = mrOk then
     begin
          CalculaPreus;
          LiniaArticles;
          UDBAlterForm.DataModified := true;
     end;
end;

procedure T_eventesB.vCReturn(Sender: TObject);
var
     r : TModalResult;
begin
     if not tInsertarConcepte.Visible then exit;

     r := mrCancel;

     if vC.Data.DataSet.RecordCount = 0
     then mDlg('No hi ha registres a modificar',mtInformation,[mbOk])
     else r := T_econcepte.Create(Application).Modificar(vC);

     if r = mrOK then
     begin
          CalculaPreus;
          LiniaArticles;
          UDBAlterForm.DataModified := true;
     end;
end;

procedure T_eventesB.vCInsert(Sender: TObject);
var
     r : TModalResult;
begin
     if not tInsertarConcepte.Visible then exit;

     r := T_econcepte.Create(Application).Nou(vC);

     if r = mrOk then
     begin
          CalculaPreus;
          LiniaArticles;
          UDBAlterForm.DataModified := true;
     end;
end;

procedure T_eventesB.Editarconcepte1Click(Sender: TObject);
begin
     vC.PushReturn;
end;

procedure T_eventesB.tEditarConcepteReact(Sender: TObject);
begin
     vC.PushReturn;
end;

procedure T_eventesB.Insertar1Click(Sender: TObject);
begin
     vC.PushInsert;
end;

procedure T_eventesB.tInsertarConcepteReact(Sender: TObject);
begin
     vC.PushInsert;
end;

procedure T_eventesB.Eliminarconcepte1Click(Sender: TObject);
begin
     vC.PushDelete;
end;

procedure T_eventesB.tEliminarConcepteReact(Sender: TObject);
begin
     vC.PushDelete;
end;

procedure T_eventesB.LiniaArticles;
var
     n : integer;
begin
     ql.Active   := false;
     ql.Connection := dm.CT;
     ql.SQL.Text := vC.Data.SQLText;
     ql.Active   := true;
     ql.First;

     n := -1;

     while not ql.Eof do
     begin
          if n = -1 then n := ql.FieldByName('id_lin').AsInteger
          else
          if n <> ql.FieldByName('id_lin').AsInteger
          then begin
                    n := -9;
                    break;
               end;

          ql.Next;
     end;

     case n of
     -1 : begin dID_LINEA_VENTA.Value := 0;  dLINEA_VENTA.Caption := ''; end;
     -9 : begin dID_LINEA_VENTA.Value := -1; dLINEA_VENTA.Caption := 'LINEA MIXTA'; end;
     else begin
               dID_LINEA_VENTA.Value := n;

               ql.Active   := false;
               ql.Connection := dm.CG;
               ql.SQL.Text := 'select * from linies where id = ' + inttostr(Round(dID_LINEA_VENTA.Value));
               ql.Active   := true;

               dLINEA_VENTA.Caption := ql.FieldByName('DESCR').AsString;
          end;
     end;
end;

procedure T_eventesB.CalculaPreus;
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

procedure T_eventesB.dIVA_PValueToCaption(Sender: TObject);
begin
     CalculaPreus;
end;

procedure T_eventesB.tIVAReact(Sender: TObject);
begin
     CalculaPreus;
end;

procedure T_eventesB.vCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     107 : begin vC.PushInsert; Key := 0; end;
     109 : begin vC.PushDelete; Key := 0; end;
     end;
end;

procedure T_eventesB.UDBAlterFormCreateTempDetailTables(
  sender: TObject; Id: String);
var
     q : TADOQuery;
begin
     // es crea una taula nova amb els conceptes de c_ventesB

     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;
     dm.CT.Connected := true;

     q.Active := false;
     q.SQL.Text := 'insert into c_conceptes_tmp select c_ventesB.* from c_ventesB in ''' + dm.CR['database'] + ''' where (id_ref = ' + id + ')';
     q.ExecSQL;

     q.SQL.Text := 'select * from c_conceptes_tmp';
     q.Active := true;

     q.Free;
end;

procedure T_eventesB.UDBAlterFormDropTempDetailTables(sender: TObject;
  Id: String);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT; // es borren totes les dades de conceptes temporals

     q.Active := false;
     q.SQL.Text := 'delete * from c_conceptes_tmp';
     q.ExecSQL;

     q.Free;
end;

procedure T_eventesB.UDBAlterFormDeleteDetailValues(sender: TObject;
  id: String; var Stop: Boolean);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil); // s'eliminen totes les dades relacionades al id. No necesita
     q.Connection := dm.CG;      // per res la taula temporal.

     try
     q.Active := false;
     q.SQL.Text := 'select * from c_ventesB where id_ref = ' + id;
     q.Active := true;
     q.First;

     while not q.Eof do
     begin
          magatzem.PosaAMagatzem(q.FieldByName('concepte').AsString,q.FieldByName('id_elem').AsInteger,q.FieldByName('uts').AsFloat,dDATA.Date);
          q.Delete;
     end;

     except
     on E:EOleException do
     begin
          Stop := true;
          mDlg(Format('Error eliminant detalls de ref. #'+id+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     end;
     q.Free;
     _magatzem.v.Refresh;
end;

procedure PosaMargeIdFam(id_elem : integer; q2 : TADOQuery);
var
     q : TADOQuery;
begin
     if id_elem = 0 then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.SQL.Text := 'select id,id_fam,marge from articles where id = ' + inttostr(id_elem);
     q.Active := true;

     if q.RecordCount > 0
     then
     begin
          q2.FieldValues['id_fam'] := q.FieldByName('id_fam').AsInteger;
          q2.FieldValues['marge']  := q.FieldByName('marge').AsFloat;
     end;

     q.Free;
end;

procedure T_eventesB.UDBAlterFormInsertDetailValues(sender: TObject;
  Id: String);
var
     q : TADOQuery;
     q2 : TADOQuery;
     idori : integer;
     id_elem : integer;
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
          q2.SQL.Text := 'select max(id) as NewId from c_ventesB';
          q2.Active := true;

          idori := q2.FieldByName('NewId').AsInteger;

          q2.Active := false;
          q2.SQL.Text := 'select * from c_ventesB';
          q2.Active := true;

          while not q.Eof do
          begin
               inc(idori);

               id_elem := q.FieldByName('id_elem').AsInteger;

               q2.Append;
               q2.FieldValues['id']       := idori;
               q2.FieldValues['id_ref']   := id;
               q2.FieldValues['id_elem']  := id_elem;
               q2.FieldValues['id_lin']   := q.FieldByName('id_lin').AsInteger;
               q2.FieldValues['concepte'] := q.FieldByName('concepte').AsString;
               q2.FieldValues['preu']     := q.FieldByName('preu').AsFloat;
               q2.FieldValues['uts']      := q.FieldByName('uts').AsFloat;
               q2.FieldValues['import']   := q.FieldByName('import').AsFloat;

               PosaMargeIdFam(id_elem,q2);

               q2.Post;

               if (q.FieldByName('uts').asFloat < 0) and (TipusVenta <> tvAbonament) then
                    mDlg('Les unitats del concepte ' + q.FieldByName('concepte').AsString + ' són ' + q.FieldByName('uts').AsString +
                    '. Es considera abonament i es tornen a posar al magatzem.',mtInformation,[mbOk]);

               magatzem.TreuDeMagatzem(q.FieldByName('concepte').AsString,q.FieldByName('id_elem').AsInteger,q.FieldByName('uts').AsFloat,dDATA.Date);
               q.Next;
          end;
     except
     on E:EOleException do
          mDlg(Format('Error insertant detalls de ref. #'+id + #13#10 + 'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q2.Free;
     q.Free;

     _ventesB.vC.Refresh;
     _magatzem.v.Refresh;
     _cventesB.v.Refresh;
end;

procedure T_eventesB.CarregaDadesVenta;
begin
     dDATA.Date   := date;

     dBASE.Value  := 0;
     dIVA_P.Value := strtofloat(dm.CR['IVA_A']);
     dIVA.Value   := 0;
     dSUBTOTAL.Value := 0;
     dDESCOMPTE_P.Value := 0;
     dDESCOMPTE.Value := 0;
     dDESCOMPTE_C.Value := false;
     dTOTAL.Value := 0;

     dA_COMPTE.value := 0;
     dPENDENT.Value  := 0;
     dDATA_COBRO.Caption := '';

     dOBSERVACIONS.Caption := '';
     dREF_pressupost.Value     := 0;
     dREF_AVERIA.Value   := 0;
     dABONADA.Value    := false;
     dABONAMENT_DE.Value   := 0;

     dATES_PER.Caption := Treballadors;
end;

procedure T_eventesB.CarregaDadesAbonament;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.SQL.Text := 'select * from ventesB where id = ' + inttostr(id_abonament);
     q.Active := true;

     dDATA.Date       := q.FieldByName('data').AsDateTime;
     dID_CLI.Caption  := q.FieldByname('id_cli').AsString;
     dNOM_CLI.Caption := q.FieldByName('nom_cli').AsString;
     dDIR_CLI.Caption := q.FieldByName('dir_cli').AsString;
     dTEL_CLI.Caption := q.FieldByName('tel_cli').AsString;
     dNIF_CLI.Caption := q.FieldByName('nif_cli').AsString;
     dPOB_CLI.Caption := q.FieldByName('pob_cli').AsString;
     dCP_CLI.Caption  := q.FieldByName('cp_cli').AsString;
     dID_LINEA_VENTA.Caption := q.FieldByName('id_linea_venta').AsString;
     dLINEA_VENTA.Caption := q.FieldByName('linea_venta').AsString;
     dBASE.Value := -q.FieldByName('base').AsFloat;
     dIVA_P.Value := q.FieldByName('iva_p').AsFloat;
     dIVA.Value   := -q.FieldByName('iva').AsFloat;
     dSUBTOTAL.Value := -q.FieldByName('subtotal').AsFloat;
     dDESCOMPTE_P.Value := q.FieldByName('descompte_p').AsFloat;
     dDESCOMPTE.Value   := q.FieldByName('descompte').AsFloat;
     dTOTAL.Value       := -q.FieldByName('total').AsFloat;
     dA_COMPTE.Value    := 0;
     dPENDENT.Value     := dTOTAL.Value;
     dOBSERVACIONS.Caption := '(abonament de venta #' + inttostr(id_abonament) + '). '+q.FieldByName('observacions').AsString;
     dPAGADA.Value := false;
     dDATA_COBRO.Date := 0;
     dREF_pressupost.Value := 0;
     dREF_averia.Value := 0;
     dABONADA.Value := false;
     dABONAMENT_DE.Value := id_abonament;
     dATES_PER.Caption := Treballadors;
// n_serie

     q.Active := false;
     q.Connection := dm.CT;

     q.SQL.Text := 'insert into c_conceptes_tmp select c_ventesB.* from c_ventesB in ''' + dm.CR['database'] + ''' where (id_ref = ' + inttostr(id_abonament) + ')';
     q.ExecSQL;
     q.SQL.Text := 'update c_conceptes_tmp set uts = -uts, import = -import';
     q.ExecSQL;

     q.Free;
end;

procedure T_eventesB.UDBAlterFormLoadDefValues(Sender: TObject);
begin
     case TipusVenta of
     tvAbonament : CarregaDadesAbonament;
     tvVenta     : CarregaDadesVenta;
     end;
end;

procedure T_eventesB.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
//   VK_F1 : ajuda
     end;
end;

procedure T_eventesB.UText3React(Sender: TObject);
begin
     vC.SetFocus;
end;

procedure T_eventesB.dPOB_CLISetInnerCaption(Sender: TObject);
begin
     lbGUIO.Visible := Trim(dCP_CLI.Caption) <> '';
     lbGUIO.Left    := dPOB_CLI.Left + dPOB_CLI.Width;
     dCP_CLI.Left   := lbGUIO.Left + lbGUIO.Width;
end;

procedure T_eventesB.dDIR_CLISetInnerCaption(Sender: TObject);
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

procedure T_eventesB.ColorBanda;
var
     c : TColor;
     s : string;
begin
     c := clBtnFace;

     if dABONAMENT_DE.Value <> 0
     then
     begin
          c := C_ABONAMENT;
          s := 'Abonament de venta #' + dABONAMENT_DE.Caption;
     end
     else
     if dABONADA.Value
     then
     begin
          c := C_ABONADA;
          s := 'Amb abonaments';
     end
     else
     if  (dPENDENT.Value > 0)
     then
     begin
          c := C_ENDEUTE;
          s := 'Amb deute pendent';
          if _ventesB.AmbCobraments then
          s := s + ' (amb cobraments parcials. No modificable)';
     end
     else
     if _ventesB.AmbCobraments then
     begin
          if c = clBtnFace then c := clSilver;
          s := 'Amb cobraments. No modificable.';
     end;

     UDBAlterForm.NotAllowPost := _ventesB.AmbCobraments;

     Panel1.Visible := c <> clBtnFace;
     Panel1.Font.Color := NegLumColor(c);
     Panel1.Color := c;
     Panel1.caption := s;
end;

procedure T_eventesB.UDBAlterFormAfterLoadValues(Sender: TObject);
begin
     ColorBanda;
     CalculaPreus;
     ModificableONo;
end;

procedure T_eventesB.ModificableONo;
var
     b : boolean;
begin
     b := UDBAlterForm.NotAllowPost;

     dDATA.NoClick := b;
     dNOM_CLI.NoClick := b;
     dIVA_P.NoClick := b;
     dDESCOMPTE_P.NoClick := b;
     dDESCOMPTE.NoClick := b;
     dOBSERVACIONS.NoClick := b;
     tIVA.NotAllowChange := b;

     b := not b;
     
     tNouClient.Visible := b;
     tEditarClient.Visible := b;
     tInsertarConcepte.Visible := b;
     tEditarConcepte.Visible := b;
     tEliminarConcepte.Visible := b;
     tMoureAmunt.Visible := b;
     tMoureAvall.Visible := b;

     Insertar1.Enabled := b;
     EditarConcepte1.Enabled := b;
     EliminarConcepte1.Enabled := b;

     MoureAmunt1.Enabled := b;
     MoureAvall1.Enabled := b;
end;

procedure T_eventesB.dTOTALSetInnerCaption(Sender: TObject);
begin
     if not (csLoading in ComponentState) and Visible
     then dPENDENT.Value := dTOTAL.Value - dA_COMPTE.Value;
end;

procedure T_eventesB.dPENDENTSetInnerCaption(Sender: TObject);
begin
     if not (csLoading in ComponentState) and Visible
     then dPAGADA.Value := (dPENDENT.Value = 0) and (dTOTAL.Value = 0);
end;

procedure T_eventesB.UDBAlterFormPostValues(Sender: TObject);
begin
     _personals.ActualitzarDades(Round(dID_CLI.Value)); 
     _personals.Refresh;
     CobrarVenta;
     ImprimirVenta;
end;

procedure T_eventesB.ImprimirVenta;
begin
     case mDlg('Imprimir a full o a ticket?',['&Full','&Ticket','&No imprimir']) of
     mrYes : {full}   T_reports.Create(self).VeureventesB;
     mrNo  : {ticket} _main.tImprTicket.React;
     mrCancel : ;
     end;
end;

procedure T_eventesB.CobrarVenta;
begin
     if _ventesB.v.FieldByName('PENDENT').AsFloat <> 0 then
     if _ventesB.v.FieldByName('PENDENT').AsFloat < 0 then
     begin
          mDLG('Venta amb pendent negatiu. Es farà abonament automàticament (els abonaments han de pagar-se al acte)',mtInformation,[mbOk]);
          T_ecaixa.Create(self).Abonament(_ventesB.v.FieldByName('id').AsInteger,lvB);
     end
     else
     case mDlg('Venta amb pendent. Cobrar venta?',mtInformation,[mbYes,mbNo]) of
     mrYes : if T_ecaixa.Create(self).Cobrar(_ventesB.v.FieldByName('id').AsInteger,lvB) <> mrOk then
               mDlg('Cobrament cancel·lat',mtInformation,[mbOk]);
     end;
end;

procedure T_eventesB.UDBAlterFormBeforePost(sender: TObject;
  var Stop: Boolean);
begin
     dHORA.Time := time;

     if dREF_PRESSUPOST.Value <> 0 then
     if mDlg('Aquesta venta referencia al pressupost ' + FormatFloat('0',dREF_PRESSUPOST.Value) + '. No s''actualitzaran les modificacions de la venta al pressupost. Continuar?',mtWarning,[mbYes,mbNo]) <> mrYes then
     begin
          Stop := true;
          exit;
     end;

     if dREF_AVERIA.Value <> 0 then
     if mDlg('Aquesta venta referencia a l''averia ' + FormatFloat('0',dREF_AVERIA.Value) + '. No s''actualitzaran les modificacions de la venta a l''averia. Continuar?',mtWarning,[mbYes,mbNo]) <> mrYes then
     begin
          Stop := true;
          exit;
     end;

     if (dPENDENT.Value < 0) and (TornObert < 0) then
     begin
          mDlg('No es pot donar d''alta aquesta venta, ja que els '+
          'abonaments han d''efectuar-se al moment i no hi ha cap torn de caixa obert.',mtError,[mbOk]);
          Stop := true;
          exit;
     end;

     if ((dID_CLI.Value = 0) or (dID_CLI.Caption = '')) and (dNOM_CLI.Caption = '') then
     begin
          case mDlg('No s''ha entrat client. Venta al comptat?',mtInformation,
          [mbYes,mbNo]) of
          mrYes : begin
                         dID_CLI.Value := -999999;
                         dNOM_CLI.Caption := '<venta al comptat>';
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

procedure T_eventesB.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);

     ql := TADOQuery.Create(nil);
end;

procedure T_eventesB.dDESCOMPTE_PChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     if (UDBAlterForm.State = asLoading) or not visible then exit;

     if dDESCOMPTE_C.Value then
          dDESCOMPTE.Value := dSUBTOTAL.Value * V / 100;
end;

procedure T_eventesB.dDESCOMPTEChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     if (UDBAlterForm.State = asLoading) or not visible then exit;

     if not dDESCOMPTE_C.Value then
     try dDESCOMPTE_P.Value := 100 * V / dSUBTOTAL.Value
     except dDESCOMPTE_P.Value := 0;
     end;

     dTOTAL.Value := dSUBTOTAL.Value - V;
end;

procedure T_eventesB.dDESCOMPTE_PClick(Sender: TObject);
begin
     dDESCOMPTE_C.Value := true;
end;

procedure T_eventesB.dDESCOMPTEClick(Sender: TObject);
begin
     dDESCOMPTE_C.Value := false;
end;

procedure T_eventesB.Moureamunt1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentUp;
end;

procedure T_eventesB.Moureavall1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CurrentDown;
end;

procedure T_eventesB.tMoureAmuntReact(Sender: TObject);
begin
     vC.CurrentUp;
end;

procedure T_eventesB.tMoureAvallReact(Sender: TObject);
begin
     vC.CurrentDown;
end;

procedure T_eventesB.dDATAChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     if not (csLoading in ComponentState) and not (UDBAlterForm.State = asLoading) and Visible then
     Cancel := not (mDlg('Es considera la data de factura com l''inici de la garantía de 15 díes. Canviar data?',mtWarning,[mbYes,mbNo]) = mrYes);
end;

procedure T_eventesB.dTIPUSChange(Sender: TObject);
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

procedure T_eventesB.dNOM_CLIShowPickForm(sender: TObject; F: TCustomForm;
  U: TUDBView);
begin
     U.Look.Assign(_personals.v.Look);
     U.AssignColumnInfo(CInfo[ctPersonals_p],VisFields[ctPersonals_p]);
end;

procedure T_eventesB.FormDestroy(Sender: TObject);
begin
     ql.Free;
end;

end.
