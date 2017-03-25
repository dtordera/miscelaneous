unit codcolor;

interface

uses Windows, Controls, Forms, ExtCtrls, CColor, StdCtrls, UText, Gradient,
  Classes, sysutils, Graphics;

type
  T_codcolor = class(TForm)
    Label2: TLabel;
    UText1: TUText;
    UText2: TUText;
    dC_OBSOLET: TCColor;
    GradientNC1: TGradientNC;
    UText6: TUText;
    Bevel1: TBevel;
    UText3: TUText;
    UText4: TUText;
    UText5: TUText;
    dC_MARGEMARCA: TCColor;
    dC_MARGEDEFECTE: TCColor;
    dC_MARGENOVALID: TCColor;
    UText7: TUText;
    dC_ENTRADADIRECTA: TCColor;
    Label1: TLabel;
    UText8: TUText;
    dC_MESDOSANYS: TCColor;
    UText9: TUText;
    dC_REPETIT_2: TCColor;
    UText10: TUText;
    dC_REPETIT_3: TCColor;
    UText11: TUText;
    dC_REPETIT_4: TCColor;
    Label3: TLabel;
    UText12: TUText;
    UText13: TUText;
    dC_ABONAMENT: TCColor;
    dC_ENDEUTE: TCColor;
    UText14: TUText;
    dC_ABONADA: TCColor;
    Label4: TLabel;
    UText15: TUText;
    dC_REALITZATS: TCColor;
    Label5: TLabel;
    UText17: TUText;
    dC_REP_FINALITZADA: TCColor;
    Label6: TLabel;
    UText16: TUText;
    dC_TORN_OBERT: TCColor;
    Label7: TLabel;
    UText18: TUText;
    dC_UTS_CERO: TCColor;
    Label8: TLabel;
    UText19: TUText;
    dC_NORMALIT: TCColor;
    procedure UText5Click(Sender: TObject);
    procedure UText6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
     procedure CarregadesdeVariables;
     procedure SalvaACR;
     procedure Mostra;
  end;

implementation

uses dmsrc, global, estilcolor;

{$R *.dfm}

procedure T_codcolor.CarregadesdeVariables;
begin
     dC_OBSOLET.Color         := C_OBSOLET;
     dC_MARGENOVALID.Color    := C_MARGENOVALID;
     dC_MARGEDEFECTE.Color    := C_MARGEDEFECTE;
     dC_MARGEMARCA.Color      := C_MARGEMARCA;
     dC_ENTRADADIRECTA.Color  := C_ENTRADADIRECTA;
     dC_REPETIT_2.Color       := C_REPETIT_2;
     dC_REPETIT_3.Color       := C_REPETIT_3;
     dC_REPETIT_4.Color       := C_REPETIT_4;
     dC_MESDOSANYS.Color      := C_MESDOSANYS;
     dC_ABONAMENT.Color       := C_ABONAMENT;
     dC_ABONADA.Color         := C_ABONADA;
     dC_ENDEUTE.Color         := C_ENDEUTE;
     dC_REALITZATS.Color      := C_REALITZATS;
     dC_REP_FINALITZADA.Color := C_REP_FINALITZADA;
     dC_TORN_OBERT.Color      := C_TORN_OBERT;
     dC_UTS_CERO.Color        := C_UTS_CERO;
     dC_NORMALIT.Color        := C_NORMALIT;
end;

