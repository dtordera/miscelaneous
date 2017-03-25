unit sumcli;

interface

uses Windows, LlistCfg,Controls, StdCtrls, UText, ULabel, Classes, db, Forms, Dialogs, graphics, sysutils, ComObj, ShellApi;

type
  T_sumcli = class(TForm)
    UText12: TUText;
    UText1: TUText;
    UText2: TUText;
    UText3: TUText;
    UText4: TUText;
    btEntrar: TUText;
    dLINIA: TMLabel;
    dDATA_INICI: TDLabel;
    dDATA_FINAL: TDLabel;
    dSUMA_INF: TNLabel;
    dSUMA_SUP: TNLabel;
    procedure FormCreate(Sender: TObject);
    procedure Fcreate(sender : TObject);
    procedure btEntrarReact(Sender: TObject);
    procedure vDrawRow(sender: TObject; R: TRect; F: TField; FS: Boolean; C: TCanvas);
  private
  public
  end;

implementation

uses dmsrc, ADOdb, udbview, udbvaux, global, estilcolor, dbutils;

{$R *.dfm}

procedure T_sumcli.FormCreate(Sender: TObject);
var
     y,m,d : word;
     dt : TDateTime;
begin
     mDlg('Atenció : aquesta suma té en compte només les dades totals (TOTAL,BASE,IVA,DESCOMPTE), això és, no té en compte si les ventes han estat o no pagades parcial o totalment.',mtInformation,[mbOk]);

     _estilcolor.Apply(sender as TCustomForm,false);

     DecodeDate(date,y,m,d);

     y := y - 1;

     dt := EncodeDate(y,1,1);
     dDATA_INICI.Date := dt;
     dt := EncodeDate(y,12,31);
     dDATA_FINAL.Date := dt;
end;

procedure T_sumCli.Fcreate(sender : TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,false);
end;

procedure T_sumcli.vDrawRow(sender: TObject; R: TRect; F: TField;
  FS: Boolean; C: TCanvas);
var
     l : double;
     cl : TColor;
begin
     l := (sender as TUDBView).FieldByName('SUBTOTAL').AsFloat;

     cl := clNone;

     if l >= dSUMA_SUP.Value then cl := clAqua;

     if not FS and (cl <> clNone) then
     begin
          c.Brush.Color := cl;
          c.Font.Color := NegLumColor(cl);
     end;
end;

procedure T_sumcli.btEntrarReact(Sender: TObject);
var
     q : TADOQuery;
     v : TUDBView;
     f : TForm;
     s : string;
     n : integer;
     i : integer;
     excel : variant;
     d : double;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;

     if ETaula('suma_clients',q.Connection) then
     begin
           q.SQL.Text := 'drop table suma_clients';
           q.ExecSQL;
     end;

     q.SQL.Text := 'select id_cli,nom_cli,dir_cli,sum(base) as base,sum(iva) as iva,sum(subtotal) as subtotal,'+
     'sum(descompte) as descompte, sum(total) as total into suma_clients from ventes'+dLINIA.Caption+ ' in ''' + dm.CR['DATABASE'] + ''' where (data >= ' + FormatSQLDate(dDATA_INICI.Date) + ') and (data < ' + FormatSQLDate(dDATA_FINAL.Date+1) + ') group by id_cli,nom_cli,dir_cli ';
     q.ExecSQL;

     q.SQL.Text := 'delete * from suma_clients where subtotal < ' + StringReplace(FormatFloat('0.00',dSUMA_INF.Value),',','.',[]);
     q.ExecSQL;

     q.SQL.Text := 'select * from suma_clients';
     q.Active := true;

     n := q.RecordCount;

     q.Free;

     f := TForm.Create(Application);
     f.Position := poScreenCenter;
     f.Width  := 700;
     f.Height := 500;

     v := TUDBView.Create(f);
     v.Parent := f;
     v.Align := alClient;
     v.Data.Table := 'suma_clients';
     v.Data.PrimaryKey := 'id_cli';
     v.Data.OrderBy := 'nom_cli asc';
     v.OnDrawRow := vDrawRow;
     v.Data.Connection := dm.CT;
     v.Data.Active := true;
     v.Caption.Fixed := 'Suma segons clients';
     v.AssignColumnInfo(CInfo[ctSumCli],VisFields[ctSumCli]);
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

     for i := 6 to n + 1 + 6 do
     begin
          try    d := strtofloat(Excel.Cells[i,4].Value);
          except d := 0;
          end;

          if d >= dSUMA_SUP.value then
          begin
               Excel.Cells[i,2].Interior.Color  := clAqua;
               Excel.Cells[i,3].Interior.Color  := clAqua;
               Excel.Cells[i,4].Interior.Color  := clAqua;
               Excel.Cells[i,5].Interior.Color  := clAqua;
               Excel.Cells[i,6].Interior.Color  := clAqua;
               Excel.Cells[i,7].Interior.Color  := clAqua;
               Excel.Cells[i,8].Interior.Color  := clAqua;
               Excel.Cells[i,9].Interior.Color  := clAqua;
               Excel.Cells[i,10].Interior.Color := clAqua;
               Excel.Cells[i,11].Interior.Color := clAqua;
          end;
     end;

     Excel.WorkBooks[1].Save;
     Excel.Quit;

     Screen.Cursor := crDefault;

     if (s <> '') and (mDLG('Obrir arxiu ' + s + ' a Excel ara?',mtInformation,[mbYes,mbNo]) = mrYes) then
     ShellExecute(Handle, 'open', PChar('explorer'),PChar(s), PChar(s),SW_SHOWNORMAL);

     modalresult := mrOk;
end;

end.
