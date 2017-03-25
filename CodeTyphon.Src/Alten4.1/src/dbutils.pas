unit dbutils;

interface

uses ADOdb;

          function CompactAndRepair(DB: string) : boolean;
          function Tamany_de_(s : string) : string;
          function Crear_base_de_dades(n : string) : boolean;
          function ConnectString(s : string) : string;
          function ETaula(s : string; c : TADOConnection) : boolean;

implementation

uses comobj, sysutils, variants, windows, classes;

function ETaula(s : string; c : TADOConnection) : boolean;
var
     ss : TStrings;
begin
     ss := TStringList.Create;

     c.GetTableNames(ss);

     result := ss.IndexOf(s) <> -1;

     ss.Free;
end;

function CompactAndRepair(DB: string) : boolean;
var
  v: OLEvariant;
begin { CompactAndRepair }

  Result := True;
  try
     v := CreateOLEObject('JRO.JetEngine');
     v.CompactDatabase('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + DB,
                      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + DB +
                      'x;Jet OLEDB:Engine type=5');
     CopyFile(PChar(DB),PChar(DB+'k'),false);
     sysutils.DeleteFile(DB);
     RenameFile(DB + 'x', DB)
  except
     CopyFile(PChar(DB+'k'),PChar(DB),false);
     Result := False
  end;

  v := Unassigned;
end;

function Tamany_de_(s : string) : string;
var
        F : file;
        n : longint;
        nf : double;
begin
        AssignFile(F,s);        // asignem s
        reset(F,1);
        n := FileSize(F);
        nf := n / 1024;
        Tamany_de_ := FormatFloat('0 kb',nf);
        CloseFile(F);           // tanquem s
end;

function Crear_base_de_dades(n : string) : boolean;
var
        db : OleVariant;
        rs : boolean;
begin
        try     // intentant mitjan�ant dao
        db := CreateOleObject('dao.dbengine.36');
        db := db.CreateDatabase(n,';langid=0x040a;cp=1252;country=0;');
        rs := true;
        except
        rs := false;
        end;

        if not rs then // mitjant�ant ADOX
        try
        db := CreateOleObject('ADOX.Catalog');
        db.Create('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + n+ ';');
        rs := true;
        except
        rs := false;
        end;

        if not rs then // mitjan�ant access
        try
        db := CreateOleObject('Access.Application');
        db := db.NewCurrentDatabase(n);
        rs := true;
        except
        rs := false;
        end;

        Crear_base_de_dades := rs;
        db := unassigned;
end;

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

end.
