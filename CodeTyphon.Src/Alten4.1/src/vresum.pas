unit vresum;

interface

uses Dialogs, Classes, Controls, StdCtrls, forms, sysutils,ComCtrls, Menus;

type T_vresum = class(TForm)
    m: TMemo;
    MainMenu1: TMainMenu;
    Opcions1: TMenuItem;
    Imprimir1: TMenuItem;
    Guardaraarchiu1: TMenuItem;
    N1: TMenuItem;
    Tancar1: TMenuItem;
    Copiar1: TMenuItem;
    SaveDialog: TSaveDialog;
    Imprimirimpresoradefulls1: TMenuItem;
    procedure Tancar1Click(Sender: TObject);
    procedure Guardaraarchiu1Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure Imprimirimpresoradefulls1Click(Sender: TObject);
    private
    public
    procedure Imprimir;
end;

implementation

{$R *.dfm}

uses global, uraw, dmsrc, printers, caixa;

procedure T_vresum.Guardaraarchiu1Click(Sender: TObject);
begin
     SaveDialog.InitialDir := BINDIR;
     if SaveDialog.Execute then m.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure T_vresum.Copiar1Click(Sender: TObject);
begin
     m.SelectAll;
     m.CopyToClipboard;
end;

procedure T_vresum.Imprimir;
var
     xPrn : TRawPrint;
     i : integer;
begin
     xPrn := TRawPrint.Create;
     xPrn.PrinterName := dm.CR['IMPRESORA_2'];
     xPrn.Document := 'Alten41_resum_caixa';

     if xPrn.Open = False then
     raise exception.Create('Error a impresora.');

     m.Lines.Add('');
     m.Lines.Add('');
     m.Lines.Add('');

     for i := 0 to m.Lines.Count - 1 do
     try
          xPrn.Write(m.Lines[i] + #13#10);
     except
     end;

     xPrn.Close;
     xPrn.Free;
end;

procedure T_vresum.Imprimir1Click(Sender: TObject);
begin
     Imprimir;
end;

procedure T_vresum.Tancar1Click(Sender: TObject);
begin
     close;
end;

procedure T_vresum.Imprimirimpresoradefulls1Click(Sender: TObject);
begin
     Printer.PrinterIndex := -1;

     with TRichEdit.Create(self) do
     begin
          Parent := self;
          width := 1000;
          Lines.Assign(m.Lines);
          Print('resum de torn ' + _caixa.v.FieldByName('id').AsString);
     end;
end;

end.
