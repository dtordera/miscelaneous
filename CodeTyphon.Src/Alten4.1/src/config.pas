unit config;

interface

uses Windows, Forms, StdCtrls, Controls, UText, ULabel, ExtCtrls, Classes,
  Gradient, sysutils, CColor, Estilcolor, FileCtrl, ShellApi, Dialogs;

type
  T_config = class(TForm)
    dDATABASE: TLLabel;
    UText6: TUText;
    btCancel: TButton;
    dIVA_ARTICLES: TNLabel;
    Label2: TLabel;
    Label7: TLabel;
    UText9: TUText;
    UText8: TUText;
    UText12: TUText;
    GradientNC1: TGradientNC;
    UText14: TUText;
    dMARGE_DEFECTE: TNLabel;
    Label1: TLabel;
    UText2: TUText;
    dIMPRESORA_2: TMLabel;
    Label10: TLabel;
    UText10: TUText;
    UText11: TUText;
    dIVA_A: TNLabel;
    dIVA_B: TNLabel;
    Label11: TLabel;
    UText13: TUText;
    UText15: TUText;
    dESTIL_PREFIXAT: TMLabel;
    dAPLICAR_COLORS: TBLabel;
    dULTIM_FITXER: TULabel;
    dULTIMA_DATA: TULabel;
    tCODIS_DE_COLORS: TUText;
    Label4: TLabel;
    UText16: TUText;
    dBAK_DIR: TLLabel;
    d: TUText;
    dLLISTES_FIXES: TBLabel;
    Shape1: TShape;
    Label5: TLabel;
    UText20: TUText;
    dMOSTRAR_A_COMPTE_PENDENT: TBLabel;
    Label8: TLabel;
    tInfoAmple: TUText;
    UText4: TUText;
    dCOPIES_INF: TNLabel;
    UText5: TUText;
    dCOPIES_TCK: TNLabel;
    UText17: TUText;
    dU_LLEGENDA: TBLabel;
    dSEQ_OPERTURA: TTLabel;
    UText3: TUText;
    Label3: TLabel;
    UText18: TUText;
    dOBRIR_CAIXA_AUTO: TBLabel;
    UText21: TUText;
    Label9: TLabel;
    dNO_NORMALIT: TBLabel;
    UText22: TUText;
    UText23: TUText;
    UText24: TUText;
    UText1: TUText;
    dIMPRESORA_1: TMLabel;
    Label6: TLabel;
    tTREBALLADORS: TUText;
    UText19: TUText;
    dUT_TREBALLADORS: TBLabel;
    dTREBALLADORS: TTLabel;
    UText7: TUText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure LoadValues;
    procedure SaveValues;
    procedure UText6React(Sender: TObject);
    procedure UText13React(Sender: TObject);
    procedure dULTIM_FITXERClick(Sender: TObject);
    procedure tCODIS_DE_COLORSReact(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dESTIL_PREFIXATChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dAPLICAR_COLORSChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dLLISTES_FIXESClick(Sender: TObject);
    procedure dReact(Sender: TObject);
    procedure dLINIES_A_LLISTESClick(Sender: TObject);
    procedure dMARGESClick(Sender: TObject);
    procedure tInfoAmpleReact(Sender: TObject);
    procedure UText21React(Sender: TObject);
    procedure dAPLICAR_COLORSValueToCaption(Sender: TObject);
    procedure dDATABASEValueToCaption(Sender: TObject);
    procedure UText7React(Sender: TObject);
  private
     AplicarColors : boolean;
     CanviLlistes  : boolean;
  public
  end;

implementation

uses dmsrc, global, printers, colorscfg, codcolor, personals, articles,
  pressupostos, llistcfg, main, fastbut, ticket, mainaux, averies, ventesA,
  ventesB, caixa, entrades, magatzem, poblacions, marques, families,
  linies, caveries, cpressupostos, cventesA, cventesB, centrades, peinfor;

{$R *.DFM}

procedure T_config.SaveValues;
var
     i : integer;
     o : TObject;
     s : string;
const
     SINO : array [boolean] of string = ('NO','SI');
begin
     for i := 0 to dm.CR.DefaultNames.Count - 1 do
     begin
          s := dm.CR.DefaultNames[i];

          if Copy(s,0,2) = 'C_' then continue;

          o := self.FindComponent('d'+s);

          if o <> nil then
          if o is TNLabel then
          case (o as TNLabel).NumType of
          ntInt   : dm.CR[s] := inttostr(Round((o as TNLabel).Value));
          ntFloat : dm.CR[s] := FormatFloat('0.00',(o as TNLabel).Value);
          end
          else
          if o is TBLabel then
          dm.CR[s] := SINO[(o as TBLabel).Value]
          else
          if o is TDLabel then
          dm.CR[s] := datetostr((o as TDLabel).Date)
          else
          if o is THLabel then
          dm.CR[s] := timetostr((o as THLabel).Time)
          else
          if o is TCustomULabel then
          dm.CR[s] := (o as TCustomULabel).Caption
          else
          if o is TCustomLabel then
          dm.CR[s] := (o as TLabel).Caption
          else
          if o is TCColor then
          dm.CR[s] := inttostr((O as TCColor).Color);
     end;
end;

procedure T_config.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if modalresult = mrOk then
     begin
          SaveValues;

          dm.CR.Save;
          if AplicarColors then
          try
               _estilcolor.Active := dm.CR['APLICAR_COLORS'] = 'SI';
               T_colorscfg.Create(self).AplicaColors(BINDIR + 'STC\\' + dESTIL_PREFIXAT.Caption);
          except
          end;

          if CanviLlistes then PosaMargeALlistes;
     end;
end;

procedure T_config.LoadValues;
var
     i : integer;
     o : TObject;
     s : string;
begin
     for i := 0 to dm.CR.DefaultNames.Count - 1 do
     begin
          s := dm.CR.DefaultNames[i];

          if Copy(s,0,2) = 'C_' then continue;

          o := self.FindComponent('d'+s);

          if o <> nil then
          if o is TNLabel then
          (o as TNLabel).Value := strtofloat(dm.CR[s])
          else
          if o is TBLabel then
          (o as TBLabel).Value := (dm.CR[s] = 'si') or (dm.CR[s] = 'SI')
          else
          if o is TDLabel then
          (o as TDLabel).Date := strtodate(dm.CR[s])
          else
          if o is THLabel then
          (o as THLabel).Time := strtotime(dm.CR[s])
          else
          if o is TCustomULabel then
          (o as TCustomULabel).Caption := dm.CR[s]
          else
          if o is TCustomLabel then
          (o as TLabel).Caption := dm.CR[s]
          else
          if o is TCColor then
          (o as TCColor).Color := strtoint(dm.CR[s]);
     end;
end;

procedure SetFileList(S : TStrings;dir,ext : string; o : TCustomForm);
var
     f : TFileListBox;
begin
     f := TFileListBox.Create(o);
     f.Visible := false;
     f.Parent := o;
     f.Directory := dir;
     f.Mask := ext;
     f.Update;

     S.Assign(f.Items);

     f.Free;
end;

procedure T_config.FormActivate(Sender: TObject);
begin
     Printer.Refresh;

     dIMPRESORA_1.Items.Assign(Printer.Printers);
     dIMPRESORA_2.Items.Assign(Printer.Printers);

     SetFileList(dESTIL_PREFIXAT.Items,BINDIR+'STC','*.stc', self);

     LoadValues;

     dIMPRESORA_1.ItemIndex := dIMPRESORA_1.Items.IndexOf(dIMPRESORA_1.Caption);
     dIMPRESORA_2.ItemIndex := dIMPRESORA_2.Items.IndexOf(dIMPRESORA_2.Caption);
     dESTIL_PREFIXAT.ItemIndex := dESTIL_PREFIXAT.Items.IndexOf(dESTIL_PREFIXAT.Caption);
     dESTIL_PREFIXAT.Visible := dAPLICAR_COLORS.Value;     
end;


procedure T_config.UText6React(Sender: TObject);
begin
     modalresult := mrOk;
end;

procedure T_config.UText13React(Sender: TObject);
begin
     T_colorscfg.Create(self).ShowModal;
     SetFileList(dESTIL_PREFIXAT.Items,BINDIR+'STC','*.stc', self);
     dESTIL_PREFIXAT.ItemIndex := dESTIL_PREFIXAT.Items.IndexOf(dm.CR['ESTIL_PREFIXAT']);
end;

procedure T_config.dULTIM_FITXERClick(Sender: TObject);
begin
     ShellExecute(Handle, 'open', PChar('explorer'),PChar(dULTIM_FITXER.Caption), PChar(dULTIM_FITXER.Caption),SW_SHOWNORMAL);
end;

procedure T_config.tCODIS_DE_COLORSReact(Sender: TObject);
begin
     T_codcolor.Create(sender as TComponent).Mostra;
end;

procedure T_config.FormCreate(Sender: TObject);
begin
     AplicarColors := false;
     CanviLlistes  := false;

     _estilcolor.Apply(sender as TCustomForm);
end;

procedure T_config.dESTIL_PREFIXATChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     AplicarColors := true;
end;

procedure T_config.dAPLICAR_COLORSChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     AplicarColors := true;
end;

procedure T_config.dLLISTES_FIXESClick(Sender: TObject);
begin
     CanviLlistes := true;
end;

procedure T_config.dReact(Sender: TObject);
begin
     CanviLlistes := true;
end;

procedure T_config.dLINIES_A_LLISTESClick(Sender: TObject);
begin
     CanviLlistes := true;
end;

procedure T_config.dMARGESClick(Sender: TObject);
begin
     CanviLlistes := true;
end;

procedure T_config.tInfoAmpleReact(Sender: TObject);
begin
     T_ticket.Create(self).ShowModal;
end;

procedure T_config.UText21React(Sender: TObject);
begin
     if mDlg('Posar seqüència d''opertura per defecte?',mtInformation,[mbYes,mbCancel]) = mrYes
     then dSEQ_OPERTURA.Caption := '027 112 000 060 240';
end;

procedure T_config.dAPLICAR_COLORSValueToCaption(Sender: TObject);
begin
     dESTIL_PREFIXAT.Visible := dAPLICAR_COLORS.Value;
end;

procedure T_config.dDATABASEValueToCaption(Sender: TObject);
begin
     dm.CR['DATABASE'] := dDATABASE.Caption;
     dm.CarregaBD;

     _articles.v.Refresh;
     _personals.v.Refresh;
     _averies.v.Refresh;
     _averies.vCArt.Refresh;
     _averies.vCInt.Refresh;
     _ventesA.v.Refresh;
     _ventesA.vC.Refresh;
     _ventesB.v.Refresh;
     _ventesB.vC.Refresh;
     _caixa.v.Refresh;
     _caixa.vC.Refresh;
     _entrades.v.Refresh;
     _entrades.vC.Refresh;
     _magatzem.v.Refresh;
     _poblacions.v.Refresh;
     _marques.v.Refresh;
     _families.v.Refresh;
     _linies.v.Refresh;
     _caveries.vCArt.Refresh;
     _caveries.vCInt.Refresh;
     _cpressupostos.v.Refresh;
     _cventesA.v.Refresh;
     _cventesB.v.Refresh;
     _centrades.v.Refresh;
end;

procedure T_config.UText7React(Sender: TObject);
begin
     T_peinfor.Create(Application).ShowModal;
end;

end.