procedure T_codcolor.SalvaACR;
begin
     dm.CR['C_OBSOLET']       := dC_OBSOLET.ColorS;
     dm.CR['C_MARGENOVALID']  := dC_MARGENOVALID.ColorS;
     dm.CR['C_MARGEDEFECTE']  := dC_MARGEDEFECTE.ColorS;
     dm.CR['C_MARGEMARCA']    := dC_MARGEMARCA.ColorS;
     dm.CR['C_ENTRADADIRECTA']:= dC_ENTRADADIRECTA.ColorS;
     dm.CR['C_REPETIT_2]']    := dC_REPETIT_2.ColorS;
     dm.CR['C_REPETIT_3']     := dC_REPETIT_3.ColorS;
     dm.CR['C_REPETIT_4']     := dC_REPETIT_4.ColorS;
     dm.CR['C_MESDOSANYS']    := dC_MESDOSANYS.ColorS;
     dm.CR['C_ABONAMENT']     := dC_ABONAMENT.ColorS;
     dm.CR['C_ABONADA']       := dC_ABONADA.ColorS;
     dm.CR['C_ENDEUTE']       := dC_ENDEUTE.ColorS;
     dm.CR['C_REALITZATS']    := dC_REALITZATS.ColorS;
     dm.CR['C_REP_FINALITZADA'] := dC_REP_FINALITZADA.ColorS;
     dm.CR['C_TORN_OBERT']      := dC_TORN_OBERT.ColorS;
     dm.CR['C_UTS_CERO']      := dC_UTS_CERO.ColorS;
     dm.CR['C_NORMALIT']      := dC_NORMALIT.ColorS;

     C_OBSOLET         := strtoint(dm.CR['C_OBSOLET']);
     C_MARGENOVALID    := strtoint(dm.CR['C_MARGENOVALID']);
     C_MARGEDEFECTE    := strtoint(dm.CR['C_MARGEDEFECTE']);
     C_MARGEMARCA      := strtoint(dm.CR['C_MARGEMARCA']);
     C_ENTRADADIRECTA  := strtoint(dm.CR['C_ENTRADADIRECTA']);
     C_REPETIT_2       := strtoint(dm.CR['C_REPETIT_2]']);
     C_REPETIT_3       := strtoint(dm.CR['C_REPETIT_3']);
     C_REPETIT_4       := strtoint(dm.CR['C_REPETIT_4']);
     C_MESDOSANYS      := strtoint(dm.CR['C_MESDOSANYS']);
     C_ABONAMENT       := strtoint(dm.CR['C_ABONAMENT']);
     C_ABONADA         := strtoint(dm.CR['C_ABONADA']);
     C_ENDEUTE         := strtoint(dm.CR['C_ENDEUTE']);
     C_REALITZATS      := strtoint(dm.CR['C_REALITZATS']);
     C_REP_FINALITZADA    := strtoint(dm.CR['C_REP_FINALITZADA']);
     C_TORN_OBERT         := strtoint(dm.CR['C_TORN_OBERT']);
     C_UTS_CERO           := strtoint(dm.CR['C_UTS_CERO']);
     C_NORMALIT           := strtoint(dm.CR['C_NORMALIT']);
end;

procedure T_codcolor.UText5Click(Sender: TObject);
begin
     dC_OBSOLET.Color            := clSilver;
     dC_MARGENOVALID.Color       := $000000C8;
     dC_MARGEDEFECTE.Color       := clYellow;
     dC_MARGEMARCA.Color         := $0045B8FC;
     dC_ENTRADADIRECTA.Color     := $00AB0000;
     dC_REPETIT_2.Color          := $0000BD00;
     dC_REPETIT_3.Color          := $00008E00;
     dC_REPETIT_4.Color          := $00006F00;
     dC_MESDOSANYS.Color         := clSilver + $0B0B0B;
     dC_ABONAMENT.Color          := clYellow;
     dC_ABONADA.Color        := clYellow + $0000A0;
     dC_ENDEUTE.Color            := clRed;
     dC_REALITZATS.Color         := clSilver;
     dC_REP_FINALITZADA.Color    := clSilver;
     dC_TORN_OBERT.Color         := clAqua;
     dC_UTS_CERO.Color           := clSilver;
     dC_NORMALIT.Color           := clYellow;
end;

procedure T_codcolor.UText6Click(Sender: TObject);
begin
     modalresult := mrOK;
end;

procedure T_codcolor.Mostra;
begin
     CarregaDesdeVariables;
     if ShowModal = mrOk then SalvaACR;
end;

procedure T_codcolor.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
end;

end.
