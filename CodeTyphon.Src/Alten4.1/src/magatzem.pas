unit magatzem;

interface

uses Windows, Menus, UDBView, Forms, Controls, StdCtrls, Classes, ExtCtrls, ADOdb, FPanel, db, Graphics, sysutils, estilcolor, ComObj, Dialogs;

procedure TreuDeMagatzem(descr : string; id_elem : integer; uts : double; data : TDateTime);
procedure PosaAMagatzem(descr : string; id_elem : integer; uts : double; data : TDateTime);

type
  T_magatzem = class(TForm)
    PopupMenu1: TPopupMenu;
    Aplicarfiltre1: TMenuItem;
    Eliminarfiltre1: TMenuItem;
    Anara1: TMenuItem;
    Ventesrelacionades1: TMenuItem;
    pCaption: TFPanel;
    lbCaption: TLabel;
    v: TUDBView;
    N3: TMenuItem;
    Tornarllistaprvia1: TMenuItem;
    Articlerelacionats1: TMenuItem;
    Entradesrelacionades1: TMenuItem;
    N2: TMenuItem;
    Filtrespredefinits1: TMenuItem;
    Articlesaceroonegatiu1: TMenuItem;
    Seguimentdarticle1: TMenuItem;
    Entradadirectauts1: TMenuItem;
    AplicarfiltreacolumnaF81: TMenuItem;
    Notrobatsaarticles1: TMenuItem;
    N1: TMenuItem;
    Eliminarregistredemagatzem1: TMenuItem;
    procedure Modifica_uts(q,r : TADOQuery; f : integer);
    procedure FormCreate(Sender: TObject);
    procedure MostraMenu;
    procedure vGetFocus(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SeguimentArticle;
    procedure PreparaSegMag;
    procedure EntradaDirectaUts;
    procedure Articlerelacionats1Click(Sender: TObject);
    procedure Ventesrelacionades1Click(Sender: TObject);
    procedure Entradesrelacionades1Click(Sender: TObject);
    procedure Articlesaceroonegatiu1Click(Sender: TObject);
    procedure Seguimentdarticle1Click(Sender: TObject);
    procedure Entradadirectauts1Click(Sender: TObject);
    procedure Aplicarfiltre1Click(Sender: TObject);
    procedure Eliminarfiltre1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean;
      C: TCanvas);
    procedure AplicarfiltreacolumnaF81Click(Sender: TObject);
    procedure Notrobatsaarticles1Click(Sender: TObject);
    procedure Eliminarregistredemagatzem1Click(Sender: TObject);
  private
  public
     procedure ActualitzarCodisArticles;
  end;

var
     _magatzem : T_magatzem;

implementation

{$R *.DFM}

uses dmsrc, main, normalit, global, segmag, gULib, entrades,
  cpressupostos, articles, cventesA, cventesB, centrades;

procedure ModificaUtsMagatzem(descr : string; id_elem : integer; uts : double; data : TDateTime);
var
     q : TADOQuery;
begin
     if id_elem = 0 then exit;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from magatzem where descr = ' + AnsiQuotedStr(Trim(NoDblSpace(descr)),'''');// + ' and id = ' + inttostr(id_elem);
     q.Active := true;

     if q.RecordCount = 0 then
     begin
          q.Append;
          q.FieldValues['id']    := id_elem;
          q.FieldValues['descr'] := descr;
          q.FieldValues['uts_anteriors'] := 0;
          q.FieldValues['uts_actuals'] := uts;
          q.FieldValues['ultima_mod'] := data;
          q.Post;
     end
     else
     begin
          q.Edit;
          q.FieldValues['uts_anteriors'] := q.FieldByName('uts_actuals').AsFloat;
          q.FieldValues['uts_actuals']   := q.FieldByName('uts_actuals').AsFloat + uts;
          q.FieldValues['ultima_mod']    := data;
          q.Post;
     end;

     q.Free;
end;

procedure PosaAMagatzem(descr : string; id_elem : integer; uts : double; data : TDateTime);
begin
     ModificaUtsMagatzem(descr,id_elem,uts,data);
end;

procedure TreuDeMagatzem(descr : string; id_elem : integer; uts : double; data : TDateTime);
begin
     ModificaUtsMagatzem(descr,id_elem,-uts,data);
end;

procedure T_magatzem.Modifica_uts(q,r : TADOQuery; f : integer);
begin
     if q.FieldByName('id_elem').AsInteger = 0 then exit;

     r.Active := false;
     r.SQL.Text := 'select * from magatzem where descr = ' +
     AnsiQuotedStr(q.FieldByName('concepte').AsString,'''');
     r.Active := true;

     if r.RecordCount > 0
     then r.Edit
     else
     begin
          r.Append;
          r.FieldValues['id']    := q.FieldByName('id').AsInteger;
          r.FieldValues['descr'] := q.FieldByName('concepte').AsString;
          r.FieldValues['uts_actuals'] := 0;
     end;

     r.FieldValues['uts_anteriors'] := r.FieldByName('uts_actuals').AsFloat;
     r.FieldValues['uts_actuals'] := r.FieldByName('uts_actuals').AsFloat +
     q.FieldByName('uts').AsFloat * f;
     r.FieldValues['ultima_mod'] := date;

     r.Post;
     r.Refresh;
