unit ecaixa;

interface

uses Windows, Controls, StdCtrls, UText, ExtCtrls, ULabel, Classes,
  Gradient, Forms, Dialogs, Sysutils, ComObj, Estilcolor;

type TLineaVenta = (lvA,lvB);

type
  T_ecaixa = class(TForm)
    Label4: TLabel;
    tEfectiu: TUText;
    tTargeta: TUText;
    tCredit: TUText;
    dIMPORT: TNLabel;
    dPENDENT: TNLabel;
    dENTREGAT: TNLabel;
    dCANVI: TNLabel;
    tIMPORT: TUText;
    tENTREGAT: TUText;
    Label1: TLabel;
    Bevel1: TBevel;
    GradientNC1: TGradientNC;
    procedure dIMPORTChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure dENTREGATChangeValue(sender: TObject; V: Variant;
      var Cancel: Boolean);
    procedure tEfectiuReact(Sender: TObject);
    procedure tTargetaReact(Sender: TObject);
    procedure tCreditReact(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
          procedure FerEntradaACaixa(tp : Char);
          procedure ActualitzarVenta;
  public
          LineaVenta : TLineaVenta;
          function  Cobrar(id : integer; linea : TLineaVenta) : TModalResult;
          procedure AbonamentTotal(venta : integer; lv : TLineaVenta; cm : string);
          procedure Abonament(venta : integer;linea : TLineaventa);
          procedure ActualitzarTorn;
          procedure EntradaDirecta;
  end;

const
     L : array [TLineaVenta] of char = ('A','B');

implementation

uses ADOdb, dmsrc, caixa, global, etorns, ventesA, ventesB, UDBView,
  eventesA, eventesB, personals, gulib;

{$R *.DFM}

function T_ecaixa.Cobrar(id : integer; linea : TLineaVenta) : TModalResult;
begin
     result := mrCancel;

     case TornObert of
     -1 : begin mDlg('No hi ha cap torn obert. No es pot facturar ni fer abonaments.',mtError,[mbOk]); exit; end;
     -2 : begin mDlg('Hi han varis torns oberts. No es pot facturar cap venta fins que no es resolgui el problema.',mtError,[mbOK]); exit; end;
     end;

     Caption := 'Cobrament de venta #' + inttostr(id);

     LineaVenta := linea;

     case LineaVenta of
     lvA : begin
               dPENDENT.Value  := _ventesA.v.FieldByName('pendent').AsFloat;
               dIMPORT.Value   := dPENDENT.Value;
               dENTREGAT.Value := 0;
               dCANVI.Value    := 0;
           end;
     lvB : begin
               dPENDENT.Value  := _ventesB.v.FieldByName('pendent').AsFloat;
               dIMPORT.Value   := dPENDENT.Value;
               dENTREGAT.Value := 0;
               dCANVI.Value    := 0;
           end;
     end;

     if (dm.CR['OBRIR_CAIXA_AUTO'] = 'SI')
     then Enviar_seq_obertura(dm.CR['SEQ_OPERTURA']);

     result := ShowModal;
end;

procedure T_ecaixa.dIMPORTChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     if not Visible then exit;

     if V > strtofloat(dPENDENT.Caption) then
     begin
          mDlg('Import a cobrar major que import pendent',mtInformation,[mbOk]);
          Cancel := true;
          exit;
     end;

     if dENTREGAT.Value <> 0 then
     dCANVI.Value := dENTREGAT.Value - V;
end;

procedure T_ecaixa.dENTREGATChangeValue(sender: TObject; V: Variant;
  var Cancel: Boolean);
begin
     if not Visible then exit;

     if V < strtofloat(dIMPORT.Caption) then
     begin
          mDlg('Import entregat menor que import a cobrar',mtInformation,[mbOk]);
          Cancel := true;
          exit;
     end;

     if V <> 0 then
     dCANVI.Value := V - dIMPORT.Value;
end;

procedure T_ecaixa.tEfectiuReact(Sender: TObject);
begin
     FerEntradaACaixa('E');
end;

procedure T_ecaixa.tTargetaReact(Sender: TObject);
begin
     FerEntradaACaixa('T');
end;

procedure T_ecaixa.tCreditReact(Sender: TObject);
begin
     FerEntradaACaixa('C');
end;

procedure T_ecaixa.FerEntradaACaixa(tp : Char);
var
     id : integer;
     mr : TModalResult;
     linea : char;
     cobrat    : double;
     base      : double;
     iva       : double;
     descompte : double;
     venta     : integer;
begin
     mr := mrNone;

     case TP of
     'E' : if strtofloat(dENTREGAT.Caption) < strtofloat(dIMPORT.Caption) then
           begin
               mDlg('Import entregat menor que import a cobrar',mtInformation,[mbOk]);
               exit;
           end;
     end;

     cobrat := dIMPORT.Value;
     descompte := 0;

     case LineaVenta of
     lvA :     begin
                    linea := 'A';
                    venta := _ventesA.v.FieldByName('id').AsInteger;
                    base := cobrat / (1 + _ventesA.v.FieldByName('IVA_P').AsFloat/100);
                    iva  := base * _ventesA.v.FieldByName('IVA_P').AsFloat / 100;

                    if (cobrat = dPENDENT.Value)
                    then descompte := _ventesA.v.FieldByName('DESCOMPTE').AsFloat;
               end;
     lvB :     begin
                    linea := 'B';
                    venta := _ventesB.v.FieldByName('id').AsInteger;
                    base := cobrat / (1 + _ventesB.v.FieldByName('IVA_P').AsFloat/100);
                    iva  := base * _ventesB.v.FieldByName('IVA_P').AsFloat / 100;

                    if (cobrat = dPENDENT.Value)
                    then descompte := _ventesB.v.FieldByName('DESCOMPTE').AsFloat;
               end;
     else
          linea := 'C';
          venta := 0;
          base  := cobrat / (1 + strtofloat(dm.CR['IVA_A']) / 100);
          iva   := base * (strtofloat(dm.CR['IVA_A']) / 100);
     end;

     if not _caixa.v.Data.Active then _caixa.v.Data.Active := true;

     try with _caixa.vC.Data.DataSet do
         begin
               id := _caixa.vC.Data.GetNewId;

               Append;
               FieldValues['linea_fact']     := linea;
               FieldValues['venta']          := venta;
               FieldValues['tipus_pagament'] := tp;
               FieldValues['cobrat']         := cobrat;
               FieldValues['base']           := base;
               FieldValues['iva']            := iva;
               if descompte <> 0 then
               FieldValues['descompte']      := descompte;
               FieldValues['id']             := id;
               FieldValues['data']           := now;
               FieldValues['id_torn']        := TornObert;
               Post;
         end;

         mr := mrOK;

         ActualitzarTorn;
         ActualitzarVenta;
     except
     on E:EOleException do
     begin
          mDlg('Error intentant crear nou registre de caixa',mtError,[mbOk]);
          mDlg(Format('Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end
     else
          mDlg('Error intentant crear nou registre de caixa',mtError,[mbOk]);

          mr := mrCancel;
     end;

     _caixa.v.Refresh;
     _caixa.vC.Refresh;

     modalresult := mr;
end;

procedure T_ecaixa.ActualitzarTorn;
var
     c : char;
     id_torn : integer;
     cobrat,
     base,
     iva,
     descompte : double;
     q : TADOQuery;
begin
     c := L[LineaVenta];

     with _caixa.vC.Data.DataSet do
     begin
          id_torn   := FieldByName('id_torn').AsInteger;
          cobrat    := FieldByName('cobrat').AsFloat;
          base      := FieldByName('base').AsFloat;
          iva       := FieldByName('iva').AsFloat;
          descompte := FieldByName('descompte').AsFloat;
     end;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from torns_caixa where id = ' + inttostr(id_torn);
     q.Active   := true;

     if q.RecordCount = 0 then
     begin
          mDlg('ERROR: no s''ha trobat el torn de caixa #' + inttostr(id_torn),
          mtError,[mbOk]);
          q.Free;
          exit;
     end;

     try  q.Edit;
          q.FieldValues['n_ventes_'+c]     := q.FieldByName('n_ventes_'+c).AsInteger + 1;
          q.FieldValues['total_'+c]        := q.FieldByName('total_'+c).AsFloat + cobrat;
          q.FieldValues['base_'+c]         := q.FieldByName('base_'+c).AsFloat + base;
          q.FieldValues['iva_'+c]          := q.FieldByName('iva_'+c).AsFloat + iva;
          q.FieldValues['descomptes_'+c]   := q.FieldByName('descomptes_'+c).AsFloat + descompte;

          q.FieldValues['n_ventes_torn']   := q.FieldByName('n_ventes_torn').AsInteger + 1;
          q.FieldValues['total_torn']      := q.FieldByName('total_torn').AsFloat + cobrat;
          q.FieldValues['base_torn']       := q.FieldByName('base_torn').AsFloat + base;
          q.FieldValues['iva_torn']        := q.FieldByName('iva_torn').AsFloat + iva;
          q.FieldValues['descomptes_torn'] := q.FieldByName('descomptes_torn').AsFloat + descompte;
          q.Post;
     except
     on E:EOleException do
          mDlg(Format('Error intentant actualitzar torn'+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q.Free;
end;

procedure T_ecaixa.ActualitzarVenta;
var
     venta  : integer;
     cobrat : double;
     data_cobro : TDateTime;
     q : TADOQuery;
     c : char;
begin
     c := L[LineaVenta];

     venta  := _caixa.vC.FieldByName('venta').AsInteger;
     cobrat := _caixa.vC.FieldByName('cobrat').AsFloat;
     data_cobro := _caixa.vC.FieldByName('data').AsDateTime;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from ventes'+c + ' where id = ' + inttostr(venta);
     q.Active := true;

     if q.RecordCount = 0 then
     begin
          mDlg('ERROR: no s''ha trobat la referència a venta #'+inttostr(venta),
          mtError,[mbOk]);
          exit;
          q.Free;
     end;

     q.Edit;
     q.FieldValues['A_COMPTE']   := q.FieldByName('A_COMPTE').AsFloat + cobrat;
     q.FieldValues['PENDENT']    := q.FieldByName('PENDENT').AsFloat - cobrat;
     q.FieldValues['DATA_COBRO'] := data_cobro;
     q.FieldValues['PAGADA']     := q.FieldByName('PENDENT').AsFloat = 0;
     q.Post;

     case LineaVenta of
     lvA : begin
               _ventesA.v.Refresh;
               _personals.ActualitzarDades(_ventesA.v.FieldByName('id_CLI').AsInteger);
               _personals.Refresh;
          end;
     lvB : begin
               _ventesB.v.Refresh;
               _personals.ActualitzarDades(_ventesB.v.FieldByName('id_CLI').AsInteger);
               _personals.Refresh;
          end;
     end;

     q.Free;
end;

procedure T_ecaixa.AbonamentTotal(venta : integer; lv : TLineaVenta; cm : string);
var
     id : integer;
     q  : TADOQuery;
     c  : char;
     base,
     iva,
     cobrat,
     descompte : double;
begin
     c := L[lv];

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;
     q.Active   := false;
     q.SQL.Text := 'select * from ventes'+c + ' where id = ' + inttostr(venta);
     q.Active   := true;

     cobrat := q.FieldByName('a_compte').AsFloat;
     base   := cobrat / (1 + q.FieldByName('IVA_P').AsFloat / 100);
     iva    := (q.FieldByName('IVA_P').AsFloat * cobrat) / (100 + q.FieldByName('IVA_P').AsFloat);

     if q.FieldByName('PAGADA').AsBoolean
     then descompte := q.FieldByName('descompte').AsFloat
     else descompte := 0;

     if q.RecordCount = 0 then
     begin
          mDlg('Error : venta #' + inttostr(venta) + ' no trobada',mtError,[mbOk]);
          q.Free;
          exit;
     end;

     id := _caixa.vC.Data.GetNewId;

     with _caixa.vC.Data.DataSet do
     begin
          Append;
          FieldValues['id']             := id;
          FieldValues['linea_fact']     := c;
          FieldValues['venta']          := venta;
          FieldValues['tipus_pagament'] := 'A';
          FieldValues['cobrat']         := cobrat;
          FieldValues['base']           := base;
          FieldValues['iva']            := iva;
          if descompte <> 0 then
          FieldValues['descompte']      := descompte;
          FieldValues['comentari']      := cm;
          FieldValues['data']           := q.FieldByName('data').AsDateTime;
          FieldValues['id_torn']        := TornObert;
          Post;
     end;

     _caixa.vC.Refresh;

     if (dm.CR['OBRIR_CAIXA_AUTO'] = 'SI')
     then Enviar_seq_obertura(dm.CR['SEQ_OPERTURA']);

     mDlg('ABONAMENT (venta #' + inttostr(venta) + ') . Import a abonar : ' + FormatFloat('0.00',-cobrat),mtInformation,[mbOk]);

     q.Free;

     ActualitzarTorn;
end;

procedure T_ecaixa.Abonament(venta : integer;linea : TLineaventa);
var
     q  : TADOQuery;
     c  : char;
begin
     c := L[Linea];

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from ventes'+c + ' where id = ' + inttostr(venta);
     q.Active   := true;

     dPENDENT.Value := q.FieldByName('PENDENT').AsFloat;
     dIMPORT.Value  := q.FieldByName('TOTAL').AsFloat;
     LineaVenta := linea;
     FerEntradaACaixa('A');

     if dm.CR['OBRIR_CAIXA_AUTO'] = 'SI'
     then Enviar_seq_obertura(dm.CR['SEQ_OPERTURA']);

     mDlg('ABONAMENT (venta #' + inttostr(venta) + ') . Import a abonar : ' + FormatFloat('0.00',-dIMPORT.Value),mtInformation,[mbOk]);

     q.Free;
end;

procedure T_ecaixa.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TForm);
end;

procedure T_ecaixa.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_ecaixa.EntradaDirecta;
var
     im  : double;
     com : string;
     id  : integer;
     q   : TADOQuery;
begin
     if mDlg('Fer entrada directa a caixa?',mtInformation,[mbYes,mbNo]) <> mrYes then exit;

     im := gULib.NumberIn('Import','0.00');

     if im = 0 then exit;

     if dm.CR['OBRIR_CAIXA_AUTO'] = 'SI'
     then Enviar_seq_obertura(dm.CR['SEQ_OPERTURA']);

     com := gULib.TextIn('Comentari');

     id := _caixa.vC.Data.GetNewId;

     with _caixa.vC.Data.Dataset do
     begin
          Append;
          FieldValues['id'] := id;
          FieldValues['linea_fact'] := 'd';
          FieldValues['venta'] := 0;
          FieldValues['cobrat'] := im;
          FieldValues['comentari'] := com;
          FieldValues['data'] := now;
          FieldValues['id_torn'] := TornObert;
          Post;
     end;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from torns_caixa where id = ' + inttostr(TornObert);
     q.Active   := true;

     if q.RecordCount = 0 then
     begin
          mDlg('ERROR: no s''ha trobat el torn de caixa #' + inttostr(TornObert),
          mtError,[mbOk]);
          q.Free;
          exit;
     end;

     try  q.Edit;
          q.FieldValues['total_directe'] := q.FieldByName('total_directe').AsFloat + im;
          q.Post;
     except
     on E:EOleException do
          mDlg(Format('Error intentant actualitzar torn'+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q.Free;

     _caixa.v.Refresh;
     _caixa.vC.Refresh;
end;

procedure T_ecaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : ModalResult := mrCancel;
     end;
end;

end.
