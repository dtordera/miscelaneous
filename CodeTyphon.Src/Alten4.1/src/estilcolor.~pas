unit estilcolor;

interface

uses classes, Forms, RTScriptFnc;

type TEstilColor = class(TObject)
     private
     public
          Active : boolean;
          Lines  : TStrings;
          constructor Create;
          destructor Destroy; override;
          procedure  Apply(f : TCustomForm; NoForm : boolean = false);
          procedure  Load(s : string);
     published
end;

var
     _estilcolor : TEstilColor;

implementation

constructor TEstilColor.Create;
begin
     inherited Create;
     Lines := TStringList.Create;
end;

destructor TEstilColor.Destroy;
begin
     if Assigned(Lines) then Lines.Free;
     inherited Destroy;
end;

procedure TEstilColor.Load(s : string);
begin
     try    Lines.LoadFromFile(s);
     except Active := false;
     end;
end;

procedure TEstilColor.Apply(f : TCustomForm; NoForm : boolean);
var
     i,j : integer;
     s,r : string;
     P   : TPersistentClass;
     C   : TComponentClass;
begin
     f.Doublebuffered := true;
     f.Font.Name := 'MS Sans serif';
     f.Font.Size := 8;

     (f as TForm).Scaled := false;
     (f as TForm).PrintScale := poNone;

     if not Active then exit;     

     for i := 0 to Lines.Count - 1 do
     begin
          s := First(Lines[i]);
          r := Rest(Lines[i]);

          if s = '' then continue;

          P := classes.getclass(s);
          C := TComponentClass(P);

          if (f is C) and (not NoForm) then setprop(f,r)
          else
          for j := 0 to f.ComponentCount - 1 do
               if (f.Components[j] is C) then SetProp(f.Components[j],r)
     end;
end;

end.
