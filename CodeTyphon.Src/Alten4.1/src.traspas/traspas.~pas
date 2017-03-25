unit traspas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ULabel;

type
  TForm1 = class(TForm)
    LLabel1: TLLabel;
    b2: TLLabel;
    Button1: TButton;
    CG: TADOConnection;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    procedure LLabel1Load(sender: TObject; var Accept: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function ConnectString(s : string) : string;
begin
     ConnectString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +   // creem una conection sring standard
          'Password="";User ID=Admin;Data Source=' + s + ';' +
          'Mode=Share Deny None;Extended Properties="";' +
          'Jet OLEDB:System database="";' +
          'Jet OLEDB:Registry Path="";' +
          'Jet OLEDB:Database Password="";' +
          'Jet OLEDB:Engine Type=5;' +
          'Jet OLEDB:Database Locking Mode=1;' +
          'Jet OLEDB:Global Partial Bulk Ops=2;' +
          'Jet OLEDB:Global Bulk Transactions=1;' +
          'Jet OLEDB:New Database Password="";' +
          'Jet OLEDB:Create System Database=False;' +
          'Jet OLEDB:Encrypt Database=False;' +
          'Jet OLEDB:Don''t Copy Locale on Compact=False;' +
          'Jet OLEDB:Compact Without Replica Repair=False;' +
          'Jet OLEDB:SFP=False;';
end;

procedure TForm1.LLabel1Load(sender: TObject; var Accept: Boolean);
begin
     CG.Connected := false;
     CG.ConnectionString := ConnectString((sender as TCustomULabel).Caption);
     CG.Connected := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
     q : TADOQuery;
     q2 : TADOQuery;
     s : string;
begin
     s := b2.Caption;

     q := TADOQuery.Create(nil);
     q.Connection := CG;

     q2 := TADOQuery.Create(nil);
     q2.Connection := CG;

     q.Active := false;
     try
     q.SQL.Text := 'drop table clients_nou';
     q.ExecSQL;
     except
     end;

     q.Active := false;
     q.SQL.Text := 'select * into clients_nou from tCLIENT in ''' + s + '''';
     q.ExecSQL;

     q.SQL.Text := 'select * from clients_nou order by id asc';
     q.Active := true;
     q.First;

     q2.SQL.Text := 'delete * from personals';
     q2.ExecSQL;

     q2.SQL.Text := 'select * from personals';
     q2.Active := true;

     while not q.Eof do
     begin
          q2.Append;
          q2.FieldValues['id'] := q.FieldByName('id').AsInteger;
          q2.FieldValues['NOM'] := q.FieldByName('NOM').AsString;
          q2.FieldValues['NIF'] := q.FieldByName('NIF').AsString;
          q2.FieldValues['TEL'] := q.FieldByName('TEL').AsString;
          q2.FieldValues['DIR'] := q.FieldByName('DIR').AsString;
          q2.FieldValues['POB'] := q.FieldByName('POB').AsString;
          q2.FieldValues['CP']  := q.FieldByName('CP').AsString;
          q2.FieldValues['A_COMPTE'] := 0;
          q2.FieldValues['EN_DEUTE'] := 0;
          q2.FieldValues['ULTIMA_ACCIO'] := q.FieldByName('ULTIMA_ACCIO').AsDateTime;
          q2.FieldValues['REPETIT'] := 0;
          q2.FieldValues['TIPUS'] := 'C';
          q2.FieldValues['OBS'] := q.FieldByName('OBS').AsString;
          q2.Post;

          Label3.Caption := inttostr(q.RecNo) + ' / ' + inttostr(q.RecordCount);
          Application.ProcessMessages;

          q.Next;
     end;

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


     q2.Free;
     q.Free;
end;

end.
