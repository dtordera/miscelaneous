unit linies;

interface

uses Windows, Menus, Controls, Forms, DB, Graphics, StdCtrls, ExtCtrls, FPanel, Classes, EstilColor, UDBView;

type
  T_linies = class(TForm)
    PopupMenu1: TPopupMenu;
    NovaLinia: TMenuItem;
    Modificar1: TMenuItem;
    EliminarRegistre1: TMenuItem;
    N1: TMenuItem;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    v: TUDBView;
    pCaption: TFPanel;
    lbCaption: TLabel;
    N2: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    procedure Nouregistre1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminarregistre1Click(Sender: TObject);
    procedure vInsert(Sender: TObject);
    procedure vReturn(Sender: TObject);
    procedure vDelete(Sender: TObject);
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MostraMenu;
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
  private
  public
  end;

var
  _linies: T_linies;

implementation

uses dmsrc, main, elinies, global;

{$R *.DFM}

procedure T_linies.Nouregistre1Click(Sender: TObject);
begin
     vInsert(sender);
end;

procedure T_linies.Modificar1Click(Sender: TObject);
begin
     vReturn(sender);
end;

procedure T_linies.Eliminarregistre1Click(Sender: TObject);
begin
     vDelete(sender);
end;

procedure T_linies.vInsert(Sender: TObject);
begin
     T_elinies.Create(Application).Nou;
end;

procedure T_linies.vReturn(Sender: TObject);
begin
     T_elinies.Create(Application).Modificar;
end;

procedure T_linies.vDelete(Sender: TObject);
begin
     T_elinies.Create(Application).Eliminar;
end;

procedure T_linies.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_linies.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_linies.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_linies.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_linies.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tAltres.SelectNoReact;     
     _main.tLinies.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;     
end;

procedure T_linies.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_linies.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_linies.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
