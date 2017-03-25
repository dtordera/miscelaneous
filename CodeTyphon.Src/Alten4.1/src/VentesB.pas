unit ventesB;

interface

uses Windows, Menus, StdCtrls, Forms, UDBView, ExtCtrls, FPanel, Controls, Classes, DB, Graphics, Dialogs, Sysutils, estilcolor;

type T_ventesB = class(TForm)
     Splitter1: TSplitter;
     PopupMenu1: TPopupMenu;
     NovaVenta: TMenuItem;
     Modificar1: TMenuItem;
     Eliminararticle1: TMenuItem;
     N1: TMenuItem;
     Aplicarfiltre1: TMenuItem;
     Eliminarfiltre1: TMenuItem;
     N2: TMenuItem;
    pCaption: TFPanel;
    lbCaption: TLabel;
    v: TUDBView;
    vC: TUDBView;
    N3: TMenuItem;
    Veurefactura1: TMenuItem;
    ImprimirTicket1: TMenuItem;
    Anara2: TMenuItem;
    Filtrespredefinits1: TMenuItem;
    Abonar1: TMenuItem;
    Cobrar1: TMenuItem;
    Clientrelacionat1: TMenuItem;
    Averiarelacionada1: TMenuItem;
    pressupostrelacionat1: TMenuItem;
    Ambpendent1: TMenuItem;
    Pagades1: TMenuItem;
    Abonaments1: TMenuItem;
    Abonades1: TMenuItem;
    Refernciesacaixa1: TMenuItem;
    N5: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    N4: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    Articlerelacionats1: TMenuItem;
    Magatzemrelacionat1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    AplicarfiltreacolumnaF82: TMenuItem;
    Modificacipuntual1: TMenuItem;
    Feraveria1: TMenuItem;
    Veureabonaments1: TMenuItem;
     procedure vDelete(Sender: TObject);
     procedure vInsert(Sender: TObject);
     procedure vReturn(Sender: TObject);
     procedure NovaVentaClick(Sender: TObject);
     procedure Modificar1Click(Sender: TObject);
     procedure Eliminararticle1Click(Sender: TObject);
     procedure Aplicarfiltre1Click(Sender: TObject);
     procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vCDblClick(Sender: TObject);
    procedure ucKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Abonar1Click(Sender: TObject);
    procedure Cobrar1Click(Sender: TObject);
    procedure Clientrelacionat1Click(Sender: TObject);
    procedure Averiarelacionada1Click(Sender: TObject);
    procedure pressupostrelacionat1Click(Sender: TObject);
    procedure Pagades1Click(Sender: TObject);
    procedure Ambpendent1Click(Sender: TObject);
    procedure Abonades1Click(Sender: TObject);
    procedure Abonaments1Click(Sender: TObject);
    procedure Refernciesacaixa1Click(Sender: TObject);
    procedure Veurefactura1Click(Sender: TObject);
    procedure ImprimirTicket1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Articlerelacionats1Click(Sender: TObject);
    procedure Magatzemrelacionat1Click(Sender: TObject);
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF82Click(Sender: TObject);
    procedure Modificacipuntual1Click(Sender: TObject);
    procedure Feraveria1Click(Sender: TObject);
    procedure Veureabonaments1Click(Sender: TObject);
     private
     procedure IAfterScroll(dataset : TDataset);
     public
     function  AmbCobraments : boolean;
     procedure Cobrar;
     procedure Abonar;
     published
     procedure MostraMenu;
end;

var
  _ventesB: T_ventesB;

implementation

{$R *.DFM}

uses dmsrc, main, ADOdb, global, ecaixa, personals, gULIb, etorns, magatzem,
  averies, pressupostos, caixa, reports, tickprn, articles, eventesB;

procedure T_ventesB.IAfterScroll(dataset : TDataset);
begin
     if v.Data.Dataset.RecordCount > 0
     then vC.Data.Filter := ' where id_ref = ' + v.FieldByName('id').AsString
     else vC.Data.Filter := ' where id_ref = -9999999';
end;

function T_ventesB.AmbCobraments : boolean;
var
     q : TADOQuery;
