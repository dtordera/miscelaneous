unit etorns;

interface

uses Dialogs, Estilcolor, Sysutils, Windows, StdCtrls, Forms, UText, Classes, Controls, ExtCtrls, MCEdit;

function TornObert : integer;
function Torn(id,camp : string) : string;

type
  T_etorns = class(TForm)
    dOBERTURA: TMCEdit;
    btOk: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
     id : integer;
  public
     function ObrirTorn : integer;
     function TornObert : integer;
     function Torn(id,camp : string) : string;
end;

implementation

uses dmsrc, ADOdb, main, caixa, global;

{$R *.DFM}

function TornObert : integer;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active   := false;
     q.SQL.Text := 'select * from torns_caixa where tancat = false';
     q.Active   := true;

     if q.RecordCount = 1
     then result := q.FieldByName('id').AsInteger
     else
     if q.RecordCount > 1
     then result := -2
     else
     result := -1;

     q.Free;
end;

function T_etorns.TornObert : integer;
begin
     result := TornObert;
end;

function T_etorns.ObrirTorn : integer;
begin
     result := -1;
     if ShowModal = mrOk
     then result := id;

     _main.PosaCaption;
end;

function Torn(id, camp : string) : string;
var
     q : TADOQuery;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;
     q.Active := false;
     q.SQL.Text := 'select * from torns_caixa where id = ' + id;
     q.Active := true;

     if q.RecordCount < 1 then result := '(not found)'
     else result := q.FieldByName(camp).AsString;

     q.Free;
end;

function T_etorns.Torn(id,camp : string) : string;
begin
     result := Torn(id,camp);
end;

procedure T_etorns.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;

     dOBERTURA.Date := now;
end;

procedure T_etorns.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
end;

procedure T_etorns.FormClose(Sender: TObject; var Action: TCloseAction);
var
     q : TADOQuery;
begin
     if Modalresult <> mrOk then exit;

     q := TADOQuery.Create(self);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select max(id) + 1 as maxim from torns_caixa';
     q.Active := true;

     id := q.FieldByName('maxim').AsInteger;

     q.Active := false;
     q.SQL.Text := 'select * from torns_caixa';
     q.Active := true;
     q.Append;
     q.FieldValues['id'] := id;
     q.FieldValues['obertura'] := dOBERTURA.Date;
     q.Post;

     q.Free;

     _caixa.v.Refresh;

     mDlg('Torn obert',mtInformation,[mbOk]);
end;

end.
