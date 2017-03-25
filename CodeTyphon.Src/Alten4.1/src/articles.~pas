unit articles;

interface

uses Classes, EstilColor, Menus, Windows, UDBView, Forms, gULib, DB, Graphics, Dialogs, StdCtrls, Controls, ExtCtrls, FPanel, Sysutils;

type
  T_articles = class(TForm)
    pCaption: TFPanel;    
    lbcaption: TLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    Nouarticle1: TMenuItem;
    Modificar1: TMenuItem;
    Eliminararticle1: TMenuItem;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    N2: TMenuItem;
    Anara1: TMenuItem;
    Averiesrelacionades1: TMenuItem;
    pressupostosrelacionats1: TMenuItem;
    Ventesrelacionades1: TMenuItem;
    Entradesrelacionades1: TMenuItem;
    Magatzemrelacionat1: TMenuItem;
    v: TUDBView;
    Filtresdefinits1: TMenuItem;
    Margeperdefecteaplicat1: TMenuItem;
    Margedemarcaaplicat1: TMenuItem;
    Margesnovlids1: TMenuItem;
    Articlesobsolets1: TMenuItem;
    Articlesdentradadirecta1: TMenuItem;
    N3: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    Entrarcodidebarres1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    N5: TMenuItem;
    Utsamagatzem1: TMenuItem;
    procedure vDelete(Sender: TObject);
    procedure vInsert(Sender: TObject);
    procedure vReturn(Sender: TObject);
    procedure Nouarticle1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminararticle1Click(Sender: TObject);
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
     procedure MostraMenu;
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure Margeperdefecteaplicat1Click(Sender: TObject);
    procedure Margedemarcaaplicat1Click(Sender: TObject);
    procedure Articlesobsolets1Click(Sender: TObject);
    procedure Margesnovlids1Click(Sender: TObject);
    procedure Articlesdentradadirecta1Click(Sender: TObject);
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Averiesrelacionades1Click(Sender: TObject);
    procedure pressupostosrelacionats1Click(Sender: TObject);
    procedure Ventesrelacionades1Click(Sender: TObject);
    procedure Entradesrelacionades1Click(Sender: TObject);
    procedure Magatzemrelacionat1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Tornarllistaprvia1Click(Sender: TObject);
    procedure Entrarcodidebarres1Click(Sender: TObject);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure Utsamagatzem1Click(Sender: TObject);
  private
  public
     procedure Obsolets;
     procedure MargeMarca;
     procedure MargeDefecte;
     procedure MargeInvalid;
     procedure EntradaDirecta;
     procedure ActualitzarDescripcions;
     procedure CalcularPreus;
     procedure EliminarArticlesObsolets;
     procedure EstablirLinies;
  end;

var
  _articles: T_articles;

implementation

{$R *.DFM}

uses dmsrc, earticles, ADOdb, global, caveries, cpressupostos,
  cventesA, cventesB, centrades, magatzem, carregues, main;

procedure T_articles.vDelete(Sender: TObject);
begin
     _main.OnDelete(sender);
end;

procedure T_articles.vInsert(Sender: TObject);
begin
     _main.OnInsert(sender);
end;

procedure T_articles.vReturn(Sender: TObject);
begin
     _main.OnReturn(sender);
end;

procedure T_articles.Nouarticle1Click(Sender: TObject);
begin
     v.PushInsert;
end;

procedure T_articles.Modificar1Click(Sender: TObject);
begin
     v.PushReturn;
end;

procedure T_articles.Eliminararticle1Click(Sender: TObject);
begin
     v.PushDelete;
end;

procedure T_articles.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_articles.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_articles.ActualitzarDescripcions;
begin
     EstablirLinies;
end;

procedure T_articles.EliminarArticlesObsolets;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'delete * from ARTICLES where PVP = 0';
     q.ExecSQL;

     q.Free;
end;

procedure T_articles.EstablirLinies;
var
     q,r : TADOQuery;
