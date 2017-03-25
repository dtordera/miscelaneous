unit fastbut;

interface

uses Windows, Classes, Controls, Buttons, Forms;

type
  T_fastbut = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
  public
  end;

var
  _fastbut: T_fastbut;

implementation

uses main;

{$R *.dfm}

procedure T_fastbut.SpeedButton1Click(Sender: TObject);
begin
     _main.tnVentesA.React;
end;

procedure T_fastbut.SpeedButton2Click(Sender: TObject);
begin
     _main.tEntradaaCaixa.React;
end;

procedure T_fastbut.SpeedButton4Click(Sender: TObject);
begin
     _main.tObrirCaixa.React;
end;

procedure T_fastbut.SpeedButton3Click(Sender: TObject);
begin
     _main.tnpressupostos.React;
end;

procedure T_fastbut.SpeedButton5Click(Sender: TObject);
begin
     _main.tnAveries.react;
end;

end.
