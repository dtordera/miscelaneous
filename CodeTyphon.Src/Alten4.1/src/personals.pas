unit personals;

interface

uses Windows, Gradient, Dialogs, ULabel, ComObj, UText, sysutils,
     Menus, UDBView, DB, ADOdb, Graphics, Forms, Controls, StdCtrls,
     Classes, ExtCtrls, FPanel, EstilColor;

type TAccioEscollint = (aeEsperant,aeCancelar,aeEfectuar);

type
  T_personals = class(TForm)
    PopupMenu1: TPopupMenu;
    Modificar1: TMenuItem;
    Eliminararticle1: TMenuItem;
    N1: TMenuItem;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    N2: TMenuItem;
    Anara1: TMenuItem;
    Ventesrelacionades1: TMenuItem;
    VentesBrelacionades1: TMenuItem;
    Averiesrelacionades1: TMenuItem;
    pressupostosrelacionats1: TMenuItem;
    Entradesrelacionades1: TMenuItem;
    pCaption: TFPanel;
    lbCaption: TLabel;
    v: TUDBView;
    Filtresdefinits1: TMenuItem;
    Repetitsaalguncamp1: TMenuItem;
    Msdedosanysinactiu1: TMenuItem;
    Recalculardeute1: TMenuItem;
    Fusionardosregistres1: TMenuItem;
    Mostrarrepetits1: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    Ambdeute1: TMenuItem;
    N5: TMenuItem;
    ltimaacci1: TMenuItem;
    procedure AnulaFusio(Sender : TObject);
    procedure EfectuaFusio(Sender : TObject);
    procedure vDelete(Sender: TObject);
    procedure vInsert(Sender: TObject);
    procedure vReturn(Sender: TObject);
    procedure NoupersonalClick(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminararticle1Click(Sender: TObject);
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    function  FerFusio(id1 : string) : boolean;
    procedure FusioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReactTextsFusio(sender : TObject);
    function  PreguntarFusio(c : string; s : array of string) : string;
    procedure VentesArelacionades1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
     procedure MostraMenu;
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Msdedosanysinactiu1Click(Sender: TObject);
    procedure Recalculardeute1Click(Sender: TObject);
    procedure Fusionardosregistres1Click(Sender: TObject);
    procedure Repetitsaalguncamp1Click(Sender: TObject);
    procedure Mostrarrepetits1Click(Sender: TObject);
    procedure VentesBrelacionades1Click(Sender: TObject);
    procedure Averiesrelacionades1Click(Sender: TObject);
    procedure pressupostosrelacionats1Click(Sender: TObject);
    procedure Entradesrelacionades1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure Ambdeute1Click(Sender: TObject);
    procedure ltimaacci1Click(Sender: TObject);
  private
     AccioEscollint : TAccioEscollint;
  public
     procedure ReassignaReferenciaClient(idori,idnew : string);
     procedure ActualitzarRepeticions;
     procedure ActualitzarDades(id : integer); overload;
     procedure ActualitzarDades; overload;
     procedure FusionarRegistres;
     procedure RepetitFiltre;
     procedure MesDosAnys;
     procedure Repetits;
     function RegistreAssociat : boolean;
end;

var
  _personals: T_personals;

implementation

{$R *.DFM}

uses dmsrc, normalit, main, global, earticles, epersonals,
  ventesA, eventesA, ventesB, averies, pressupostos, entrades, carregues;

function T_personals.RegistreAssociat : boolean;
var
     q : TADOQuery;
begin
     result := false;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from ventesA where id_cli = ' + v.FieldByName('id').AsString;
     q.Active := true;

     result := result or (q.RecordCount > 0);

     if result then begin q.Free; exit; end;

     q.Active := false;
     q.SQL.Text := 'select * from ventesB where id_cli = ' + v.FieldByName('id').AsString;
     q.Active := true;

     result := result or (q.RecordCount > 0);

     if result then begin q.Free; exit; end;

     q.Active := false;
     q.SQL.Text := 'select * from entrades where id_prv = ' + v.FieldByName('id').AsString;
     q.Active := true;

     result := result or (q.RecordCount > 0);

     if result then begin q.Free; exit; end;

     q.Active := false;
     q.SQL.Text := 'select * from averies where id_cli = ' + v.FieldByName('id').AsString;
     q.Active := true;

     result := result or (q.RecordCount > 0);

     if result then begin q.Free; exit; end;

     q.Active := false;
     q.SQL.Text := 'select * from pressupostos where id_cli = ' + v.FieldByName('id').AsString;
     q.Active := true;

     result := result or (q.RecordCount > 0);

     if result then begin q.Free; exit; end;

     q.Active := false;
     q.SQL.Text := 'select * from averies where id_rep = ' + v.FieldByName('id').AsString;
     q.Active := true;

     result := result or (q.RecordCount > 0);

     q.Free;
end;

procedure T_personals.vDelete(Sender: TObject);
begin
     _main.OnDelete(sender);
end;

procedure T_personals.vInsert(Sender: TObject);
begin
     _main.OnInsert(sender);
end;

procedure T_personals.vReturn(Sender: TObject);
begin
     _main.OnReturn(sender);
end;

procedure T_personals.NoupersonalClick(Sender: TObject);
begin
     v.PushInsert;
end;

procedure T_personals.Modificar1Click(Sender: TObject);
begin
     v.PushReturn;
end;

procedure T_personals.Eliminararticle1Click(Sender: TObject);
begin
     v.PushDelete;
end;

procedure T_personals.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_personals.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_personals.MesDosAnys;
begin
     v.Data.Filter := 'where (' + FormatSQLDate(date) + ' - ULTIMA_ACCIO > 730) and ULTIMA_ACCIO <> ' + FormatSQLDate(0);
     v.Caption.Variable := 'més de dos anys inactius';
end;

procedure T_personals.Repetits;
begin
     v.Data.Filter := 'where (REPETIT > 0)';
     v.Caption.Variable := 'repetits';
end;

procedure T_personals.Ambdeute1Click(Sender: TObject);
begin
     v.Data.Filter := 'where (EN_DEUTE <> 0)';
     v.Caption.Variable := 'amb deute';
end;



procedure T_personals.ActualitzarRepeticions;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'update personals set repetit = 0';
     q.ExecSQL;

     q.SQL.Text := 'update personals set repetit = 1 where personals.nom in '+
     '(select nom from personals as Tmp group by nom having count(*) > 1) and personals.nom <> ''''';
     q.ExecSQL;

     q.SQL.Text := 'update personals set repetit = repetit + 1 where personals.nif in '+
     '(select nif from personals as Tmp group by nif having count(*) > 1) and personals.nif <> ''''';
     q.ExecSQL;

     q.SQL.Text := 'update personals set repetit = repetit + 1 where personals.dir in '+
     '(select dir from personals as Tmp group by dir having count(*) > 1) and personals.dir <> ''''';
     q.ExecSQL;

     q.SQL.Text := 'update personals set repetit = repetit + 1 where personals.tel in ' +
     '(select tel from personals as Tmp group by tel having count(*) > 1) and personals.tel <> ''''';
     q.ExecSQL;

     q.Free;
end;

procedure T_personals.RepetitFiltre;
var
     NOM,TEL,DIR,NIF,f : string;
begin
     NOM := Trim(v.FieldByName('NOM').AsString);
     DIR := Trim(v.FieldByName('DIR').AsString);
     TEL := Trim(v.FieldByName('TEL').AsString);
     NIF := Trim(v.FieldByName('NIF').AsString);

     f := 'where (NOM = ' + AnsiquotedStr(NOM,'''') + ')';

     if TEL <> '' then f := f + ' or (TEL = ' + AnsiquotedStr(TEL,'''') + ')';
     if NIF <> '' then f := f + ' or (NIF = ' + AnsiQuotedStr(NIF,'''') + ')';
     if DIR <> '' then f := f + ' or (DIR = ' + AnsiquotedStr(DIR,'''') + ')';

     v.Data.Filter := f;
     v.Caption.Variable := 'semblant a ' + NOM + ' (' + DIR + ';' + TEL + ';' + NIF + ')';
end;

procedure T_personals.AnulaFusio(sender : TObject);
begin
     AccioEscollint := aeCancelar;
end;

procedure T_personals.FusioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     VK_ESCAPE : (sender as TForm).ModalResult := mrCancel;
     49,50,51,52 : (sender as TForm).Tag := Key - 48;
     end;

     Key := 0;
end;

procedure T_personals.ReactTextsFusio(sender : TObject);
begin
     ((sender as TUText).Owner as TForm).Tag := strtoint(Copy((sender as TUText).Caption,2,1)) - 1;
     ((sender as TUText).Owner as TForm).Modalresult := mrOk;
end;

function T_personals.PreguntarFusio(c : string; s : array of string) : string;
var
     f : TForm;
     l : TLabel;
     t : array of TUText;
     u : TTLabel;
     i : integer;
     g : TGradientNC;
begin
     result := 'fusió abortada';

     f := TForm.Create(self);
     f.BorderStyle := bsToolWindow;
     f.OnKeyDown := FusioKeyDown;
     f.Position := poDesktopCenter;
     f.ClientWidth := 520;
     f.Caption := '   ' + AnsiUppercase(c);
     f.Color := _main.Llistes.Color;

     setlength(t,length(s) + 1);

     l := TLabel.Create(f);
     l.Parent := f;
     l.Transparent := true;
     l.Left := 10;
     l.Top  := 10;
     l.Caption := 'Seleccioni el nou valor per al camp ' + AnsiUppercase(c);
     l.Font.Color := _main.tTitolArticles.Font.Color;

     g := TGradientNC.Create(f);
     g.Parent := f;
     g.Left  := 80;
     g.Align := alNone;
     g.Width := ClientWidth - g.Left;
     g.Visible := true;
     g.ColorInicial := _main.fonsmain.ColorInicial;
     g.ColorFinal   := _main.fonsmain.ColorFinal;
     g.Direccio := TDireccio(E);
     g.SendToBack;

     for i := 0 to High(t) - 1 do
     begin
          t[i] := TUText.Create(f);
          t[i].Parent := f;
          t[i].Left := 20;
          t[i].Width := f.ClientWidth - t[i].Left - 20;
          t[i].Top  := 40 + i*20;
          t[i].Height := 19;
          t[i].OnReact := ReactTextsFusio;
          t[i].Caption := '&' + inttostr(i+1) + ' - ' + s[i];
          t[i].ReactAndActive := false;
          t[i].SelectAndNext  := false;
          t[i].TextStyleDefault.Assign(_main.tArticles.TextStyleDefault);
          t[i].TextStyleMouseOver.Assign(_main.tArticles.TextStyleMouseOver);
          t[i].TextStyleSelected.Assign(_main.tArticles.TextStyleSelected);
          t[i].Color := _main.tArticles.Color;
          t[i].Font.Color := _main.tArticles.Font.Color;
     end;

     i := High(t);

     t[i] := TUText.Create(f);
     t[i].Parent := f;
     t[i].Left := 20;
     t[i].Width := f.ClientWidth - t[i].Left - 20;
     t[i].Top  := 40 + i*20;
     t[i].Height := 19;
     t[i].OnReact := ReactTextsFusio;
     t[i].Caption := '&'+inttostr(i+1)+' - Entrar nou valor';
     t[i].ReactAndActive := false;
     t[i].SelectAndNext  := false;
     t[i].DefaultReact := true;
     t[i].TextStyleDefault.Assign(_main.tArticles.TextStyleDefault);
     t[i].TextStyleMouseOver.Assign(_main.tArticles.TextStyleMouseOver);
     t[i].TextStyleSelected.Assign(_main.tArticles.TextStyleSelected);
     t[i].Color := _main.tArticles.Color;
     t[i].Font.Color := _main.tArticles.Font.Color;

     u := TTLabel.Create(self);
     u.Parent := f;
     u.AutoSize := true;
     u.Left := t[i].Left + 80;
     u.Top  := t[i].Top;
     u.Transparent := true;
     u.ColorMouseOver := T_eventesA.Create(Application).dNOM_CLI.ColorMouseOver;
     u.Font.Color := l.Font.Color;
     u.QWidth := 400;
     u.LabelCase := ecUpperCase;
     u.Question := 'Nou valor per al camp ' + c;

     t[i].LinkedControl := u;

     f.ClientHeight := t[i].Top + t[i].Height + 30;
     g.Height := ClientHeight;

     f.ActiveControl := t[0];
     f.DoubleBuffered := true;
     f.Invalidate;

     if f.ShowModal = mrOk
     then if f.tag = High(t)
          then result := u.Caption
          else result := Copy(t[f.tag].Caption,6,1000);

     f.Release;
end;

function T_personals.FerFusio(id1 : string) : boolean;
     function TrobaCP(pb : string) : string;
     var
          q : TADOQuery;
     begin
          q := TADOQuery.Create(nil);
          q.Connection := dm.CG;

          q.Active := false;
          q.SQL.Text := 'select * from poblacions where poblacio = ''' + pb + '''';
          q.Active := true;

          if q.RecordCount > 0
          then result := q.FieldByName('CP').AsString
          else result := '';

          q.Free;
     end;
var
     id2,id : string;
     nom,dir,tel,nif,pob,cp,obs : array [0..2] of string;
     ua : array [0..2] of TDateTime;
     mesnou     : integer;
     s : string;
const
     SS : array [0..1] of string = ('primer','segon');
begin
     result := false;

     with v do
     begin
          id2  := FieldByName('id').AsString;
          nom[1] := Trim(FieldByName('nom').AsString);
          dir[1] := Trim(FieldByName('dir').AsString);
          tel[1] := Trim(FieldByName('tel').AsString);
          nif[1] := Trim(FieldByName('nif').AsString);
          pob[1] := Trim(FieldByName('pob').AsString);
          cp [1] := Trim(FieldByName('cp').AsString);
          ua [1] := FieldByName('ULTIMA_ACCIO').AsDateTime;
     end;

     with v.Data.DataSet do
     begin
          Locate('id',id1,[]);

          nom[0] := Trim(FieldByName('nom').AsString);
          dir[0] := Trim(FieldByName('dir').AsString);
          tel[0] := Trim(FieldByName('tel').AsString);
          nif[0] := Trim(FieldByName('nif').AsString);
          pob[0] := Trim(FieldByName('pob').AsString);
          cp [0] := Trim(FieldByName('cp').AsString);
          ua [0] := FieldByName('ULTIMA_ACCIO').AsDateTime;
     end;

     id := inttostr(min(strtoint(id2),strtoint(id1)));

     if ua[1] > ua[0]      then mesnou := 1
     else if ua[0] > ua[1] then mesnou := 0 else mesnou := -1;

     if mesnou <> -1 then
     ua[2] := ua[mesnou]
     else
     ua[2] := ua[1];

     if mesnou > -1 then
     mDlg('El registre més actual és el ' + SS[mesnou] + ' ('+nom[mesnou]+')',mtInformation,[mbOk])
     else
     mDlg('Els dos registres tenen la mateixa data d''última acció',mtInformation,[mbOk]);

     s := PreguntarFusio('nom',[nom[0],nom[1],nom[0] + '; ' + nom[1]]);
     if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
     nom[2] := s;

     s := PreguntarFusio('N.I.F.',[nif[0],nif[1],nif[0]+'; '+nif[1]]);
     if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
     nif[2] := s;

     s := PreguntarFusio('direcció',[dir[0],dir[1],dir[0]+ ' / '+dir[1]]);
     if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
     dir[2] := s;

     s := PreguntarFusio('telèfon',[tel[0],tel[1],tel[0]+'; '+tel[1]]);
     if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
     tel[2] := s;

     if pob[0] <> pob[1] then
     begin
          s := PreguntarFusio('població',[pob[0],pob[1]]);
          if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
          pob[2] := s;

          cp[2] := TrobaCP(pob[2]);
          if cp[2] = '' then
          begin
               s := PreguntarFusio('Codi postal',[cp[0],cp[1]]);
               if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
               cp[2] := s;
          end;
     end
     else
     begin
          pob[2] := pob[0];
          cp[2]  := cp[0];
     end;

     s := PreguntarFusio('observacions',[obs[0],obs[1],obs[0]+' / ' + obs[1]]);
     if s = 'fusió abortada' then begin AccioEscollint := aeCancelar; exit; end;
     obs[2] := s;

     case mDlg(
     'Fusionar registres : '#13#10+
     id1+#9+ ' - ' + nom[0] + ' (' + nif[0] + ') - ' + dir[0] + '; ' + tel[0] + ' - ' + pob[0] + '-' + cp[0] + #13#10+
     id2+#9+ ' - ' + nom[1] + ' (' + nif[1] + ') - ' + dir[1] + '; ' + tel[1] + ' - ' + pob[1] + '-' + cp[1] + #13#10#13#10+
     'a : ' + #13#10 +
     id+#9 + ' - ' + nom[2] + ' (' + nif[2] + ') - ' + dir[2] + '; ' + tel[2] + ' - ' + pob[2] + '-' + cp[2]+ #13#10#13#10+
     'S''eliminaran els dos registres d''origen, establint-se el codi de dades personals de les llistes relacionades al nou registre creat.'#13#10+
     'Continuar?',
     mtInformation,[mbYes,mbNo]) of
     mrNo : begin AccioEscollint := aeCancelar; exit; end;
     end;

     with v.Data.DataSet do
     begin
          if Locate('id',id1,[]) then Delete;
          if Locate('id',id2,[]) then Delete;

          try
          Append;
          FieldValues['id'] := id;
          FieldValues['NOM'] := nom[2];
          FieldValues['DIR'] := dir[2];
          FieldValues['NIF'] := nif[2];
          FieldValues['TEL'] := tel[2];
          FieldValues['POB'] := pob[2];
          FieldValues['CP']  := cp[2];
          FieldValues['OBS'] := obs[2];

          Post;

          ReassignaReferenciaClient(id1,id);
          ReassignaReferenciaClient(id2,id);

          except
          on E:EOleException do
          begin
               mDlg(Format('Error intentant fusionar registres de dades personals. #'+id + #13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
               v.SetFocus;
               exit;
          end
          end;

          ActualitzarDades(strtoint(id));
          ActualitzarRepeticions;
     end;

     v.SetFocus;
end;

procedure T_personals.ReassignaReferenciaClient(idori,idnew : string);
var
     q : TADOQuery;
     n,i : integer;
begin
     if strtoint(idori) = strtoint(idnew) then exit;

     i := strtoint(idori);
     if (i = 0) or (i = -999999) then
     begin
          mDlg('Referències incorrectes (0 o -999999)',mtError,[mbOk]);
          exit;
     end;

     i := strtoint(idnew);
     if (i = 0) or (i = -999999) then
     begin
          mDlg('Referències incorrectes (0 o -999999)',mtError,[mbOk]);
          exit;
     end;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     try  q.SQL.Text := 'update ventesA set id_cli = ' + idnew + ' where id_cli = ' + idori;
          q.ExecSQL;
          n := q.RowsAffected;

          q.SQL.Text := 'update ventesB set id_cli = ' + idnew + ' where id_cli = ' + idori;
          q.ExecSQL;
          n := n + q.RowsAffected;

          q.SQL.Text := 'update averies set id_cli = ' + idnew + ' where id_cli = ' + idori;
          q.ExecSQL;
          n := n + q.RowsAffected;

          q.SQL.Text := 'update pressupostos set id_cli = ' + idnew + ' where id_cli = ' + idori;
          q.ExecSQL;
          n := n + q.RowsAffected;

          q.SQL.Text := 'update entrades set id_prv = ' + idnew + ' where id_prv = ' + idori;
          q.ExecSQL;
          n := n + q.RowsAffected;

          q.SQL.Text := 'update averies set id_rep = ' + idnew + ' where id_rep = ' + idori;
          q.ExecSQL;
          n := n + q.RowsAffected;
     except
     on E:EOleException do
     begin
          mDlg(Format('Error restablint referències.' + #13#10+'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
          q.Free;
          exit;
     end
     end;

     if n <> 0 then
     mDlg('S''han actualitzat ' + inttostr(n) + ' referències a altres taules.',mtInformation,[mbOk]);

     _averies.v.Refresh;
     _pressupostos.v.Refresh;
     _ventesA.v.Refresh;
     _ventesB.v.Refresh;
     _entrades.v.Refresh;

     q.Free;
end;

procedure T_personals.EfectuaFusio(sender : TObject);
begin
     AccioEscollint := aeEfectuar;
end;

procedure T_personals.FusionarRegistres;
var
     idori : string;
     c : longint;
begin
     if not _carregues.UProcessos.AfegeixProces('Fusionar dades personals')
     then
     begin
          mDlg('Aquest procès ja s''està efectuant.',mtInformation,[mbOk]);
          exit;
     end;

     v.EscClose := false;
     v.OnEscape := AnulaFusio;
     v.OnReturn := EfectuaFusio;

     idori := v.FieldByName('id').AsString;

     mDlg('Escolleixi el registre amb el qual fusionar l''actual (' + v.FieldByName('id').AsString + ' ' +
     v.FieldByName('NOM').AsString + ') i premi <intro>. Per cancelar, premi <esc>.',mtInformation,[mbOk]);

     v.SetFocus;

     AccioEscollint := aeEsperant;

     c := 0;
     while AccioEscollint = aeEsperant
     do
     begin
          c := c + 1;
          if c mod 30000000 = 0 then _main.tFusionarRegistres.Run;
          Application.ProcessMessages;

          if _carregues.UProcessos.Cancelar then AccioEscollint := aeCancelar;
     end;

     _main.tFusionarRegistres.Clear;
     _main.tFusionarRegistres.Caption := '     Fusionar registres';

     _carregues.UProcessos.EliminaProces('Fusionar dades personals');
     _main.tFusionarRegistres.Caption := '     Fusionar registres';

     if AccioEscollint = aeEfectuar then FerFusio(idori);
     // no else. Fer fusio canvia accio escollint

     if AccioEscollint = aeCancelar then mDlg('Fusió de registres anul·lada',mtInformation,[mbOK]);

     v.OnReturn := vReturn;
     v.OnClick  := nil;
     v.OnEscape := nil;
     v.EscClose := true;
end;

procedure T_personals.ActualitzarDades(id : integer);
     function MaxData(d1,d2 : TDateTime) : TDateTime;
     begin
          if d1 > d2 then result := d1 else result := d2;
     end;
var
     q : TADOQuery;
     maxdat : TDateTime;
     ac,pn : double;
begin
     if (id = 0) or (id = -999999) then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select sum(pendent) as spendent, sum(a_compte) as sa_compte from ventesA where id_CLI = ' + inttostr(id);
     q.Active := true;

     ac := q.FieldByName('sa_compte').AsFloat;
     pn := q.FieldByName('spendent').AsFloat;

     q.Active := false;
     q.SQL.Text := 'select sum(pendent) as spendent, sum(a_compte) as sa_compte from ventesB where id_CLI = ' + inttostr(id);
     q.Active := true;

     ac := ac + q.FieldByName('sa_compte').AsFloat;
     pn := pn + q.FieldByName('spendent').AsFloat;

     q.Active := false;
     q.SQL.Text := 'select max(data_cobro) as maxdata from ventesA where id_CLI = ' + inttostr(id);
     q.Active := true;

     maxdat := q.FieldByName('maxdata').AsDateTime;

     q.Active := false;
     q.SQL.Text := 'select max(data) as maxdata from ventesA where id_CLI = ' + inttostr(id);
     q.Active := true;

     maxdat := MaxData(maxdat,q.FieldByName('maxdata').AsDateTime);
     q.Active := false;
     q.SQL.Text := 'select max(data_cobro) as maxdata from ventesB where id_CLI = ' + inttostr(id);
     q.Active := true;

     maxdat := MaxData(maxdat,q.FieldByName('maxdata').AsDateTime);

     q.Active := false;
     q.SQL.Text := 'select max(data) as maxdata from ventesB where id_CLI = ' + inttostr(id);
     q.Active := true;

     maxdat := MaxData(maxdat,q.FieldByName('maxdata').AsDateTime);

     q.Active := false;
     q.SQL.Text := 'select * from personals where id = ' + inttostr(id);
     q.Active := true;

     if q.RecordCount = 0 then
     begin
          mDlg('ERROR intentant actualitzar valors de personal. personal #' + inttostr(id) + ' no trobat.',
          mtError,[mbOk]);
          q.Free;
          exit;
     end;

     q.Edit;
     q.FieldValues['A_COMPTE'] := ac;
     q.FieldValues['EN_DEUTE'] := pn;
     if maxdat <> 0 then
     q.FieldValues['ULTIMA_ACCIO'] := maxdat;
     q.Post;

     q.Free;
end;

procedure T_personals.ActualitzarDades;
begin
     ActualitzarDades(v.FieldByName('id').AsInteger);
     v.Refresh;
end;

procedure T_personals.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_personals.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_personals.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     ultima_accio : TDateTime;
     rp : integer;
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] = 'NO' then exit;

     ultima_accio := v.FieldByName('ULTIMA_ACCIO').AsDateTime;
     rp := v.FieldByName('REPETIT').AsInteger;

     cl := clNone;

     if rp > 1 then
     case rp of
     2 : cl := C_REPETIT_2;
     3 : cl := C_REPETIT_3;
     4 : cl := C_REPETIT_4;
     end
     else
     if ultima_accio > 0 then
     if (date - ultima_accio > 730) then cl := C_MESDOSANYS;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_personals.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paPersonals);
     _main.NMSEnabled;
     _main.INoEnabled;   
end;

procedure T_personals.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_personals.Msdedosanysinactiu1Click(Sender: TObject);
begin
     _main.tMesDe2Anys.React;
end;

procedure T_personals.Recalculardeute1Click(Sender: TObject);
begin
     _main.tActualitzarDeuteACompe.React;
end;

procedure T_personals.Fusionardosregistres1Click(Sender: TObject);
begin
     _main.tFusionarRegistres.React;
end;

procedure T_personals.Repetitsaalguncamp1Click(Sender: TObject);
begin
     _main.tRepetits1.React;
end;

procedure T_personals.Mostrarrepetits1Click(Sender: TObject);
begin
     _main.tRepetits.React;
end;

procedure T_personals.VentesArelacionades1Click(Sender: TObject);
begin
     _ventesA.v.Data.Filter := 'where (NOM_CLI like ' + AnsiquotedStr('%'+v.FieldByName('NOM').AsString+'%','''') + ')';
     _ventesA.v.Caption.Variable := v.FieldByName('NOM').AsString;

     if  (_ventesA.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquestes dades personals a ventes (A)',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tVentesA.React;
     end;
end;

procedure T_personals.VentesBrelacionades1Click(Sender: TObject);
begin
     _ventesB.v.Data.Filter := 'where (NOM_CLI like ' + AnsiquotedStr('%'+v.FieldByName('NOM').AsString+'%','''') + ')';
     _ventesB.v.Caption.Variable := v.FieldByName('NOM').AsString;

     if  (_ventesB.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquestes dades personals a ventes (B)',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tVentesB.React;
     end;
end;

procedure T_personals.Averiesrelacionades1Click(Sender: TObject);
begin
     _averies.v.Data.Filter := 'where (NOM_CLI like ' + AnsiquotedStr('%'+v.FieldByName('NOM').AsString+'%','''') + ') '+
                               'or (NOM_REP like ' + AnsiquotedStr('%'+v.FieldByName('NOM').AsString+'%','''') + ')';
     _averies.v.Caption.Variable := v.FieldByName('NOM').AsString;

     if  (_averies.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquestes dades personals a averies',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tAveries.React;
     end;
end;

procedure T_personals.pressupostosrelacionats1Click(Sender: TObject);
begin
     _pressupostos.v.Data.Filter := 'where (NOM_CLI like ' + AnsiquotedStr('%'+v.FieldByName('NOM').AsString+'%','''') + ')';
     _pressupostos.v.Caption.Variable := v.FieldByName('NOM').AsString;

     if  (_pressupostos.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquestes dades personals a pressupostos',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tpressupostos.React;
     end;
end;

procedure T_personals.Entradesrelacionades1Click(Sender: TObject);
begin
     _entrades.v.Data.Filter := 'where (NOM_PRV like ' + AnsiquotedStr('%'+v.FieldByName('NOM').AsString+'%','''') + ')';
     _entrades.v.Caption.Variable := v.FieldByName('NOM').AsString;

     if  (_entrades.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquestes dades personals a entrades',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tEntrades.React;
     end;
end;

procedure T_personals.PopupMenu1Popup(Sender: TObject);
var
     q : TADOQuery;
     d : TDateTime;
     s : string;
     id : string;
begin
     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;

     if v.Data.Dataset.RecordCount = 0 then exit;

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     d := 0;
     s := '<cap>';
     id := v.FieldByName('id').AsString;

     if id = '' then id := '0';

     q.SQL.Text := 'select * from ventesA where (data = (select max(data) as dt from ventesA where id_cli = ' + id + ')) and (id_cli = ' + id + ')';
     q.Active := true;

     if q.FieldByName('data').AsDateTime > d
     then
     begin
          s := 'venta A'+q.FieldByName('id').AsString;
          d := q.FieldByName('data').AsDateTime;
     end;

     q.SQL.Text := 'select * from ventesB where (data = (select max(data) as dt from ventesB where id_cli = ' + id + ')) and (id_cli = ' + id + ')';
     q.Active := true;

     if q.FieldByName('data').AsDateTime > d
     then
     begin
          s := 'venta B'+q.FieldByName('id').AsString;
          d := q.FieldByName('data').AsDateTime;
     end;

     q.SQL.Text := 'select * from pressupostos where (data = (select max(data) as dt from pressupostos where id_cli = ' + id + ')) and (id_cli = ' + id + ')';
     q.Active := true;

     if q.FieldByName('data').AsDateTime > d
     then
     begin
          s := 'pressupost '+q.FieldByName('id').AsString;
          d := q.FieldByName('data').AsDateTime;
     end;

     q.SQL.Text := 'select * from averies where (data = (select max(data) as dt from averies where id_cli = ' + id + ')) and (id_cli = ' + id + ')';
     q.Active := true;

     if q.FieldByName('data').AsDateTime > d
     then
     begin
          s := 'averia '+q.FieldByName('id').AsString;
          d := q.FieldByName('data').AsDateTime;
     end;

     q.SQL.Text := 'select * from entrades where (data = (select max(data) as dt from entrades where id_prv = ' + id + ')) and (id_prv = ' + id + ')';
     q.Active := true;

     if q.FieldByName('data').AsDateTime > d
     then
          s := 'entrada '+q.FieldByName('id').AsString;

     ltimaacci1.Caption := 'Última acció : ' + s;

     q.Free;
end;

procedure T_personals.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_personals.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

procedure T_personals.ltimaacci1Click(Sender: TObject);
var
     s : string;
begin
     if Pos('<cap>',s) <> 0 then exit;

     s := StringReplace(ltimaacci1.Caption,'&','',[rfReplaceAll]);
     s := Trim(StringReplace(s,'Última acció : ','',[]));

     if Pos('venta A',s) <> 0 then
     begin
          s := StringReplace(s,'venta A','',[]);

          _ventesA.v.Data.Filter := 'where id = ' + s;
          _ventesA.v.Caption.Variable := s;

          _main.PosaAPrevies(self);
          _main.tVentesA.React;
     end
     else
     if Pos('venta B',s) <> 0 then
     begin
          s := StringReplace(s,'venta B','',[]);
          _ventesB.v.Data.Filter := 'where id = ' + s;
          _ventesB.v.Caption.Variable := s;

          _main.PosaAPrevies(self);
          _main.tVentesB.React;
     end
     else
     if Pos('pressupost ',s) <> 0 then
     begin
          s := StringReplace(s,'pressupost ','',[]);
          _pressupostos.v.Data.Filter := 'where id = ' + s;
          _pressupostos.v.Caption.Variable := s;

          _main.PosaAPrevies(self);
          _main.tPressupostos.React;
     end
     else
     if Pos('averia ',s) <> 0 then
     begin
          s := StringReplace(s,'averia ','',[]);
          _averies.v.Data.Filter := 'where id = ' + s;
          _averies.v.Caption.Variable := s;

          _main.PosaAPrevies(self);
          _main.tAveries.React;
     end
     else
     if Pos('entrada ',s) <> 0 then
     begin
          s := StringReplace(s,'entrada ','',[]);
          _entrades.v.Data.Filter := 'where id = ' + s;
          _entrades.v.Caption.Variable := s;

          _main.PosaAPrevies(self);
          _main.tEntrades.React;
     end

end;

end.
