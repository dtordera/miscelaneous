unit econcepte;

interface

uses Windows, UDBAlter, Controls, StdCtrls, UText, UDBLabel, ULabel,
  Estilcolor, Dialogs, ExtCtrls, Classes, Gradient, Forms, db, graphics, UDBView, Sysutils;

type TTipusForm = (tcpressupostos,tcVentesA,tcVentesB,tcAveArt,tcAveInt,tcEntrades);
type TTipusForms = set of TTipusForm;

type T_econcepte = class(TForm)
          Bevel1: TBevel;
          btAnterior: TUText;
          btSeguent: TUText;
          btEntrar: TUText;
          tCONCEPTE: TUText;
          dID_ELEM: TNLabel;
          tPREU: TUText;
          tUTS: TUText;
          dUTS: TNLabel;
          UDBAlterForm: TUDBAlterForm;
          GradientNC1: TGradientNC;
          dIMPORT: TNLabel;
          dLINIA: TULabel;
          dID: TNLabel;
          tNouArticle: TUText;
          dID_LIN: TNLabel;
          tTIPUS_CONCEPTE: TUText;
          dTIPUS_CONCEPTE: TMLabel;
          dID_REF: TNLabel;
          dCONCEPTE_DESCR: TXLabel;
          dCONCEPTE: TUDBLabel;
    UText1: TUText;
    tRefLligada: TUText;
    tImport: TUText;
    dPREU: TNLabel;
          procedure dID_LINChange(Sender: TObject);
          procedure UDBAlterFormBeforePost(sender: TObject; var Stop: Boolean);
          procedure dTIPUS_CONCEPTEChangeValue(sender: TObject; V: Variant;
          var Cancel: Boolean);
          procedure UDBAlterFormAfterLoadValues(Sender: TObject);
          procedure dPREUChangeValue(sender: TObject; V: Variant;
          var Cancel: Boolean);
          procedure dUTSChangeValue(sender: TObject; V: Variant;
          var Cancel: Boolean);
          procedure UDBAlterFormGetNewId(sender: TObject; var Id: Integer);
          procedure UDBAlterFormLoadDefValues(Sender: TObject);
          procedure dLINIASetInnerCaption(Sender: TObject);
          procedure FormKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
          procedure dCONCEPTESetInnerCaption(Sender: TObject);
          procedure FormCreate(Sender: TObject);
    procedure tNouArticleReact(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dCONCEPTEShowPickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
     private
          OriginForm : TCustomForm;
          TipusForm : TTipusForm;
          procedure PreparaFormSegonsTipus(U : Tudbview);
          procedure DefaultValues;
     public
          function Nou(U : Tudbview) : TModalResult;
          function Modificar(U : Tudbview) : TModalResult;
          function Eliminar(U : Tudbview)  : TModalResult;
end;

implementation

uses epressupostos, dmsrc, ADOdb, eventesA, eventesB, eentrades, ventesA, global, eaveries,
  earticles, articles,econcepteaux;

{$R *.DFM}

function T_econcepte.Nou(U : Tudbview) : TModalResult;
begin
     PreparaFormSegonsTipus(U);
     result := UDBAlterForm.New;
end;

function T_econcepte.Modificar(U : Tudbview) : TModalResult;
begin
     PreparaFormSegonsTipus(U);

     DefaultValues;

     result := UDBAlterForm.Modify;
end;

function T_econcepte.Eliminar(U : Tudbview) : TModalResult;
begin
     PreparaFormSegonsTipus(U);
     result := UDBAlterForm.Delete;
end;

procedure T_econcepte.PreparaFormSegonsTipus(U : Tudbview);
var
     F : TCustomForm;
begin
     F := U.Owner as TCustomForm;
     
     if F is T_epressupostos then
     begin
          TipusForm := tcpressupostos;
          Caption := 'Conceptes de pressupost';
          ClientHeight := 250;
     end
     else
     if F is T_eventesA then
     begin
          TipusForm := tcVentesA;
          Caption := 'Conceptes de venta';
          ClientHeight := 250;
     end
     else
     if F is T_eventesB then
     begin
          TipusForm := tcVentesB;
          Caption := 'Conceptes de venta B';
          ClientHeight := 250;
     end
     else
     if F is T_eentrades then
     begin
          TipusForm := tcEntrades;
          Caption := 'Conceptes d''entrada';
          ClientHeight := 250;
     end
     else
     if F is T_eaveries then
     begin
          if U.Name = 'vCArt' then
          begin
               TipusForm := tcAveArt;
               Caption := 'Conceptes a reparar';
               ClientHeight := 200;
          end
          else
          if U.Name = 'vCInt' then
          begin
               TipusForm := tcAveInt;
               Caption := 'Intervencions realitzades / Material';
               ClientHeight := 200;
          end;
     end;

     tPREU.Visible := not ((TipusForm = tcAveArt) or (TipusForm = tcAveInt));
     tIMPORT.Visible := tPREU.Visible;

     dUTS.Visible := tUTS.Visible;
     dPREU.Visible := tPREU.Visible;
     dIMPORT.Visible := tIMPORT.Visible;

     OriginForm := F;
     UDBAlterForm.UDBView := U;
     GradientNC1.SendToBack;
end;

procedure T_econcepte.DefaultValues;
const
     S : array [TTipusForm] of string = ('de pressupost','de venta ','de venta (B)','conceptes','intervencions','d''entrada');
     T : array [boolean] of string = ('PVP','PCost');
     C : array [boolean] of string = ('&preu de venta','&preu de cost');
begin
     dIMPORT.Value := 0;
     dPREU.Value := 0;
     dUTS.Value := 1;
     dCONCEPTE.Caption := '(descripció d''article)';
     dCONCEPTE_DESCR.Caption := '(descripció lliure)';
     dID_ELEM.Value := 0;
     dLINIA.Caption := '(línia no assignada)';
     dID_LIN.Value  := 0;

     dTIPUS_CONCEPTE.ItemIndex := 0;

     case TipusForm of
     tcAveArt,
     tcAveInt      : dID_REF.Value := (OriginForm as T_eaveries).dID.Value;
     tcpressupostos : dID_REF.Value := (OriginForm as T_epressupostos).dID.Value;
     tcVentesA     : dID_REF.Value := (OriginForm as T_eventesA).dID.Value;
     tcVentesB     : dID_REF.Value := (OriginForm as T_eventesB).dID.Value;
     tcEntrades    : dID_REF.Value := (OriginForm as T_eentrades).dID.Value;
     end;

     dCONCEPTE.DerivedFields.Values['dPREU'] := T[TipusForm = tcEntrades];
     dCONCEPTE.Data.Connection := dm.CG;
     tPREU.Caption := C[TipusForm = tcEntrades];

     tRefLligada.Caption := 'ref. ' + S[TipusForm];
end;

procedure T_econcepte.dID_LINChange(Sender: TObject);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from linies where id = ' + floattostr(dID_LIN.Value);
     q.Active := true;

     if q.RecordCount > 0
     then dLINIA.Caption := q.FieldByName('DESCR').AsString
     else dLINIA.Caption := '(línia no assignada)';

     q.Free;
end;

procedure T_econcepte.UDBAlterFormBeforePost(sender: TObject;
  var Stop: Boolean);
begin
     if ((dCONCEPTE.Caption = '(descripció d''article)') and (dTIPUS_CONCEPTE.ItemIndex = 0))
     or ((dCONCEPTE_DESCR.Caption = '(descripció lliure)') and (dTIPUS_CONCEPTE.ItemIndex = 1))
     then
     Stop := mDlg('No s''ha entrat cap article ni descripció. Continuar de totes maneres?',mtInformation,[mbYes,mbNo]) <> mrYes;

     if (not Stop) and (dUTS.Value = 0) then
     Stop := mDlg('El nombre d''unitats es cero. Continuar de totes maneres?',mtInformation,[mbYes,mbNo]) <> mrYes;

     if dTIPUS_CONCEPTE.ItemIndex = 1 then
     begin
          dCONCEPTE.Caption := dCONCEPTE_DESCR.Caption;
          dID_ELEM.Value := 0;
     end;
end;

procedure T_econcepte.dTIPUS_CONCEPTEChangeValue(sender: TObject;
  V: Variant; var Cancel: Boolean);
begin
     dCONCEPTE.Visible := V = 0;

     dID_ELEM.Visible := dCONCEPTE.Visible;
     dID_LIN.Visible  := dCONCEPTE.Visible;
     dLINIA.Visible   := dCONCEPTE.Visible;

     dCONCEPTE_DESCR.Visible := not dID_ELEM.Visible;

     tNouArticle.Visible := dCONCEPTE.Visible;

     if V = 0
     then tCONCEPTE.LinkedControl := dCONCEPTE
     else tCONCEPTE.LinkedControl := dCONCEPTE_DESCR;
end;

procedure T_econcepte.UDBAlterFormAfterLoadValues(Sender: TObject);
const
     v : array [boolean] of integer = (0,1);
begin
     UDBAlterForm.DeApplyOnChange;

     dTIPUS_CONCEPTE.ItemIndex := v[dID_ELEM.Value = 0];

     if dTIPUS_CONCEPTE.ItemIndex = 1 then
     begin
          dCONCEPTE_DESCR.Caption := dCONCEPTE.Caption;
          dCONCEPTE.Caption := '(descripció d''article)';
     end;

     UDBAlterForm.ApplyOnChange;
end;

procedure T_econcepte.dPREUChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     dIMPORT.Value := dUTS.Value * V;
end;

procedure T_econcepte.dUTSChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     dIMPORT.Value := dPREU.Value * V;
end;

procedure T_econcepte.UDBAlterFormGetNewId(sender: TObject;
  var Id: Integer);
var
     q : TADOQuery;
     s : string;
begin
     case TipusForm of
     tcpressupostos : s := 'c_pressupostos';
     tcVentesA     : s := 'c_ventesA';
     tcVentesB     : s := 'c_ventesB';
     tcEntrades    : s := 'c_entrades';
     tcAveArt      : s := 'c_aveart';
     tcAveInt      : s := 'c_aveint';
     end;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select max(id) + 1 as maxim from ' + s;
     q.Active := true;

     id := Max(id,q.FieldByName('maxim').AsInteger);

     q.Free;
end;

procedure T_econcepte.UDBAlterFormLoadDefValues(Sender: TObject);
begin
     DefaultValues;
end;

procedure T_econcepte.dLINIASetInnerCaption(Sender: TObject);
begin
     dID_LIN.Left := dLINIA.Left + dLINIA.Width + 7;
end;

procedure T_econcepte.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
     end;
end;

procedure T_econcepte.dCONCEPTESetInnerCaption(Sender: TObject);
begin
     dID_ELEM.Left := dCONCEPTE.Left + dCONCEPTE.Width + 7;
end;

procedure T_econcepte.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
     dCONCEPTE.Data.Connection := dm.CG;
end;

procedure T_econcepte.tNouArticleReact(Sender: TObject);
begin
     if T_earticles.Create(self).Nou_ = mrOk then
     begin
          dTIPUS_CONCEPTE.ItemIndex := 0;
          dCONCEPTE.Caption := _articles.v.FieldByName('descr').AsString;
          dID_ELEM.Value    := _articles.v.FieldByName('id').AsInteger;
          dID_LIN.Value     := _articles.v.FieldByName('id_lin').AsInteger;
          dPREU.Value       := _articles.v.FieldByName('PVP').AsFloat;
     end;
end;

procedure T_econcepte.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_econcepte.dCONCEPTEShowPickForm(sender: TObject;
  F: TCustomForm; U: TUDBView);
begin
     U.Look.Assign(_articles.v.Look);

     case TipusForm of
     tcEntrades : U.AssignColumnInfo(cENTRADA,vEntrada);
     tcVentesA,
     tcVentesB,
     tcPressupostos : U.AssignColumnInfo(cPRESSUPOST,vPRESSUPOST);
     tcAveArt,
     tcAveInt       : U.AssignColumnInfo(cAVERIES,vAVERIES);
     end;
end;

end.
