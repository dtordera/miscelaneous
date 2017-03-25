unit lectura;

interface

uses ADOdb, dialogs, sysutils, classes, Forms, ComObj, Controls;

          procedure Interpretar_articles_bulk;
          procedure Interpretar_marques;
          procedure Interpretar_Linies;
          procedure Interpretar_Families;
          procedure RestablirArticles;

implementation

uses dmsrc, inifiles, global, main, articles, marques, linies, families, magatzem, carregues;

procedure RestablirArticles;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;
     q.SQL.Text := 'drop table articles';
     q.ExecSQL;
     q.SQL.Text := 'select * into articles from articles_backup';
     q.ExecSQL;

     mDlg('Taula d''articles anterior restablerta',mtInformation,[mbOk]);

     q.Free;

     _articles.v.Refresh;
end;
procedure Crear_Schema_ini_articles(n : string);
var
        s, p : string;
        F : TIniFile;
begin
        s := ExtractFileName(n);        // agafem nom
        p := ExtractFilePath(n);        // agafem path

        F := TiniFile.Create(p + 'schema.ini'); // creem .ini amb esquema d'articles

        F.WriteString(s,'Format','FixedLength');
        F.WriteString(s,'ColNameHeader','False');
        F.WriteString(s,'Col1','id integer width 8');
        F.WriteString(s,'Col2','id_mar integer width 4');
        F.WriteString(s,'Col3','id_fam integer width 4');
        F.WriteString(s,'Col4','DESCR1 char width 30');
        F.WriteString(s,'Col5','DESCR2 char width 32');
        F.WriteString(s,'Col6','PBASE double width 9');
        F.WriteString(s,'Col7','PMIN double width 9');
        F.WriteString(s,'Col8','PREC double width 9');
        F.WriteString(s,'Col9','STOCK char width 1');
        F.WriteString(s,'Col10','DATA char width 11');
        F.WriteString(s,'Col11','MOD char width 1');
        F.WriteString(s,'CharacterSet','ANSI');
        F.Free;
end;

procedure Interpretar_articles_bulk;
     function FToSQLF(s : string) : string;
     begin
          result := FormatFloat('0.0000',strtofloat(s));
          result := StringReplace(result,DecimalSeparator,'.',[rfReplaceAll]);
     end;
var
     s : string;
     p : string;
     b : string;
     sl : TStringList;
     c,t  : TADOConnection;
     q,q2 : TADOQuery;
     op   : TOpenDialog;
