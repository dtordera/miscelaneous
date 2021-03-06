unit averies;

interface

uses Windows, ComCtrls,Menus, StdCtrls, Forms, ExtCtrls, FPanel, Controls, UDBView, Classes, DB, Graphics, estilcolor, dialogs, sysutils;

type T_averies = class(TForm)
     Splitter1: TSplitter;
     PopupMenu1: TPopupMenu;
     Novaaveria: TMenuItem;
     Modificar1: TMenuItem;
     Eliminararticle1: TMenuItem;
     N1: TMenuItem;
     Aplicarfiltre1: TMenuItem;
     Eliminarfiltre1: TMenuItem;
     N2: TMenuItem;
     Anara1: TMenuItem;
     pCaption: TFPanel;
     lbCaption: TLabel;
     Splitter2: TSplitter;
     v: TUDBView;
     vCInt: TUDBView;
     vCArt: TUDBView;
    Filtrespredefinits1: TMenuItem;
    dpersonalsrelacionades1: TMenuItem;
    dpersonalsrelacionadesreparador1: TMenuItem;
    ventarelacionada1: TMenuItem;
    Veureparte1: TMenuItem;
    N4: TMenuItem;
    Reparacionspendents1: TMenuItem;
    Reparacionsexternes1: TMenuItem;
    Reparacionsadomicili1: TMenuItem;
    ReparacionsEnviades1: TMenuItem;
    Facturar1: TMenuItem;
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
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    Articlerelacionat1: TMenuItem;
    AplicarFiltreColumna: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    Visites1: TMenuItem;
    Facturaorigenrelacionada1: TMenuItem;
     procedure vDelete(Sender: TObject);
     procedure vInsert(Sender: TObject);
     procedure vReturn(Sender: TObject);
     procedure NovaaveriaClick(Sender: TObject);
     procedure Modificar1Click(Sender: TObject);
     procedure Eliminararticle1Click(Sender: TObject);
     procedure Aplicarfiltre1Click(Sender: TObject);
     procedure Eliminarfiltre1Click(Sender: TObject);
     procedure FormCreate(Sender: TObject);
     procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;C: TCanvas);
     procedure IAfterScroll(Dataset : TDataset);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dpersonalsrelacionades1Click(Sender: TObject);
    procedure dpersonalsrelacionadesreparador1Click(Sender: TObject);
    procedure ventarelacionada1Click(Sender: TObject);
    procedure Veureparte1Click(Sender: TObject);
    procedure Reparacionspendents1Click(Sender: TObject);
    procedure Reparacionsexternes1Click(Sender: TObject);
    procedure Reparacionsadomicili1Click(Sender: TObject);
    procedure vCArtDblClick(Sender: TObject);
    procedure vCIntClick(Sender: TObject);
    procedure Facturar1Click(Sender: TObject);
    procedure ReparacionsEnviades1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Articlerelacionat1Click(Sender: TObject);
    procedure AplicarFiltreColumnaClick(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Visites1Click(Sender: TObject);
    procedure Facturaorigenrelacionada1Click(Sender: TObject);
     private
     public
          procedure MOnClick(sender : TObject);
          procedure Facturar; overload;
          procedure Facturar(c : char); overload;
          procedure Visites(d : TDateTime);
     published
          procedure MostraMenu;
end;

var
  _averies: T_averies;

implementation

{$R *.DFM}

uses dmsrc, main, ADOdb, global, ecaixa, personals, gULIb, etorns, magatzem,
  ventesA, ventesB, eventesA, eventesB, reports, articles, LlistCfg;

procedure T_averies.vDelete(Sender: TObject);
begin
     _main.OnDelete(sender);
end;

procedure T_averies.vInsert(Sender: TObject);
begin
     _main.OnInsert(sender);
end;

procedure T_averies.vReturn(Sender: TObject);
begin
     _main.OnReturn(sender);
end;

procedure T_averies.NovaaveriaClick(Sender: TObject);
begin
     v.PushInsert;
end;

procedure T_averies.Modificar1Click(Sender: TObject);
begin
     v.PushReturn;
end;

procedure T_averies.Eliminararticle1Click(Sender: TObject);
begin
     v.PushDelete;
end;

procedure T_averies.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_averies.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_averies.FormCreate(Sender: TObject);
begin
     v.Data.Dataset.AfterScroll := IAfterscroll;
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_averies.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_averies.IAfterScroll(dataset : TDataset);
begin
     if v.Data.Dataset.RecordCount > 0
     then vCArt.Data.Filter := ' where id_ref = ' + v.FieldByName('id').AsString
     else vCArt.Data.Filter := ' where id_ref = -999999';

     vCInt.Data.Filter := vCArt.Data.Filter;
end;

procedure T_averies.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] = 'NO' then exit;

     cl := clNone;

     if v.FieldByName('REP_FINALITZADA').AsBoolean
     then cl := C_REP_FINALITZADA;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_averies.Facturar;
