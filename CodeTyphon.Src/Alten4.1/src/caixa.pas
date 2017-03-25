unit caixa;

interface

uses Windows, Menus, UDBView, Forms, DB, Graphics, estilcolor, StdCtrls, Controls, ExtCtrls, FPanel, Classes, Dialogs, sysutils;

type
  T_caixa = class(TForm)
    Splitter1: TSplitter;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    N2: TMenuItem;
    Anara1: TMenuItem;
    VentesRelacionades1: TMenuItem;
    pCaption: TFPanel;
    lbCaption: TLabel;
    v: TUDBView;
    vC: TUDBView;
    Tancartorn1: TMenuItem;
    Reobrirtorn1: TMenuItem;
    Entradaacaixa1: TMenuItem;
    Resumdetorn1: TMenuItem;
    Filtrespredefinits1: TMenuItem;
    Entradesdirectes1: TMenuItem;
    Abonaments1: TMenuItem;
    Entradesdirectestornactiu1: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    N3: TMenuItem;
    Obrircaixa1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    Tornobert2: TMenuItem;
    Abonamentstornactiu1: TMenuItem;
    Obrirnoutorn1: TMenuItem;
    Comentari1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure MostraMenu;
    procedure vCDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Entradaacaixa1Click(Sender: TObject);
    procedure Tancartorn1Click(Sender: TObject);
    procedure Reobrirtorn1Click(Sender: TObject);
    procedure Resumdetorn1Click(Sender: TObject);
    procedure VentesRelacionades1Click(Sender: TObject);
    procedure Entradesdirectes1Click(Sender: TObject);
    procedure Entradesdirectestornactiu1Click(Sender: TObject);
    procedure Abonaments1Click(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    procedure Obrircaixa1Click(Sender: TObject);
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure Tornobert2Click(Sender: TObject);
    procedure Abonamentstornactiu1Click(Sender: TObject);
    procedure Obrirnoutorn1Click(Sender: TObject);
    procedure Comentari1Click(Sender: TObject);
  private
     procedure IAfterScroll(Dataset : TDataset);
  public
     function ObrirNouTorn : boolean;
  end;

var
  _caixa: T_caixa;

implementation

{$R *.DFM}

uses dmsrc, main, global, gulib, etorns, tanctorn, ecaixa, resmtrn, ventesA, ventesB;

procedure T_caixa.IAfterScroll(dataset : TDataset);
begin
     if v.Data.Dataset.RecordCount > 0
     then vC.Data.Filter := ' where id_torn = ' + v.FieldByName('id').AsString
     else vC.Data.Filter := '';
end;

procedure T_caixa.FormCreate(Sender: TObject);
begin
     v.Data.Dataset.AfterScroll := IAfterScroll;
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_caixa.MostraMenu;
begin
     PopupMenu.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_caixa.vCDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
begin
     if not FS then
     if vC.FieldByName('COBRAT').AsFloat < 0 then
     begin
          C.Brush.Color := C_ABONAMENT;
          C.Font.Color := NegLumColor(C_ABONAMENT);
     end;
end;

procedure T_caixa.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paCaixa);
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_caixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_caixa.Entradaacaixa1Click(Sender: TObject);
begin
     T_ecaixa.Create(self).EntradaDirecta;
end;

procedure T_caixa.Tancartorn1Click(Sender: TObject);
begin
     _main.tTancTorn.React;
end;

procedure T_caixa.Reobrirtorn1Click(Sender: TObject);
begin
     _main.tReobrirTorn.React;
end;

procedure T_caixa.Resumdetorn1Click(Sender: TObject);
begin
     T_resmtrn.Create(self).ResumTorn;
end;

procedure T_caixa.VentesRelacionades1Click(Sender: TObject);
begin
     if vC.FieldByName('linea_fact').AsString = 'A' then
     begin
          _ventesA.v.Data.Filter := 'where id = ' + vC.FieldByName('venta').AsString;
          _ventesA.v.Caption.Variable := vC.FieldByName('venta').AsString;

          _main.PosaAPrevies(self);
          _main.tVentesA.React;
     end
     else
     if vC.FieldByName('linea_fact').AsString = 'B' then
     begin
          _ventesB.v.Data.Filter := 'where id = ' + vC.FieldByName('venta').AsString;
          _ventesB.v.Caption.Variable := vC.FieldByName('venta').AsString;


          _main.PosaAPrevies(self);
          _main.tVentesB.React;
     end
     else
     mDlg('Aquest concepte de caixa és d''una entrada directa',mtInformation,[mbOk]);