end;

procedure T_magatzem.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
end;

procedure T_magatzem.MostraMenu;
begin
     PopupMenu1.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
end;

procedure T_magatzem.vGetFocus(Sender: TObject);
begin
     _main.PosaPanelDavant_(_main.paMagatzem);
     _main.NMSNoEnabled;
     _main.INoEnabled;          
end;

procedure T_magatzem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     _main.TancaLlista(sender);
end;

procedure T_magatzem.PreparaSegMag;
var
     s : string;
     p,q,r : TADOQuery;
     id : integer;
begin
     s := Trim(v.FieldByName('DESCR').AsString);

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     r := TADOQuery.Create(self);
     r.Connection := dm.CT;

     p := TADOQuery.Create(self);
     p.Connection := dm.CG;

     r.SQL.Text := 'delete * from segmag';
     r.ExecSQL;
     r.SQL.Text := 'select * from segmag';
     r.Active   := true;

     q.SQL.Text := 'select * from c_ventesA where concepte like ' + AnsiQuotedStr('%'+s+'%','''') + ' order by id asc';
     q.Active   := true;
     q.First;

     id := 0;
     while not q.Eof do
     begin
          p.Active   := false;
          p.SQL.Text := 'select * from ventesA where id = ' + q.FieldByName('id_ref').AsString;
          p.Active   := true;

          r.Append;
          r.FieldValues['id']      := id;
          r.FieldValues['data']    := p.FieldValues['data'];
          r.FieldValues['id_ref']  := q.FieldByName('id_ref').AsInteger;
          r.FieldValues['tp_ref']  := 'A';
          r.FieldValues['uts_mod'] := -q.FieldByName('uts').AsFloat;
          r.Post;

          inc(id);
          q.Next;
     end;

     q.SQL.Text := 'select * from c_ventesB where concepte like ' + AnsiQuotedStr('%'+s+'%','''') + ' order by id asc';
     q.Active   := true;
     q.First;

     while not q.Eof do
     begin
          p.Active   := false;
          p.SQL.Text := 'select * from ventesB where id = ' + q.FieldByName('id_ref').AsString;
          p.Active   := true;

          r.Append;
          r.FieldValues['id']      := id;
          r.FieldValues['data']    := p.FieldValues['data'];
          r.FieldValues['id_ref']  := q.FieldByName('id_ref').AsInteger;
          r.FieldValues['tp_ref']  := 'B';
          r.FieldValues['uts_mod'] := -q.FieldByName('uts').AsFloat;
          r.Post;

          inc(id);
          q.Next;
     end;

     q.SQL.Text := 'select * from c_entrades where concepte like ' + AnsiQuotedStr('%'+s+'%','''') + ' order by id asc';
     q.Active   := true;
     q.First;

     while not q.Eof do
     begin
          p.Active   := false;
          p.SQL.Text := 'select * from entrades where id = ' + q.FieldByName('id_ref').AsString;
          p.Active   := true;

          r.Append;
          r.FieldValues['id']      := id;
          r.FieldValues['data']    := p.FieldValues['data'];
          r.FieldValues['id_ref']  := q.FieldByName('id_ref').AsInteger;
          r.FieldValues['tp_ref']  := 'E';
          r.FieldValues['uts_mod'] := q.FieldByName('uts').AsFloat;
          r.Post;

          inc(id);
          q.Next;
     end;

     p.Free;
     r.Free;
     q.Free;
end;

procedure T_magatzem.SeguimentArticle;
begin
     with T_segmag.Create(Application) do
     begin
          Caption := _magatzem.v.FieldByName('DESCR').AsString;
          PreparaSegMag;
          v.Data.OrderBy := 'data asc';          
          v.Refresh;
          Show;
          BringToFront;
     end;
end;

procedure T_magatzem.EntradaDirectaUts;
var
     a : double;
     id : integer;
     id_ref : integer;
     fet : boolean;
     afs : TDatasetNotifyEvent;
begin
     afs := _entrades.v.Data.Dataset.AfterScroll;
     _entrades.v.Data.Dataset.AfterScroll := nil;

     id := _entrades.v.Data.GetNewId;

     with _entrades.v.Data.DataSet do
     try
          Append;
          FieldValues['id']   := id;
          FieldValues['DATA'] := date;
          FieldValues['REF_ALBARA'] := '<directe>';
          FieldValues['PAGADA'] := false;
          FieldValues['NOM_PRV'] := '<normalitzaci� d''inventari>';
          FieldValues['TOTAL']   := 0;
          FieldValues['BASE']    := 0;
          FieldValues['IVA']     := 0;
          FieldValues['IVA_P']   := 0;
          FieldValues['id_PRV']  := -999999;
          FieldValues['OBSERVACIONS'] := '(normalitzaci� d''inventari)';
          Post;
          //comprobar
     except
     on E:EOleException do
     begin
          mDlg(Format('Error intentant crear entrada de normalitzaci�' + #13#10 +'Codi d''error : %d ' + #13#10 + 'Missatge : %s',[E.ErrorCode,E.Message]),mtError,[mbOk]);
          _entrades.v.Data.Dataset.AfterScroll := afs;
     end
     end;

     id_ref := id;

     fet := false;

     while not fet do
     begin
          a := NumberInModal(v.FieldByName('DESCR').AsString,FormatFloat('0',v.FieldByName('uts_actuals').AsFloat),700);

          if a <> -999999 then
          begin
               id := _entrades.vC.Data.GetNewId;

               with _entrades.vC.Data.DataSet do
               begin
                    Append;
                    FieldValues['id'] := id;
                    FieldValues['id_ref'] := id_ref;
                    FieldValues['id_elem']  := v.FieldByName('id').AsInteger;
                    FieldValues['concepte'] := v.FieldByName('DESCR').AsString;
                    FieldValues['preu']   := 0;
                    FieldValues['import'] := 0;
                    FieldValues['uts']    := a - v.FieldByName('uts_actuals').AsFloat;
                    Post;
               end;

               with v.Data.DataSet do
               begin
                    Edit;
                    FieldValues['uts_anteriors'] := FieldByName('uts_actuals').AsFloat;
                    FieldValues['uts_actuals']   := a;
                    FieldValues['ultima_mod']    := date;
                    Post;
               end;

               if v.Data.Dataset.RecNo = v.Data.Dataset.RecordCount
               then
               begin
                    mDlg('Final de llista',mtInformation,[mbOk]);
                    fet := true;
               end
               else v.Down;
          end
          else fet := true;
     end;

     _entrades.v.Refresh;
     _entrades.vC.Refresh;

     _entrades.v.Data.Dataset.AfterScroll := afs;
end;

procedure T_magatzem.Articlerelacionats1Click(Sender: TObject);
begin
     _articles.v.Data.Filter := 'where (DESCR like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _articles.v.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_articles.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''ha trobat aquest article a la taula d''articles. Es posible que estigui obsolet o hagi canviat la seva descripci�.',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tArticles.React;
     end;
end;

procedure T_magatzem.Ventesrelacionades1Click(Sender: TObject);
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

procedure T_magatzem.Entradesrelacionades1Click(Sender: TObject);
begin
     _centrades.v.Data.Filter := 'where (CONCEPTE like ' + AnsiQuotedStr('%'+v.FieldByName('DESCR').AsString+'%','''') + ')';
     _centrades.v.Caption.Variable := v.FieldByName('DESCR').AsString;

     if  (_centrades.v.Data.Dataset.RecordCount = 0)
     then mDlg('No s''ha trobat aquest article als conceptes d''entrades',mtInformation,[mbOk])
     else
     begin
          _main.PosaAPrevies(self);
          _main.tcEntrades.React;
     end;
end;

procedure T_magatzem.Articlesaceroonegatiu1Click(Sender: TObject);
begin
     v.Data.Filter := 'where (uts_actuals <= 0)';
     v.Caption.Variable := 'articles amb unitats cero o negatives';
end;

procedure T_magatzem.Seguimentdarticle1Click(Sender: TObject);
begin
     SeguimentArticle;
end;

procedure T_magatzem.Entradadirectauts1Click(Sender: TObject);
begin
     EntradaDirectaUts;
end;

procedure T_magatzem.Aplicarfiltre1Click(Sender: TObject);
begin
     v.CallFilter;
end;

procedure T_magatzem.Eliminarfiltre1Click(Sender: TObject);
begin
     v.ClearFilter;
end;

procedure T_magatzem.PopupMenu1Popup(Sender: TObject);
begin
     Tornarllistaprvia1.Enabled := Length(_main.ALlistaPrevia) > 0;
end;

procedure T_magatzem.ActualitzarCodisArticles;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.SQL.Text := 'update magatzem, articles set magatzem.id = articles.id where magatzem.descr = articles.descr';
     q.ExecSQL;

     v.Refresh;

     q.Free;
end;

procedure T_magatzem.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     cl : TColor;
begin
     if dm.CR['U_LLEGENDA'] <> 'SI' then exit;

     cl := clNone;

     if v.FIeldByName('uts_actuals').AsFloat <= 0 then
     cl := C_UTS_CERO;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_magatzem.AplicarfiltreacolumnaF81Click(Sender: TObject);
begin
     v.CallColumnFilter;
end;

procedure T_magatzem.Notrobatsaarticles1Click(Sender: TObject);
begin
     v.Data.Filter := 'where not (magatzem.descr in (select descr from articles))';
     v.Caption.Variable := 'no trobats a taula d''articles';
end;

procedure T_magatzem.Eliminarregistredemagatzem1Click(Sender: TObject);
begin
     if v.FieldByName('uts_actuals').AsFloat <> 0
     then
     begin
          mDlg('Aquest article encara t� unitats entrades.',mtInformation,[mbOk]);
          exit;
     end;

     if mDlg('Eliminar registre de magatzem ' + v.FieldByName('descr').AsString + '.Continuar?',mtInformation,[mbYes,mbNo]) <> mrYes then exit;

     v.Data.Dataset.Delete;
     v.Refresh;
end;

end.