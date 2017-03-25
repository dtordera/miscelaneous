unit ConfigRecord;

interface

uses classes, sysutils, forms;

type TConfigRecord = class(TComponent)
     private
          FRegistres : TStrings;
          FDefaultNames : TStrings;
          FOnSave    : TNotifyEvent;
          FOnLoad    : TNotifyEvent;
     protected
          procedure SetFRegistres(r : TStrings);
          procedure SetFDefaultNames(d : TStrings);
          procedure SetValor(const Name, Value : string); overload;
          function  GetValor(const Name : string) : string;
     public
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
          procedure Save;
          procedure Load; overload;
          procedure Load(n : string); overload;
          property R : TStrings read FRegistres write SetFRegistres;
          property Valor[const Name : string] : string read GetValor write SetValor; default;
     published
          property Registres : TStrings read FRegistres write SetFRegistres;
          property DefaultNames : TStrings read FDefaultNames write SetFDefaultNames;
          property OnLoad : TNotifyEvent read FOnLoad write FOnLoad;
          property OnSave : TNotifyEvent read FOnSave write FOnSave;
end;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('pkULIB',[TConfigRecord]);
end;

procedure TConfigRecord.Save;
var
     s : string;
begin
     s := ExtractFilePath(Application.ExeName) + 'STP\';
     Registres.SaveToFile(s + stringReplace(ExtractFileName(Application.ExeName),'.exe','.stp',[]));

     if Assigned(FOnSave) then FOnSave(self);
end;

procedure TConfigRecord.Load;
begin
      Load(Extractfilepath(Application.ExeName) + 'STP\' + stringReplace(ExtractFileName(Application.ExeName),'.exe','.stp',[]));
end;

procedure TConfigRecord.Load(n : string);
begin
     Registres.LoadFromFile(n);

     if Assigned(FOnLoad) then FOnLoad(self);
end;

procedure TConfigRecord.SetValor(const Name, Value : string);
begin
     try
     FRegistres.Values[Name] := Value;
     except
     raise Exception.Create('Error accedint a ' + Name + ' col·locant ' + Value);
     end;

     if Assigned(FOnSave) then FOnSave(self);
end;

function TConfigRecord.GetValor(const Name : string) : string;
begin
     try
     result := FRegistres.Values[Name];
     except
     result := '';
     end;
end;

procedure TConfigRecord.SetFRegistres(r : TStrings);
begin
     FRegistres.Assign(r);
end;

procedure TConfigRecord.SetFDefaultNames(d : TStrings);
begin
     FDefaultNames.Assign(d);
end;

constructor TConfigRecord.Create(AOwner : Tcomponent);
begin
     inherited Create(AOwner);

     FRegistres := TStringList.Create;
     FDefaultNames := TStringList.Create;
end;

destructor TConfigRecord.Destroy;
begin
     if Assigned(FDefaultNames) then FDefaultNames.Free;
     if Assigned(FRegistres) then FRegistres.Free;
     inherited Destroy;
end;

end.

