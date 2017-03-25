unit pressupostos;

interface

uses Windows, Menus, UDBView, StdCtrls, Forms, Controls, ExtCtrls, FPanel, Classes, DB, graphics, dialogs, sysutils;

type T_pressupostos = class(TForm)
     Splitter1: TSplitter;
     PopupMenu1: TPopupMenu;
     Noupressupost: TMenuItem;
     Modificar1: TMenuItem;
     Eliminarpressupost1: TMenuItem;
     N1: TMenuItem;
     Aplicarfiltre1: TMenuItem;
     Eliminarfiltre1: TMenuItem;
     N2: TMenuItem;
     Anara1: TMenuItem;
    clientrelacionat1: TMenuItem;
    facturesrelacionades: TMenuItem;
    pCaption: TFPanel;
    lbCaption: TLabel;
    v: TUDBView;
    vC: TUDBView;
    Splitter2: TSplitter;
    Filtrespredefinits1: TMenuItem;
    pressupostosrealitzats1: TMenuItem;
    Marcarcomrealitzat1: TMenuItem;
    Facturar1: TMenuItem;
    N4: TMenuItem;
    Veurepressupost1: TMenuItem;
    N5: TMenuItem;
    N3: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
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
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    Articlerelacionat1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    AplicarfiltreacolumnaF82: TMenuItem;
     procedure vDelete(Sender: TObject);
     procedure vInsert(Sender: TObject);
     procedure vReturn(Sender: TObject);
     procedure NoupressupostClick(Sender: TObject);
     procedure Modificar1Click(Sender: TObject);
     procedure Eliminarpressupost1Click(Sender: TObject);
     procedure Aplicarfiltre1Click(Sender: TObject);
     procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vCDblClick(Sender: TObject);
    procedure pressupostosrealitzats1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Marcarcomrealitzat1Click(Sender: TObject);
    procedure Facturar1Click(Sender: TObject);
    procedure clientrelacionat1Click(Sender: TObject);
    procedure facturesrelacionadesClick(Sender: TObject);
    procedure Veurepressupost1Click(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Articlerelacionat1Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF82Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
     private
     procedure IAfterScroll(dataset : TDataset);
     public
          procedure Facturar; overload;
          procedure Facturar(c : char); overload;
          procedure Realitzat;
     published
     procedure MostraMenu;
end;

var
  _pressupostos: T_pressupostos;

implementation

{$R *.DFM}

uses dmsrc, main, ADOdb, global, ecaixa, personals, gULIb, etorns, magatzem,
  ventesA, ventesB, eventesA, eventesB, reports, articles, estilcolor;

procedure T_pressupostos.vDelete(Sender: TObject);
begin
     _main.OnDelete(sender);
end;

procedure T_pressupostos.vInsert(Sender: TObject);
begin
     _main.OnInsert(sender);
end;

procedure T_pressupostos.vReturn(Sender: TObject);
begin
     _main.OnReturn(sender);
end;

procedure T_pressupostos.NoupressupostClick(Sender: TObject);
begin
     v.PushInsert;
end;

procedure T_pressupostos.Modificar1Click(Sender: TObject);
begin
     v.PushReturn;
end;

procedure T_pressupostos.Eliminarpressupost1Click(Sender: TObject);
begin
     v.PushDelete;
end;

procedure T_pressupostos.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_pressupostos.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_pressupostos.FormCreate(Sender: TObject);
begin
     v.Data.Dataset.AfterScroll := IAfterScroll;
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_pressupostos.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_pressupostos.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] = 'NO' then exit;

     cl := clNone;

     if  v.FieldByName('REALITZAT').AsBoolean
     then cl := C_REALITZATS;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := neglumcolor(cl);
     end;
end;

procedure T_pressupostos.IAfterScroll(dataset : TDataset);
begin
     if v.Data.Dataset.RecordCount > 0
     then vC.Data.Filter := ' where id_ref = ' + v.FieldByName('id').AsString
     else vC.Data.Filter := ' where id_ref = -9999999';
end;

procedure T_pressupostos.Realitzat;
var
     b : boolean;
     s : string;
begin
     b := v.FieldByName('REALITZAT').AsBoolean;

     case b of
     true  : s := 'està marcat com realitzat. Desmarcar?';
     false : s := 'no està marcat com realitzat. Marcar?';
     end;

     if mDlg('Aquest pressupost ' + s,mtInformation,[mbYes,mbNo]) = mrYes then
     begin
          if (b = true) and (v.FieldByName('REF_FACTURA').AsInteger <> 0)
          and (mDlg('Aquest pressupost està facturat. Continuar desmarcant-lo?',mtInformation,[mbYes,mbNo]) <> mrYes) then exit;

          v.Data.Dataset.Edit;
          v.Data.Dataset.FieldValues['REALITZAT'] := not b;
          v.Data.Dataset.Post;
          v.Refresh;
     end;
