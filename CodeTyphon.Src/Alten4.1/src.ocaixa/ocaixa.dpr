program ocaixa;

uses
  Forms, URaw, classes, sysutils, configrecord;

var
     impres_tick  : string;
     seq_obertura : string;

{$R *.RES}

function BINDir : string;
begin
     BINdir := ExtractFilePath(Application.Exename);
end;

procedure Llegir_Ini;
var
     CR : TConfigRecord;
begin
     CR := TConfigRecord.Create(nil);
     CR.Load(BINDIR + 'STP\alten4.stp');

     impres_tick := CR['IMPRESORA_2'];
     seq_obertura:= CR['SEQ_OPERTURA'];

     CR.Free;
end;

procedure Enviar_seq_obertura(s : string);
var
        sl : TStringList;
        xPrn: TRawPrint;
        i : integer;
begin
        sl := TStringList.Create;

        sl.commatext := s;
        xPrn := TRawPrint.Create;
        xPrn.PrinterName := impres_tick;
        xPrn.Document := 'opertura';

        if xPrn.Open = False then
        raise exception.Create('Error a impresora.');

        for i := 0 to sl.Count do
        try
        xPrn.Write(Chr(strtoint(sl[i])));
        except
        end;

        xPrn.Close;
        xPrn.Free;

        sl.Free;
end;

begin
     Llegir_INI;
     Enviar_seq_obertura(seq_obertura);
end.