begin
     result := false;
     if v.Data.DataSet.RecordCount = 0 then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from c_caixa where venta = ' + v.FieldByName('id').AsString + ' and linea_fact = ''B''';
     q.Active   := true;

     result := q.RecordCount > 0;

     q.Free;
end;

procedure T_ventesB.vDelete(Sender: TObject);
begin
     _main.OnDelete(sender);
end;

procedure T_ventesB.vInsert(Sender: TObject);
begin
     _main.OnInsert(sender);
end;

procedure T_ventesB.vReturn(Sender: TObject);
begin
     _main.OnReturn(sender);
end;

procedure T_ventesB.NovaVentaClick(Sender: TObject);
begin
     v.PushInsert;
end;

procedure T_ventesB.Modificar1Click(Sender: TObject);
begin
     v.PushReturn;
end;

procedure T_ventesB.Eliminararticle1Click(Sender: TObject);
begin
     v.PushDelete;
end;

procedure T_ventesB.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_ventesB.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_ventesB.Cobrar;
begin
     if _ventesB.v.Data.DataSet.RecordCount = 0
     then
     begin
          mDlg('No hi ha registres a cobrar',mtInformation,[mbOk]);
          exit;
     end;

     if v.FieldByName('pagada').Asboolean then
     mDlg('Aquesta venta ja està completament cobrada',mtInformation,[mbOk])
     else
     if (v.FieldByName('total').AsFloat <= 0) then
     mDlg('Aquesta venta ja està abonada (els abonaments s''efectuen al moment)',
     mtInformation,[mbOK])
     else
     T_ecaixa.Create(self).Cobrar(v.FieldByName('id').AsInteger,lvB)
end;

procedure T_ventesB.Abonar;
var
     q : TADOQuery;
     s : string;
     id : integer;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     if v.Data.Dataset.RecordCount = 0 then
     begin
          mDlg('No hi han registres a abonar',mtInformation,[mbOk]);
          exit;
     end;

     if v.FieldByName('a_compte').AsFloat < 0 then
     begin
          mDlg('Aquesta venta ja correspon a un abonament',mtInformation,[mbOk]);
          exit;
     end;

     case TornObert of
     -1 : begin mDlg('No hi ha cap torn obert. No es pot facturar ni fer abonaments.',mtError,[mbOk]); exit; end;
     -2 : begin mDlg('Hi han varis torns oberts. No es pot facturar ni abonar cap venta fins que no es resolgui el problema.',mtError,[mbOK]); exit; end;
     end;

     if not v.FieldByName('PAGADA').AsBoolean then
     begin
          mDlg('No es poden fer abonaments d''una venta fins que aquesta no estigui completament pagada.',mtInformation,[mbOk]);
          exit;
     end;

     if v.FieldByName('ABONADA').AsBoolean then
     begin
          q.SQL.Text := 'select * from ventesB where abonament_de = ' + v.FieldByName('id').AsString;
          q.Active := true;
          q.First;

          s := '';

          if q.RecordCount > 0 then
          begin
               while not q.Eof do
               begin
                    s := s + q.FieldByName('id').AsString + ',';
                    q.Next;
               end;
               s[length(s)] := ' ';
          end;

          if mDlg('Aquesta venta ja té el/s abonament/s ' + s + '. Continuar? (l''abonament resultant serà inmodificable)',mtInformation,[mbYes,mbNo]) <> mrYes
          then exit;
     end
     else
     if mDlg('Crear abonament de la venta #' + v.FieldByName('id').AsString + '. Continuar? (l''abonament resultant serà inmodificable)',
     mtInformation,[mbYes,mbNo]) <> mrYes
     then exit;

     id := v.FieldByName('id').AsInteger;

     case T_eventesB.Create(Application).Abonar(id) of
     mrOk : begin
               q.Active := false;
               q.SQL.Text := 'select * from ventesB where id = ' + inttostr(id);
               q.Active := true;
               q.Edit;
               q.FieldValues['ABONADA'] := true;
               q.Post;

               mDlg('Venta #' + inttostr(id) + ' abonada amb ref. #' + v.FieldByName('id').AsString,mtInformation,[mbOk]);
            end;
     else   mDlg('Abonament cancel·lat',mtInformation,[mbOk]);
     end;

     q.Free;
end;

procedure T_ventesB.FormCreate(Sender: TObject);
begin
     v.Data.Dataset.AfterScroll := IAfterScroll;
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_ventesB.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_ventesB.vCDblClick(Sender: TObject);
begin
     v.Locate('id',vc.FieldByName('id_ref').AsInteger,[]);
end;

procedure T_ventesB.ucKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     VK_RETURN : begin vCDblClick(sender); Key := 0; end;
     end;
end;

procedure T_ventesB.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paventesB);
     _main.NMSEnabled;
     _main.IEnabled;     
end;

procedure T_ventesB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_ventesB.Abonar1Click(Sender: TObject);
begin
     Abonar;
end;

procedure T_ventesB.Cobrar1Click(Sender: TObject);
begin
     Cobrar;
end;

procedure T_ventesB.Clientrelacionat1Click(Sender: TObject);
begin
     _personals.v.Data.Filter := 'where (id = ' + v.FieldByName('id_cli').AsString + ') ';
     _personals.v.Caption.Variable := v.FieldByName('NOM_CLI').AsString;

     if  (_personals.v.Data.Dataset.RecordCount = 0)
     then mDlg('No hi ha registres relacionats d''aquest client a la taula de dades personals.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tpersonals.React;
     end;
end;

procedure T_ventesB.Averiarelacionada1Click(Sender: TObject);
begin
     if v.FieldByName('REF_AVERIA').AsInteger = 0 then
     begin
          mDlg('Aquesta venta no és factura de cap averia',mtInformation,[mbOk]);
          exit;
     end;

     _averies.v.Data.Filter := 'where (id = ' + v.FieldByName('REF_AVERIA').AsString + ')';
     _averies.v.Caption.Variable := v.FieldByName('REF_AVERIA').AsString;

     if  (_averies.v.Data.Dataset.RecordCount = 0)
     then mDlg('ERROR: No es troba l''averia relacionada ' + v.FieldByName('REF_AVERIA').AsString,mtError,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tAveries.React;
     end;
end;

procedure T_ventesB.pressupostrelacionat1Click(Sender: TObject);
begin
     if v.FieldByName('REF_pressupost').AsInteger = 0 then
     begin
          mDlg('Aquesta venta no es factura de cap pressupost',mtInformation,[mbOk]);
          exit;
     end;

     _pressupostos.v.Data.Filter := 'where (id = ' + v.FieldByName('REF_pressupost').AsString + ')';
     _pressupostos.v.Caption.Variable := v.FieldByName('REF_pressupost').AsString;

     if  (_pressupostos.v.Data.Dataset.RecordCount = 0)
     then mDlg('ERROR: No es troba el pressupost relacionat ' + v.FieldByName('REF_pressupost').AsString,mtError,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tpressupostos.React;
     end;
end;

procedure T_ventesB.Pagades1Click(Sender: TObject);
begin
     v.Data.Filter := 'where PAGADA = true';
     v.Caption.Variable := 'ventes pagades';
end;

procedure T_ventesB.Ambpendent1Click(Sender: TObject);
begin
     v.Data.Filter := 'where PENDENT <> 0';
     v.Caption.Variable := 'ventes amb pendent';
end;

procedure T_ventesB.Abonades1Click(Sender: TObject);
begin
     v.Data.Filter := 'where abonada';
     v.Caption.Variable := 'ventes abonades';
end;

procedure T_ventesB.Abonaments1Click(Sender: TObject);
begin
     v.Data.Filter := 'where (abonament_de <> 0) or (total < 0)';
     v.Caption.Variable := 'abonaments';
end;

procedure T_ventesB.Refernciesacaixa1Click(Sender: TObject);
begin
     _caixa.vC.Data.Filter := 'where (venta = ' + v.FieldByName('id').AsString + ') and linea_fact = ''A''';
     _caixa.vC.Caption.Variable := 'venta = ' + v.FieldByName('id').AsString;

     if _caixa.vC.Data.Dataset.RecordCount = 0
     then mDlg('No hi ha referències a caixa d''aquesta venta',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tCaixa.React;
     end;
end;

procedure T_ventesB.Veurefactura1Click(Sender: TObject);
begin
     T_reports.Create(self).VeureventesB;
end;

procedure T_ventesB.ImprimirTicket1Click(Sender: TObject);
begin
     tickprn.ImprimirTicket_A;
end;

procedure T_ventesB.PopupMenu1Popup(Sender: TObject);
begin
     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;
end;

procedure T_ventesB.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_ventesB.Articlerelacionats1Click(Sender: TObject);
begin
     _articles.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+vC.FieldByName('CONCEPTE').AsString+'%','''') + ') ';
     _articles.v.Caption.Variable := vC.FieldByName('CONCEPTE').AsString;

     if  (_articles.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest concepte a la taula d''articles.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tArticles.React;
     end;
end;

procedure T_ventesB.Magatzemrelacionat1Click(Sender: TObject);
begin
     _magatzem.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+vC.FieldByName('CONCEPTE').AsString+'%','''') + ') ';
     _magatzem.v.Caption.Variable := vC.FieldByName('CONCEPTE').AsString;

     if  (_magatzem.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest concepte a la taula de magatzem.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tMagatzem.React;
     end;
end;

procedure T_ventesB.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] <> 'SI' then exit;

     cl := clNone;

     if  ((sender as TUDBView).FieldByName('ABONAMENT_DE').AsString <> '')
     and ((sender as TUDBView).FieldByName('ABONAMENT_DE').AsInteger <> 0)
     then cl := C_ABONAMENT
     else
     if  ((sender as TUDBView).FieldByName('ABONADA').AsBoolean)
     then cl := C_ABONADA
     else
     if  ((sender as TUDBView).FieldByName('PENDENT').AsFloat > 0)
     then cl := C_ENDEUTE;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := neglumcolor(cl);
     end;