end;

procedure T_pressupostos.Facturar;
begin
     if v.FieldByName('REF_FACTURA').AsInteger <> 0 then
     begin
          mDlg('Aquest pressupost ja està facturat (ref.#' + v.FieldByName('REF_FACTURA').AsString + v.FieldByName('REF_FACTURA_LIN').AsString + ')',mtInformation,[mbOk]);
          exit;
     end;

     case mDlg('Facturar pressupost #' + v.FieldByName('id').AsString + ' a quina línia ?',['Línia &A','Línia &B','&Cancelar']) of
     mrYes : Facturar('A');
     mrNo  : Facturar('B');
     end;
end;

procedure T_pressupostos.Facturar(c : Char);
var
     u,uc : TUDBView;
     id   : integer;
     q : TADOQuery;
     afs : TDatasetNotifyEvent;
begin
     u := nil;
     uc := nil;

     if not v.FieldByName('REALITZAT').AsBoolean then
     if mDlg('pressupost no marcat com realitzat. Marcar com realitzat?',mtInformation,[mbYes,mbNo]) = mrYes then
     begin
          v.Data.Dataset.Edit;
          v.Data.Dataset.FieldValues['REALITZAT'] := true;
          v.Data.Dataset.Post;
          v.Refresh;
     end;

     case c of
     'A' : begin u := _ventesA.v; uC := _ventesA.vC; end;
     'B' : begin u := _ventesB.v; uC := _ventesB.vC; end;
     end;

     afs := u.Data.Dataset.AfterScroll;
     u.Data.Dataset.AfterScroll := nil;

     with u.Data.Dataset do
     begin
          id := u.Data.GetNewId;
          Append;
          FieldValues['id']        := id;
          FieldValues['data']      := date;
          FieldValues['NOM_CLI']   := v.FieldByName('NOM_CLI').AsString;
          FieldValues['TOTAL']     := v.FieldByName('TOTAL').AsFloat;
          FieldValues['BASE']      := v.FieldByName('BASE').AsFloat;
          FieldValues['IVA']       := v.FieldByName('IVA').AsFloat;
          FieldValues['IVA_P']     := v.FieldByname('IVA_P').AsFloat;
          FieldValues['DESCOMPTE'] := v.FieldByName('DESCOMPTE').AsFloat;
          FieldValues['DESCOMPTE_P'] := v.FieldByName('DESCOMPTE_P').AsFloat;
          FieldValues['SUBTOTAL'] := v.FieldByName('SUBTOTAL').AsFloat;
          FieldValues['PENDENT']  := v.FieldByName('TOTAL').AsFloat;
          FieldValues['REF_pressupost'] := v.FieldByName('id').AsInteger;
          FieldValues['id_cli'] := v.FieldByname('id_cli').AsInteger;
          FieldValues['DIR_CLI'] := v.FieldByName('DIR_CLI').AsString;
          FieldValues['TEL_CLI'] := v.FieldByName('TEL_CLI').AsString;
          FieldValues['NIF_CLI'] := v.FieldByName('NIF_CLI').AsString;
          FieldValues['POB_CLI'] := v.FieldByName('POB_CLI').AsString;
          FieldValues['CP_CLI']  := v.FieldByName('CP_CLI').AsString;
          FieldValues['OBSERVACIONS'] := '(factura de pressupost #' + v.FieldByName('id').AsString + ') ' + v.FieldByName('OBSERVACIONS').AsString;
          FieldValues['ATES_PER'] := v.FieldByName('ATES_PER').AsString;
          Post;
     end;

     v.Data.Dataset.Edit;
     v.Data.Dataset.FieldValues['REF_FACTURA'] := id;
     v.Data.Dataset.FieldValues['REF_FACTURA_LIN'] := c;
     v.Data.Dataset.Post;
     v.Refresh;     

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from c_pressupostos where id_ref = ' + v.FieldByName('id').AsString;
     q.Active := true;
     q.First;

     while not q.Eof do
     begin
          with uC.Data.Dataset do
          begin
               id := uC.Data.GetNewId;
               Append;
               FieldValues['id']       := id;
               FieldValues['id_elem']  := q.FieldValues['id_elem'];
               FieldValues['id_ref']   := v.FieldByName('REF_FACTURA').AsInteger;
               FieldValues['id_lin']   := q.FieldValues['id_lin'];
               FieldValues['concepte'] := q.FieldValues['concepte'];
               FieldValues['uts']      := q.FieldValues['uts'];
               FieldValues['preu']     := q.FieldValues['preu'];
               FieldValues['import']   := q.FieldValues['import'];
               Post;
          end;
          q.Next;
     end;

     q.Free;

     u.Refresh;
     u.Data.Dataset.AfterScroll := afs;
          
     uC.Refresh;

     mDlg('Pressupost facturat (' + v.FieldByName('REF_FACTURA').AsString + v.FieldByName('REF_FACTURA_LIN').AsString + '). S''obrirà per editar.',mtInformation,[mbOk]);

     case C of
     'A' : T_eventesA.Create(Application).Modificar;
     'B' : T_eventesA.Create(Application).Modificar;
     end;
