unit main_nou;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UText, ExtCtrls, FPanel, Gradient, Menus, BringToFront;

type
  TForm1 = class(TForm)
    fonsordres: TFPanel;
    paOrdenarLlistes: TFPanel;
    Llistes: TFPanel;
    tArticles: TUText;
    tPersonals: TUText;
    tAveries: TUText;
    tPresupostos: TUText;
    fonsmain: TGradient;
    MainMenu1: TMainMenu;
    General1: TMenuItem;
    Sortir1: TMenuItem;
    N1: TMenuItem;
    Configuraci1: TMenuItem;
    paCaixa: TFPanel;
    tEntradaaCaixa: TUText;
    paAveries: TFPanel;
    tnAveries: TUText;
    tmAveries: TUText;
    tdAveries: TUText;
    paPressupostos: TFPanel;
    tnPressupostos: TUText;
    tmPressupostos: TUText;
    tdPressupostos: TUText;
    tFacturarPres: TUText;
    paArticles: TFPanel;
    tnArticles: TUText;
    tmArticles: TUText;
    tdArticles: TUText;
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
    tvPressupostos: TUText;
    tResumTorn: TUText;
    paVentesA: TFPanel;
    tnVentesA: TUText;
    taVentesA: TUText;
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
    tColumnes: TUText;
    tFiles: TUText;
    tMaximitzar: TUText;
    tMosaic: TUText;
    tMinimitzar: TUText;
    tTancar: TUText;
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
    tAltres: TUText;
    tEntrades: TUText;
    tMagatzem: TUText;
    tCaixa: TUText;
    tVentesB: TUText;
    tVentesA: TUText;
    tActualitzarDeuteACompe: TUText;
    paEntrades: TFPanel;
    tnEntrades: TUText;
    tMarcarPagada: TUText;
    tmEntrades: TUText;
    tRealitzat: TUText;
    ftoppanel: TFPanel;
    utAltres: TUText;
    utEntrades: TUText;
    utMagatzem: TUText;
    utCaixa: TUText;
    utVentesB: TUText;
    utVentesA: TUText;
    utAveries: TUText;
    utPressupostos: TUText;
    utPersonals: TUText;
    utArticles: TUText;
    UText29: TUText;
    N3: TMenuItem;
    AlternarTipusdePanells1: TMenuItem;
    N4: TMenuItem;
    Ordredellistes1: TMenuItem;
    enfiles1: TMenuItem;
    encolumnes1: TMenuItem;
    mosaic1: TMenuItem;
    maximitzartotes1: TMenuItem;
    minimitzartotes1: TMenuItem;
    tancar1: TMenuItem;
    llegendadellista1: TMenuItem;
    veurebotonsrpids1: TMenuItem;
    n5: TMenuItem;
    Ordresrpides1: TMenuItem;
    NovaVenta1: TMenuItem;
    Entradaacaixa1: TMenuItem;
    ObrirCaixa1: TMenuItem;
    NouPressupost1: TMenuItem;
    NovaAveries1: TMenuItem;
    N6: TMenuItem;
    PopupAltres: TMenuItem;
    Poblacions1: TMenuItem;
    Marques1: TMenuItem;
    Lnies1: TMenuItem;
    Famlies1: TMenuItem;
    PantallaComplerta1: TMenuItem;
    tImprTicket: TUText;
    tAbonaments: TUText;
    tcVentesA: TUText;
    tcVentesB: TUText;
    tcPressupostos: TUText;
    tcAveries: TUText;
    Altres1: TMenuItem;
    ExportarLlistaAXLS1: TMenuItem;
    tcVentesRelacionades: TUText;
    tcAveriesRelacionades: TUText;
    tcMagatzemRelacionat: TUText;
    tcEntradesRelacionades: TUText;
    tFusionarRegistres: TUText;
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
    tcPressupostosRelacionat: TUText;
    tTitolArticles: TSimpleUText;
    tTitolPersonals: TSimpleUText;
    tTitolAveries: TSimpleUText;
    tTitolPressupostos: TSimpleUText;
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
    tPersVentesBRelacionades: TUText;
    tPersAveriesRelacionades: TUText;
    tPersPresupRelacionats: TUText;
    tpersEntradesRelacionades: TUText;
    tAveriesClientRelacionat: TUText;
    tAveReparadorRelacionat: TUText;
    tAveVentaRelacionada: TUText;
    tClientRelacionatPres: TUText;
    tFacturaRelacionadaPres: TUText;
    tPressupostosRealitzats: TUText;
    tClientRelacionatVentesA: TUText;
    tAveriaRelacionada: TUText;
    tPressupostRelacionat: TUText;
    tReferenciesACaixa: TUText;
    tVentesAbonades: TUText;
    tRepExternes: TUText;
    tRepEnviades: TUText;
    tVentesRelacionada: TUText;
    tEntradesDirectesTotes: TUText;
    tEntradesDirectesTorn: TUText;
    tAbonamentsCaixa: TUText;
    TornarLlistaprvia1: TMenuItem;
    N10: TMenuItem;
    tArticleRelacionat: TMenuItem;
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
    VeureInforme1: TMenuItem;
    Sumadeventessegonslniadarticle1: TMenuItem;
    tEntrarCodiBarres: TUText;
    tAmbDeute: TUText;
    tTornObertFiltre: TUText;
    tPagades: TUText;
    UText2: TUText;
    UText4: TUText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
