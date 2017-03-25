unit poblacions;

interface

uses Windows, Estilcolor, Menus, Controls, Forms, DB, Graphics, StdCtrls, ExtCtrls, FPanel, Classes, UDBView;

type
  T_poblacions = class(TForm)
     PopupMenu1: TPopupMenu;
     Nouarticle1: TMenuItem;
     Modificar1: TMenuItem;
     Eliminararticle1: TMenuItem;
     N1: TMenuItem;
     Aplicarfiltre1: TMenuItem;
     Eliminarfiltre1: TMenuItem;
     v: TUDBView;
    pCaption: TFPanel;
    lbCaption: TLabel;
    AplicarfiltreacolumnaF81: TMenuItem;
     procedure Novapoblacio1Click(Sender: TObject);
     procedure Modificar1Click(Sender: TObject);
     procedure Eliminarregistre1Click(Sender: TObject);
     procedure Aplicarfiltre1Click(Sender: TObject);
     procedure Eliminarfiltre1Click(Sender: TObject);
     procedure vDelete(Sender: TObject);
     procedure vInsert(Sender: TObject);
     procedure vReturn(Sender: TObject);
     procedure FormCreate(Sender: TObject);
     procedure MostraMenu;
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
  private
  public
  end;

var
  _poblacions: T_poblacions;

implementation

uses main, epoblacions, dmsrc, global;

{$R *.dfm}

procedure T_poblacions.NovaPoblacio1Click(Sender: TObject);
begin
     vInsert(sender);
end;

procedure T_poblacions.Modificar1Click(Sender: TObject);
begin
     vReturn(sender);
end;

procedure T_poblacions.Eliminarregistre1Click(Sender: TObject);
begin
     vDelete(sender);
end;

procedure T_poblacions.vDelete(Sender: TObject);
begin
     T_epoblacions.Create(self).Eliminar;
end;

procedure T_poblacions.vInsert(Sender: TObject);
begin
     T_epoblacions.Create(self).Nou;
end;

procedure T_poblacions.vReturn(Sender: TObject);
begin
     T_epoblacions.Create(self).Modificar;
end;

procedure T_poblacions.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_poblacions.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_poblacions.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_poblacions.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_poblacions.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paAltres);
     _main.tAltres.SelectNoReact;     
     _main.tPoblacions.SelectNoReact;
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_poblacions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_poblacions.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

end.
