unit marques;

interface

uses Windows, Menus, Controls, Forms, DB, Graphics, StdCtrls, ExtCtrls, FPanel, Classes, UDBView, EstilColor;

type
  T_marques = class(TForm)
    PopupMenu1: TPopupMenu;
    Novamarca: TMenuItem;
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
    AplicarfilteracolumnaF81: TMenuItem;
    procedure Novamarca1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminarregistre1Click(Sender: TObject);
    procedure vReturn(Sender: TObject);
    procedure vDelete(Sender: TObject);
    procedure vInsert(Sender: TObject);
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
     procedure MostraMenu;
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure AplicarfilteracolumnaF81Click(Sender: TObject);
    private
  public
  end;

var
  _marques: T_marques;

implementation

uses emarques, dmsrc, main, global;

{$R *.DFM}

procedure T_marques.Novamarca1Click(Sender: TObject);
begin
     vInsert(sender);
end;

procedure T_marques.Modificar1Click(Sender: TObject);
begin
     vReturn(sender);
end;

procedure T_marques.Eliminarregistre1Click(Sender: TObject);
begin
     vDelete(sender);
end;

procedure T_marques.vReturn(Sender: TObject);
begin
     T_emarques.Create(self).Modificar;
end;

procedure T_marques.vDelete(Sender: TObject);
begin
     T_emarques.Create(self).Eliminar;
end;

procedure T_marques.vInsert(Sender: TObject);
begin
     T_emarques.Create(self).Nou;
end;

procedure T_marques.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_marques.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_marques.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_marques.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_marques.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tAltres.SelectNoReact;     
     _main.tMarques.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;
end;

procedure T_marques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_marques.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_marques.AplicarfilteracolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
