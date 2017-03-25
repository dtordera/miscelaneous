unit resmtrn;

interface

uses sysutils, Escpos, Windows, Controls, Forms, StdCtrls, UText, ULabel, Classes, Gradient, ADOdb;

type TAccioVResum = (avVeure,avImprimir);

type
  T_resmtrn = class(TForm)
    UText3: TUText;
    T: TBLabel;
    B: TBLabel;
    UText2: TUText;
    UText1: TUText;
    A: TBLabel;
    btVeureAPantalla: TUText;
    btImprimir: TUText;
    GradientNC1: TGradientNC;
    tNomesTotals: TUText;
    dNomesTotals: TBLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btVeureAPantallaReact(Sender: TObject);
    procedure btImprimirReact(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
     AccioVResum : TAccioVResum;
     AmpleChar : integer;
     sC,
     sN,
     sQ,
     sR : TStrings;
     sP : TStrings;
     q : TADOQuery;
     procedure ResumTorn;
     procedure PreparaForm;
     procedure FerResumTorn;
     procedure PreparaN;
     procedure PreparaC;
     procedure PreparaQ;
     procedure PreparaR;
     procedure PreparaP;
     procedure ImprimirResum;
     procedure ImprimirResum_2;
end;

implementation

{$R *.DFM}

uses dmsrc, global, vresum, caixa, estilcolor;

procedure T_resmtrn.ResumTorn;
begin
     PreparaForm;
     ShowModal;
end;

procedure T_resmtrn.FerResumTorn;
var
     ss : TStrings;
     i  : integer;
begin
     PreparaC;
     PreparaN;
     PreparaQ;
     PreparaR;
     PreparaP;

     ss := TStringList.Create;

     with T_vresum.Create(self) do
     begin
          m.Lines.Clear;

          try ss.LoadFromFile(BINDIR + 'STP\tl.tck'); except ss.Clear; end;
          for i := 0 to ss.Count - 1
          do ss[i] := Centrar(ss[i],AmpleChar);

          m.Lines.AddStrings(ss);

          try ss.LoadFromFile(BINDIR + 'STP\es.tck'); except ss.Clear; end;
          for i := 0 to ss.Count - 1 do
          ss[i] := Centrar(ss[i],AmpleChar);
          m.Lines.AddStrings(ss);

          m.Lines.AddStrings(sC);

          if not dNomesTotals.Value then m.Lines.AddStrings(sN);

          m.Lines.AddStrings(sQ);

          m.Lines.AddStrings(sR);
          m.Lines.AddStrings(sP);
          m.Lines.Add('');
          m.Lines.Add('');
          m.Lines.Add('');

          case AccioVResum of
          avVeure :
          begin
               ClientWidth  := Canvas.TextWidth('X')  * AmpleChar + 3 + GetSystemMetrics(SM_CXVSCROLL);
               ClientHeight := Canvas.TextHeight('X') * (m.Lines.Count + 1);

               if ClientHeight > 700 then ClientHeight := 700;

               ShowModal;
          end;
          avImprimir :
          begin
               ClientWidth  := 2000;
               Imprimir;
          end;
          end;
     end;

     ss.Free;
end;

procedure T_resmtrn.PreparaN;
var
     s : string;
begin
     sN.Clear;

     if not A.Value then s := ' and (linea_fact <> ''A'')';
     if not B.Value then s := s + ' and (linea_fact <> ''B'')';

     q.Active   := false;
     q.SQL.Text := 'select * from c_caixa where (id_torn = ' + _caixa.v.FieldByName('id').AsString + ')' + s + ' order by id asc';
     q.Active   := true;
     q.First;

     sN.Add(' CONCEPTES : ');
     sN.Add('');
     sN.Add(Centrar('ref.  hora  L P   cobrat   iva   desc',AmpleChar));
     sN.Add(Rc('-',AmpleChar-1));

     while not q.Eof do
     begin
          s := ' ' + FormatFloat('00000',q.FieldByName('id').AsInteger);
          s := s + ' ' + FormatDateTime('hh:nn',q.FieldByName('data').AsDateTime);
          s := s + ' ' + q.FieldByName('linea_fact').AsString;

          if q.FieldByName('tipus_pagament').AsString <> ''
          then s := s + ' ' + q.FieldByName('tipus_pagament').AsString
          else s := s + '  ';

          s := s + ' ' + Dreta(FormatFloat('0.00',q.FieldByName('COBRAT').AsFloat),8);
          s := s + ' ' + Dreta(FormatFloat('0.00',q.FieldByName('IVA').AsFloat),6);
          s := s + ' ' + Dreta(FormatFloat('0.00',q.FieldByName('DESCOMPTE').AsFloat),5);

          sN.Add(Centrar(s,AmpleChar-1));
          q.Next;
     end;

     sN.Add(Rc('-',AmpleChar-1));
end;

procedure T_resmtrn.PreparaC;
begin
     sC.Clear;

// if ESCPOS then ...

     sC.Add('');
     sC.Add(Centrar('RESUM DE TORN ' + _caixa.v.FieldByName('id').AsString,AmpleChar));
     sC.Add(Rc('-',AmpleChar-1));
     sC.Add(Centrar('Opertura  : ' + FormatDateTime('ddddd (h:nn)',_caixa.v.FieldByName('obertura').AsDateTime),AmpleChar));

     if _caixa.v.FieldByName('Tancat').AsBoolean
     then sC.Add(Centrar('Tancament : ' + FormatDateTime('ddddd (h:nn)',_caixa.v.FieldByName('tancament').AsDateTime),AmpleChar))
     else sC.Add('   Torn actiu');

     if _caixa.v.FieldByName('reobert').Asboolean
     then sC.Add('   Torn reobert');

     sC.Add(Rc('-',AmpleChar - 1));
end;

procedure T_resmtrn.PreparaQ;
var
     tA,tB,tT,
     iA,iB,iT,
     dA,dB,dT,
     bA,bB,bT,
     aA,aB,aT,
     eA,eB,eT,
     cA,cB,cT,
     gA,gB,gT : double;

     stA,stB,stT,
     siA,siB,siT,
     sdA,sdB,sdT,
     sbA,sbB,sbT,
     saA,saB,saT,
     seA,seB,se_T,
     scA,scB,scT,
     sgA,sgB,sgT : string;

     TlA,TlB,TlT : string;
const
     l : integer = 10;
begin
     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as eA from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''A'' and tipus_pagament = ''E''';
     q.Active := true;

     eA := q.FieldByName('eA').AsFloat;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as eB from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''B'' and tipus_pagament = ''E''';
     q.Active := true;

     eB := q.FieldByName('eB').AsFloat;

     eT := eA + eB;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as cA from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''A'' and tipus_pagament = ''C''';
     q.Active := true;

     cA := q.FieldByName('cA').AsFloat;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as cB from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''B'' and tipus_pagament = ''C''';
     q.Active := true;

     cB := q.FieldByName('cB').AsFloat;

     cT := cA + cB;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as gA from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''A'' and tipus_pagament = ''T''';
     q.Active := true;

     gA := q.FieldByName('gA').AsFloat;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as gB from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''B'' and tipus_pagament = ''T''';
     q.Active := true;

     gB := q.FieldByName('gB').AsFloat;

     gT := gA + gB;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as aA from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''A'' and cobrat < 0';
     q.Active := true;

     aA := q.FieldByName('aA').AsFloat;

     q.Active := false;
     q.SQL.Text := 'select sum(cobrat) as aB from c_caixa where id_torn = ' + _caixa.v.FieldByName('id').AsString + ' and linea_fact = ''B'' and cobrat < 0';
     q.Active := true;

     aB := q.FieldByName('aB').AsFloat;

     aT := aA + aB;

     tA := _caixa.v.FieldByName('total_A').AsFloat;
     tB := _caixa.v.FieldByName('total_B').AsFloat;
     tT := _caixa.v.FieldByName('total_Torn').AsFloat;

     bA := _caixa.v.FieldByName('base_A').AsFloat;
     bB := _caixa.v.FieldByName('base_B').AsFloat;
     bT := _caixa.v.FieldByName('base_Torn').AsFloat;

     iA := _caixa.v.FieldByName('IVA_A').AsFloat;
     iB := _caixa.v.FieldByName('IVA_B').AsFloat;
     iT := _caixa.v.FieldByName('IVA_Torn').AsFloat;

     dA := _caixa.v.FieldByName('descomptes_A').AsFloat;
     dB := _caixa.v.FieldByName('descomptes_B').AsFloat;
     dT := _caixa.v.FieldByName('descomptes_Torn').AsFloat;


     if A.Value then
     begin
          stA := Dreta(FormatFloat('0.00',tA),L);
          sbA := Dreta(FormatFloat('0.00',bA),L);
          siA := Dreta(FormatFloat('0.00',iA),L);
          sdA := Dreta(FormatFloat('0.00',dA),L);
          saA := Dreta(FormatFloat('0.00',aA),L);
          seA := Dreta(FormatFloat('0.00',eA),L);
          scA := Dreta(FormatFloat('0.00',cA),L);
          sgA := Dreta(FormatFloat('0.00',gA),L);
          TlA := Dreta('Linia A',L);
     end
     else
     begin
          stA := RC(' ',L);
          sbA := RC(' ',L);
          siA := RC(' ',L);
          sdA := RC(' ',L);
          saA := RC(' ',L);
          seA := RC(' ',L);
          scA := RC(' ',L);
          sgA := RC(' ',L);
          TlA := RC(' ',L);
     end;

     if B.Value then
     begin
          stB := Dreta(FormatFloat('0.00',tB),L);
          sbB := Dreta(FormatFloat('0.00',bB),L);
          siB := Dreta(FormatFloat('0.00',iB),L);
          sdB := Dreta(FormatFloat('0.00',dB),L);
          saB := Dreta(FormatFloat('0.00',aB),L);
          seB := Dreta(FormatFloat('0.00',eB),L);
          scB := Dreta(FormatFloat('0.00',cB),L);
          sgB := Dreta(FormatFloat('0.00',gB),L);
          TlB := Dreta('Linia B',L);
     end
     else
     begin
          stB := RC(' ',L);
          sbB := RC(' ',L);
          siB := RC(' ',L);
          sdB := RC(' ',L);
          saB := RC(' ',L);
          seB := RC(' ',L);
          scB := RC(' ',L);
          sgB := RC(' ',L);
          TlB := RC(' ',L);
     end;

     if T.Value then
     begin
          stT := Dreta(FormatFloat('0.00',tT),L);
          sbT := Dreta(FormatFloat('0.00',bT),L);
          siT := Dreta(FormatFloat('0.00',iT),L);
          sdT := Dreta(FormatFloat('0.00',dT),L);
          saT := Dreta(FormatFloat('0.00',aT),L);
          se_T := Dreta(FormatFloat('0.00',eT),L);
          scT := Dreta(FormatFloat('0.00',cT),L);
          sgT := Dreta(FormatFloat('0.00',gT),L);
          TlT := Dreta('Torn',L);
     end
     else
     begin
          stT := RC(' ',L);
          sbT := RC(' ',L);
          siT := RC(' ',L);
          sdT := RC(' ',L);
          saT := RC(' ',L);
          se_T := RC(' ',L);
          scT := RC(' ',L);
          sgT := RC(' ',L);
          TlT := RC(' ',L);
     end;

//          1234567890123456789012345678901234567890

     sQ.Clear;
     sQ.Add(' TOTALS : ');
     sQ.Add('');
     sQ.Add(RC(' ',9) + TlA + TlB + TlT);
     sQ.Add(RC('-',AmpleChar - 1));
     sQ.Add(' Efectiu ' + seA + seB + se_T);
     sQ.Add(' Targeta ' + sgA + sgB + sgT);
     sQ.Add(' Credit  ' + scA + scB + scT);
     sQ.Add('');
     sQ.Add(' Abonam. ' + saA + saB + saT);
     sQ.Add('');
     sQ.Add(' BASE    ' + sbA + sbB + sbT);
     sQ.Add(' I.V.A.  ' + siA + siB + siT);
     sQ.Add(' TOTAL   ' + stA + stB + stT);
     sQ.Add(' Descomp.' + sdA + sdB + sdT);
end;

procedure T_resmtrn.PreparaP;
var
     s : string;
begin
     sP.Clear;
     sP.Add(RC('-',AmpleChar - 1));

     s := '';
     if A.Value then s := s + 'A';
     if B.Value then s := s + 'B';
     if T.Value then s := s + 'T';

     sP.Add(Centrar('(' + s + ') resum a ' + FormatDateTime('ddddd (h:nn)',now),AmpleChar));

     sP.Add(RC('-',AmpleChar - 1));
end;

procedure T_resmtrn.PreparaR;
begin
     sR.Clear;
     sR.Add('');
     sR.Add(Centrar('(moviments directes  : ' + FormatFloat('0.00',_caixa.v.FieldByName('total_directe').AsFloat) + ')', AmpleChar));
end;

procedure T_resmtrn.PreparaForm;
begin
     ClientHeight := tNomesTotals.Top + tNomesTotals.height + 15 + ClientHeight - btVeureAPantalla.Top;
end;

procedure T_resmtrn.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);

     AmpleChar := strtoint(dm.CR['AMPLE_TICKET_C']);

     sC := TStringList.Create;
     sN := TStringList.Create;
     sQ := TStringList.Create;
     sR := TStringList.Create;
     sP := TStringList.Create;

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;
end;

procedure T_resmtrn.FormDestroy(Sender: TObject);
begin
     q.Free;

     sP.Free;
     sR.Free;
     sQ.Free;
     sN.Free;
     sC.Free;
end;

procedure T_resmtrn.btVeureAPantallaReact(Sender: TObject);
begin
     AccioVResum := avVeure;
     FerResumTorn;
end;

procedure T_resmtrn.btImprimirReact(Sender: TObject);
begin
     AccioVResum := avImprimir;
     FerResumTorn;
     Close;
end;

procedure T_resmtrn.ImprimirResum;
begin
     AccioVResum := avImprimir;
     FerResumTorn;
end;

procedure T_resmtrn.ImprimirResum_2;
begin
     AccioVResum := avImprimir;
     FerResumTorn;
     FerResumTorn;
end;


procedure T_resmtrn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : modalresult := mrCancel;
     end;
end;

end.