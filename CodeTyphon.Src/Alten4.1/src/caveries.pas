unit caveries;

interface

uses Windows, Dialogs, Menus, UDBView, Forms, StdCtrls, Controls, ExtCtrls, FPanel, Classes, DB, graphics, estilcolor, sysutils;

type
  T_caveries = class(TForm)
    PopupMenu: TPopupMenu;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    pCaption: TFPanel;
    lbCaption: TLabel;
    vCArt: TUDBView;
    Splitter2: TSplitter;
    vCInt: TUDBView;
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
    procedure vCArtDblClick(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Magatzemrelacionat1Click(Sender: TObject);
    procedure Articlerelacionat1Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    private
  public
  end;

var
  _caveries: T_caveries;

implementation

uses dmsrc, main, global, averies, magatzem, articles;

{$R *.DFM}

procedure T_caveries.Aplicarfiltre1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CallFilter;
end;

procedure T_caveries.Eliminarfiltre1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).ClearFilter;
end;

procedure T_caveries.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_caveries.MostraMenu;
begin
     PopupMenu.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_caveries.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tAltres.SelectNoReact;
     _main.tcAveries.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_caveries.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_caveries.vCArtDblClick(Sender: TObject);
begin
     _averies.v.Data.Filter := 'where id = ' + (sender as TUDBView).FieldByName('id_ref').AsString;
     _main.tAveries.React;
end;

procedure T_caveries.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_caveries.Articlerelacionat1Click(Sender: TObject);
var
     v : TUDBView;
begin
     v := PopupMenu.PopupComponent as TUDBView;

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

procedure T_caveries.Magatzemrelacionat1Click(Sender: TObject);
var
     v : TUDBView;
begin
     v := PopupMenu.PopupComponent as TUDBView;

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

procedure T_caveries.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     (popupmenu.PopupComponent as TUDBView).CallColumnFilter;
end;

procedure T_caveries.PopupMenuPopup(Sender: TObject);
begin
     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;
end;

end.