begin
     if v.FieldByName('REF_FACTURA').AsInteger <> 0 then
     begin
          mDlg('Aquesta averia ja est� facturada (ref.#' + v.FieldByName('REF_FACTURA').AsString + v.FieldByName('REF_FACTURA_LIN').AsString + ')',mtInformation,[mbOk]);
          exit;
     end;

     case mDlg('Facturar averia #' + v.FieldByName('id').AsString + ' a quina l�nia ?',['L�nia &A','L�nia &B','&Cancelar']) of
     mrYes : Facturar('A');
     mrNo  : Facturar('B');
     end;
end;

procedure T_averies.Facturar(c : Char);
var
     u,uc : TUDBView;
     id   : integer;
     q : TADOQuery;
     q2 : TADOQuery;
     afs : TDatasetNotifyEvent;
     p : double;
begin
     u := nil;
     uC := nil;

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
          FieldValues['REF_AVERIA'] := v.FieldByName('id').AsInteger;
          FieldValues['id_cli'] := v.FieldByname('id_cli').AsInteger;
          FieldValues['IVA_P']   := strtoint(dm.CR['IVA_'+C]);
          FieldValues['DIR_CLI'] := v.FieldByName('DIR_CLI').AsString;
          FieldValues['TEL_CLI'] := v.FieldByName('TEL_CLI').AsString;
          FieldValues['NIF_CLI'] := v.FieldByName('NIF_CLI').AsString;
          FieldValues['POB_CLI'] := v.FieldByName('POB_CLI').AsString;
          FieldValues['CP_CLI']  := v.FieldByName('CP_CLI').AsString;
          FieldValues['OBSERVACIONS'] := '(factura d''averia #' + v.FieldByName('id').AsString + ') ' + v.FieldByName('OBSERVACIONS').AsString;
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
     q.SQL.Text := 'select * from c_aveint where c_aveint.id_ref = ' + v.FieldByName('id').AsString;
     q.Active := true;
     q.First;

     q2 := TADOQuery.Create(nil);
     q2.Connection := dm.CG;
     q2.SQL.Text := 'select descr,pvp from articles';
     q2.Active := true;

     while not q.Eof do
     begin
          with uC.Data.Dataset do
          begin
               id := uC.Data.GetNewId;

               if q2.Locate('DESCR',q.FieldValues['concepte'],[]) then
               p := q2.FieldValues['pvp']
               else
               p := 0;

               Append;
               FieldValues['id']       := id;
               FieldValues['id_elem']  := q.FieldValues['id_elem'];
               FieldValues['id_ref']   := v.FieldByName('REF_FACTURA').AsInteger;
               FieldValues['id_lin']   := q.FieldValues['id_lin'];
               FieldValues['concepte'] := q.FieldValues['concepte'];
               FieldValues['uts']      := q.FieldValues['uts'];
               FieldValues['preu']   := p;
               FieldValues['import'] := q.FieldValues['uts'] * p;
               Post;
          end;
          q.Next;
     end;

     q2.Free;
     q.Free;

     u.Refresh;
     uC.Refresh;
     u.Data.Dataset.AfterScroll := afs;

     mDlg('Averia facturada (' + v.FieldByName('REF_FACTURA').AsString + v.FieldByName('REF_FACTURA_LIN').AsString + '). S''obrir� per editar.',mtInformation,[mbOk]);

     case C of
     'A' : T_eventesA.Create(Application).Modificar;
     'B' : T_eventesA.Create(Application).Modificar;
     end;
end;

procedure T_averies.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAveries);
     _main.NMSEnabled;
     _main.IEnabled;
end;

procedure T_averies.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_averies.dpersonalsrelacionades1Click(Sender: TObject);
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

