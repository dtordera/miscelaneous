unit cpressupostos;

interface

uses Windows, Menus, Controls, Forms, Dialogs, sysutils, Estilcolor, DB, Graphics, StdCtrls, FPanel, Classes, UDBView,
  ExtCtrls;

type
  T_cpressupostos = class(TForm)
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
  _cpressupostos: T_cpressupostos;

implementation

uses dmsrc, main, global, pressupostos, articles, magatzem;

{$R *.DFM}

procedure T_cpressupostos.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_cpressupostos.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_cpressupostos.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_cpressupostos.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_cpressupostos.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tAltres.SelectNoReact;     
     _main.tcpressupostos.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_cpressupostos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_cpressupostos.vDblClick(Sender: TObject);
begin
     _pressupostos.v.Data.Filter := 'where id = ' + v.FieldByName('id_ref').AsString;
     _main.tpressupostos.React;
end;

procedure T_cpressupostos.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_cpressupostos.Articlerelacionat1Click(Sender: TObject);
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

procedure T_cpressupostos.Magatzemrelacionat1Click(Sender: TObject);
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

procedure T_cpressupostos.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
