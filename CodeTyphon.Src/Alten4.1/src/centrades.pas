unit centrades;

interface

uses Windows, Menus, Controls, Forms, StdCtrls, ExtCtrls, FPanel, Classes, UDBView, db, graphics, sysutils, dialogs;

type
 T_centrades = class(TForm)
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
  _centrades: T_centrades;

implementation

uses dmsrc, main, global, entrades, articles, magatzem, estilcolor;

{$R *.DFM}

procedure T_centrades.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_centrades.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_centrades.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_centrades.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_centrades.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tcEntrades.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;     
end;

procedure T_centrades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_centrades.vDblClick(Sender: TObject);
begin
     _entrades.v.Data.Filter := 'where id = ' + v.FieldByName('id_ref').AsString;
     _main.tEntrades.React;
end;

procedure T_centrades.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_centrades.Articlerelacionat1Click(Sender: TObject);
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

procedure T_centrades.Magatzemrelacionat1Click(Sender: TObject);
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

procedure T_centrades.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