procedure T_averies.dpersonalsrelacionadesreparador1Click(Sender: TObject);
begin
     if v.FieldByName('id_rep').AsInteger = 0 then
     begin
          mDlg('Aquesta averia no t� cap reparador asignat',mtInformation,[mbOk]);
          exit;
     end;

     _personals.v.Data.Filter := 'where (id = ' + v.FieldByName('id_rep').AsString + ') ';
     _personals.v.Caption.Variable := v.FieldByName('NOM_REP').AsString;

     if  (_personals.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest reparador a la taula de dades personals.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tpersonals.React;
     end;
end;

procedure T_averies.ventarelacionada1Click(Sender: TObject);
begin
     if v.FieldByName('REF_FACTURA').AsInteger = 0 then
     begin
          mDlg('Aquesta averia no ha estat facturada',mtInformation,[mbOk]);
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

procedure T_averies.Veureparte1Click(Sender: TObject);
begin
     T_reports.Create(self).VeureAveries;
end;

procedure T_averies.Reparacionspendents1Click(Sender: TObject);
begin
     v.Data.Filter := 'where REP_FINALITZADA = false';
     v.Caption.Variable := 'reparacions pendents';
end;

procedure T_averies.Reparacionsexternes1Click(Sender: TObject);
begin
     v.Data.Filter := 'where REP_EXTERNA = true';
     v.Caption.Variable := 'reparacions externes';
end;

procedure T_averies.Reparacionsadomicili1Click(Sender: TObject);
begin
     v.Data.Filter := 'where REP_A_DOMICILI = true';
     v.Caption.Variable := 'reparacions a domicili';
end;

procedure T_averies.vCArtDblClick(Sender: TObject);
begin
     v.Locate('id',vCArt.FieldByName('id_ref').AsInteger,[]);
end;

procedure T_averies.vCIntClick(Sender: TObject);
begin
     v.Locate('id',vCInt.FieldByName('id_ref').AsInteger,[]);
end;

procedure T_averies.Facturar1Click(Sender: TObject);
begin
     Facturar;
end;

procedure T_averies.ReparacionsEnviades1Click(Sender: TObject);
begin
     v.Data.Filter := 'where ENVIAT = true';
     v.Caption.Variable := 'reparacions enviades';
end;

procedure T_averies.PopupMenu1Popup(Sender: TObject);
begin
     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;
end;

procedure T_averies.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_averies.Articlerelacionat1Click(Sender: TObject);
var
     v : TUDBView;
begin
     v := PopupMenu2.PopupComponent as TUDBView;

     _articles.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+v.FieldByName('CONCEPTE').AsString+'%','''') + ') ';
     _articles.v.Caption.Variable := v.FieldByName('CONCEPTE').AsString;

     if  (_articles.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest concepte a la taula d''articles .',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tArticles.React;
     end;
end;

procedure T_averies.AplicarFiltreColumnaClick(
  Sender: TObject);
begin
     v.CallColumnFilter;     
end;

procedure T_averies.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     (popupmenu2.PopupComponent as TUDBView).CallColumnFilter;
end;

procedure T_averies.MenuItem1Click(Sender: TObject);
begin
     (popupmenu2.PopupComponent as TUDBView).CallFilter;
end;

procedure T_averies.MenuItem2Click(Sender: TObject);
begin
     (popupmenu2.PopupComponent as TUDBView).ClearFilter;
end;

procedure T_averies.Visites1Click(Sender: TObject);
begin
     Visites(v.FieldByName('data_visita').AsDateTime);
end;

procedure T_averies.MOnClick(sender : TObject);
var
     v : TUDBView;
     c : TMonthCalendar;
begin
     c := Sender as TMonthCalendar;
     v := ((sender as TControl).Parent as TForm).FindComponent('v') as TUDBView;
     v.Data.Filter := 'where data_visita = ' + FormatSQLDate(c.Date) + ' and rep_a_domicili';
     ((sender as TControl).Parent as TForm).Caption := 'Visites a ' + FormatDateTime('ddddd',c.Date);
end;

procedure T_averies.Visites(d : TDateTime);
var
     f : TForm;
     v : TUDBView;
     m : TMonthCalendar;
begin
     f := TForm.Create(Application);

     with f do
     begin
          f.Position := poScreenCenter;

          v := TUDBView.Create(f);
          v.Parent := f;
          v.Align := alClient;
          v.Data.Connection := dm.CG;
          v.Data.PrimaryKey := 'id';
          v.Data.Table := 'averies';
          v.AssignColumnInfo(CInfo[ctVisites],VisFields[ctVisites]);
          v.Name := 'v';

          f.ClientHeight := 400;
          f.ClientWidth  := v.TotalWidth;

          m := TMonthCalendar.Create(f);
          m.Parent := f;
          m.Visible := true;
          m.AutoSize := true;
          m.Cursor := crHandPoint;
          m.Top := v.ClientHeight - 30 - 20 - m.Height;
          m.Left := v.ClientWidth - 30 - m.Width;
          m.Anchors := [akRight,akBottom];

          if d = 0 then d := now;

          m.Date := d;
          m.OnClick := MOnClick;

          _estilcolor.Apply(f);

          f.ShowModal;

          m.Free;
          v.Free;
     end;

     f.Release;
end;

procedure T_averies.Facturaorigenrelacionada1Click(Sender: TObject);
begin
     if v.FieldByName('REF_ORIGEN').AsInteger = 0 then
     begin
          mDlg('Aquesta averia no ha estat facturada',mtInformation,[mbOk]);
          exit;
     end;

     if v.FieldByName('REF_ORIGEN_LIN').AsString = 'A' then
     begin
          _ventesA.v.Data.Filter := 'where (id = ' + v.FieldByName('REF_ORIGEN').AsString + ')';
          _ventesA.v.Caption.Variable := v.FieldByName('REF_ORIGEN').AsString;

          if  (_ventesA.v.Data.Dataset.RecordCount = 0)
          then mDlg('ERROR: No es troba la factura relacionada ' + v.FieldByName('REF_ORIGEN').AsString,mtError,[mbOk])
          else
          begin
               _main.PosaAPrevies(self);
               _main.tVentesA.React;
          end;
     end
     else
     begin
          _ventesB.v.Data.Filter := 'where (id = ' + v.FieldByName('REF_ORIGEN').AsString + ')';
          _ventesB.v.Caption.Variable := v.FieldByName('REF_ORIGEN').AsString;

          if  (_ventesB.v.Data.Dataset.RecordCount = 0)
          then mDlg('No es troba la factura relacionada ' + v.FieldByName('REF_ORIGEN').AsString,mtError,[mbOk])
          else
          begin
               _main.PosaAPrevies(self);
               _main.tVentesB.React;
          end;
     end;
end;

end.