end;

procedure T_pressupostos.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.papressupostos);
     _main.NMSEnabled;
     _main.IEnabled;     
end;

procedure T_pressupostos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_pressupostos.vCDblClick(Sender: TObject);
begin
     v.Locate('id',vc.FieldByName('id_ref').AsInteger,[]);
end;

procedure T_pressupostos.pressupostosrealitzats1Click(Sender: TObject);
begin
     v.Data.Filter := 'where REALITZAT = true';
     v.Caption.Variable := 'pressupostos realitzats';
end;

procedure T_pressupostos.PopupMenu1Popup(Sender: TObject);
begin
     if v.FieldByName('realitzat').AsBoolean
     then Marcarcomrealitzat1.Caption := 'Desmarcar com realitzat'
     else Marcarcomrealitzat1.Caption := 'Marcar com realitzat';

     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;
end;

procedure T_pressupostos.Marcarcomrealitzat1Click(Sender: TObject);
begin
     Realitzat;
end;

procedure T_pressupostos.Facturar1Click(Sender: TObject);
begin
     Facturar;
end;

procedure T_pressupostos.clientrelacionat1Click(Sender: TObject);
begin
     _personals.v.Data.Filter := 'where (id = ' + v.FieldByName('id_cli').AsString + ') ';
     _personals.v.Caption.Variable := v.FieldByName('NOM_CLI').AsString;

     if  (_personals.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest client a la taula de dades personals.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tpersonals.React;
     end;
end;

procedure T_pressupostos.facturesrelacionadesClick(Sender: TObject);
begin
     if v.FieldByName('REF_FACTURA').AsInteger = 0 then
     begin
          mDlg('Aquest pressupost no ha estat facturat',mtInformation,[mbOk]);
          exit;
     end;

     if v.FieldByName('REF_FACTURA_LIN').AsString = 'A' then
     begin
          _ventesA.v.Data.Filter := 'where (id = ' + v.FieldByName('REF_FACTURA').AsString + ')';
          _ventesA.v.Caption.Variable := v.FieldByName('REF_FACTURA').AsString;

          if  (_ventesA.v.Data.Dataset.RecordCount = 0)
          then mDlg('ERROR: No es troba la factura relacionada ' + v.FieldByName('REF_FACTURA').AsString,mtError,[mbOk])
          else
          begin
               _main.PosaAPrevies(self);
               _main.tVentesA.React;
          end;
     end
     else
     begin
          _ventesB.v.Data.Filter := 'where (id = ' + v.FieldByName('REF_FACTURA').AsString + ')';
          _ventesB.v.Caption.Variable := v.FieldByName('REF_FACTURA').AsString;

          if  (_ventesB.v.Data.Dataset.RecordCount = 0)
          then mDlg('No es troba la factura relacionada ' + v.FieldByName('REF_FACTURA').AsString,mtError,[mbOk])
          else
          begin
               _main.PosaAPrevies(self);
               _main.tVentesB.React;
          end;
     end;
end;

procedure T_pressupostos.Veurepressupost1Click(Sender: TObject);
begin
     T_reports.Create(Application).Veurepressupost;
end;

procedure T_pressupostos.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_pressupostos.Articlerelacionat1Click(Sender: TObject);
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

procedure T_pressupostos.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

procedure T_pressupostos.AplicarfiltreacolumnaF82Click(Sender: TObject);
begin
     vC.CallColumnFilter;
end;

procedure T_pressupostos.MenuItem1Click(Sender: TObject);
begin
     vC.CallFilter;
end;

procedure T_pressupostos.MenuItem2Click(Sender: TObject);
begin
     vC.ClearFilter;
end;

end.

