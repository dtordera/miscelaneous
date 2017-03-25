unit entrades;

interface

uses Windows, Menus, Dialogs, UDBView, Forms, estilcolor, db, StdCtrls, Controls, ExtCtrls, FPanel, Classes, Graphics, sysutils;

type T_entrades = class(TForm)
     Splitter1: TSplitter;
     PopupMenu1: TPopupMenu;
     NovaEntrada: TMenuItem;
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
    vC: TUDBView;
    Filtrespredefinits1: TMenuItem;
    N3: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    proveedorrelacionat1: TMenuItem;
    entradesdenormalitzaci1: TMenuItem;
    N4: TMenuItem;
    Marcarcompagada1: TMenuItem;
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
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    Articlerelacionat1: TMenuItem;
    Magatzemrelacionat1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    AplicarfiltreacolumnaF82: TMenuItem;
    Pagades1: TMenuItem;
     procedure vDelete(Sender: TObject);
     procedure vInsert(Sender: TObject);
     procedure vReturn(Sender: TObject);
     procedure NovaEntradaClick(Sender: TObject);
     procedure Modificar1Click(Sender: TObject);
     procedure Eliminararticle1Click(Sender: TObject);
     procedure Aplicarfiltre1Click(Sender: TObject);
     procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vCDblClick(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure proveedorrelacionat1Click(Sender: TObject);
    procedure entradesdenormalitzaci1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Marcarcompagada1Click(Sender: TObject);
    procedure Articlerelacionat1Click(Sender: TObject);
    procedure Magatzemrelacionat1Click(Sender: TObject);
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF82Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Pagades1Click(Sender: TObject);
     private
     procedure IAfterScroll(dataset : TDataset);     
     public
     procedure MarcarDesmarcarPagada;
     published
     procedure MostraMenu;
end;

var
  _entrades: T_entrades;

implementation

{$R *.DFM}

uses dmsrc, main, ADOdb, global, ecaixa, personals, gULIb, etorns, magatzem,
  articles;


procedure T_entrades.vDelete(Sender: TObject);
begin
     _main.OnDelete(sender);
end;

procedure T_entrades.vInsert(Sender: TObject);
begin
     _main.OnInsert(sender);
end;

procedure T_entrades.vReturn(Sender: TObject);
begin
     _main.OnReturn(sender);
end;

procedure T_entrades.NovaEntradaClick(Sender: TObject);
begin
     v.PushInsert;
end;

procedure T_entrades.Modificar1Click(Sender: TObject);
begin
     v.PushReturn;
end;

procedure T_entrades.Eliminararticle1Click(Sender: TObject);
begin
     v.PushDelete;
end;

procedure T_entrades.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_entrades.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_entrades.FormCreate(Sender: TObject);
begin
     v.Data.Dataset.AfterScroll := IAfterScroll;
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_entrades.MarcarDesmarcarPagada;
var
     b : boolean;
begin
     if v.Data.DataSet.RecordCount = 0 then
     begin
          mDlg('No hi ha registres a modificar',mtInformation,[mbOk]);
          exit;
     end;

     b := v.FieldByName('PAGADA').AsBoolean;

     if b
     then b := not (mDlg('Desmarcar entrada com pagada?',mtInformation,[mbYes,mbNo]) = mrYes)
     else b := mDlg('Marcar entrada com pagada?',mtInformation,[mbYes,mbNo]) = mrYes;

     v.Data.DataSet.Edit;
     v.Data.DataSet.FieldValues['PAGADA'] := b;
     v.Data.DataSet.Post;
     v.Refresh;
end;

procedure T_entrades.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_entrades.IAfterScroll(dataset : TDataset);
begin
     if v.Data.Dataset.RecordCount > 0
     then vC.Data.Filter := ' where id_ref = ' + v.FieldByName('id').AsString
     else vC.Data.Filter := ' where id_ref = -9999999';
end;

procedure T_entrades.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paEntrades);
     _main.NMSEnabled;
     _main.INoEnabled;     
end;

procedure T_entrades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_entrades.vCDblClick(Sender: TObject);
begin
     v.Locate('id',vc.FieldByName('id_ref').AsInteger,[]);
end;

procedure T_entrades.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_entrades.proveedorrelacionat1Click(Sender: TObject);
begin
     _personals.v.Data.Filter := 'where (id = ' + v.FieldByName('id_prv').AsString + ') ';
     _personals.v.Caption.Variable := v.FieldByName('NOM_PRV').AsString;

     if  (_personals.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest proveedor a la taula de dades personals.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tpersonals.React;
     end;
end;

procedure T_entrades.entradesdenormalitzaci1Click(Sender: TObject);
begin
     v.Data.Filter := 'where (id_prv = -999999)';
     v.Caption.Variable := 'entrades de normalització';
end;

procedure T_entrades.PopupMenu1Popup(Sender: TObject);
begin
     if v.FieldByName('pagada').AsBoolean
     then Marcarcompagada1.Caption := 'Desmarcar com pagada'
     else Marcarcompagada1.Caption := 'Marcar com pagada';

     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;     
end;

procedure T_entrades.Marcarcompagada1Click(Sender: TObject);
begin
     MarcarDesmarcarPagada;
end;

procedure T_entrades.Articlerelacionat1Click(Sender: TObject);
begin
     _articles.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+vC.FieldByName('CONCEPTE').AsString+'%','''') + ') ';
     _articles.v.Caption.Variable := vC.FieldByName('CONCEPTE').AsString;

     if  (_articles.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest concepte a la taula d''articles .',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tArticles.React;
     end;
end;

procedure T_entrades.Magatzemrelacionat1Click(Sender: TObject);
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

procedure T_entrades.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] <> 'SI' then exit;

     cl := clNone;

     if v.FieldByName('id_prv').AsInteger = -999999 then
          cl := clYellow;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_entrades.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

procedure T_entrades.AplicarfiltreacolumnaF82Click(Sender: TObject);
begin
     vC.CallColumnFilter;
end;

procedure T_entrades.MenuItem1Click(Sender: TObject);
begin
     vC.CallFilter;
end;

procedure T_entrades.MenuItem2Click(Sender: TObject);
begin
     vC.ClearFilter;
end;

procedure T_entrades.Pagades1Click(Sender: TObject);
begin
     v.Data.Filter := 'where (PAGADA = true)';
     v.Caption.Variable := 'pagades';
end;

end.

