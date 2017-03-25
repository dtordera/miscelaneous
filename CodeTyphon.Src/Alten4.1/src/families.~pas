unit families;

interface

uses Windows, Menus, Controls, Forms, StdCtrls, ExtCtrls, FPanel, Classes, UDBView, DB, Graphics, Estilcolor;

type
  T_families = class(TForm)
    PopupMenu1: TPopupMenu;
    Novafamilia1: TMenuItem;
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
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminarregistre1Click(Sender: TObject);
    procedure Nouregistre1Click(Sender: TObject);
    procedure vInsert(Sender: TObject);
    procedure vDelete(Sender: TObject);
    procedure vReturn(Sender: TObject);
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
  _families: T_families;

implementation

uses dmsrc, main, efamilies, global;

{$R *.DFM}

procedure T_families.Modificar1Click(Sender: TObject);
begin
     vReturn(sender);
end;

procedure T_families.Eliminarregistre1Click(Sender: TObject);
begin
     vDelete(sender);
end;

procedure T_families.Nouregistre1Click(Sender: TObject);
begin
     vInsert(sender);
end;

procedure T_families.vInsert(Sender: TObject);
begin
     T_efamilies.Create(self).Nou;
end;

procedure T_families.vDelete(Sender: TObject);
begin
     T_efamilies.Create(self).Eliminar;
end;

procedure T_families.vReturn(Sender: TObject);
begin
     T_efamilies.Create(self).Modificar;
end;

procedure T_families.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_families.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_families.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_families.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_families.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tFamilies.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_families.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_families.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_families.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