end;

procedure T_ventesB.MenuItem1Click(Sender: TObject);
begin
     vC.CallFilter;
end;

procedure T_ventesB.MenuItem2Click(Sender: TObject);
begin
     vC.ClearFilter;
end;

procedure T_ventesB.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

procedure T_ventesB.AplicarfiltreacolumnaF82Click(Sender: TObject);
begin
     vC.CallColumnFilter;
end;

procedure T_ventesB.Modificacipuntual1Click(Sender: TObject);
var
     d : TDateTime;
     s : string;
begin
     if v.Data.Dataset.RecordCount = 0 then
     begin
          mDlg('No hi han registres a modificar',mtInformation,[mbOk]);
          exit;
     end;

     s := v.FieldByName('observacions').AsString;
     d := v.FieldByName('data').AsDateTime;

     case mDlg('Modificar data o observacions?',['&Data','&Observacions','&Cancel·lar']) of
     mrYes : {data} d := DateIn('Data',datetostr(d));
     mrNo  : {observacions} s := MemoIn('Observacions',s);
     else
          exit;
     end;

     v.Data.Dataset.Edit;
     v.Data.Dataset.FieldValues['data'] := d;
     v.Data.Dataset.FieldValues['observacions'] := s;
     v.Data.Dataset.Post;
