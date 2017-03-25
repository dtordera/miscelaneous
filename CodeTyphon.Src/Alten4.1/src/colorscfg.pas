unit colorscfg;

interface

uses Classes, Dialogs, Controls, ExtCtrls, CColor, StdCtrls, UText,
  Gradient, Forms, Graphics, sysutils;

type
  T_colorscfg = class(TForm)
    GradientNC1: TGradientNC;
    UText6: TUText;
    UText1: TUText;
    UText9: TUText;
    UText11: TUText;
    UText12: TUText;
    UText13: TUText;
    UText14: TUText;
    UText17: TUText;
    UText18: TUText;
    Label2: TLabel;
    UText2: TUText;
    cGradientInicial: TCColor;
    cGradientFinal: TCColor;
    cDefaultNormalUText: TCColor;
    cSelectedFont: TCColor;
    cSelectedBand: TCColor;
    cMouseOverFont: TCColor;
    cMouseOverBand: TCColor;
    cULabelMouseOver: TCColor;
    cULabelFont: TCColor;
    cUDBGodd: TCColor;
    cUDBGFont: TCColor;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    UText3: TUText;
    UText5: TUText;
    UText7: TUText;
    cUDBGEven: TCColor;
    UText10: TUText;
    cUDBGTitleFont: TCColor;
    UText8: TUText;
    cUDBGTitle: TCColor;
    UText15: TUText;
    SaveDialog1: TSaveDialog;
    UText19: TUText;
    OpenDialog1: TOpenDialog;
    UText20: TUText;
    Shape1: TShape;
    procedure UText6React(Sender: TObject);
    procedure UText19React(Sender: TObject);
    procedure UText20React(Sender: TObject);
    procedure UText15React(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
     procedure AplicaColors(nm : string);
     procedure SalvaFitxer(nm : string);
     procedure CarregaFitxer(nm : string);
     procedure ColorsPerDefecte;
  end;

implementation

uses global, main, dmsrc, config, estilcolor;

{$R *.dfm}

procedure T_colorscfg.AplicaColors(nm : string);
var
     i : integer;
begin
     _estilcolor.Load(nm);
     _estilcolor.Active := dm.CR['APLICAR_COLORS'] = 'SI';

     for i := 0 to Application.ComponentCount - 1 do
     if (Application.Components[i] is TCustomForm) then
     try
          _estilcolor.Apply(Application.Components[i] as TCustomForm);
     except
     end;

     for i := 0 to _main.fonsmain.ComponentCount - 1 do
     if (_main.fonsmain.Components[i] is TCustomForm) then
     try
          _estilcolor.Apply(_main.fonsmain.Components[i] as TCustomForm);
     except
     end;

     if Visible then
     try
          _estilcolor.Apply(self)
     except
     end;

     _main.PosaColorsTitols;     

     if Extractfilename(nm) <> 'tmp.stc' then
     dm.CR['ESTIL_PREFIXAT'] := extractfilename(nm);
end;

procedure T_colorscfg.UText6React(Sender: TObject);
begin
     ModalResult := mrOk;
end;

procedure T_colorscfg.ColorsPerDefecte;
begin
     cGradientInicial.Color    := $00804000;
     cGradientFinal.Color      := clWhite;
     cDefaultNormalUText.Color := clWhite;
     cMouseOverBand.Color      := $000080FF;
     cMouseOverFont.Color      := clWhite;
     cSelectedBand.Color       := clNavy;
     cSelectedFont.Color       := clWhite;
     cULabelFont.Color         := clYellow;
     cULabelMouseOver.Color    := $000080FF;
     cUDBGEven.Color           := $EEF5F7;
     cUDBGOdd.Color            := $E2F0F1;
     cUDBGTitleFont.Color      := clSilver;
     cUDBGFont.Color           := clSilver + $A0A0A0;
     cUDBGTitle.Color          := clNavy;
end;

procedure T_colorscfg.CarregaFitxer(nm : string);
begin
     try
          _estilcolor.Load(nm);
     except
          mDlg('No s''ha pogut carregar el fitxer de colors ' + nm,mtError,[mbOk]);
          ColorsPerDefecte;
          exit;
     end;

     with _estilcolor.Lines do
     begin
          cGradientInicial.ColorS    := Values['TGradientNC.ColorInicial'];
          cGradientFinal.ColorS      := Values['TGradientNC.ColorFinal'];
          cDefaultNormalUText.ColorS := Values['TCUSTOMUText.TextStyleDefault.Font.Color'];
          cMouseOverBand.ColorS      := Values['TCUSTOMUText.TextStyleMouseOver.Color'];
          cMouseOverFont.ColorS      := Values['TCUSTOMUText.TextStyleMouseOver.Font.Color'];
          cSelectedBand.ColorS       := Values['TCUSTOMUText.TextStyleSelected.Color'];
          cSelectedFont.ColorS       := Values['TCUSTOMUText.TextStyleSelected.Font.Color'];
          cULabelFont.ColorS         := Values['TCUSTOMULabel.Font.Color'];
          cULabelMouseOver.ColorS    := Values['TCUSTOMULabel.ColorMouseOver'];
          cUDBGEven.ColorS           := Values['TUDBView.Look.Even'];
          cUDBGOdd.Colors            := Values['TUDBView.Look.Odd'];
          cUDBGTitleFont.ColorS      := Values['TUDBView.Look.FixedRowFont.Color'];
          cUDBGFont.ColorS           := Values['TUDBView.Look.DataFont.Color'];
          cUDBGTitle.ColorS          := Values['TUDBView.Look.FixedRow'];
     end;
end;

procedure T_colorscfg.SalvaFitxer(nm : string);
var
     ss : TStrings;
begin
     ss := TStringList.Create;

     ss.Add('TGradientNC.ColorInicial='+cGradientInicial.ColorS);
     ss.Add('TGradientNC.ColorFinal='+cGradientFinal.ColorS);
     ss.Add('TGradient.ColorInicial='+cGradientInicial.ColorS);
     ss.Add('TGradient.ColorFinal='+cGradientFinal.ColorS);
     ss.Add('TCustomForm.Color='+cGradientInicial.ColorS);
     ss.Add('TFPanel.Color='+cGradientInicial.ColorS);
     ss.Add('TFPanel.Font.Color='+cGradientInicial.Colors);
     ss.Add('TUText.TextStyleDefault.Color='+cGradientInicial.ColorS);
     ss.Add('TLabel.Color='+cGradientInicial.ColorS);
     ss.Add('TLabel.Font.Color='+cDefaultNormalUText.ColorS);
     ss.Add('TCUSTOMUText.Color='+cGradientInicial.Colors);
     ss.Add('TCUSTOMUText.TextStyleDefault.Font.Color='+cDefaultNormalUText.ColorS);
     ss.Add('TCUSTOMUText.TextStyleDefault.Color='+cGradientInicial.Colors);
     ss.Add('TCUSTOMUText.TextStyleMouseOver.Color='+cMouseOverBand.ColorS);
     ss.Add('TCUSTOMUText.TextStyleMouseOver.Font.Color='+ cMouseOverFont.ColorS);
     ss.Add('TCUSTOMUText.TextStyleSelected.Color='+cSelectedBand.ColorS);
     ss.Add('TCUSTOMUText.TextStyleSelected.Font.Color='+cSelectedFont.ColorS);
     ss.Add('TCUSTOMULabel.Font.Color='+cULabelFont.ColorS);
     ss.Add('TBLabel.ColorTrue='+cULabelFont.ColorS);
     ss.Add('TCUSTOMULabel.ColorMouseOver='+cULabelMouseOver.ColorS);
     ss.Add('TCUSTOMULabel.ColorRestore='+cULabelFont.ColorS);
     ss.Add('TUDBView.Look.BackColor='+cUDBGEven.ColorS);
     ss.Add('TUDBView.Look.Selected='+cSelectedBand.Colors);
     ss.Add('TUDBView.Look.Focused='+cMouseOverBand.ColorS);
     ss.Add('TUDBView.Look.Even='+cUDBGEven.ColorS);
     ss.Add('TUDBView.Look.Odd='+cUDBGOdd.Colors);
     ss.Add('TUDBView.Look.FixedRow='+cUDBGTitle.ColorS);
     ss.Add('TUDBView.Look.Bordercolor='+cGradientFinal.ColorS);
     ss.Add('TUDBView.Look.FixedRowFont.Color='+cUDBGTitleFont.ColorS);
     ss.Add('TUDBView.Look.DataFont.Color='+cUDBGFont.ColorS);
     ss.Add('TSHAPE.PEN.Color='+cGradientFinal.ColorS);
     ss.Add('TSplitter.Color='+cGradientFinal.ColorS);

     ss.SaveToFile(nm);
     ss.Free;
end;

procedure T_colorscfg.UText19React(Sender: TObject);
begin
     OpenDialog1.InitialDir := BINDIR + 'STC';
     if OpenDialog1.Execute
     then
     begin
          CarregaFitxer(OpenDialog1.FileName);
          Caption := 'Colors : ' + ExtractFileName(OpenDialog1.FileName);
     end;
end;

procedure T_colorscfg.UText20React(Sender: TObject);
begin
     SalvaFitxer(BINDIR + 'STC\\tmp.stc');
     AplicaColors(BINDIR + 'STC\\tmp.stc');
     if FileExists(BINDIR + 'STC\\tmp.stc') then
     DeleteFile(BINDIR + 'STC\\tmp.stc');
end;

procedure T_colorscfg.UText15React(Sender: TObject);
begin
     SaveDialog1.InitialDir := BINDIR + 'STC';
     if SaveDialog1.Execute
     then
     begin
          SalvaFitxer(SaveDialog1.FileName);
          Caption := 'Colors : ' + ExtractFileName(SaveDialog1.FileName);
     end;
end;

procedure T_colorscfg.FormCreate(Sender: TObject);
begin
     try
          CarregaFitxer(BINDIR + 'STC\\' + ((sender as TComponent).Owner as T_config).dESTIL_PREFIXAT.Caption);
          Caption := 'Colors : ' + ((sender as TComponent).Owner as T_config).dESTIL_PREFIXAT.Caption;
     except
          ColorsPerDefecte;
          Caption := 'Colors';
     end;

     _estilcolor.Apply(sender as TCustomForm);
end;

end.
