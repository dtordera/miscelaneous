unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UText, Comobj, DB, ADODB;

type
  T_main = class(TForm)
    UText1: TUText;
    UText2: TUText;
    UText3: TUText;
    UText5: TUText;
    SaveDialog: TSaveDialog;
    CG: TADOConnection;
    OpenDialog: TOpenDialog;
    UText6: TUText;
    procedure UText5React(Sender: TObject);
    procedure UText2React(Sender: TObject);
    procedure UText3Click(Sender: TObject);
    procedure UText6React(Sender: TObject);
    procedure UText1React(Sender: TObject);
  private
  public
  end;

function ConnectString(s : string) : string;

var
  _main: T_main;

implementation

uses visor;

{$R *.dfm}

function ConnectString(s : string) : string;
begin
     ConnectString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
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
          'Jet OLEDB:SFP=False';
end;

function Crear_base_de_dades(n : string) : boolean;
var
        db : OleVariant;
        rs : boolean;
begin
     try     // intentant mitjançant dao
        db := CreateOleObject('dao.dbengine.36');
        db := db.CreateDatabase(n,';langid=0x040a;cp=1252;country=0;');
        rs := true;
     except
        rs := false;
     end;

     if not rs then // mitjantçant ADOX
     try
        db := CreateOleObject('ADOX.Catalog');
        db.Create('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + n+ ';');
        rs := true;
     except
        rs := false;
     end;

     if not rs then // mitjançant access
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

procedure T_main.UText5React(Sender: TObject);
begin
     _visor.Show;
end;

procedure T_main.UText2React(Sender: TObject);
begin
     SaveDialog.Title := 'Crear nova base de dades';
     if SaveDialog.Execute
     then
     begin
          Crear_base_de_dades(SaveDialog.FileName);
          MessageDLG('Base de dades ' + SaveDialog.FileName + ' creada',mtInformation,[mbOk],0);
     end;
end;

procedure T_main.UText3Click(Sender: TObject);
var
     q : TADOQuery;
begin
     OpenDialog.Title := 'Crear taules';
     if OpenDialog.Execute
     then
     try
          CG.Connected := false;
          CG.ConnectionString := ConnectString(OpenDialog.FileName);

          CG.Connected := true;

          q := TADOQuery.Create(nil);
          q.Connection := CG;

          q.Active := false;

          // Taula articles
          try
          q.SQL.Text := 'drop table articles';
          q.ExecSQL;
          q.SQL.Text := 'drop table personals';
          q.ExecSQL;
          q.SQL.Text := 'drop table averies';
          q.ExecSQL;
          q.SQL.Text := 'drop table ventesA';
          q.ExecSQL;
          q.SQL.Text := 'drop table ventesB';
          q.ExecSQL;
          q.SQL.Text := 'drop table pressupostos';
          q.ExecSQL;
          q.SQL.Text := 'drop table entrades';
          q.ExecSQL;
          q.SQL.Text := 'drop table c_ventesA';
          q.ExecSQL;
          q.SQL.Text := 'drop table c_ventesB';
          q.ExecSQL;
          q.SQL.Text := 'drop table c_pressupostos';
          q.ExecSQL;
          q.SQL.Text := 'drop table c_entrades';
          q.ExecSQL;
          q.SQL.Text := 'drop table c_aveart';
          q.ExecSQL;
          q.SQL.Text := 'drop table c_aveint';
          q.ExecSQL;
          q.SQL.Text := 'drop table magatzem';
          q.ExecSQL;
          q.SQL.Text := 'drop table poblacions';
          q.ExecSQL;
          except
          end;

          q.SQL.text :=  'create table articles('+
                         'id integer primary key,'+
                         'DESCR varchar(65) with compression,'+
                         'PVP double,'+
                         'STOCK bit,'+
                         'FAMILIA varchar(35) with compression,'+
                         'MARCA varchar(25) with compression,'+
                         'LINIA varchar(25) with compression,'+
                         'PBase double,'+
                         'PCost double,'+
                         'PRec double,'+
                         'PMin double,'+
                         'Marge double,'+
                         'Marge_mar double,'+
                         'DATA_REGISTRE date,'+
                         'id_mar integer,'+
                         'id_fam integer,'+
                         'id_lin integer,'+
                         'codi_barres varchar(255) with compression'+
                         ')';
          q.ExecSQL;

          // Taula personals
          q.SQL.text := 'create table personals('+
                        'id integer primary key, '+
                        'tipus varchar(1) with compression, ' +
                        'NOM varchar(150) with compression, '+
                        'NIF varchar(15) with compression, '+
                        'TEL varchar(50) with compression, '+
                        'DIR varchar(50) with compression, '+
                        'POB varchar(30) with compression, '+
                        'CP varchar(5) with compression, '+
                        'OBS memo with compression, '+
                        'A_COMPTE double, ' +
                        'EN_DEUTE double, ' +
                        'ULTIMA_ACCIO date, ' +
                        'repetit integer' +
                        ')';
          q.ExecSQL;

          // Taula averies
          q.SQL.Text := 'create table averies('+
                        'id integer primary key, '+
                        'DATA date, '+
                        'id_CLI int, '+
                        'NOM_CLI varchar(150) with compression, '+
                        'ANOMALIES memo with compression, '+
                        'GARANTIA bit, '+
                        'REP_A_DOMICILI bit, '+
                        'DISP_HOR varchar(30) with compression, '+
                        'DATA_VISITA date, '+
                        'REP_EXTERNA bit, '+
                        'ENVIAT bit, '+
                        'DATA_ENVIAMENT date, '+
                        'REF_ORIGEN int,'+
                        'REF_ORIGEN_LIN varchar(1), '+
                        'REF_FACTURA int, '+
                        'REF_FACTURA_LIN varchar(1), '+
                        'DATA_ENTRADA date, '+
                        'DATA_ENTREGA date, '+
                        'REP_FINALITZADA bit, '+
                        'DATA_REPARACIO date, ' +
                        'id_REP int, '+
                        'NOM_REP varchar(150) with compression, '+
                        'DIR_CLI varchar(50) with compression, '+
                        'TEL_CLI varchar(50) with compression, '+
                        'NIF_CLI varchar(15) with compression, '+
                        'POB_CLI varchar(30) with compression, '+
                        'CP_CLI  varchar(5) with compression, '+
                        'LIN_FACT varchar(1) with compression, '+
                        'OBSERVACIONS memo with compression, '+
                        'ATES_PER varchar(15) with compression,'+
                        'n_serie memo with compression '+
                        ')';
          q.ExecSQL;

          // taula de ventes (A)
          q.SQL.Text := 'create table ventesA('+
                        'id integer primary key, '+
                        'DATA date, '+
                        'PAGADA bit, '+
                        'NOM_CLI varchar(150) with compression, '+
                        'TOTAL double, '+
                        'BASE double, '+
                        'IVA  double, '+
                        'IVA_P double, '+
                        'DESCOMPTE double, '+
                        'DESCOMPTE_P double, '+
                        'SUBTOTAL double, '+
                        'PENDENT double, '+
                        'A_COMPTE double, '+
                        'DATA_COBRO date, '+
                        'REF_pressupost integer, '+
                        'REF_AVERIA integer, '+
                        'ABONAMENT_DE integer, '+
                        'ABONADA bit, '+
                        'linea_venta varchar(15) with compression, '+
                        'id_linea_venta integer, '+
                        'id_CLI int, '+
                        'DIR_CLI varchar(50) with compression, '+
                        'TEL_CLI varchar(50) with compression, '+
                        'NIF_CLI varchar(15) with compression, '+
                        'POB_CLI varchar(30) with compression, '+
                        'CP_CLI  varchar(5) with compression, '+
                        'OBSERVACIONS memo with compression, '+
                        'ates_per varchar(15) with compression,'+
                        'n_serie memo with compression'+
                        ')';
          q.ExecSQL;

          // taula ventes (B)
          q.SQL.Text := 'select * into ventesB from ventesA where id = 0';
          q.ExecSQL;

          // taula de pressupostos
          q.SQL.Text := 'create table pressupostos('+
                        'id integer primary key, '+
                        'DATA date, '+
                        'REALITZAT bit, '+
                        'NOM_CLI varchar(150) with compression, '+
                        'TOTAL double, '+
                        'BASE double, '+
                        'IVA  double, '+
                        'IVA_P double, '+
                        'DESCOMPTE double, '+
                        'DESCOMPTE_P double, '+
                        'SUBTOTAL double, '+
                        'REF_FACTURA integer, '+
                        'REF_FACTURA_LIN varchar(1), '+
                        'id_CLI int, '+
                        'DIR_CLI varchar(50) with compression, '+
                        'TEL_CLI varchar(50) with compression, '+
                        'NIF_CLI varchar(15) with compression, '+
                        'POB_CLI varchar(30) with compression, '+
                        'CP_CLI  varchar(5)  with compression, '+
                        'OBSERVACIONS memo   with compression, '+
                        'ATES_PER varchar(15) with compression, '+
                        'N_SERIE memo with compression, '+
                        'PEU varchar(255) with compression '+
                        ')';
          q.ExecSQL;

          // taula d'entrades
          q.SQL.Text := 'create table entrades('+
                        'id integer primary key, '+
                        'DATA date, '+
                        'REF_ALBARA varchar(15) with compression, '+
                        'PAGADA bit, '+
                        'NOM_PRV varchar(150) with compression, '+
                        'TOTAL double, '+
                        'BASE double, '+
                        'IVA  double, '+
                        'IVA_P double, '+
                        'id_PRV int, '+
                        'DIR_PRV varchar(50) with compression, '+
                        'TEL_PRV varchar(50) with compression, '+
                        'NIF_PRV varchar(15) with compression, '+
                        'POB_PRV varchar(30) with compression, '+
                        'CP_PRV  varchar(5)  with compression, '+
                        'OBSERVACIONS memo   with compression'+
                        ')';
          q.ExecSQL;

          // taula poblacions
          q.SQL.Text := 'create table poblacions('+
                        'id integer primary key, '+
                        'poblacio varchar(30) with compression, ' +
                        'cp varchar(5) with compression '+
                        ')';
          q.ExecSQL;

          // taula conceptes
          q.SQL.Text := 'create table c_ventesA('+
                        'id integer primary key, '+
                        'id_ref integer, '+
                        'id_elem integer, '+
                        'id_lin integer, '+
                        'concepte memo with compression, '+
                        'uts double, '+
                        'preu double, '+
                        'import double, '+
                        'marge double,'+
                        'id_fam integer'+
                        ')';

          q.ExecSQL;
          q.SQL.Text := 'select * into c_ventesB from c_ventesA where id = 0';
          q.ExecSQL;
          q.SQL.Text := 'select * into c_pressupostos from c_ventesA where id = 0';
          q.ExecSQL;
          q.SQL.Text := 'select * into c_aveint from c_ventesA where id = 0';
          q.ExecSQL;
          q.SQL.Text := 'alter table c_aveint drop preu,import';
          q.ExecSQL;
          q.SQL.Text := 'select * into c_aveart from c_aveint where id = 0';
          q.ExecSQL;
          q.SQL.Text := 'select * into c_entrades from c_ventesA where id = 0';
          q.ExecSQL;

          // taula torns_caixa

          q.SQL.Text := 'create table torns_caixa('+
                        'id integer, '+
                        'tancat bit, '+
                        'reobert bit, '+
                        'obertura datetime, '+
                        'tancament datetime, '+
                        'n_ventes_torn integer, '+
                        'n_ventes_A integer, '+
                        'n_ventes_B integer, '+
                        'total_A double, '+
                        'total_B double, '+
                        'total_torn double, '+
                        'base_A double, '+
                        'base_B double, '+
                        'base_torn double, '+
                        'iva_A double, '+
                        'iva_B double, '+
                        'iva_torn double, '+
                        'descomptes_torn double, '+
                        'descomptes_A double, '+
                        'descomptes_B double, '+
                        'total_directe double '+
                        ')';
          q.ExecSQL;

          // taula conceptes caixa
          q.SQL.Text :=  'create table c_caixa('+
                         'linea_fact varchar(1), '+
                         'venta integer, '+
                         'tipus_pagament varchar(1), '+
                         'cobrat double, '+
                         'base double, '+
                         'iva double, '+
                         'descompte double, '+
                         'comentari varchar(255) with compression, '+
                         'data date, '+
                         'id_torn integer, '+
                         'id integer '+
                         ')';
          q.ExecSQL;

          // taula magatzem
          q.SQL.text := 'create table magatzem('+
                        'id integer,'+
                        'DESCR varchar(65) with compression primary key,'+
                        'uts_anteriors double,'+
                        'uts_actuals double,'+
                        'ultima_mod datetime'+
                        ')';
          q.ExecSQL;

          // taula linies
          q.SQL.Text := 'create table linies('+
                        'id integer primary key, '+
                        'descr varchar(25) with compression '+
                        ')';
          q.ExecSQL;

          // taula families
          q.SQL.Text := 'create table families('+
                        'id integer primary key, '+
                        'descr varchar(35) with compression, '+
                        'id_lin integer '+
                        ')';
          q.ExecSQL;

          // taula marques
          q.SQL.Text := 'create table marques('+
                        'id integer primary key, '+
                        'descr varchar(25) with compression, '+
                        'marge double '+
                        ')';
          q.ExecSQL;

          MessageDLG('Taules creades',mtInformation,[mbOk],0);
     finally
     q.Free;
     end;
end;

procedure T_main.UText6React(Sender: TObject);
begin
     OpenDialog.Title := 'Eliminar fitxer';
     if OpenDialog.Execute then
     case MessageDLG('Eliminar fitxer ' + OpenDialog.Filename + '. Continuar?',mtWarning,[mbYes,mbNo],0) of
     mrYes :   try    DeleteFile(OpenDialog.FileName);
               except MessageDLG('Error intentant eliminar fitxer ' + OpenDialog.Filename,mtError,[mbOk],0);
               end;
     end;
end;

function CompactAndRepair(DB: string) : boolean;
var
  v: OLEvariant;
begin { CompactAndRepair }
  Result := True;
  try
    v := CreateOLEObject('JRO.JetEngine');
    try
      v.CompactDatabase('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + DB,
                        'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + DB +
                        'x;Jet OLEDB:Engine type=5');
      DeleteFile(DB);
      RenameFile(DB + 'x', DB)
    finally
      v := Unassigned
    end; { try }

  except
    Result := False
  end; { try }
end;

procedure T_main.UText1React(Sender: TObject);
begin
     OpenDialog.Title := 'Compactar i reparar';
     if OpenDialog.Execute then
     case CompactAndRepair(OpenDialog.Filename) of
     true  : MessageDLG('Base de dades compactada',mtInformation,[mbOk],0);
     false : MessageDLG('Error intentant compactar i reparar base de dades',mtError,[mbOk],0);
     end;
end;

end.