begin
     if not _carregues.UProcessos.AfegeixProces('Carregant articles') then
     begin
          mDlg('Aquest procès ja s''està efectuant.',mtInformation,[mbOk]);
          exit;
     end;

     op := TOpendialog.Create(Application);

     op.DefaultExt := '*.txt';              // Obrim opendialog
     op.FileName := 'tarifa.txt';
     op.Filter := 'Fitxers de texte (*.txt)|*.txt|Qualsevol fitxer (*.*)|*.*';
     op.InitialDir := ExtractFilePath(dm.CR['ULTIM_FITXER']);

     if not op.Execute then
     begin
          _carregues.UProcessos.EliminaProces('Carregant articles');
          op.Free;
          exit;
     end;

     sl := TStringList.Create;               // Llista per fer replace directament de caràcters extranys (no s'elimina el dblspace)
     sl.LoadFromFile(op.Filename);
     sl.text := StringReplace(sl.text,'¥','Ñ',[rfReplaceAll,rfIgnoreCase]);
     sl.text := StringReplace(sl.text,'€','Ç',[rfReplaceAll,rfIgnoreCase]);
     sl.SaveToFile(op.Filename);
     sl.Free;

     Crear_Schema_ini_articles(op.Filename);        // Creem schema.ini amb esquema d'articles

     s := ExtractFileName(op.Filename);             // Nom de l'arxiu
     p := ExtractFilePath(op.Filename);             // path de l'arxiu


     _carregues.tCarregarArticles.FixedCaption := '     Creant conexió ';
     Application.ProcessMessages;
     _carregues.tCarregarArticles.Run;

     c := TADOConnection.Create(nil);
     c.Connected := false;                                   // Fem conexió a l'arxiu
     c.LoginPrompt := false;
     c.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";User ID=Admin;'+
        'Data Source='+ ExtractFilePath(op.Filename) + ';Mode=Share Deny None;Extended Properties="text;HDR=Yes;FMT=Fixed";'+
        'Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";'+
        'Jet OLEDB:Engine Type=96;Jet OLEDB:Database Locking Mode=0;Jet OLEDB:Global Partial Bulk Ops=2;'+
        'Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;'+
        'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;'+
        'Jet OLEDB:SFP=False';
     c.Connected := true;

     t := TADOConnection.Create(nil);
     t.Connected := false;
     t.LoginPrompt := false;
     t.ConnectionString := dm.CG.ConnectionString;
     t.Connected := true;

     q  := TADOQuery.Create(nil);
     q2 := TADOQuery.Create(nil);

     _carregues.tCarregarArticles.FixedCaption := '    Fent còpia de seguretat';
     Application.ProcessMessages;
     _carregues.tCarregarArticles.Run;

     try  q.Connection := dm.CG;
          q.SQL.Text := 'drop table articles_backup';
          q.ExecSQL;
     except
     end;

     try  q.Connection := dm.CG;
          q.Active := false;
          q.SQL.Text := 'select * into articles_backup from articles';
          q.ExecSQL;
     except
     on E:EOleException do
     begin
          mDLG(Format('ERROR : No s''ha pogut crear la taula de còpia de seguretat. S''abortarà el procés.'+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);

          _carregues.UProcessos.EliminaProces('Carregant articles');
          _carregues.tCarregarArticles.Caption := '    Carregar articles';
          _carregues.Update;
          exit;
     end
     end;

     _carregues.tCarregarArticles.FixedCaption := '    Borrant dades antigues i t.temporal';    // Pas 2
     Application.ProcessMessages;
     _carregues.tCarregarArticles.Run;

     try
          q2.Connection := t;                                   // Eliminem dades entrades per arxiu
          q2.Active := false;
          q2.SQL.text := 'delete * from ARTICLES where (id < 999999) and (id > 0)';
          q2.ExecSQL;
     except
     end;

     try                                                     // si existeix, ens carreguem taula temporal
          q2.SQL.Text := 'drop table ARTICLES_TMP';
          q2.ExecSQL;
     except
     end;

     _carregues.tCarregarArticles.FixedCaption := '    Carregant i interpretant dades'; // Pas 3
     _carregues.tCarregarArticles.Clear;
     _carregues.Update;
     Application.ProcessMessages;

     b := dm.CR['database'];

     q.Connection := c;                                      // insert massiu a ARTICLES_TMP
     q.Active := false;
     q.SQL.Text :=  'select ' +
                    'id, '+
                    'id_mar, ' +
                    'id_fam, ' +
                    '(select id_lin from FAMILIES in ''' + b + ''' where id = id_fam) as id_lin, '+
                    '(select DESCR from FAMILIES in ''' + b + ''' where id = id_fam) as FAMILIA, ' +
                    '(select DESCR from marques in ''' + b + ''' where id = id_mar) as MARCA, ' +
                    ''''' as LINIA,'+
                    'Trim(IIF(DESCR1,Trim(DESCR1),'''') + '' '' + IIF(DESCR2,Trim(DESCR2),'''')) as DESCR,' +
                    'PMin, ' +
                    'PRec, ' +
                    'PBase, ' +
                    'PMin as PVP,'+
                    'iif(stock = ''&'',true,false) as STOCK,'+
                    '0 as MARGE,'+
                    'PBase * (1 + ' + FToSQLF(dm.CR['IVA_ARTICLES']) + '/100) as PCost,'+
                    '(select MARGE from MARQUES in ''' + b + ''' where id = id_mar) as MARGE_MAR,'+
                    'DATA as DATA_REGISTRE ' +
                    'into ARTICLES_TMP in ''' + b + ''' from ' + s;
     q.ExecSQL;
     t.Connected := False; // Per refresh que es reflecti la nova taula ARTICLES_TMP

     try if FileExists(p + 'schema.ini') then deletefile(p + 'schema.ini'); except end; // eliminem esquema

     _carregues.tCarregarArticles.Run;

     t.Connected := true;

     _carregues.tCarregarArticles.Run;

     q2.SQL.Text := 'delete * from ARTICLES_TMP where id is null'; // Eliminem coses extranyes
     q2.ExecSQL;

     q2.SQL.Text := 'update ARTICLES_TMP set marge_mar = 0 where marge_mar is null';
     q2.ExecSQL;

     _carregues.tCarregarArticles.FixedCaption := '    Pasant a articles'; // Pas 4
     Application.ProcessMessages;
     _carregues.tCarregarArticles.Run;

     q2.Active := False; // Desde la temporal, insertem a ARTICLES
     try
          q2.SQL.Text := 'insert into ARTICLES select distinct * from ARTICLES_TMP';
          q2.ExecSQL;
     except
          q2.SQL.Text := 'select * into ARTICLES from ARTICLES_TMP';
          q2.ExecSQL;
     end;

     _carregues.tCarregarArticles.Run;

     _carregues.tCarregarArticles.FixedCaption := '    Borrant taula temporal';
     Application.ProcessMessages;
     _carregues.tCarregarArticles.Run;

     try   q2.SQL.Text := 'drop table ARTICLES_TMP'; // eliminem taula temporal
           q2.ExecSQL;
     except
     end;

     _carregues.tCarregarArticles.Run;

     _carregues.tCarregarArticles.FixedCaption := '    Establint línies';
     Application.ProcessMessages;
     _carregues.tCarregarArticles.Run;

     _articles.EstablirLinies;

     _carregues.tCarregarArticles.FixedCaption := '    Establint preus';
     Application.ProcessMessages;

     _carregues.tCarregarArticles.Run;

     _articles.CalcularPreus;

     q.Connection := dm.CG;
     q.SQL.Text := 'update articles,articles_backup set articles.codi_barres = articles_backup.codi_barres where articles.descr = articles_backup.descr';
     q.ExecSQL;

     _carregues.tCarregarArticles.Clear;
     _carregues.tCarregarArticles.Caption := '    Fet'; // Ok

     _carregues.UProcessos.EliminaProces('Carregant articles');

     mDlg('Dades d''article carregades',mtInformation,[mbOk]);
     _carregues.tCarregarArticles.Caption := '    Carregar articles';
     _carregues.Update;

     try
          q2.Active := false;
          q2.SQL.Text := 'select * from ARTICLES order by id asc';
          q2.Active := true;
     except
     on E:EOleException do
          mDlg(Format('Les dades s''han carregat i interpretat correctament, però sembla que hi ha algun error de coherència interna a l''arxiu. Utilitzar ''Restaurar articles anteriors'' i ''Comprobar fitxer d''articles'''+#13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
     end;

     q2.Active := false;             // comprobem amb descripció nula
     q2.SQL.Text := 'select * from ARTICLES where (DESCR = '''')';
     q2.Active := true;
     if q2.RecordCount > 0
     then mDlg('S''han trobat articles sense descripció',mtInformation,[mbOk]);

     q2.Active := false;             // comprobem amb marca o familia nula
     q2.SQL.Text := 'select * from ARTICLES where (MARCA = '''') or (FAMILIA = '''')';
     q2.Active := true;
     if q2.RecordCount > 0
     then mDlg('S''han trobat articles sense descripció de marca o de familia. Posiblemente siguin marques, families, encara no entrades',mtInformation,[mbok]);

     q2.Active := false;             // comprobem amb linia nula
     q2.SQL.Text := 'select * from ARTICLES where (LINIA = '''')';
     q2.Active := true;
     if q2.RecordCount > 0
     then mDlg('S''han trobat articles sense descripció de linia. Posiblement siguin línies encara no entrades.',mtInformation,[mbOk]);

     q2.Active := false;
     q2.SQl.Text := 'select * from ARTICLES where PVP = 0';
     q2.Active  := true;
     if (q2.RecordCount > 0)
     and (mDlg('S''han trobat articles amb tots els preus (recomenat, base i mínim) a cero. '+
        'Probablement són articles ja obsolets, tot i que es posible que siguin també conceptes d''ofertes o promocions. '+
        'Eliminar aquests articles de la taula?',mtInformation,[mbYes,mbNo]) = mrYes)
     then _articles.EliminarArticlesObsolets;

     q2.Active := false;
     q2.SQL.Text := 'select * from articles where MARGE <= 0 and pvp <> 0';
     q2.Active := true;

     if q2.RecordCount > 0
     then mDlg('S''han trobat articles amb marge invàlid (negatiu). Això significa que el seu preu de venta es menor que '+
     'el preu de cost.',mtInformation,[mbOk]);

     q2.Active := false;
     q2.SQL.Text := 'select * from articles where PRec = 0 and PMin = 0 and PVP <> 0 and MARGE = ' + FToSQLF(dm.CR['MARGE_DEFECTE']);
     q2.Active  := true;

     if q2.RecordCount > 0
     then mDlg('S''ha aplicat el marge per defecte a diferents articles.',mtInformation,[mbOk]);

     q2.Active := false;
     q2.SQL.Text := 'select * from articles where (PRec <> 0) and (PMin <> 0) and (PCost > PMin) and (PCost > PRec)';
     q2.Active := true;

     if q2.RecordCount > 0
     then mDlg('S''ha aplicat el marge de fàbrica a diferents articles.',mtInformation,[mbOk]);

     _articles.v.Refresh;

     dm.CR['ultim_fitxer'] := op.FileName;
     dm.CR['ultima_data']  := datetostr(FileDateToDateTime(FileAge(s)));
     dm.CR.Save;

     op.Free;
     c.Free;
     t.Free;
     q.Free;
     q2.Free;

     _magatzem.ActualitzarCodisArticles;
     _magatzem.v.Refresh;     
end;

procedure Interpretar_Marques;
var
     sl : TStrings;
     id,descr : string;
     i  : integer;
     q    : TADOQuery;
     op : TOpenDialog;
begin
     if not _carregues.UProcessos.AfegeixProces('Carregant marques') then
     begin
          mDlg('Aquest procès ja s''està efectuant.',mtInformation,[mbOk]);
          exit;
     end;

     op := TOpenDialog.Create(nil);

     op.DefaultExt := '*.txt';              // Obrim opendialog
     op.FileName := 'marques.txt';
     op.Filter := 'Fitxers de texte (*.txt)|*.txt|Qualsevol fitxer (*.*)|*.*';
     op.InitialDir := ExtractFilePath(dm.CR['ultim_fitxer']);

     if not op.Execute then
     begin
          _carregues.UProcessos.EliminaProces('Carregant marques');
          op.Free;
          exit;
     end;

     sl := TStringList.Create;
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     sl.LoadFromFile(op.Filename);
     op.Free;

     q.Active   := false;
     q.SQL.Text := 'select * from MARQUES';
     q.Active   := true;

     for i := 0 to sl.Count - 1 do
     begin
          id    := Copy(sl[i],0,4);
          descr := Copy(sl[i],5,25);

          try strtofloat(id) except continue; end;

          if not q.Locate('id',id,[]) then
          begin
               q.Append;
               q.FieldByName('id').AsString    := id;
               q.FieldByName('descr').AsString := Trim(descr);
               q.FieldByName('marge').AsFloat  := 0;
               q.Post;
          end
          else
          begin
               q.Edit;
               q.FieldByName('descr').AsString := Trim(descr);
               q.Post;
          end;
          Application.ProcessMessages;
          if _carregues.UProcessos.Cancelar then break;

          _carregues.tCarregarMarques.Run;
     end;

     _marques.v.Refresh;

     if _carregues.UProcessos.Cancelar
     then mDlg('Marques no carregades completament',mtWarning,[mbOK])
     else mDlg('Marques carregades.',mtInformation,[mbOk]);

     _carregues.UProcessos.EliminaProces('Carregant marques');
     _carregues.tCarregarMarques.Clear;

     q.Free;
     sl.Free;
end;

procedure Interpretar_Linies;
var
     sl : TStrings;
     id,
     descr : string;
     i     : integer;
     q     : TADOQuery;
     op    : TOpenDialog;
begin
     if not _carregues.UProcessos.AfegeixProces('Carregant línies') then
     begin
          mDlg('Aquest procès ja s''està efectuant.',mtInformation,[mbOk]);
          exit;
     end;

     op := TOpenDialog.Create(nil);

     op.DefaultExt := '*.txt';              // Obrim opendialog
     op.FileName := 'linies.txt';
     op.Filter := 'Fitxers de texte (*.txt)|*.txt|Qualsevol fitxer (*.*)|*.*';
     op.InitialDir := ExtractFilePath(dm.CR['ultim_fitxer']);

     if not op.Execute then
     begin
          _carregues.UProcessos.EliminaProces('Carregant línies');
          op.Free;
          exit;
     end;

     sl := TStringList.Create;
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     sl.LoadFromFile(op.Filename);
     op.Free;

     q.Active   := false;
     q.SQL.Text := 'select * from LINIES';
     q.Active   := true;

     for i := 0 to sl.Count - 1 do
     begin
          id    := Copy(sl[i],0,2);
          descr := Copy(sl[i],3,25);

          try strtofloat(id) except continue; end;

          if not q.Locate('id',id,[]) then
          begin
               q.Append;
               q.FieldByName('id').AsString    := id;
               q.FieldByName('descr').AsString := Trim(descr);
               q.Post;
          end
          else
          begin
               q.Edit;
               q.FieldByName('descr').AsString := Trim(descr);
               q.Post;
          end;
          Application.ProcessMessages;
          if _carregues.UProcessos.Cancelar then break;

          _carregues.tCarregarLinies.Run;
     end;

     if _carregues.UProcessos.Cancelar
     then mDlg('Línies no carregades completament',mtWarning,[mbOK])
     else mDlg('Línies carregades',mtInformation,[mbOk]);

     _linies.v.Refresh;

     _carregues.UProcessos.EliminaProces('Carregant línies');
     _carregues.tCarregarLinies.Clear;

     q.Free;
     sl.Free;
end;

procedure Interpretar_Families;
var
     sl : TStrings;
     id,descr,gama : string;
     i  : integer;
     q  : TADOQuery;
     op : TOpenDialog;
begin
     if not _carregues.UProcessos.AfegeixProces('Carregant famílies') then
     begin
          mDlg('Aquest procès ja s''està efectuant.',mtInformation,[mbOk]);
          exit;
     end;

     op := TOpenDialog.Create(nil);

     op.DefaultExt := '*.txt';              // Obrim opendialog
     op.FileName := 'families.txt';
     op.Filter := 'Fitxers de texte (*.txt)|*.txt|Qualsevol fitxer (*.*)|*.*';
     op.InitialDir := ExtractFilePath(dm.CR['ultim_fitxer']);

     if not op.Execute then
     begin
          _carregues.UProcessos.EliminaProces('Carregant famílies');
          op.Free;
          exit;
     end;

     sl := TStringList.Create;
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     sl.LoadFromFile(op.Filename);
     op.Free;

     q.Active   := false;
     q.SQL.Text := 'delete * from FAMILIES where id < 10000';
     q.ExecSQL;
     q.SQL.Text := 'select * from FAMILIES';
     q.Active := true;

     for i := 0 to sl.Count - 1 do
     begin
          id    := Copy(sl[i],0,4);
          descr := Copy(sl[i],5,35);
          gama  := Copy(sl[i],41,2);

          try strtofloat(id) except continue; end;

          q.Append;
          q.FieldByName('id').AsString    := id;
          q.FieldByName('descr').AsString := Trim(descr);
          q.FieldByName('id_lin').AsString := Trim(gama);
          q.Post;

          Application.ProcessMessages;
          if _carregues.UProcessos.Cancelar then break;
          _carregues.tCarregarFamilies.Run;
     end;

     case _carregues.UProcessos.Cancelar of
     false: mDlg('Famílies carregades.',mtInformation,[mbOk]);
     true : mDlg('Famílies no carregades completament',mtWarning,[mbOk]);
     end;

     _carregues.UProcessos.EliminaProces('Carregant famílies');
     _carregues.tCarregarFamilies.Clear;

     _families.v.Refresh;

     q.Free;
     sl.Free;
end;

end.


