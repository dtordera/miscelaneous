unit URaw;
{
Unit to print raw text
Author: Alejandro Castro
Date 16/Jul/2000
}

interface

uses SysUtils, Windows, WinSpool;

type
  TRawPrint = class(TObject)

  private
    xIsOpen: Boolean;
    xHandle: THandle;
    xBytesWritten: DWord;
    xDocInfo: TDocInfo1;
    xIsMatrix: Boolean; // is a matrix printer ?
    function ReadLasPrt: Boolean;
    procedure WriteLasPrt(const Value: Boolean);
    function ReadMatPrt: Boolean;
    procedure WriteMatPrt(const Value: Boolean);

  public
    Row: Integer; // current row
    Column: Integer; // current column
    RowsPage: Integer; // no. of rows per page
    Document: string; // name of the document for winspool
    PrinterName: string; // name of the raw printer
    Condensed: Boolean; // print on condensed mode
    SeqCondensed: string; // sequence of chars for print to 16 cpi
    SeqNormal: string; // sequence of chars for print to 10 cpi


    constructor Create;
    function Open: Boolean; // open the printer
    function Close: Boolean; // close the printer
    function InitPrinter: Boolean;
    function Write(xText: string): Boolean;
    procedure SetPos(xRow, xCol: Integer);
    procedure Go(xRow, xCol: Integer); // force to move the head of the printer
    procedure GoTop; // go to the begining of the next page or form
    procedure NewPage; // form feed
    procedure writeLn(s : string);
    procedure Print(xRow, xCol: Integer; xText: string);
      // print xText on the row, col
    property MatrixPrinter: Boolean read ReadMatPrt write WriteMatPrt;
    property LaserPrinter: Boolean read ReadLasPrt write WriteLasPrt;

  end;

implementation

constructor TRawPrint.Create;
begin
  Row := 0;
  Column := 0;
  RowsPage := 66;
  xIsOpen := False;
  Condensed := False;
  Document := 'alten_ticket';
  PrinterName := '';
  MatrixPrinter := True;
end;

function TRawPrint.ReadMatPrt: Boolean;
begin
  Result := xIsMatrix;
end;

procedure TRawPrint.WriteMatPrt(const Value: Boolean);
begin
  xIsMatrix := Value;
  SeqNormal := #18;
  SeqCondensed := #15;
end;

procedure TRawPrint.WriteLasPrt(const Value: Boolean);
begin
  xIsMatrix := not Value;
  SeqNormal := #27 + '&l6D' + #27 + '(s0p10H';
  SeqCondensed := #27 + '&l6D' + #27 + '(s0p16.66H';
end;

function TRawPrint.ReadLasPrt: Boolean;
begin
  Result := not xIsMatrix;
end;

function TRawPrint.Open: Boolean;
begin
  Result := False;
  if not xIsOpen then
  begin
    if PrinterName <> '' then
    begin
      if Document = '' then
        Document := 'swave_raw';

      with xDocInfo do
      begin
        pDocName := PChar(Document);
        pOutputFile := nil;
        pDatatype := 'RAW';
      end;
      Result := OpenPrinter(PChar(PrinterName), xHandle, nil);
      if Result then
      begin
        Row := 0;
        Column := 0;
        if StartDocPrinter(xHandle, 1, @xDocInfo) = 0 then
        begin
          Result := False;
          ClosePrinter(xHandle);
        end;
      end;
    end;
    xIsOpen := Result;
  end;
end;

function TRawPrint.Close: Boolean;
begin
    Result := False;
  if xIsOpen then
    Result := ClosePrinter(xHandle);
end;

procedure TRawPrint.SetPos(xRow, xCol: Integer);
begin
  Column := xCol;
  Row := xRow;
end;

function TRawPrint.InitPrinter: Boolean;
begin
  Column := 0;
  Row := 0;
  if Condensed then
    Write(SeqCondensed + #13)
  else
    Write(SeqNormal + #13);

  Result := True;
end;

procedure TRawPrint.Go(xRow, xCol: Integer);
var
  i: Integer;
begin
  if Row > xRow then
    GoTop;


  if Column > xCol then
  begin
    Write(#13);
    Column := 0;
  end;

  i := Column;
  if i <> xCol then
    Write(Format('%-*s', [xCol - Column, '']));

  Column := xCol;
end;

procedure TRawPrint.GoTop;
begin
  Go(RowsPage, 0);
  Column := 0;
  Row := 0;
end;

procedure TRawPrint.Print(xRow, xCol: Integer; xText: string);
begin
  go(xRow, xCol);
  if Write(xText) then
    Column := Column + xBytesWritten;
end;

procedure TRawPrint.WriteLN(s : string);
var
        l : integer;
        i : integer;
begin
        l := strLen(PChar(s));
        for i := 0 to l - 1 do
        write(s[i]);

        write(#13#10);
end;

procedure TRawPrint.NewPage;
begin
  Write(#12 + #13);
  Column := 0;
  Row := 0;
end;

function TRawPrint.Write(xText: string): Boolean;
var
  xBuffer: string;
begin
  Result := False;
  xBuffer := xText;

  if xIsOpen then
    Result := WritePrinter(xHandle, @xBuffer[1], Length(xBuffer), xBytesWritten);
end;

end.