end;

procedure T_ventesB.Feraveria1Click(Sender: TObject);
var
     id : integer;
     idc : integer;
     q : TADOQuery;
     afs : TDatasetNotifyEvent;
begin
     if v.Data.Dataset.RecordCount = 0 then
     begin
          mDlg('No hi ha venta de la que fer averia',mtInformation,[mbOk]);
          exit;
     end;

     if mDlg('Fer averia desde venta #' + v.FieldByName('id').AsString + '?',mtInformation,[mbYes,mbCancel]) <> mrYes then exit;

     afs := _averies.v.Data.Dataset.AfterScroll;
     _averies.v.Data.Dataset.AfterScroll := nil;

     with _averies.v.Data.Dataset do
     begin
          id := _averies.v.Data.GetNewId;

          Append;
          FieldValues['id'] := id;
          FieldValues['data'] := date;
          FieldValues['nom_cli'] := v.FieldByName('nom_cli').AsString;
          FieldValues['dir_cli'] := v.FieldByName('dir_cli').AsString;
          FieldValues['nif_cli'] := v.FieldByName('nif_cli').AsString;
          FieldValues['tel_cli'] := v.FieldByName('tel_cli').AsString;
          FieldValues['pob_cli'] := v.FieldByName('pob_cli').AsString;
          FieldValues['cp_cli']  := v.FieldByName('cp_cli').AsString;
          FieldValues['data_entrada'] := date;
          FieldValues['data_entrega'] := date + 15;
          FieldValues['ref_origen'] := v.FieldByName('id').AsInteger;
          FieldValues['ref_origen_lin'] := 'B';
          FieldValues['ates_per'] := v.FieldByName('ates_per').AsString;          
          Post;
     end;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.SQL.Text := 'select * from c_ventesB where id_ref = ' + v.FieldByName('id').AsString + ' order by id asc';
     q.Active := true;
     q.First;

     with _averies.vCArt.Data.Dataset do
          while not q.Eof do
          begin
               idc := _averies.vCArt.Data.GetNewId;

               Append;
               FieldValues['id'] := idc;
               FieldValues['id_ref'] := id;
               FieldValues['id_elem'] := q.FieldByName('id_elem').AsInteger;
               FieldValues['id_lin']  := q.FieldByName('id_lin').AsInteger;
               FieldValues['concepte'] := q.FieldByName('concepte').AsString;
               FieldValues['uts'] := q.FieldByName('uts').AsFloat;
               Post;
               q.Next;
          end;

     q.Free;

     _averies.v.Data.Dataset.AfterScroll := afs;

     if mDlg('Averia realitzada. Obrir per editar?',mtInformation,[mbYes,mbCancel]) <> mrYes then exit;

     _averies.Modificar1.Click;
end;

procedure T_ventesB.Veureabonaments1Click(Sender: TObject);
var
     id : string;
begin
     id := v.FieldByName('id').AsString;
     v.Data.Filter := 'where abonament_de = ' + id;
     v.Caption.Variable := 'Abonaments de venta #' + id;
end;

end.











