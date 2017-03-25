unit main; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;

const
  Rows = 0;
  Cols = 0;

implementation

{$R *.lfm}

end.

