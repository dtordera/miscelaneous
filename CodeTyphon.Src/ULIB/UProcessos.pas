unit UProcessos;

interface

uses classes, extctrls;

type TUProcessos = class(TComponent)
     private
          VProcessos : TStrings;
          VCancelar : boolean;
     protected
          procedure SetVCancelar(b : boolean);
          procedure SetVProcessos(S : TStrings);
          procedure UpdateCaption(sender : TObject);
          function  GetInterval : integer;
          procedure SetInterval(i : integer);
     public
          constructor Create(AOwner : TComponent); override;
          destructor  Destroy; override;
     public
          function  Progress : string;
          function  ProcessosActius : integer;
          procedure CancelarProcessos;
          function  AfegeixProces(s : string) : boolean;
          procedure EliminaProces(s : string);
          function  ComprobaProces(s : string) : boolean;
     published
          property Processos : TStrings read VProcessos write SetVProcessos;
          property Cancelar  : boolean read VCancelar write SetVCancelar;
          property Interval : integer read GetInterval write SetInterval;
end;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('pkULIB',[TUProcessos]);
end;

procedure TUProcessos.SetInterval(i : integer);
begin
end;

function TUProcessos.ComprobaProces(s : string) : boolean;
begin
     result := VProcessos.IndexOf(s) > -1;
end;

function TUProcessos.GetInterval : integer;
begin
end;

function TUProcessos.Progress : string;
begin
end;

constructor TUProcessos.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
     VProcessos := TStringList.Create;

     Cancelar := true;
end;

procedure TUProcessos.UpdateCaption(sender : TObject);
begin
end;

destructor TUProcessos.Destroy;
begin
     if Assigned(VProcessos)    then VProcessos.Free;
     inherited Destroy;
end;

procedure TUProcessos.SetVProcessos(S : TStrings);
begin
     VProcessos.Assign(S);
     Cancelar := not (VProcessos.Count > 0);
end;

function TUProcessos.ProcessosActius : integer;
begin
     result := VProcessos.Count;
end;

procedure TUProcessos.CancelarProcessos;
begin
     VProcessos.Clear;
     Cancelar := true;
end;

procedure TUProcessos.EliminaProces(s : string);
var
     ix : integer;
begin
     ix := VProcessos.IndexOf(s);
     try
     VProcessos.Delete(ix);
     except
     end;
end;

procedure TUProcessos.SetVCancelar(b : boolean);
begin
     VCancelar := b;
end;

function TUProcessos.AfegeixProces(s : string) : boolean;
begin
     if VProcessos.IndexOf(s) <> - 1 then result := false
     else
     begin
          VProcessos.Add(s);
          Cancelar := not (VProcessos.Count > 0);
          result := true;
     end;
end;

end.
