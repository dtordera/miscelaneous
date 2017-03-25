unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  Menus, StdCtrls, Gradient, udbview, HelpInfo,
  Buttons, UText, FPanel, ComCtrls, CColor, BringToFront,
  UProcessos, estilcolor, DB, ADODB, tickprn, UDBVAux, shellapi;

type TOrdreLlistes = (olCap,olFiles,olColumnes,olMosaic,olMaximitzar);

type T_main = class(TForm)
     MainMenu1: TMainMenu;
     General1: TMenuItem;
     fonsordres: TFPanel;
     Sortir1: TMenuItem;
     N1: TMenuItem;
     Configuraci1: TMenuItem;
    paCaixa: TFPanel;
    tEntradaaCaixa: TUText;
    paAveries: TFPanel;
    tnAveries: TUText;
    tmAveries: TUText;
    tdAveries: TUText;
    tFacturarAveria: TUText;
    papressupostos: TFPanel;
    tnpressupostos: TUText;
    tmpressupostos: TUText;
    tdpressupostos: TUText;
    tFacturarPres: TUText;
    paArticles: TFPanel;
    tnArticles: TUText;
    tmarticles: TUText;
    tdarticles: TUText;
    paMagatzem: TFPanel;
    tSegMag: TUText;
    tEntrDirectaUts: TUText;
    paPersonals: TFPanel;
    tnPersonals: TUText;
    tmPersonals: TUText;
    tdPersonals: TUText;
    paTapa: TFPanel;
    tvAveries: TUText;
    tRepPendents: TUText;
    tRepDomicili: TUText;
    tvpressupostos: TUText;
    tResumTorn: TUText;
    tReobrirTorn: TUText;
    paVentesA: TFPanel;
    tnventesA: TUText;
    taventesA: TUText;
    tCobrarVenta: TUText;
    tvventesA: TUText;
    tVentesPagades: TUText;
    tVentesAmbPendent: TUText;
    tmVentesA: TUText;
    tdVentesA: TUText;
    Veure1: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    tTancTorn: TUText;
    tMargeDefecte: TUText;
    tMargeMarca: TUText;
    tMargeNoValid: TUText;
    tObsolets: TUText;
    tEntradaDirecta: TUText;
    paOrdenarLlistes: TFPanel;
    lbColumnes: TUText;
    lbFiles: TUText;
    lbMaximitzar: TUText;
    lbMosaic: TUText;
    lbMinimitzar: TUText;
    lbTancar: TUText;
    Eliminar________: TBringToFront;
    tRepetits: TUText;
    tMesDe2Anys: TUText;
    tRepetits1: TUText;
    N32: TMenuItem;
    N2: TMenuItem;
    Processos: TMenuItem;
    paAltres: TFPanel;
    tMarques: TUText;
    tFamilies: TUText;
    tLinies: TUText;
    tPoblacions: TUText;
    Llistes: TFPanel;
    tAltres: TUText;
    tEntrades: TUText;
    tMagatzem: TUText;
    tCaixa: TUText;
    tVentesB: TUText;
    tVentesA: TUText;
    tAveries: TUText;
    tpressupostos: TUText;
    tPersonals: TUText;
    tArticles: TUText;
    tActualitzarDeuteACompe: TUText;
    paEntrades: TFPanel;
    tnEntrades: TUText;
    tMarcarpagada: TUText;
    tmEntrades: TUText;
    tdEntrades: TUText;
    tRealitzat: TUText;
    fonsmain: TGradient;
    ftoppanel: TFPanel;
    utAltres: TUText;
    utEntrades: TUText;
    utMagatzem: TUText;
    utCaixa: TUText;
    utVentesB: TUText;
    utVentesA: TUText;
    utAveries: TUText;
    utpressupostos: TUText;
    utPersonals: TUText;
    utArticles: TUText;
    UText29: TUText;
    N3: TMenuItem;
    Alternartipusdepanells1: TMenuItem;
    Ordredellistes1: TMenuItem;
    enfiles1: TMenuItem;
    encolumnes1: TMenuItem;
    mosaic1: TMenuItem;
    maximitzartotes1: TMenuItem;
    minimitzartotes1: TMenuItem;
    tancar1: TMenuItem;
    Llegendadellista1: TMenuItem;
    veurebotonsrpids1: TMenuItem;
    N5: TMenuItem;
    Ordresrpides1: TMenuItem;
    Novaventa1: TMenuItem;
    Entradaacaixa1: TMenuItem;
    Obrircaixa1: TMenuItem;
    Noupressupost1: TMenuItem;
    Novaaveries1: TMenuItem;
    N6: TMenuItem;
    PopupAltres: TPopupMenu;
    Poblacions1: TMenuItem;
    Marques1: TMenuItem;
    Lnies1: TMenuItem;
    Famlies1: TMenuItem;
    Pantallacomplerta1: TMenuItem;
    tImprTicket: TUText;
    tAbonaments: TUText;
    tcventesA: TUText;
    tcventesB: TUText;
    tcpressupostos: TUText;
    tcAveries: TUText;
    Altres1: TMenuItem;
    ExportarllistaaXLS1: TMenuItem;
    tcVentesRelacionades: TUText;
    tcAveriesRelacionades: TUText;
    tcMagatzemRelacionat: TUText;
    tcEntradesRelacionades: TUText;
    tFusionarRegistres: TGUText;
    PopupMenu1: TPopupMenu;
    RestaurarAlten41: TMenuItem;
    tTornObert: TUText;
    paVentesB: TFPanel;
    tnVentesB: TUText;
    tAbonarVentaB: TUText;
    tCobrarVentaB: TUText;
    tvVentesB: TUText;
    UText6: TUText;
    UText7: TUText;
    tmVentesB: TUText;
    tdVentesB: TUText;
    tImprTicketB: TUText;
    UText14: TUText;
    tcpressupostosRelacionat: TUText;
    tTitolArticles: TSimpleUText;
    tTitolPersonals: TSimpleUText;
    tTitolAveries: TSimpleUText;
    tTitolpressupostos: TSimpleUText;
    tTitolVentesA: TSimpleUText;
    tTitolVentesB: TSimpleUText;
    tTitolCaixa: TSimpleUText;
    tTitolMagatzem: TSimpleUText;
    tTitolEntrades: TSimpleUText;
    tTitolAltres: TSimpleUText;
    N8: TMenuItem;
    Nou1: TMenuItem;
    Modificar1: TMenuItem;
    Eliminar1: TMenuItem;
    tcEntrades: TUText;
    tpersVentesARelacionades: TUText;
    tpersVentesBRelacionades: TUText;
    tpersAveriesRelacionades: TUText;
    tpersPresupRelacionats: TUText;
    tpersEntradesRelacionades: TUText;
    tAveriesClientRelacionat: TUText;
    tAveReparadorRelacionat: TUText;
    tAveVentaRelacionada: TUText;
    tClientRelacionatPres: TUText;
    tFacturarelacionadaPres: TUText;
    tpressupostosRealitzats: TUText;
    tClientRelacionatVentesA: TUText;
    tAveriaRelacionada: TUText;
    tpressupostRelacionat: TUText;
    tReferenciesACaixa: TUText;
    tVentesAbonades: TUText;
    tRepExternes: TUText;
    tRepEnviades: TUText;
    tVentesrelacionada: TUText;
    tEntradesDirectesTotes: TUText;
    tEntradesDirectesTorn: TUText;
    tAbonamentscaixa: TUText;
    Tornarllistaprvia1: TMenuItem;
    N10: TMenuItem;
    tArticleRelacionat: TUText;
    UText1: TUText;
    tEntradesRelacionadesMag: TUText;
    UText3: TUText;
    tProveedorRelacionat: TUText;
    tEntradesNormalit: TUText;
    Conceptesdentrades1: TMenuItem;
    Conceptesdaveries1: TMenuItem;
    Conceptesdepressupostos1: TMenuItem;
    ConceptesdeventesA1: TMenuItem;
    ConceptesdeventesB1: TMenuItem;
    tObrirCaixa: TUText;
    Sumes1: TMenuItem;
    Sumaderegistresvisibles1: TMenuItem;
    Sumadeventessegonsclients1: TMenuItem;
    Contarnderegistres1: TMenuItem;
    Veureinforme1: TMenuItem;
    Sumadeventessegonslniadarticle1: TMenuItem;
    tEntrarCodiBarres: TUText;
    tAmbDeute: TUText;
    tTornObertFiltre: TUText;
    tPagades: TUText;
    UText2: TUText;
    UText4: TUText;
    procedure Sortir1Click(Sender: TObject);
    procedure Configuraci1Click(Sender: TObject);
    procedure lbColumnesReact(Sender: TObject);
    procedure lbFilesReact(Sender: TObject);
    procedure lbMinimitzarReact(Sender: TObject);
    procedure lbTancarReact(Sender: TObject);
    procedure lbMosaicReact(Sender: TObject);
    procedure NouRegistreReact(sender : TObject);
    procedure ModificarRegistreReact(sender : TObject);
    procedure EliminarRegistreReact(sender : TObject);
    procedure lbMaximitzarReact(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure tvventesAReact(Sender: TObject);
    procedure lbpEntradesReact(Sender: TObject);
    procedure tTancTornReact(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function  ComprobaTornObert : boolean;
    procedure PosaCaption;
    procedure tResumTornReact(Sender: TObject);
    procedure tMargeDefecteReact(Sender: TObject);
    procedure tMargeMarcaReact(Sender: TObject);
    procedure tMargeNoValidReact(Sender: TObject);
    procedure tObsoletsReact(Sender: TObject);
    procedure tEntradaDirectaReact(Sender: TObject);
    procedure fonsmainResize(Sender: TObject);
    procedure tRepetitsReact(Sender: TObject);
    procedure tFusionarRegistresReact(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tMesDe2AnysReact(Sender: TObject);
    procedure tRepetits1React(Sender: TObject);
    procedure ProcessosClick(Sender: TObject);
    procedure tActualitzarDeuteACompeReact(Sender: TObject);
    procedure tCobrarVentaReact(Sender: TObject);
    procedure taventesAReact(Sender: TObject);
    procedure tMarcarpagadaReact(Sender: TObject);
    procedure enfiles1Click(Sender: TObject);
    procedure encolumnes1Click(Sender: TObject);
    procedure mosaic1Click(Sender: TObject);
    procedure maximitzartotes1Click(Sender: TObject);
    procedure minimitzartotes1Click(Sender: TObject);
    procedure tancar1Click(Sender: TObject);
    procedure Llegendadellista1Click(Sender: TObject);
    procedure Alternartipusdepanells1Click(Sender: TObject);
    procedure veurebotonsrpids1Click(Sender: TObject);
    procedure Obrircaixa1Click(Sender: TObject);
    procedure Entradaacaixa1Click(Sender: TObject);
    procedure utAltresReact(Sender: TObject);
    procedure tvpressupostosReact(Sender: TObject);
    procedure tvAveriesReact(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Pantallacomplerta1Click(Sender: TObject);
    procedure tImprTicketReact(Sender: TObject);
    procedure tcventesAReact(Sender: TObject);
    procedure tcpressupostosReact(Sender: TObject);
    procedure tcAveriesReact(Sender: TObject);
    procedure tcventesBReact(Sender: TObject);
    procedure tFacturarPresReact(Sender: TObject);
    procedure tRealitzatReact(Sender: TObject);
    procedure tFacturarAveriaReact(Sender: TObject);
    procedure ExportarllistaaXLS1Click(Sender: TObject);
    procedure ShowLlistes(Sender: TObject);
    procedure tAltresReact(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure Novaventa1Click(Sender: TObject);
    procedure Noupressupost1Click(Sender: TObject);
    procedure Novaaveries1Click(Sender: TObject);
    procedure TopTextReact(Sender: TObject);
    procedure RestaurarAlten41Click(Sender: TObject);
    procedure tEntradaaCaixaReact(Sender: TObject);
    procedure tReobrirTornReact(Sender: TObject);
    procedure tTornObertReact(Sender: TObject);
    procedure tSegMagReact(Sender: TObject);
    procedure tEntrDirectaUtsReact(Sender: TObject);
    procedure tvVentesBReact(Sender: TObject);
    procedure tImprTicketBReact(Sender: TObject);
    procedure tAbonarVentaBReact(Sender: TObject);
    procedure tCobrarVentaBReact(Sender: TObject);
    procedure Nou1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminar1Click(Sender: TObject);
    procedure tcAveriesRelacionadesReact(Sender: TObject);
    procedure tcpressupostosRelacionatReact(Sender: TObject);
    procedure tcVentesRelacionadesReact(Sender: TObject);
    procedure tcEntradesRelacionadesReact(Sender: TObject);
    procedure tcMagatzemRelacionatReact(Sender: TObject);
    procedure tpersAveriesRelacionadesReact(Sender: TObject);
    procedure tpersPresupRelacionatsReact(Sender: TObject);
    procedure tpersVentesARelacionadesReact(Sender: TObject);
    procedure tpersVentesBRelacionadesReact(Sender: TObject);
    procedure tpersEntradesRelacionadesReact(Sender: TObject);
    procedure tAveriesClientRelacionatReact(Sender: TObject);
    procedure tAveReparadorRelacionatReact(Sender: TObject);
    procedure tAveVentaRelacionadaReact(Sender: TObject);
    procedure tRepPendentsReact(Sender: TObject);
    procedure tFacturarelacionadaPresReact(Sender: TObject);
    procedure tClientRelacionatPresReact(Sender: TObject);
    procedure tClientRelacionatVentesAReact(Sender: TObject);
    procedure tAveriaRelacionadaReact(Sender: TObject);
    procedure tpressupostRelacionatReact(Sender: TObject);
    procedure tReferenciesACaixaReact(Sender: TObject);
    procedure tVentesPagadesReact(Sender: TObject);
    procedure tVentesAmbPendentReact(Sender: TObject);
    procedure tVentesAbonadesReact(Sender: TObject);
    procedure tAbonamentsReact(Sender: TObject);
    procedure tRepDomiciliReact(Sender: TObject);
    procedure tRepExternesReact(Sender: TObject);
    procedure tRepEnviadesReact(Sender: TObject);
    procedure tpressupostosRealitzatsReact(Sender: TObject);
    procedure tVentesrelacionadaReact(Sender: TObject);
    procedure tEntradesDirectesTotesReact(Sender: TObject);
    procedure tEntradesDirectesTornReact(Sender: TObject);
    procedure tAbonamentscaixaReact(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure tArticleRelacionatReact(Sender: TObject);
    procedure UText1React(Sender: TObject);
    procedure tEntradesRelacionadesMagReact(Sender: TObject);
    procedure UText3React(Sender: TObject);
    procedure tProveedorRelacionatReact(Sender: TObject);
    procedure tEntradesNormalitReact(Sender: TObject);
    procedure Poblacions1Click(Sender: TObject);
    procedure Marques1Click(Sender: TObject);
    procedure Lnies1Click(Sender: TObject);
    procedure Famlies1Click(Sender: TObject);
    procedure Conceptesdaveries1Click(Sender: TObject);
    procedure Conceptesdepressupostos1Click(Sender: TObject);
    procedure ConceptesdeventesA1Click(Sender: TObject);
    procedure ConceptesdeventesB1Click(Sender: TObject);
    procedure Conceptesdentrades1Click(Sender: TObject);
    procedure tObrirCaixaReact(Sender: TObject);
    procedure Sumaderegistresvisibles1Click(Sender: TObject);
    procedure Sumadeventessegonsclients1Click(Sender: TObject);
    procedure Contarnderegistres1Click(Sender: TObject);
    procedure Veureinforme1Click(Sender: TObject);
    procedure Sumadeventessegonslniadarticle1Click(Sender: TObject);
    procedure tEntrarCodiBarresReact(Sender: TObject);
    procedure tTornObertFiltreReact(Sender: TObject);
    procedure tPagadesReact(Sender: TObject);
    procedure UText2React(Sender: TObject);
    procedure UText4React(Sender: TObject);
  private
          bpcWidth,
          bpcHeight,
          bpcLeft,
          bpcTop : integer;
          VCaptionProcess : string;
          IconData : TNotifyIconData;                   // trayicon
          procedure WMSysCommand(var Msg : TWMSysCommand); message WM_SYSCOMMAND; // per agafar misatges
          procedure Espabila(var Msg : TMessage); message WM_USER + 1; // per restaurar
  protected
          procedure SetVCaptionProcess(s : string);
  public
          ALlistaPrevia : array of TCustomForm;
          FirstTimeActivate : boolean;
          OrdreLlistes : TOrdreLlistes;
          IdxLlista : integer;
          ALlistes  : array of TCustomForm;
          procedure NMSEnabled;
          procedure NMSNoEnabled;
          procedure IEnabled;
          procedure INoEnabled;
          procedure PosaAPrevies(f : TCustomForm);
          procedure PosaColorsTitols;
          procedure PosaConstraintHeight;
          procedure TancaLlista(sender : TObject);
          function  ALlistesIdx(f : TCustomForm) : integer;
          procedure AfterConstruction; override;
          procedure PosaPanelDavant_(p : TFPanel);
          procedure PosaPanels;
          procedure EndrezaLlistes(f : TCustomForm);
          procedure OnDelete(sender : TObject);
          procedure OnReturn(sender : TObject);
          procedure OnInsert(sender : TObject);
          procedure OnDBGridKey(sender : TObject; c : char );
          property  CaptionProcess : string read VCaptionProcess write SetVCaptionProcess;
end;

var
  _main: T_main;

implementation

uses global, dmsrc, config, articles, marques, families, linies,
     personals, averies, pressupostos, ventesA, caixa, math, earticles,
     lectura, ePersonals, eaveries, epressupostos, eventesA, ecaixa, entrades,
     eentrades, magatzem, printers, tanctorn, etorns, resmtrn, llegcol, ventesB,
     processos, mainaux, fastbut, llistcfg,reports,cventesA, cpressupostos,
     caveries, cventesB, centrades;

{$R *.DFM}

procedure T_main.RestaurarAlten41Click(Sender: TObject);
begin
     _main.Show;

     ShowWindow(Application.Handle, SW_HIDE);
     Shell_NotifyIcon(NIM_DELETE, @IconData);      {Y nos cargamos el icono de la system tray}
     IconData.Wnd := 0;
end;

procedure T_main.Espabila(var Msg : TMessage); {Aqui se recibe la pulsacion sobre el icono}
var
     p : TPoint;
begin
     if Msg.lParam = WM_RBUTTONDOWN then
     begin
          SetForegroundWindow(Handle);
          GetCursorPos(p);
          PopupMenu1.Popup(p.x, p.y);
          PostMessage(Handle, WM_NULL, 0, 0);
     end
     else
     if Msg.LParam = WM_LBUTTONDBLCLK then
     begin
          SetForegroundWindow(Handle);
          RestaurarAlten41Click(nil);
          PostMessage(Handle, WM_NULL, 0, 0);
     end;
end;

procedure T_main.WMSysCommand(var Msg : TWMSysCommand);
begin
     if (Msg.CmdType = SC_MINIMIZE) then
     begin
          with IconData do
          begin
               cbSize := sizeof(IconData);
               Wnd := Handle;
               uID := 100;
               uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
               uCallbackMessage := WM_USER + 1;

               hIcon := Application.Icon.Handle;
 //             Usamos de icono el mismo de la aplicacion
 //             Como Hint del icono, el nombre de la aplicacion
               StrPCopy(szTip, Application.Title);
          end;
          //          Ponemos el icono al lado del reloj
          Shell_NotifyIcon(NIM_ADD, @IconData);
          //          Ocultamos la Form...
          Hide;
     end
     else
     if (msg.CmdType = SC_RESTORE) then
     begin
          DefaultHandler(Msg);
     end
     else DefaultHandler(Msg);

end;

procedure T_main.EndrezaLlistes(f : TCustomForm);
begin
     PosaOrdreLlistes(OrdreLlistes,f);
end;

procedure T_main.Sortir1Click(Sender: TObject);
begin
     close;
end;

procedure T_main.Configuraci1Click(Sender: TObject);
begin
     T_config.Create(Application).ShowModal;
end;

procedure T_main.lbFilesReact(Sender: TObject);
begin
     PosaOrdreLlistes(olFiles);
end;

procedure T_main.PosaPanels;
var
     b : boolean;
const
     W : array [boolean] of integer = (0,200);
     T : array [boolean] of integer = (16,0);
begin
     b := dm.CR['PANELL_ORDRES'] = 'SI';

     fonsordres.Width := W[b];
     ftoppanel.Visible := not b;

     ftoppanel.TabOrder := T[not b];
     fonsordres.TabOrder := T[b];
end;

procedure T_main.OnDBGridKey(sender : TObject; c : char );
begin
    (FindComponent('t'+c+(sender as TUDBView).Data.Table)
    as TUText).React;
end;

procedure T_main.OnDelete(Sender : TObject);
begin
     OnDBGridKey(sender, 'd');
end;

procedure T_main.OnReturn(Sender : TObject);
begin
     OnDBGridKey(sender,'m');
end;

procedure T_main.OnInsert(Sender : TObject);
begin
     OnDBGridKey(sender,'n');
end;

procedure T_main.lbTancarReact(Sender: TObject);
begin
     TancarTotesLesLlistes;
end;

procedure T_main.lbMosaicReact(Sender: TObject);
begin
     PosaOrdreLlistes(olMosaic);
end;

procedure T_main.lbMinimitzarReact(Sender: TObject);
begin
     MinimitzaLlistes;
end;

procedure T_main.lbColumnesReact(Sender: TObject);
begin
     PosaOrdreLlistes(olColumnes);
end;

procedure T_main.NouRegistreReact(sender : TObject);
begin
     CreaIExecuta('T_e'+((sender as Tcontrol).Parent as TFPanel).caption,'.Nou');
end;

procedure T_main.ModificarRegistreReact(sender : TObject);
begin
     CreaIExecuta('T_e'+((sender as TControl).Parent as TFPanel).Caption,'.Modificar');
end;

procedure T_main.EliminarRegistreReact(sender : TObject);
begin
     CreaIExecuta('T_e'+((sender as TControl).Parent as TFPanel).Caption,'.Eliminar');
end;

procedure T_main.lbMaximitzarReact(Sender: TObject);
begin
     PosaOrdreLlistes(olMaximitzar);
end;

procedure T_main.N41Click(Sender: TObject);
begin
     paOrdenarLlistes.ActiveControl.SetFocus;
end;

procedure T_main.N11Click(Sender: TObject);
begin
     if Llistes.Width <> 0
     then Llistes.ActiveControl.SetFocus
     else ftoppanel.ActiveControl.SetFocus;
end;

procedure T_main.tvventesAReact(Sender: TObject);
begin
     _ventesA.Veurefactura1Click(nil);
end;

procedure T_main.lbpEntradesReact(Sender: TObject);
var
     s : string;
begin
     with _entrades.v.Data.DataSet do
     begin
          if not FieldByName('PAGADA').AsBoolean then
          s := 'Marcar ''PAGADA'' a entrada?'
          else
          s := 'Desmarcar ''PAGADA'' a entrada ?';

          case mDlg(s,mtInformation,[mbYes,mbNo]) of
          mrYes :
          begin
               Edit;
               FieldValues['PAGADA'] := not FieldValues['PAGADA'];
               Post;
               Refresh;
          end;
          end;
     end;
end;

procedure T_main.tTancTornReact(Sender: TObject);
begin
     Tancartorn;
end;

function T_main.ComprobaTornObert : boolean;
begin
     result := _caixa.ObrirNouTorn;
end;

procedure T_main.PosaCaption;
begin
     Caption := 'Alten 4';
     if TornObert < 0 then Caption := Caption + ' - *CAIXA TANCADA*';
     if CaptionProcess <> ''  then Caption := Caption + ' - ' + CaptionProcess;
end;

procedure T_main.FormCreate(Sender: TObject);
const
     S : array [boolean] of string = ('NO','SI');
begin
     paTapa.BringToFront;

     dm.CR['PANELL_ORDRES'] := S[FileExists(BINDIR + 'STP\\pp.stp')];
     PosaPanels;

     _estilColor.Apply(self);
     fonsordres.Color := Llistes.Color;

     FirstTimeActivate := true;
     IdxLlista := -1;
end;

procedure T_main.AfterConstruction;
begin
     inherited;

     try    Width  := strtoint(dm.CR['WIDTH_MAIN']);
     except Width  := 850;
     end;

     try    Height := strtoint(dm.CR['HEIGHT_MAIN']);
     except Height := 700;
     end;

     try    Left   := strtoint(dm.CR['LEFT_MAIN']);
     except Left   := (Screen.Width - Width) div 2;
     end;

     try    Top    := strtoint(dm.CR['TOP_MAIN']);
     except Top    := (Screen.Height - Height) div 2;
     end;

     try    OrdreLlistes := TOrdreLlistes(strtoint(dm.CR['ORDRE_LLISTES']));
     except OrdreLlistes := olMaximitzar;
     end;

     bpcWidth  := Width;
     bpcHeight := Height;
     bpcTop    := Top;
     bpcLeft   := Left;

     DoubleBuffered := true;
end;

procedure T_main.PosaConstraintHeight;
var
     i,j : integer;
     mh : integer;
     t  : TCustomUText;
     nch : integer;
     p : TCustomPanel;
begin
     nch := Height - clientheight;
     mh := 0 ;
     p := nil;

     with fonsordres do
     for i := 0 to ControlCount - 1 do
     begin

          if Controls[i] = Llistes then continue;

          try p := Controls[i] as TCustomPanel;
          except continue;
          end;

          if Assigned(p) then
          for j := 0 to p.ControlCount - 1 do
          begin
               if not (p.Controls[j] is TCustomUText) then continue;
               t := p.Controls[j] as TCustomUText;

               if t.Height + t.Top > mh then mh := t.Height + t.Top;
          end;
     end;

     Constraints.MinHeight := nch + Llistes.Height + mh + paOrdenarLlistes.Height;
     Constraints.MinWidth  := Constraints.MinHeight;
end;

procedure T_main.PosaColorsTitols;
begin
     tTitolArticles.Color :=      _articles.v.Look.FixedRow;
     tTitolArticles.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolPersonals.Color :=      _articles.v.Look.FixedRow;
     tTitolPersonals.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolAveries.Color :=      _articles.v.Look.FixedRow;
     tTitolAveries.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolpressupostos.Color :=      _articles.v.Look.FixedRow;
     tTitolpressupostos.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolVentesA.Color :=      _articles.v.Look.FixedRow;
     tTitolVentesA.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolVentesB.Color :=      _articles.v.Look.FixedRow;
     tTitolVentesB.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolCaixa.Color :=      _articles.v.Look.FixedRow;
     tTitolCaixa.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolMagatzem.Color :=      _articles.v.Look.FixedRow;
     tTitolMagatzem.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolEntrades.Color :=      _articles.v.Look.FixedRow;
     tTitolEntrades.Font.Color := _articles.v.Look.FixedRowFont.Color;

     tTitolAltres.Color :=      _articles.v.Look.FixedRow;
     tTitolAltres.Font.Color := _articles.v.Look.FixedRowFont.Color;
end;

procedure T_main.FormActivate(Sender: TObject);
begin
     if FirstTimeActivate then
     begin
          CarregaOrdreColumnes;
          BuscaErrors;
          PreparaArrayLlistaPrevia;
          PosaColorsTitols;
          PosaConstraintHeight;
          PreparaArrayLlistes;
          PosaMargeALlistes;
          NMSNoEnabled;
          INoEnabled;
          if not ComprobaTornObert then Application.Terminate;
     end;
     PosaCaption;

     FirstTimeactivate := false;
end;

procedure T_main.tMargeDefecteReact(Sender: TObject);
begin
     _articles.MargeDefecte;
end;

procedure T_main.tMargeMarcaReact(Sender: TObject);
begin
     _articles.MargeMarca;
end;

procedure T_main.tMargeNoValidReact(Sender: TObject);
begin
     _articles.MargeInvalid;
end;

procedure T_main.tObsoletsReact(Sender: TObject);
begin
     _articles.Obsolets;
end;

procedure T_main.tEntradaDirectaReact(Sender: TObject);
begin
     _articles.EntradaDirecta;
end;

procedure T_main.fonsmainResize(Sender: TObject);
var
     sc : TSizeConstraints;
begin
     sc := TSizeConstraints.Create(nil);
     sc.MaxHeight := (sender as TCustomPanel).clientheight + _articles.Height - _articles.clientheight;
     sc.MaxWidth  := (sender as TCustomPanel).ClientWidth +  _articles.Width  - _articles.ClientWidth;
     sc.MinHeight := 0;
     sc.MinWidth  := 0;

     _articles.Constraints.Assign(sc);
     _personals.Constraints.Assign(sc);
     _averies.Constraints.Assign(sc);
     _pressupostos.Constraints.Assign(sc);
     _ventesA.Constraints.Assign(sc);
     _ventesB.Constraints.Assign(sc);
     _entrades.Constraints.Assign(sc);
     _magatzem.Constraints.Assign(sc);

     sc.Free;
end;

procedure T_main.SetVCaptionProcess(s : string);
begin
     VCaptionProcess := s;
     PosaCaption;
end;

procedure T_main.tRepetitsReact(Sender: TObject);
begin
     _personals.RepetitFiltre;
end;

procedure T_main.tFusionarRegistresReact(Sender: TObject);
begin
     _personals.FusionarRegistres;
end;

procedure T_main.FormClose(Sender: TObject; var Action: TCloseAction);
var
     s : string;
     i : integer;
begin
     SalvaOrdreColumnes;
     AlliberaArrayLlistes;

     if _processos.UProcessos.ProcessosActius > 0 then
     begin
          s := '';
          for i := 0 to _processos.UProcessos.Processos.Count - 1 do
          s := s + _processos.UProcessos.Processos[i] + #13#10;

          if mDlg('Hi han processos actius : '#13#10#13#10+s+#13#10'Tancar programa i anul·lar processos?',mtInformation,[mbYes,mbNo]) = mrYes
          then
          begin
               mDlg('Aquests processos estan inacabats :'#13#10#13#10 + s + #13#10'Es recomana reexecutar-los al iniciar altre cop el programa.',mtWarning,[mbOk]);

               _processos.UProcessos.CancelarProcessos;
          end
          else Action := caNone;
     end;

     if WindowState <> wsMaximized then
     begin
          dm.CR['WIDTH_MAIN'] := inttostr(Width);
          dm.CR['HEIGHT_MAIN'] := inttostr(Height);
          dm.CR['LEFT_MAIN'] := inttostr(Left);
          dm.CR['TOP_MAIN'] := inttostr(Top);
          dm.CR['ORDRE_LLISTES'] := inttostr(integer(OrdreLlistes));
     end;

     dm.CR.Save;

     dm.CG.Connected := false;
     dm.CrearCopiaDeSeguretat;
end;

procedure T_main.tMesDe2AnysReact(Sender: TObject);
begin
     _personals.MesDosAnys;
end;

procedure T_main.tRepetits1React(Sender: TObject);
begin
     _personals.Repetits;
end;

procedure T_main.ProcessosClick(Sender: TObject);
begin
     _processos.Show;
end;

procedure T_main.tActualitzarDeuteACompeReact(Sender: TObject);
begin
     _personals.ActualitzarDades;
end;

procedure T_main.tCobrarVentaReact(Sender: TObject);
begin
     _ventesA.Cobrar;
end;

procedure T_main.taventesAReact(Sender: TObject);
begin
     _ventesA.Abonar;
end;

procedure T_main.tMarcarpagadaReact(Sender: TObject);
begin
     _entrades.MarcarDesmarcarPagada;
end;

procedure T_main.enfiles1Click(Sender: TObject);
begin
     lbFilesReact(sender);
end;

procedure T_main.encolumnes1Click(Sender: TObject);
begin
     lbColumnesReact(sender);
end;

procedure T_main.mosaic1Click(Sender: TObject);
begin
     lbMosaicReact(sender);
end;

procedure T_main.maximitzartotes1Click(Sender: TObject);
begin
     lbMaximitzarReact(sender);
end;

procedure T_main.minimitzartotes1Click(Sender: TObject);
begin
     lbMinimitzarReact(sender);
end;

procedure T_main.tancar1Click(Sender: TObject);
begin
     lbTancarReact(sender);
end;

procedure T_main.Llegendadellista1Click(Sender: TObject);
var
     f : TCustomForm;
begin
     if not Assigned(ActiveControl) or not (ActiveControl is TUDBView) then
     begin
          mDlg('Cap llista seleccionada',mtInformation,[mbOk]);
          exit;
     end;

     f := (ActiveControl.Owner as TForm);

     if f = _articles then LLegendaArticles
     else
     if f = _personals then Llegendapersonals
     else
     if f = _averies then LlegendaAveries
     else
     if f = _ventesA then LlegendaVentes
     else
     if f = _pressupostos then Llegendapressupostos
     else
     if f = _caixa then LlegendaCaixa
     else
     if f = _entrades then LlegendaEntrades
     else
     if f = _magatzem then LlegendaMagatzem;

end;

procedure T_main.Alternartipusdepanells1Click(Sender: TObject);
const
     b : array [boolean] of string = ('NO','SI');
begin
     dm.CR['PANELL_ORDRES'] := b[not (dm.CR['PANELL_ORDRES'] = 'SI')];
     _main.PosaPanels;
     EndrezaLlistes(nil);
end;

procedure T_main.veurebotonsrpids1Click(Sender: TObject);
begin
     _fastbut.Visible := not _fastbut.Visible;
end;

procedure T_main.Obrircaixa1Click(Sender: TObject);
begin
     tObrirCaixa.react;
end;

procedure T_main.Entradaacaixa1Click(Sender: TObject);
begin
     tEntradaaCaixa.React
end;

procedure T_main.Novaventa1Click(Sender: TObject);
begin
     tnVentesA.React;
end;

procedure T_main.Noupressupost1Click(Sender: TObject);
begin
     tnpressupostos.React;
end;

procedure T_main.Novaaveries1Click(Sender: TObject);
begin
     tnAveries.React;
end;

procedure T_main.utAltresReact(Sender: TObject);
var
     P : TPoint;
begin
     P.x := utAltres.left;
     P.y := utAltres.Top + utAltres.Height;

     P := ClientToScreen(P);
     PopupAltres.Popup(P.x,P.y);
end;

procedure T_main.tvpressupostosReact(Sender: TObject);
begin
     _pressupostos.Veurepressupost1Click(nil);
end;

procedure T_main.tvAveriesReact(Sender: TObject);
begin
     _averies.VeureParte1Click(nil);
end;

procedure T_main.FormResize(Sender: TObject);
begin
     EndrezaLlistes(nil);
end;

procedure T_main.Pantallacomplerta1Click(Sender: TObject);
begin
     if borderstyle = bsSizeable then
     begin
          bpcWidth  := Width;
          bpcHeight := Height;
          bpcTop    := Top;
          bpcLeft   := Left;

          BorderStyle := bsNone;
          WindowState := wsMaximized;

          (sender as TMenuItem).Checked := true;
     end
     else
     begin
          BorderStyle := bsSizeable;     
          WindowState := wsNormal;

          Width  := bpcWidth;
          Height := bpcHeight;
          Top    := bpcTop;
          Left   := bpcLeft;

          (sender as TMenuItem).Checked := false;
     end;
end;

procedure T_main.tImprTicketReact(Sender: TObject);
begin
     _ventesA.ImprimirTicket1Click(nil);
end;

procedure T_main.tcventesAReact(Sender: TObject);
begin
     _cventesA.Show;
end;

procedure T_main.tcventesBReact(Sender: TObject);
begin
     _cventesB.Show;
end;

procedure T_main.tcpressupostosReact(Sender: TObject);
begin
     _cpressupostos.Show;
end;

procedure T_main.tcAveriesReact(Sender: TObject);
begin
     _caveries.Show;
end;

procedure T_main.tFacturarPresReact(Sender: TObject);
begin
     _pressupostos.Facturar;
end;

procedure T_main.tRealitzatReact(Sender: TObject);
begin
     _pressupostos.Realitzat;
end;

procedure T_main.tFacturarAveriaReact(Sender: TObject);
begin
     _averies.Facturar;
end;

procedure T_main.ExportarllistaaXLS1Click(Sender: TObject);
var
     s : string;
     v : TUDBView;
begin
     if not Assigned(ActiveControl) or not (ActiveControl is TUDBView) then
     begin
          mDlg('Cap llista seleccionada',mtInformation,[mbOk]);
          exit;
     end;

     Screen.Cursor := crHourGlass;

     v := ActiveControl as TUDBView;
     s := v.ExportToXLS('',rwNoRaw,false);

     Screen.Cursor := crDefault;

     if (s <> '') and (mDLG('Obrir arxiu ' + s + ' a Excel ara?',mtInformation,[mbYes,mbNo]) = mrYes) then
     ShellExecute(Handle, 'open', PChar('explorer'),PChar(s), PChar(s),SW_SHOWNORMAL);
end;

procedure T_main.ShowLlistes(Sender: TObject);
var
     f : TCustomForm;
     i : integer;
begin
     f := ((sender as TCustomUText).LinkedControl.Owner) as TCustomForm;

     if f.WindowState = wsMinimized then f.WindowState := wsNormal
     else f.Show;

     if IdxLlista <> -1 then PosaAPrevies(ALlistes[IdxLlista]);

     IdxLlista := ALlistesIdx(f);
     EndrezaLlistes(nil);
     Executa(f,'vGetFocus');

     for i := 0 to ftoppanel.ControlCount - 1 do
     if  (ftoppanel.Controls[i] is TCustomUText)
     and ((ftoppanel.Controls[i] as TCustomUText).LinkedControl = sender)
     then
     begin
          (ftoppanel.Controls[i] as TCustomUText).SelectNoReact;
          break;
     end;
end;

procedure T_main.PosaPanelDavant_(p : TFPanel);
begin
     PosaPanelDavant(p);

     try   (FindComponent('t'  + p.Caption) as TCustomUText).SelectNoReact;
           (FindComponent('ut' + p.Caption) as TCustomUText).SelectNoReact;
     except
     end;
end;

procedure T_main.tAltresReact(Sender: TObject);
begin
     if Llistes.Width > 0
     then PosaPanelDavant_(paAltres)
     else
     begin
          utAltres.SelectNoReact;
          utAltres.React;
     end;
end;

procedure T_main.TancaLlista(sender : TObject);
var
     b : boolean;
     i : integer;
begin
     N32Click(nil);

     b := false;

     for i := 0 to length(ALlistes) - 1 do
     begin
          if ALlistes[i] <> (sender as TCustomForm)
          then b := b or ALlistes[i].Visible;

          if b then break;
     end;

     if not b then
     begin
          PosaPanelDavant(paTapa);
          N11Click(sender);
     end
     else
     EndrezaLlistes(sender as TCustomForm);
end;

procedure T_main.N32Click(Sender: TObject);
var
     i : integer;
begin
     if Assigned(ActiveControl) and (ActiveControl is TUDBView)
     then
          IdxLlista := (IdxLlista - 1 + length(ALlistes)) mod length(ALlistes);

     for i := 0 to length(ALlistes) - 1 do
     if (IdxLlista = -1) or not ALlistes[IdxLlista].Visible then
     IdxLlista := (IdxLlista - 1 + length(ALlistes)) mod length(ALlistes)
     else break;

     with ALlistes[IdxLlista] do
     if (IdxLlista > -1) and (Visible) then
     begin
          if   WindowState = wsMinimized
          then WindowState := wsNormal
          else Show;

          try    (FindComponent('v') as TWinControl).SetFocus;
          except (FindComponent('vCArt') as TWinControl).SetFocus;
          end;
     end
     else IdxLlista := -1;
end;

procedure T_main.N31Click(Sender: TObject);
var
     i : integer;
begin
     if Assigned(ActiveControl) and (ActiveControl is TUDBView)
     then
          IdxLlista := (IdxLlista + 1) mod length(Allistes);

     for i := 0 to length(ALlistes) - 1 do
     if (IdxLlista = -1) or not ALlistes[IdxLlista].Visible then
     IdxLlista := (IdxLlista + 1) mod length(Allistes)
     else break;

     with ALlistes[IdxLlista] do
     if (IdxLlista > -1) and (Visible) then
     begin
          if   WindowState = wsMinimized
          then WindowState := wsNormal
          else Show;

          try    (FindComponent('v') as TWinControl).SetFocus;
          except (FindComponent('vCArt') as TWinControl).SetFocus;
          end;
     end
     else IdxLlista := -1;
end;

function T_main.ALlistesIdx(f : TCustomForm) : integer;
var
     i : integer;
begin
     result := 0;
     for i := 0 to length(ALlistes) - 1 do
     if ALlistes[i] = f
     then begin
               result := i;
               break;
          end;
end;

procedure T_main.N21Click(Sender: TObject);
var
     i : integer;
begin
     if Llistes.Width <> 0 then
     begin
          for i := 0 to fonsordres.ControlCount - 1 do
          if (fonsordres.Controls[i] is TCustomPanel) and
          (fonsordres.Controls[i] as TCustomPanel).visible and
          (fonsordres.Controls[i] <> Llistes) then
          begin
               (fonsordres.Controls[i] as TFPanel).ActiveControl.SetFocus;
               break;
          end;
     end
     else
     if Assigned(ActiveControl) and (ActiveControl is TUDBView) then
     (ActiveControl as TUDBView).PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure T_main.TopTextReact(Sender: TObject);
begin
     ((sender as TCustomUText).LinkedControl as TCustomUText).React;
end;

procedure T_main.tEntradaaCaixaReact(Sender: TObject);
begin
     _caixa.Entradaacaixa1Click(nil);
end;

procedure T_main.tReobrirTornReact(Sender: TObject);
begin
     ReobrirTorn;
end;

procedure T_main.tTornObertReact(Sender: TObject);
begin
     _caixa.Tornobert1Click(nil);
end;

procedure T_main.tResumTornReact(Sender: TObject);
begin
     _caixa.Resumdetorn1Click(nil);
end;

procedure T_main.tSegMagReact(Sender: TObject);
begin
     _magatzem.SeguimentArticle;
end;

procedure T_main.tEntrDirectaUtsReact(Sender: TObject);
begin
     _magatzem.EntradaDirectaUts;
end;

procedure T_main.tvVentesBReact(Sender: TObject);
begin
     T_reports.Create(self).VeureVentesB;
end;

procedure T_main.tImprTicketBReact(Sender: TObject);
begin
     tickprn.ImprimirTicket_B;
end;

procedure T_main.tAbonarVentaBReact(Sender: TObject);
begin
     _ventesB.Abonar;
end;

procedure T_main.tCobrarVentaBReact(Sender: TObject);
begin
     _ventesB.Cobrar;
end;

procedure T_main.Nou1Click(Sender: TObject);
begin
     N_Click;
end;

procedure T_main.Modificar1Click(Sender: TObject);
begin
     M_Click;
end;

procedure T_main.Eliminar1Click(Sender: TObject);
begin
     E_Click;
end;

procedure T_main.tcAveriesRelacionadesReact(Sender: TObject);
begin
     _articles.Averiesrelacionades1Click(nil);
end;

procedure T_main.tcpressupostosRelacionatReact(Sender: TObject);
begin
     _articles.pressupostosrelacionats1Click(nil);
end;

procedure T_main.tcVentesRelacionadesReact(Sender: TObject);
begin
     _articles.Ventesrelacionades1Click(nil);
end;

procedure T_main.tcEntradesRelacionadesReact(Sender: TObject);
begin
     _articles.Entradesrelacionades1Click(nil);
end;

procedure T_main.tcMagatzemRelacionatReact(Sender: TObject);
begin
     _articles.Magatzemrelacionat1Click(nil);
end;

procedure T_main.tpersAveriesRelacionadesReact(Sender: TObject);
begin
     _personals.Averiesrelacionades1Click(nil);
end;

procedure T_main.tpersPresupRelacionatsReact(Sender: TObject);
begin
     _personals.pressupostosrelacionats1Click(nil);
end;

procedure T_main.tpersVentesARelacionadesReact(Sender: TObject);
begin
     _personals.VentesArelacionades1Click(nil);
end;

procedure T_main.tpersVentesBRelacionadesReact(Sender: TObject);
begin
     _personals.VentesBrelacionades1Click(nil);
end;

procedure T_main.tpersEntradesRelacionadesReact(Sender: TObject);
begin
     _personals.Entradesrelacionades1Click(nil);
end;

procedure T_main.tAveriesClientRelacionatReact(Sender: TObject);
begin
     _averies.dpersonalsrelacionades1Click(nil);
end;

procedure T_main.tAveReparadorRelacionatReact(Sender: TObject);
begin
     _averies.dpersonalsrelacionadesreparador1Click(nil);
end;

procedure T_main.tAveVentaRelacionadaReact(Sender: TObject);
begin
     _averies.ventarelacionada1Click(nil);
end;

procedure T_main.tRepPendentsReact(Sender: TObject);
begin
     _averies.Reparacionspendents1Click(nil);
end;

procedure T_main.tFacturarelacionadaPresReact(Sender: TObject);
begin
     _pressupostos.facturesrelacionadesClick(nil);
end;

procedure T_main.tClientRelacionatPresReact(Sender: TObject);
begin
     _pressupostos.clientrelacionat1Click(nil);
end;

procedure T_main.tClientRelacionatVentesAReact(Sender: TObject);
begin
     _ventesA.Clientrelacionat1Click(nil);
end;

procedure T_main.tAveriaRelacionadaReact(Sender: TObject);
begin
     _ventesA.Averiarelacionada1Click(nil);
end;

procedure T_main.tpressupostRelacionatReact(Sender: TObject);
begin
     _ventesA.pressupostrelacionat1Click(nil);
end;

procedure T_main.tReferenciesACaixaReact(Sender: TObject);
begin
     _ventesA.Refernciesacaixa1Click(nil);
end;

procedure T_main.tVentesPagadesReact(Sender: TObject);
begin
     _ventesA.Pagades1Click(nil);
end;

procedure T_main.tVentesAmbPendentReact(Sender: TObject);
begin
     _ventesA.Ambpendent1Click(nil);
end;

procedure T_main.tVentesAbonadesReact(Sender: TObject);
begin
     _ventesA.Abonades1Click(nil);
end;

procedure T_main.tAbonamentsReact(Sender: TObject);
begin
     _ventesA.Abonaments1Click(nil);
end;

procedure T_main.tRepDomiciliReact(Sender: TObject);
begin
     _averies.Reparacionsadomicili1Click(nil);
end;

procedure T_main.tRepExternesReact(Sender: TObject);
begin
     _averies.Reparacionsexternes1Click(nil);
end;

procedure T_main.tRepEnviadesReact(Sender: TObject);
begin
     _averies.ReparacionsEnviades1Click(nil);
end;

procedure T_main.tpressupostosRealitzatsReact(Sender: TObject);
begin
     _pressupostos.pressupostosrealitzats1Click(nil);
end;

procedure T_main.tVentesrelacionadaReact(Sender: TObject);
begin
     _caixa.VentesRelacionades1Click(nil);
end;

procedure T_main.tEntradesDirectesTotesReact(Sender: TObject);
begin
     _caixa.Entradesdirectes1Click(nil);
end;

procedure T_main.tEntradesDirectesTornReact(Sender: TObject);
begin
     _caixa.Entradesdirectestornactiu1Click(nil);
end;

procedure T_main.tAbonamentscaixaReact(Sender: TObject);
begin
     _caixa.Abonaments1Click(nil);
end;

procedure T_main.PosaAPrevies(f : TCustomForm);
var
     i : integer;
begin
     if length(ALlistaPrevia) < 10 then
     begin
          setlength(ALlistaPrevia,length(ALlistaPrevia) + 1);
          ALlistaPrevia[length(ALlistaPrevia) - 1] := f;
     end
     else
     begin
          for i := 0 to length(ALlistaPrevia) - 2 do
          begin
               ALlistaPrevia[i] := ALlistaPrevia[i+1];
          end;
          ALlistaPrevia[length(ALlistaPrevia) - 1] := f;
     end;

     Tornarllistaprvia1.Enabled := length(ALlistaPrevia) > 0;
end;

procedure T_main.Tornarllistaprvia1Click(Sender: TObject);
var
     v : TUDBView;
     f : TCustomForm;
begin
     if length(ALlistaPrevia) > 0 then
     begin
          f := ALlistaPrevia[length(ALlistaPrevia) - 1];

          f.BringToFront;
          f.Show;

          try    v := f.FindComponent('v') as TUDBView;
                 v.SetFocus;
          except v := f.Findcomponent('vCArt') as TUDBView;
                 v.SetFocus;
          end;

          setlength(ALlistaPrevia,length(ALlistaPrevia) - 1);
     end;

     Tornarllistaprvia1.Enabled := length(ALlistaPrevia) > 0;
end;

procedure T_main.NMSEnabled;
begin
     Nou1.Enabled := true;
     Modificar1.Enabled := true;
     Eliminar1.Enabled := true;
end;

procedure T_main.IEnabled;
begin
     VeureInforme1.Enabled := true;
end;

procedure T_main.INoEnabled;
begin
     VeureInforme1.Enabled := false;
end;

procedure T_main.NMSNoEnabled;
begin
     Nou1.Enabled := false;
     Modificar1.Enabled := false;
     Eliminar1.Enabled := false;
     INoEnabled;
end;

procedure T_main.tArticleRelacionatReact(Sender: TObject);
begin
     _magatzem.Articlerelacionats1Click(nil);
end;

procedure T_main.UText1React(Sender: TObject);
begin
     _magatzem.Ventesrelacionades1Click(nil);
end;

procedure T_main.tEntradesRelacionadesMagReact(Sender: TObject);
begin
     _magatzem.Entradesrelacionades1Click(nil);
end;

procedure T_main.UText3React(Sender: TObject);
begin
     _magatzem.Articlesaceroonegatiu1Click(nil);
end;

procedure T_main.tProveedorRelacionatReact(Sender: TObject);
begin
     _entrades.proveedorrelacionat1Click(nil);
end;

procedure T_main.tEntradesNormalitReact(Sender: TObject);
begin
     _entrades.entradesdenormalitzaci1Click(nil);
end;

procedure T_main.Poblacions1Click(Sender: TObject);
begin
     tPoblacions.React;
end;

procedure T_main.Marques1Click(Sender: TObject);
begin
     tMarques.React;
end;

procedure T_main.Lnies1Click(Sender: TObject);
begin
     tLinies.React;
end;

procedure T_main.Famlies1Click(Sender: TObject);
begin
     tFamilies.React;
end;

procedure T_main.Conceptesdaveries1Click(Sender: TObject);
begin
     tcAveries.React;
end;

procedure T_main.Conceptesdepressupostos1Click(Sender: TObject);
begin
     tcpressupostos.React;
end;

procedure T_main.ConceptesdeventesA1Click(Sender: TObject);
begin
     tcVentesA.React;
end;

procedure T_main.ConceptesdeventesB1Click(Sender: TObject);
begin
     tcVentesB.React;
end;

procedure T_main.Conceptesdentrades1Click(Sender: TObject);
begin
     tcEntrades.React;
end;

procedure T_main.tObrirCaixaReact(Sender: TObject);
begin
     _caixa.Obrircaixa1Click(nil);
end;

procedure T_main.Sumaderegistresvisibles1Click(Sender: TObject);
begin
     SumaRegistresVisibles;
end;

procedure T_main.Sumadeventessegonsclients1Click(Sender: TObject);
begin
     SumaSegonsClients;
end;

procedure T_main.Contarnderegistres1Click(Sender: TObject);
begin
     ContarRegistres;
end;

procedure T_main.Veureinforme1Click(Sender: TObject);
begin
     I_Click;
end;

procedure T_main.Sumadeventessegonslniadarticle1Click(Sender: TObject);
begin
     SumaSegonsLiniaArticles;
end;

procedure T_main.tEntrarCodiBarresReact(Sender: TObject);
begin
     _articles.Entrarcodidebarres1Click(nil);
end;

procedure T_main.tTornObertFiltreReact(Sender: TObject);
begin
     _caixa.Tornobert2Click(nil);
end;

procedure T_main.tPagadesReact(Sender: TObject);
begin
     _entrades.Pagades1Click(nil);
end;

procedure T_main.UText2React(Sender: TObject);
begin
     _caixa.Abonamentstornactiu1Click(nil);
end;

procedure T_main.UText4React(Sender: TObject);
begin
     _caixa.Obrirnoutorn1Click(nil);
end;

end.