end;

procedure T_caixa.Entradesdirectes1Click(Sender: TObject);
begin
     vC.Data.Filter := 'where linea_fact = ''d''';
     vC.Caption.Variable := 'entrades directes (tots els torns)';
end;

procedure T_caixa.Entradesdirectestornactiu1Click(Sender: TObject);
begin
     vC.Data.Filter := 'where (linea_fact = ''d'') and (id_torn = ' + inttostr(tornobert) + ')';
     vC.Caption.Variable := 'entrades directes (torn actiu)';
end;

procedure T_caixa.Abonaments1Click(Sender: TObject);
begin
     vC.Data.Filter := 'where cobrat <= 0';
     vC.Caption.Variable := 'abonaments (tots els torns)';
end;

procedure T_caixa.Abonamentstornactiu1Click(Sender: TObject);
begin
     vC.Data.Filter := 'where (cobrat <= 0) and (id_torn = ' + inttostr(tornobert) + ')';
     vC.Caption.Variable := 'abonaments (torn actiu)';
end;

procedure T_caixa.PopupMenuPopup(Sender: TObject);
begin
     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;
     Obrirnoutorn1.Enabled := TornObert >= 0;
end;

procedure T_caixa.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_caixa.Aplicarfiltre1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).CallFilter;
end;

procedure T_caixa.Eliminarfiltre1Click(Sender: TObject);
begin
     (PopupMenu.PopupComponent as TUDBView).ClearFilter;
end;

procedure T_caixa.Obrircaixa1Click(Sender: TObject);
begin
     Enviar_seq_obertura(dm.CR['SEQ_OPERTURA']);
end;

procedure T_caixa.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] = 'NO' then exit;

     cl := clNone;
     if not v.FieldByName('tancat').Asboolean then cl := C_TORN_OBERT;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_caixa.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     (popupmenu.PopupComponent as TUDBView).CallColumnFilter;
end;

procedure T_caixa.Tornobert2Click(Sender: TObject);
begin
      v.Data.Filter := 'where TANCAT = false';
      v.Caption.Variable := 'Torn obert';
end;

function T_caixa.ObrirNouTorn : boolean;
var
     d : TDateTime;
begin
     result := true;

     if TornObert < 0 then
     case TornObert of
     -1 : if mDlg('No hi ha cap torn de caixa obert. Obrir torn?',
          mtInformation,[mbYes,mbNo]) = mrYes then
          T_etorns.Create(Application).ObrirTorn;
     -2 : begin
               mDlg('S''ha trobat més d''un torn obert de caixa. Es recomana '+
               'consultar la llista de caixa i tancar els que no s''hagin d''utilitzar. '+
               'No es podrà efectuar cap venta fins que es solucioni el conflicte de torns oberts',
               mtWarning,[mbOk]);
               exit;
          end;
     end;

     if TornObert > -1 then
     begin
          d := strtodatetime(Torn(inttostr(TornObert),'obertura'));

          if Round(d) <> Round(now) then
          case mDlg('El torn obert actual té una data d''obertura ('+
          datetostr(d) +') diferent de la data actual ('+datetostr(date)+'). Es '+
          'recomana obrir un torn per dia, tot i que no es forçosament necesari. '+
          'Mantenir el torn obert?',['&Sí','&No','S&ortir']) of
          mrYes : ;
          mrNo  : begin _caixa.v.Locate('id',TornObert,[]); TancarTorn; end;
          mrCancel : result := false;
          end;
     end;

     if TornObert < 0 then
     begin
          mDlg('No es podrà cobrar cap venta ni efectuar cap abonament fins que no '+
          's''obri un torn de caixa.',mtWarning,[mbOk]);
     end;
end;

procedure T_caixa.Obrirnoutorn1Click(Sender: TObject);
begin
     if TornObert >= 0
     then mDlg('Està el torn ' + inttostr(TornObert) + ' obert.',mtInformation,[mbOk])
     else ObrirNouTorn;
end;

procedure T_caixa.Comentari1Click(Sender: TObject);
var
     s : string;
begin
     if vC.Data.Dataset.RecordCount = 0 then
     begin
          mDlg('No hi han registres de caixa a comentar',mtError,[mbOk]);
          exit;
     end;

     s := vC.FieldByName('comentari').AsString;
     s := TextIn('Comentari',s,ecNormal,500);

     vC.Data.Dataset.Edit;
     vC.Data.Dataset.FieldValues['comentari'] := s;
     vC.Data.Dataset.Post;
end;

end.
