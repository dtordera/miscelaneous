program altenmant;

uses
  Forms,
  main in 'main.pas' {_main},
  visor in 'visor.pas' {_visor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Alten 4 - Manteniment';
  Application.CreateForm(T_main, _main);
  Application.CreateForm(T_visor, _visor);
  Application.Run;
end.
