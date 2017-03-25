unit cventesB;

interface

uses Windows, Menus, Controls, Forms, Dialogs, sysutils, Estilcolor, DB, Graphics, StdCtrls, FPanel, Classes, UDBView,
  ExtCtrls;

type
  T_cventesB = class(TForm)
    PopupMenu1: TPopupMenu;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    v: TUDBView;
    pCaption: TFPanel;
    lbCaption: TLabel;
    N1: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    Anara1: TMenuItem;
    Articlerelacionat1: TMenuItem;
    Magatzemrelacionat1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    Venta1: TMenuItem;
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MostraMenu;
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vDblClick(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Articlerelacionat1Click(Sender: TObject);
    procedure Magatzemrelacionat1Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    private
    public
end;

var
  _cventesB: T_cventesB;

implementation

uses dmsrc, main, global, ventesB, articles, magatzem;

{$R *.DFM}

procedure T_cventesB.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_cventesB.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_cventesB.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_cventesB.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_cventesB.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tAltres.SelectNoReact;     
     _main.tcVentesB.SelectNoReact;     
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_cventesB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_cventesB.vDblClick(Sender: TObject);
begin
     _ventesB.v.Data.Filter := 'where id = ' + v.FieldByName('id_ref').AsString;
     _main.tventesB.React;
end;

procedure T_cventesB.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_cventesB.Articlerelacionat1Click(Sender: TObject);
begin
     _articles.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+v.FieldByName('CONCEPTE').AsString+'%','''') + ')';
     _articles.v.Caption.Variable := v.FieldByName('CONCEPTE').AsString;

     if  (_articles.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''ha trobat aquest article a la taula d''articles. Es posible que estigui obsolet o hagi canviat la seva descripció.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tArticles.React;
     end;
end;

procedure T_cventesB.Magatzemrelacionat1Click(Sender: TObject);
begin
     _magatzem.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+v.FieldByName('CONCEPTE').AsString+'%','''') + ')';
     _magatzem.v.Caption.Variable := v.FieldByName('CONCEPTE').AsString;

     if  (_magatzem.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''ha trobat aquest article a la taula de magatzem.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tMagatzem.React;
     end;
end;

procedure T_cventesB.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
