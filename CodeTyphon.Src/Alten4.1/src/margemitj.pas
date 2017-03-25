unit margemitj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UText, ULabel;

type
  T_margemitj = class(TForm)
    dLINIA: TMLabel;
    dDATA_INICI: TDLabel;
    dDATA_FINAL: TDLabel;
    UText12: TUText;
    UText1: TUText;
    UText4: TUText;
    btEntrar: TUText;
    procedure FormCreate(Sender: TObject);
    procedure Fcreate(sender : TObject);
    procedure btEntrarReact(Sender: TObject);
  private
  public
  end;

implementation

uses dmsrc, estilcolor, ADOdb, udbview, dbutils, global, llistcfg, udbvaux, comobj, shellapi;

{$R *.dfm}

procedure T_margemitj.FormCreate(Sender: TObject);
var
     y,m,d : word;
     mm : integer;
begin
     _estilcolor.Apply(sender as TCustomForm,false);

     DecodeDate(date,y,m,d);

     mm := m - 2;
     if mm < 1 then begin mm := mm + 12; y := y - 1; end;

     m := mm;

     dDATA_INICI.Date := EncodeDate(y,m,1);
     dDATA_FINAL.Date := date;
end;

procedure T_margemitj.Fcreate(sender : TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,false);
end;

procedure T_margemitj.btEntrarReact(Sender: TObject);
var
     q : TADOQuery;
     q2 : TADOQuery;
     v : TUDBView;
     f : TForm;
     s : string;
     sm : double;
     r : integer;
     i : integer;
     excel : variant;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;

     if ETaula('marge_mitj',q.Connection) then
     begin
          q.SQL.Text := 'drop table marge_mitj';
          q.ExecSQL;
     end;

     q.Connection := dm.CG;
     q.Active := false;
     q.SQL.Text := 'select * from ventes' + dLINIA.Caption + ' where (data >= ' + FormatSQLDate(dDATA_INICI.Date) + ') and (data < ' + FormatSQLDate(dDATA_FINAL.Date+1) + ')';
     q.Active := true;
     q.First;

     s := '';
     while not q.Eof do
     begin
          s := s + q.FieldByName('id').AsString + ',';
          q.Next;
     end;

     if length(s) = 0 then
     begin
          mDlg('No hi han ventes de les que fer resum entre aquestes dades',mtError,[mbOk]);
          exit;
     end;

     s[length(s)] := ' ';

     q.Active := false;
     q.Connection := dm.CT;
     q.SQL.Text :=  'create table marge_mitj('+
                    'id_fam integer, '+
                    'familia varchar(35) with compression, '+
                    'marge_mig double '+
                    ')';
     q.ExecSQL;
     q.SQL.Text := 'select * from marge_mitj';
     q.Active := true;

     q2 := TADOQuery.Create(nil);
     q2.Connection := dm.CG;
     q2.SQL.Text := 'select * from families order by id_lin asc';
     q2.Active := true;
     q2.First;

     while not q2.Eof do
     begin
          q.Append;
          q.FieldValues['id_fam'] := q2.FieldByName('id').AsInteger;
          q.FieldValues['familia'] := q2.FieldByName('descr').AsString;
          q.FieldValues['marge_mig'] := 0;
          q.Post;

          q2.Next;
     end;

     q.Active := false;
     q.SQL.Text := 'select * from marge_mitj';
     q.Active := true;
     q.First;

     while not q.Eof do
     begin
          q2.Active := false;
          q2.SQL.Text := 'select (sum(marge)/count(*)) as marge_mig from c_ventes'+dLINIA.Caption + ' where id_ref in ('+s+') and id_fam = ' + q.FieldByName('id_fam').AsString;
          q2.Active := true;

          q.Edit;
          q.FieldValues['marge_mig'] := q2.FieldByName('marge_mig').AsFloat;
          q.Post;

          q.Next;
     end;

     f := TForm.Create(Application);
     f.Position := poScreenCenter;
     f.Width  := 700;
     f.Height := 500;

     v := TUDBView.Create(f);
     v.Parent := f;
     v.Align := alClient;
     v.Data.Table := 'marge_mitj';
     v.Data.PrimaryKey := 'id_fam';
     v.Data.OrderBy := 'familia asc';
     v.Data.Connection := dm.CT;
     v.Data.Active := true;
     v.Caption.Fixed := 'Marge mig segons famílies';
     v.AssignColumnInfo(CInfo[ctMargeMig],VisFields[ctMargeMig]);

     f.ClientWidth := v.TotalWidth;

     FCreate(f);
     f.ShowModal;

     Screen.Cursor := crHourGlass;

     s := v.ExportToXLS('',rwNoRaw,false);

     f.Free;

     if s = '' then
     begin
          Screen.Cursor := crDefault;
          modalresult := mrCancel;
          exit;
     end;

     try    Excel := CreateOleObject('Excel.Application');
     except raise exception.Create('Es requereix Excel instal·lat.');
     end;

     Excel.WorkBooks.Open(s);
     Excel.Visible := false;

     Excel.WorkBooks[1].Save;
     Excel.Quit;

     Screen.Cursor := crDefault;

     if (s <> '') and (mDLG('Obrir arxiu ' + s + ' a Excel ara?',mtInformation,[mbYes,mbNo]) = mrYes) then
     ShellExecute(Handle, 'open', PChar('explorer'),PChar(s), PChar(s),SW_SHOWNORMAL);

     modalresult := mrOk;
end;

end.
