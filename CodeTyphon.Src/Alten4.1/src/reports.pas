unit reports;

interface

uses Windows, FR_DSet, FR_DBSet, DB, ADODB, FR_Class, ExtCtrls, FR_View,
  StdCtrls, UText, Classes, Forms, Controls, FPanel, sysutils, Dialogs, gulib;

type TClaseReport = (crVentesA,crVentesB,crpressupostos,crAveries);

type
  T_reports = class(TForm)
    rep: TfrReport;
    FPanel1: TFPanel;
    tImprimir: TUText;
    frPreview: TfrPreview;
    q: TADOQuery;
    r: TADOQuery;
    tTamany: TMUText;
    frDataDetail: TfrDBDataSet;
    frDataMaster: TfrDBDataSet;
    UText3: TUText;
    UText4: TUText;
    UText6: TUText;
    UText7: TUText;
    UText8: TUText;
    UText9: TUText;
    btCancel: TButton;
    s: TADOQuery;
    frDataDetail2: TfrDBDataSet;
    tCopies: TUText;
    procedure FormCreate(Sender: TObject);
    procedure tImprimirReact(Sender: TObject);
    procedure UText3React(Sender: TObject);
    procedure UText4React(Sender: TObject);
    procedure UText5React(Sender: TObject);
    procedure UText6React(Sender: TObject);
    procedure UText7React(Sender: TObject);
    procedure UText9React(Sender: TObject);
    procedure tTamanyReact(Sender: TObject);
    procedure UText8React(Sender: TObject);
    procedure tCopiesReact(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UText1React(Sender: TObject);
  private
     VCopies : integer;
     procedure LoadValues;
     procedure LoadBody;
     procedure LoadDetails;
     procedure LoadDetails2;
     procedure LoadReport;
     procedure BorraTemporals;
     procedure PreparaReport;
     procedure SetVCopies(C : integer);
  public
     AdjustaraA4      : boolean;
     Preparant_report : boolean;
     ClaseReport : TClaseReport;
     id : integer;
     procedure VeureVentesA;
     procedure VeureVentesB;
     procedure Veurepressupost;
     procedure VeureAveries;
     procedure PosaCaption;
     property  Copies : integer read VCopies write SetVCopies;
end;

implementation

{$R *.dfm}

uses estilcolor, repaux, dmsrc, ventesA, UDbgridLT, printers, modprint, global,
  main, ventesB, pressupostos, averies;

procedure T_reports.LoadValues;
begin
     LoadBody;
     LoadDetails;
     LoadDetails2;
end;

procedure T_reports.SetVCopies(C : integer);
begin
     VCopies := C;
     tCopies.Caption := '    &Còpies : ' + inttostr(C);
end;

procedure T_reports.LoadBody;
var
     d : TDataSet;
     s : string;
     ss : TStrings;
begin
     d := nil;
     case ClaseReport of
     crVentesA     : d := _ventesA.v.Data.DataSet;
     crVentesB     : d := _ventesB.v.Data.DataSet;
     crpressupostos : d := _pressupostos.v.Data.DataSet;
     crAveries     : d := _averies.v.Data.DataSet;
     end;

     ss := TStringList.Create;

     id := d.FieldByName('id').AsInteger;

     s := '_CLI';

     q.connection := dm.CT;
     r.Connection := dm.CT;

     q.SQL.Text := 'delete * from Reporttemp';
     q.ExecSQL;

     q.SQL.Text := 'select * from ReportTemp';
     q.Active   := true;

     q.Append;

     case ClaseReport of
     crVentesA : q.FieldValues['id_data'] := 'ref. #'+ FormatFloat('000000',d.FieldByName('id').AsFloat);
     crVentesB : q.FieldValues['id_data'] := 'ref. #'+ FormatFloat('B000000',d.FieldByName('id').AsFloat);
     crpressupostos : q.FieldValues['id_data'] := 'pressupost #' + FormatFloat('000000',d.FieldByName('id').AsFloat);
     crAveries : q.FieldValues['id_data'] := 'PARTE D''AVERIA #' + FormatFloat('000000',d.FieldByName('id').AsFloat);
     end;

     q.FieldValues['id_data'] := q.FieldValues['id_data'] + '-' + FormatDateTime('ddddd',d.FieldByName('data').AsDateTime);

     q.FieldValues['NOM_NIF'] := d.FieldByName('NOM'+s).AsString;

     if d.FieldByname('nif'+s).AsString <> '' then
     q.FieldValues['NOM_NIF'] := q.FieldValues['NOM_NIF'] + ' (' + d.FieldByName('nif'+s).AsString + ')';

     q.FieldValues['DIR_TEL'] := d.FieldByName('DIR'+s).AsString;

     if d.FieldByName('tel'+s).AsString <> '' then
     begin
          if q.FieldValues['dir_tel'] <> '' then q.FieldValues['dir_tel'] := q.FieldValues['dir_tel'] + '; ';

          q.FieldValues['dir_tel'] := q.FieldValues['dir_tel'] + d.FieldByName('tel'+s).AsString;
     end;

     q.FieldValues['pob_cp'] := d.FieldByName('pob'+s).AsString;

     if d.FieldByname('cp'+s).AsString <> '' then
     q.FieldValues['pob_cp'] := q.FieldValues['pob_cp'] + ' - ' + d.FieldByname('cp'+s).AsString;

     if ClaseReport in [crVentesA,crVentesB,crpressupostos] then
     begin
          q.FieldValues['BASE'] := FormatFloat('0.00',d.FieldByname('BASE').AsFloat);
          q.FieldValues['IVA']  := FormatFloat('0.00',d.FieldByname('IVA').AsFloat);
          q.FieldValues['IVA_P'] := 'I.V.A. (' + d.FieldByName('IVA_P').AsString + '%)';
          q.FieldValues['SUBTOTAL'] := FormatFloat('0.00',d.FieldByName('SUBTOTAL').AsFloat);

          q.FieldValues['TOTAL']    := FormatFloat('0.00€',d.FieldByname('TOTAL').AsFloat);

          if d.FieldByName('descompte').AsFloat <> 0 then
          begin
               q.FieldValues['descompte'] := FormatFloat('0.00',-d.FieldByName('descompte').AsFloat);
               q.FieldValues['descompte_p'] := 'Descompte (' + FormatFloat('0.00',d.FieldByName('descompte_p').AsFloat) + '%)';
          end;
     end
     else
     if ClaseReport in [crAveries] then
          q.FieldValues['ANOMALIES'] := d.FieldByName('ANOMALIES').AsString;

     q.FieldValues['OBSERVACIONS'] := d.FieldByName('OBSERVACIONS').AsString;

     try
          ss.LoadFromFile(BINDIR + 'STP\es.inf');
          q.FieldValues['ESTAB'] := ss.Text;
     except
          q.FieldValues['ESTAB'] := 'Jaume I, 3 - 17300 BLANES (Girona)'#13#10+
                                    'Tel.972 33 0346 - Fax 972 33 6211';
     end;

     case ClaseReport of
     crVentesA,
     crVentesB :
     begin
          if d.FieldByName('TOTAL').AsFloat < 0 then
          begin
               q.FieldValues['INFO_AB_COB'] := 'ABONAMENT';
               q.FieldValues['TOTAL_P'] := 'ABONAMENT';
          end
          else
          if d.FieldByName('PAGADA').Asboolean then
          q.FieldValues['INFO_AB_COB'] := 'COBRAT - ' + FormatDateTime('ddddd',d.FieldByName('data_cobro').AsDateTime);

          if dm.CR['MOSTRAR_A_COMPTE_PENDENT'] = 'SI' then
          begin
               if (d.FieldByName('A_COMPTE').AsFloat <> 0) and not d.FieldByName('PAGADA').Asboolean
               then q.FieldValues['A_COMPTE'] := '(a compte a ' + Formatdatetime('ddddd',date) + ', ' + FormatFloat('0.00',d.FieldByname('A_COMPTE').AsFloat) + '€ )';

               if d.FieldByName('PENDENT').AsFloat > 0
               then q.FieldValues['EN_DEUTE']   := '(deute a ' + Formatdatetime('ddddd',date) + ', ' + FormatFloat('0.00',d.FieldByName('PENDENT').AsFloat) + '€ )';
          end;

          if d.FieldByName('ABONADA').AsBoolean then
               q.FieldValues['INFO_AB_COB'] := 'AMB ABONAMENTS';

          try
               ss.LoadFromFile(BINDIR + 'STP\pi.inf');
               q.FieldValues['PEU'] := ss.Text;
          except
               q.FieldValues['PEU'] := 'MILAR BLANES - ELÈCTRICA BLANDENSE, SL. N.I.F. B17376757';
          end;
     end;
     crpressupostos :
     begin
          q.FieldValues['TOTAL_P'] := 'pressupost';
          if d.FieldByName('REALITZAT').AsBoolean then
          q.FieldValues['INFO_AB_COB'] := 'REALITZAT';

          if d.FieldByName('REF_FACTURA').AsInteger <> 0 then
          q.FieldValues['INFO_AB_COB'] := q.FieldValues['INFO_AB_COB'] + '(fact. ' + d.FieldByName('REF_FACTURA').AsString + ')';

          if d.FieldByName('PEU').AsString <> ''
          then q.FieldValues['PEU'] := d.FieldByName('PEU').AsString
          else q.FieldValues['PEU'] := 'MILAR BLANES - ELÈCTRICA BLANDENSE, SL. N.I.F. B17376757';
     end;
     crAveries :
     begin
          if d.FieldByName('GARANTIA').AsBoolean then q.FieldValues['GARANTIA'] := 'SÍ' else q.FieldValues['GARANTIA'] := 'NO';

          q.FieldValues['ENTR'] := 'Data d''entrada : ' + Formatdatetime('ddddd',d.FieldByName('DATA_ENTRADA').AsDateTime);

          if d.FieldByName('DATA_ENTREGA').AsString <> '' then
          q.FieldValues['ENTR'] :=  + q.FieldValues['ENTR'] + ' (entrega aprox. : ' + Formatdatetime('ddddd',d.FieldByName('DATA_ENTREGA').AsDateTime) + ')';

          if d.FieldByName('REP_A_DOMICILI').AsBoolean then
          begin
               q.FieldValues['REP_A_DOMICILI'] := 'Reparació a domicili. Día ' + Formatdatetime('ddddd',d.FieldByName('DATA_VISITA').AsDateTime);
               if d.FieldByName('DISP_HOR').AsString <> '' then q.FieldValues['REP_A_DOMICILI'] := q.FieldValues['REP_A_DOMICILI'] + ' (disponibilitat horaria : ' + d.FieldByName('DISP_HOR').AsString + ')';
          end;

          if d.FieldByName('REP_EXTERNA').AsBoolean then
          begin
               q.FieldValues['REP_EXTERNA'] := 'Reparació externa. ';
               if d.FieldByName('NOM_REP').AsString <> '' then q.FieldValues['REP_EXTERNA'] := q.FieldValues['REP_EXTERNA'] + 'Reparador : ' + d.FieldByName('NOM_REP').AsString;

               if d.FieldByName('ENVIAT').AsBoolean
               then q.FieldValues['REP_EXTERNA'] := q.FieldValues['REP_EXTERNA'] + ' (enviat el ' + Formatdatetime('ddddd',d.FieldByName('DATA_ENVIAMENT').AsDateTime) + ')';
          end;

          if d.FieldByName('REP_FINALITZADA').AsBoolean
          then q.FieldValues['REP_FINALITZADA'] := '--- REPARACIÓ FINALITZADA ---';

          if d.FieldByName('DATA_REPARACIO').AsString <> ''
          then q.FieldValues['REP_FINALITZADA'] := q.FieldValues['REP_FINALITZADA'] + ' (' + FormatDateTime('ddddd',d.FieldByName('DATA_REPARACIO').AsDateTime) + ')';

          if d.FieldByName('REF_FACTURA').AsInteger <> 0
          then q.FieldValues['PRESSUPOST_FACTURA'] := 'Factura ' + d.FieldByName('REF_FACTURA_LIN').AsString + FormatFloat('000000',d.FieldByName('REF_FACTURA').AsInteger);

          if d.FieldByName('OBSERVACIONS').AsString <> ''
          then q.FieldValues['OBSERVACIONS'] := 'Observacions : ' + d.FieldByName('OBSERVACIONS').AsString;
     end;
     end;

     ss.Free;

     q.Post;

     q.Active := false;
     q.SQL.Text := 'select * from ReportTemp';
     q.Active := true;
end;

procedure T_reports.LoadDetails;
var
     s : string;
     q2 : TADOQuery;
     id_elem,
     concepte,
     uts,
     preu,
     import : string;
begin
     r.SQL.Text := 'delete * from c_reportTemp';
     r.ExecSQL;

     r.Active := false;
     r.SQL.Text := 'select * from c_ReportTemp';
     r.Active := true;

     q2 := TADOQuery.Create(nil);
     q2.Connection := dm.CG;

     case ClaseReport of
     crVentesA     : s := 'c_ventesA';
     crVentesB     : s := 'c_ventesB';
     crpressupostos : s := 'c_pressupostos';
     crAveries     : s := 'c_aveart';
     end;

     q2.SQL.Text := 'select * from ' + s + ' where id_ref = ' + inttostr(id) + ' order by id asc';
     q2.Active := true;
     q2.First;

     while not q2.Eof do
     begin
          if q2.FieldByName('id_elem').AsInteger <> 0
          then id_elem := q2.FieldByName('id_elem').AsString
          else id_elem := '---';

          if ClaseReport in [crVentesA,crVentesB,crpressupostos] then
          begin
               preu    := FormatFloat('0.00',q2.FieldByName('preu').AsFloat);
               import  := FormatFloat('0.00',q2.FieldByName('import').AsFloat);
          end;

          if q2.FieldByName('uts').AsInteger <> q2.FieldByName('uts').AsFloat
          then uts := FormatFloat('0.0',q2.FieldByName('uts').AsFloat)
          else uts := FormatFloat('0',q2.FieldByName('uts').AsInteger);

          concepte := q2.FieldByName('concepte').AsString;

          r.Append;
          r.FieldValues['id_elem']  := id_elem;
          r.FieldValues['concepte'] := concepte;
          r.FieldValues['uts'] := uts;
          r.FieldValues['preu'] := preu;
          r.FieldValues['import'] := import;
          r.Post;

          q2.Next;
     end;

     q2.Free;

     r.Active := false;
     r.SQL.Text := 'select * from c_ReportTemp';
     r.Active := true;

     AdjustaraA4 := r.RecordCount > 10;
end;

procedure T_reports.PosaCaption;
var
     s : string;
begin
     case ClaseReport of
     crVentesA : s := 'Venta ';
     crVentesB : s := 'Venta B ';
     crpressupostos : s := 'pressupost ';
     crAveries : s := 'Averia ';
     end;

     Caption := s + inttostr(id);
end;

procedure T_reports.LoadDetails2;
var
     q2 : TADOQuery;
     id_elem,
     concepte,
     uts : string;
begin
     if ClaseReport <> crAveries then exit;

     s.SQL.Text := 'delete * from c_reportTemp2';
     s.ExecSQL;

     s.Active := false;
     s.SQL.Text := 'select * from c_ReportTemp2';
     s.Active := true;

     q2 := TADOQuery.Create(nil);
     q2.Connection := dm.CG;

     q2.SQL.Text := 'select * from c_aveint where id_ref = ' + inttostr(id) + ' order by id asc';
     q2.Active := true;
     q2.First;

     while not q2.Eof do
     begin
          if q2.FieldByName('id_elem').AsInteger <> 0
          then id_elem := q2.FieldByName('id_elem').AsString
          else id_elem := '---';

          if q2.FieldByName('uts').AsInteger <> q2.FieldByName('uts').AsFloat
          then uts := FormatFloat('0.0',q2.FieldByName('uts').AsFloat)
          else uts := FormatFloat('0',q2.FieldByName('uts').AsInteger);

          concepte := q2.FieldByName('concepte').AsString;

          s.Append;
          s.FieldValues['id_elem']  := id_elem;
          s.FieldValues['concepte'] := concepte;
          s.FieldValues['uts'] := uts;
          s.Post;

          q2.Next;
     end;

     q2.Free;

     s.Active := false;
     s.SQL.Text := 'select * from c_ReportTemp2';
     s.Active := true;

     AdjustaraA4 := True;
end;

procedure T_reports.Veurepressupost;
begin
     ClaseReport := crpressupostos;
     tTamany.Visible   := true;
     PreparaReport;
     ShowModal;
end;

procedure T_reports.VeureAveries;
begin
     ClaseReport := crAveries;
     tTamany.Visible   := true;
     PreparaReport;
     ShowModal;
end;

procedure T_reports.PreparaReport;
begin
     Preparant_report := true;
     if ClaseReport in [crAveries,crpressupostos,crVentesA,crVentesB]
     then Rep.InitialZoom := pzOnePage
     else Rep.InitialZoom := pzPageWidth;

     Copies := strtoint(dm.CR['COPIES_INF']);     

     LoadValues;
     LoadReport;

     PosaCaption;
     Preparant_report := false;
end;

procedure T_reports.VeureVentesA;
begin
     ClaseReport := crVentesA;
     tTamany.Visible   := true;
     tTamany.ItemIndex := 0;

     PreparaReport;

     ShowModal;
end;

procedure T_reports.VeureVentesB;
begin
     ClaseReport := crVentesB;
     tTamany.Visible   := true;
     tTamany.ItemIndex := 0;

     PreparaReport;

     ShowModal;
end;

procedure T_reports.BorraTemporals;
begin
     q.Active := false;
     q.SQL.Text := 'delete * from ReportTemp';
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_reportTemp';
     q.ExecSQL;
end;

procedure T_reports.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
     frPreview.DoubleBuffered := true;
end;

procedure T_reports.LoadReport;
var
     b : boolean;
const
     N : array [TClaseReport] of string = ('vA','vA','vA','Av');
     O : array [boolean] of TPrinterOrientation = (poLandscape,poPortrait);
     P : array [boolean] of integer = (dmPAPER_A5,dmPAPER_A4);
     T : array [boolean] of integer = (0,1);
begin
     Rep.PrintToDefault := false;
     rep.LoadFromFile(BINDIR + 'FRF\' + N[ClaseReport]+'.frf');

     rep.ChangePrinter(-1,Printer.Printers.IndexOf(dm.CR['IMPRESORA_1']));

     b := (ClaseReport in [crpressupostos,crAveries]) or AdjustarAA4;

     if (Rep.Pages[0].pgSize <> P[b])
     then rep.Pages[0].ChangePaper(P[b],0,0,O[b]);

     rep.PrepareReport;

     if (rep.Pages.Count > 1) and (Rep.Pages[0].pgSize <> dmPAPER_A4) then
     begin
          AdjustaraA4 := true;
          LoadReport;
     end;

     rep.ShowPreparedReport;

     tTamany.ItemIndex := T[Rep.Pages[0].pgSize = dmPAPER_A4];
     tTamany.Visible   := (Rep.Pages[0].pgSize = dmPAPER_A4) or (Rep.Pages[0].pgSize = dmPAPER_A5);
end;

procedure T_reports.tImprimirReact(Sender: TObject);
begin
     rep.Title := 'Alten41_'+stringreplace(Caption,' ','_',[rfReplaceAll]);

     if rep.PrepareReport
     then rep.PrintPreparedReport('',Copies)
     else mDlg('Error intentant imprimir informe',mtError,[mbOk]);
end;

procedure T_reports.UText3React(Sender: TObject);
begin
     frPreview.PageWidth;
end;

procedure T_reports.UText4React(Sender: TObject);
begin
     frPreview.OnePage;
end;

procedure T_reports.UText5React(Sender: TObject);
begin
     frPreview.Edit;
end;

procedure T_reports.UText6React(Sender: TObject);
begin
     frPreview.Zoom := frPreview.Zoom * 2;
end;

procedure T_reports.UText7React(Sender: TObject);
begin
     frPreview.Zoom := frPreview.Zoom / 2;
end;

procedure T_reports.UText8React(Sender: TObject);
var
     d : TDataSet;
begin
     if Preparant_report then exit;

     d := nil;
     case ClaseReport of
     crVentesA     : d := _ventesA.v.Data.DataSet;
     crVentesB     : d := _ventesB.v.Data.DataSet;
     crpressupostos : d := _pressupostos.v.Data.DataSet;
     crAveries     : d := _averies.v.Data.DataSet;
     end;

     d.Prior;
     PreparaReport;
end;

procedure T_reports.UText9React(Sender: TObject);
var
     d : TDataSet;
begin
     if Preparant_report then exit;

     d := nil;
     case ClaseReport of
     crVentesA     : begin d := _ventesA.v.Data.DataSet; end;
     crVentesB     : begin d := _ventesB.v.Data.DataSet; end;
     crpressupostos : begin d := _pressupostos.v.Data.DataSet; end;
     crAveries     : d := _averies.v.Data.DataSet;
     end;

     d.Next;
     PreparaReport;
end;

procedure T_reports.tTamanyReact(Sender: TObject);
var
     b : boolean;
const
     O : array [boolean] of TPrinterOrientation = (poLandscape,poPortrait);
     P : array [boolean] of integer = (dmPAPER_A5,dmPAPER_A4);
begin
     if Preparant_report then exit;

     b := tTamany.ItemIndex = 1;

     if Rep.Pages[0].pgSize <> P[b] then
          rep.Pages[0].ChangePaper(P[b],0,0,O[b]);

     rep.ShowReport;
end;

procedure T_reports.tCopiesReact(Sender: TObject);
begin
     Copies := integer(Round(gULib.NumberIn('Còpies',inttostr(Copies))));
end;

procedure T_reports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     BorraTemporals;
end;

procedure T_reports.UText1React(Sender: TObject);
begin
     Rep.Designreport;
end;

end.
