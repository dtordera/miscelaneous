unit tanctorn;

interface

uses Windows, Dialogs, Forms, Classes, controls, sysutils;

procedure TancarTorn;
procedure ReobrirTorn;

implementation

uses caixa, global, main, resmtrn, etorns;

procedure TancarTorn;
begin
     if _caixa.v.FieldByName('TANCAT').AsBoolean then
     begin
          mDlg('Aquest torn ja est� tancat.',mtInformation,[mbOk]);
          exit;
     end;

     if mDlg('Tancar torn ' + _caixa.v.FieldByName('id').AsString + '?',mtInformation,[mbYes,mbCancel]) <> mrYes
     then exit;

     with _caixa.v.Data.DataSet do
     begin
          Edit;
          FieldByName('TANCAT').AsBoolean := true;
          FieldByName('TANCAMENT').AsDateTime := now;
          Post;
          mDlg('S''ha tancat el torn de caixa actiu.',mtInformation,[mbOk]);
          _main.PosaCaption;
     end;

     _caixa.v.Refresh;

     case mDlg('Imprimir resum?',['&1 c�pia','&2 c�pies','&No']) of
     mrYes : {1} T_resmtrn.Create(Application).ImprimirResum;
     mrNo  : {2} T_resmtrn.Create(Application).ImprimirResum_2;
     mrCancel : {No} ;
     end;
end;

procedure ReobrirTorn;
begin
     if TornObert > -1
     then
     begin
          mDlg('Hi ha el torn ' + inttostr(TornObert) + ' obert. No es pot reobrir cap torn fins que no es tanqui l''actiu actual.',mtError,[mbOK]);
          exit;
     end;

     if mDlg('Reobrir torn ' + _caixa.v.FieldByName('id').AsString + '?',mtInformation,[mbYes,mbNo]) <> mrYes
     then exit;

     with _caixa.v.Data.Dataset do
     begin
          Edit;
          FieldValues['tancat']  := false;
          FieldValues['reobert'] := true;
          Post;
     end;

     _caixa.v.Refresh;

     _main.PosaCaption;
     mDlg('Torn ' + inttostr(TornObert) + ' reobert',mtInformation,[mbOk]);
end;

end.
