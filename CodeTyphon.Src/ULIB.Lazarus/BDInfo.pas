unit BDInfo;

interface

uses classes, stdctrls, ADOdb, sysutils;

type TBDInfoType = (biTables,biFields);

type TBDInfo = class(TCustomListBox)
     private
          bi : TBDInfoType;
          FConnection : TADOConnection;
          FTable : string;
          procedure PosaTaules;
          procedure PosaFields;
     protected
          procedure SetBi(b : TBDInfoType);
          procedure SetFConnection(ac : TADOConnection);
          procedure SetFTable(s : string);
     public
          constructor Create(AOwner : TComponent); override;
          function  Selected : string;
     published
          property InfoType : TBDInfoType read bi write SetBi;
          property Connection : TADOConnection read FConnection write SetFConnection;
          property Table : string read FTable write SetFTable;
          property Ctl3D;
          property Items;
          property Color;
          property BorderStyle;
          property Font;
          property OnClick;
          property OnDblClick;
          property OnEnter;
          property OnExit;
          property OnKeyDown;
end;

procedure Register;

implementation

constructor TBDInfo.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     FTable := '';
     FConnection := nil;
end;

procedure TBDInfo.SetBi(b : TBDInfoType);
begin
     bi := b;

     case bi of
     biTables : PosaTaules;
     biFields : PosaFields;
     end;
end;

function TBDInfo.Selected : string;
begin
     result := Items[ItemIndex];
end;

procedure TBDInfo.PosaTaules;
begin
     Items.Clear;

     if FConnection = nil then Items.Add('(void connection')
     else
     if FConnection.Connected then 
     FConnection.GetTableNames(Items);
end;

procedure TBDInfo.PosaFields;
var
     q : TADOQuery;
     i : integer;
begin
     self.Items.Clear;

     if FTable = '' then begin Items.Add('(no table name)'); exit; end;
     if FConnection = nil then begin Items.Add('(void connection)'); exit; end;

     q := TADOQuery.Create(self);
     q.Connection := FConnection;

     try
          q.Active := false;
          q.SQL.Text := 'select * from ' + FTable;
          q.Active := true;

          for i := 0 to q.FieldCount - 1 do
               self.Items.Add(inttostr(q.Fields[i].DisplayWidth) + '  ' +
               q.Fields[i].FieldName);
     except
          self.Items.Add('(error loading fields)');
     end;

     q.Free;
end;

procedure TBDInfo.SetFConnection(ac : TADOConnection);
begin
     FConnection := ac;

     case bi of
     biTables : PosaTaules;
     biFields : PosaFields;
     end;
end;

procedure TBDInfo.SetFTable(s : string);
begin
     FTable := s;

     case bi of
     biTables : PosaTaules;
     biFields : PosaFields;
     end;
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TBDInfo]);
end;

end.