begin
     if not _carregues.UProcessos.AfegeixProces('Establint línies')
     then
     begin
          mDlg('Aquest procés ja s''està efectuant',mtWarning,[mbOk]);
          exit;
     end;

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     r := TADOQuery.Create(self);
     r.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from LINIES order by id asc';
     q.Active := true;
     q.First;

     while not q.Eof do
     begin                           // assignem descripció segons identificador de linia
          r.SQL.Text := 'update ARTICLES set LINIA = ''' + q.FieldByName('descr').Asstring + ''' where id_lin = ' + q.FieldByName('id').Asstring + ' and id > 0';
          r.ExecSQL;

          Application.ProcessMessages;
          _carregues.tCarregarArticles.Run;
          q.Next;
     end;

     _carregues.UProcessos.EliminaProces('Establint línies');

     r.Free;
     q.Free;
end;

procedure T_articles.CalcularPreus;
     function FToSQLF(s : string) : string;
     begin
          result := FormatFloat('0.00000',strtofloat(s));
          result := StringReplace(result,DecimalSeparator,'.',[rfReplaceAll]);
     end;
var
     q : TADOQuery;
begin
     if not _carregues.UProcessos.AfegeixProces('Calculant preus') then
     begin
          mDlg('Aquest procés ja s''està efectuant',mtWarning,[mbOk]);
          exit;
     end;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     _carregues.tCarregarArticles.Run;

     q.Active   := false; // PVP : Màxim entre PMin i PRec
     q.SQL.Text := 'update ARTICLES set PVP = iif(PRec > PMin,PRec,PMin) where id > 0';
     q.ExecSQL;

     _carregues.tCarregarArticles.Run;

     q.Active   := false; // Si PCost > PMin, PRec, llavors PVP = PCost aplicant marge de marca.
     q.SQL.Text := 'update ARTICLES set PVP = PCost / (1 - Marge_mar/100) where (PCost > PVP) and (id > 0)';
     q.ExecSQL;

     _carregues.tCarregarArticles.Run;

     q.Active := false; // En els casos a on el Marge de marca sigues cero, s'aplica el marge per defecte sempre que el preu de venta = preu de cost (l'anterior amb marges 0 o negatius)
     q.SQL.Text := 'update ARTICLES set PVP = PCost / (1 - ' + FToSQLF(dm.CR['MARGE_DEFECTE']) + '/100) where (PCost = PVP) and (id > 0)';
     q.ExecSQL;

     _carregues.tCarregarArticles.Run;

     q.Active := false;
     q.SQL.Text := 'update ARTICLES set Marge = -100*(PCost / PVP) + 100 where PVP <> 0 and id > 0';
     q.ExecSQL;

     _carregues.tCarregarArticles.Run;

     _carregues.UProcessos.EliminaProces('Calculant preus');
     q.Free;
end;

procedure T_articles.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_articles.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_articles.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     PMin,PRec,PCost,PVP,Marge,Marge_mar : double;
     id : integer;
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] = 'NO' then exit;

     PMin  := v.FieldByName('PMin').AsFloat;
     PRec  := v.FieldByName('PRec').AsFloat;
     try
     PCost := v.FieldByName('PCost').AsFloat;
     except
     PCost := v.FieldByName('PBase').AsFloat * (1 + strtoint(dm.CR['IVA_ARTICLES']) / 100);
     end;

     PVP   := v.FieldByName('PVP').AsFloat;
     try
     Marge_mar := v.FieldByName('Marge_mar').AsFloat;
     except
     Marge_mar := 0;
     end;

     Marge := v.FieldByName('Marge').AsFloat;
     id    := v.FieldByName('id').AsInteger;

     cl := clNone;

     if id < 0 then cl := C_ENTRADADIRECTA
     else
     if (PMin = 0) and (PRec = 0) and (PCost = 0)
     then cl := C_OBSOLET
     else
     if (PVP <> 0) and (Pcost > PMin) and (Pcost > PRec) and (Marge_mar = 0)
     then cl := C_MARGEDEFECTE // s'aplicat el marge per defecte
     else
     if (Pcost > PMin) and (PCost > PRec) and (PVP <> 0)
     then cl := C_MARGEMARCA //$0001B4E0 // s'aplicat el marge de marca
     else
     if (Marge <= 0) then cl := C_MARGENOVALID;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_articles.Margeperdefecteaplicat1Click(Sender: TObject);
begin
     MargeDefecte;
end;

procedure T_articles.Margedemarcaaplicat1Click(Sender: TObject);
begin
     MargeMarca;
end;

procedure T_articles.Articlesobsolets1Click(Sender: TObject);
begin
     Obsolets;
end;

procedure T_articles.Margesnovlids1Click(Sender: TObject);
begin
     MargeInvalid;
end;

procedure T_articles.Articlesdentradadirecta1Click(Sender: TObject);
begin
     EntradaDirecta;
end;

procedure T_articles.Obsolets;
begin
     v.Caption.Variable := 'articles obsolets';
     v.Data.Filter := 'where (PMin = 0) and (PRec = 0) and (PVP = 0)';
end;

procedure T_articles.MargeMarca;
begin
     v.Caption.Variable := 'marge de marca aplicat';
     v.Data.Filter :='where (PCost > PMin) and (PCost > Prec) and (PVP <> 0) and (Marge_mar <> 0)';
end;

procedure T_articles.MargeDefecte;
begin
     v.Caption.Variable := 'marge per defecte';
     v.Data.Filter := 'where (PVP <> 0) and (Pcost > PMin) and (Pcost > PRec) and (Marge_mar = 0)';
end;

procedure T_articles.MargeInvalid;
begin
     v.Caption.Variable := 'marge invàlid';
     v.Data.Filter := 'where (Marge <= 0)';
end;

procedure T_articles.EntradaDirecta;
begin
     v.Caption.Variable := 'articles d''entrada directa';
     v.Data.Filter := 'where (id < 0)';
end;

procedure T_articles.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paArticles);
     _main.NMSEnabled;
     _main.INoEnabled;     
end;

procedure T_articles.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_articles.Averiesrelacionades1Click(Sender: TObject);
begin
     _caveries.vCArt.Data.Filter := 'where (CONCEPTE like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _caveries.vCInt.Data.Filter := _caveries.vCArt.Data.Filter;

     _caveries.vCArt.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_caveries.vCArt.Data.Dataset.RecordCount = 0)
     and (_caveries.vCInt.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest article als conceptes d''averies',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tcAveries.React;
     end;
end;

procedure T_articles.pressupostosrelacionats1Click(Sender: TObject);
begin
     _cpressupostos.v.Data.Filter := 'where (CONCEPTE like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _cpressupostos.v.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_cpressupostos.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest article als conceptes de pressupostos',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tcpressupostos.React;
     end;
end;

procedure T_articles.Ventesrelacionades1Click(Sender: TObject);
begin
     _cventesA.v.Data.Filter := 'where (CONCEPTE like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _cventesB.v.Data.Filter := _cventesA.v.Data.Filter;

     _cventesA.v.Caption.Variable := v.FieldByName('DESCR').AsString;
     _cventesB.v.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_cventesA.v.Data.Dataset.RecordCount = 0)
     and (_cventesB.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest article als conceptes de ventes',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);

          _cventesA.Top    := 0;
          _cventesA.Height := _main.fonsmain.ClientHeight div 2;
          _cventesB.Height := _cventesA.Height;
          _cventesB.Top    := _cventesA.Height;

          _cventesA.Left   := 0;
          _cventesB.Left   := 0;

          _cventesA.Show;
          _cventesB.Show;
     end;
end;

procedure T_articles.Entradesrelacionades1Click(Sender: TObject);
begin
     _centrades.v.Data.Filter := 'where (CONCEPTE like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _centrades.v.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_centrades.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest article als conceptes d''entrades',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tcEntrades.React;
     end;
end;

procedure T_articles.Magatzemrelacionat1Click(Sender: TObject);
begin
     _magatzem.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _magatzem.v.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_magatzem.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''han trobat registres relacionats d''aquest article als conceptes de magatzem',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tMagatzem.React;
     end;
end;

procedure T_articles.PopupMenu1Popup(Sender: TObject);
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.SQL.Text := 'select descr,uts_actuals from magatzem where descr like ' + AnsiQuotedStr('%'+v.FieldByName('descr').AsString+'%','''');
     q.Active := true;

     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;

     if q.RecordCount <> 0 then
     Utsamagatzem1.Caption := 'Uts. a magatzem : ' + FormatFloat('0.0',q.FieldByName('uts_actuals').AsFloat)
     else
     Utsamagatzem1.Caption := 'Uts. a magatzem : <no entrat>';

     q.Free;
end;

procedure T_articles.Tornarllistaprvia1Click(Sender: TObject);
begin
     _main.Tornarllistaprvia1Click(nil);
end;

procedure T_articles.Entrarcodidebarres1Click(Sender: TObject);
var
     s : string;
begin
     s := TextIn('Codi de barres ' + v.FieldByName('descr').ASString,v.FieldByName('codi_barres').AsString,ecNormal,700);

     if s = v.FieldByName('codi_barres').AsString then exit;

     v.Data.Dataset.Edit;
     v.Data.Dataset.FieldValues['codi_barres'] := s;
     v.Data.Dataset.Post;
end;

procedure T_articles.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

procedure T_articles.Utsamagatzem1Click(Sender: TObject);
begin
     Magatzemrelacionat1Click(sender);
end;

end.
