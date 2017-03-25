program rtscriptprj;

uses
  Forms,
  rtscriptmain in 'rtscriptmain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
