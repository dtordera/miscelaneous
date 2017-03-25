unit mdant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, estilcolor, StdCtrls, ULabel, UText, ADOdb;

type
  T_mdant = class(TForm)
    UText2: TUText;
    dFINSA: TDLabel;
    btEntrar: TUText;
    procedure FormCreate(Sender: TObject);
    procedure btEntrarReact(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses dmsrc, dbutils, global;

procedure T_mdant.FormCreate(Sender: TObject);
var
     a,m,d : word;
begin
     _estilColor.Apply(self);

     DecodeDate(now,a,m,d);

     dFINSA.Date := strtodate('31/12/'+inttostr(a-3));
end;

procedure T_mdant.btEntrarReact(Sender: TObject);
var
     q : TADOQuery;
     c : TADOConnection;
     s : TSaveDialog;
     n : string;
     d : string;
begin
     s := TSaveDialog.Create(nil);
     s.Title := 'Guardar dades antigues a';
     s.FileName := 'alten41_fins_'+stringReplace(FormatDateTime('ddddd',dFINSA.Date),'/','_',[rfReplaceAll])+'.mdb';
     s.Filter := 'Fitxers de base de dades (*.mdb)|*.mdb|Tots els fitxers (*.*)|*.*';

     if not s.execute then begin s.Free; exit; end;

     n := s.FileName;
     s.Free;

     CompactAndRepair(dm.CR['DATABASE']);

     if FileExists(n)
     and (mDlg('El fitxer ' + n + ' existeix. Sobreescriure?',mtWarning,[mbYes,mbNo]) <> mrYes)
     then exit;

     try  CopyFile(PAnsiChar(dm.CR['DATABASE']),PAnsiChar(n),false)
     except
     raise;
     end;

     d := FormatSQLDate(dFINSA.Date);

     c := TADOConnection.Create(nil);
     c.ConnectionString := ConnectString(n);
     c.LoginPrompt := false;
     c.Connected := true;

     q := TADOQuery.Create(nil);
     q.Connection := c;

     q.SQL.Text := 'delete * from articles';
     q.ExecSQL;
     q.SQL.Text := 'delete * from linies';
     q.ExecSQL;
     q.SQL.Text := 'delete * from marques';
     q.ExecSQL;
     q.SQL.Text := 'delete * from families';
     q.ExecSQL;
     q.SQL.Text := 'delete * from magatzem';
     q.ExecSQL;
     q.SQL.Text := 'delete * from ventesA where data > ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_ventesA where id_ref not in (select id from ventesA)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from ventesB where data > ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_ventesB where id_ref not in (select id from ventesB)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from averies where data > ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_aveart where id_ref not in (select id from averies)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_aveint where id_ref not in (select id from averies)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from pressupostos where data > ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_pressupostos where id_ref not in (select id from pressupostos)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from entrades where data > ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_entrades where id_ref not in (select id from entrades)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from torns_caixa where tancament > ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_caixa where id_torn not in (select id from torns_caixa)';
     q.ExecSQL;

     c.Free;

     q.Connection := dm.CG;

     q.SQL.Text := 'delete * from ventesA where data <= ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_ventesA where id_ref not in (select id from ventesA)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from ventesB where data <= ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_ventesB where id_ref not in (select id from ventesB)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from averies where data <= ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_aveart where id_ref not in (select id from averies)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_aveint where id_ref not in (select id from averies)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from pressupostos where data <= ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_pressupostos where id_ref not in (select id from pressupostos)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from entrades where data <= ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_entrades where id_ref not in (select id from entrades)';
     q.ExecSQL;
     q.SQL.Text := 'delete * from torns_caixa where tancament <= ' + d;
     q.ExecSQL;
     q.SQL.Text := 'delete * from c_caixa where id_torn not in (select id from torns_caixa)';
     q.ExecSQL;
     q.Free;

     mDlg('Base de dades ' + n + ' creada. Dades mogudes. S''haurà de reiniciar el programa per reflectir la base de dades actualtizada.',mtInformation,[mbOk]);

     Application.Terminate;

     modalresult := mrOk;
end;

end.
