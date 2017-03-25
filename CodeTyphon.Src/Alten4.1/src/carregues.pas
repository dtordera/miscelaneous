unit carregues;

interface

uses Windows, UProcessos, UText, Controls, StdCtrls, Classes, Gradient, Forms, estilcolor, Dialogs;

type T_carregues = class(TForm)
     tCarregarArticles: TGUText;
     tCarregarMarques: TGUText;
     tCarregarLinies: TGUText;
     tCarregarFamilies: TGUText;
     Label1: TLabel;
     GradientNC1: TGradientNC;
     UProcessos: TUProcessos;
     UText1: TUText;
    tRestablirArticles: TGUText;
     procedure tCarregarArticlesReact(Sender: TObject);
     procedure tCarregarMarquesReact(Sender: TObject);
     procedure tCarregarLiniesReact(Sender: TObject);
     procedure tCarregarFamiliesReact(Sender: TObject);
     procedure UText1React(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tRestablirArticlesReact(Sender: TObject);
     private
     public
end;

var
  _carregues: T_carregues;

implementation

{$R *.dfm}

uses lectura, articles, personals, pressupostos, dmsrc, ventesA, global,
  magatzem, ADOdb;

procedure T_carregues.UText1React(Sender: TObject);
begin
     close;
end;

procedure T_carregues.tCarregarArticlesReact(Sender: TObject);
begin
     lectura.Interpretar_Articles_bulk;
end;

procedure T_carregues.tCarregarMarquesReact(Sender: TObject);
begin
     lectura.Interpretar_marques;
end;

procedure T_carregues.tCarregarLiniesReact(Sender: TObject);
begin
     lectura.Interpretar_Linies;
end;

procedure T_carregues.tCarregarFamiliesReact(Sender: TObject);
begin
     lectura.Interpretar_Families;
end;


procedure T_carregues.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
end;

procedure T_carregues.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : close;
     end;
end;

procedure T_carregues.tRestablirArticlesReact(Sender: TObject);
begin
     if mDlg('Atenció! Es restablirà la taula d''articles anterior a la última càrrega (tots els canvis efectuats desde aquesta es perderan). Continuar?',mtWarning,[mbYes,mbNo]) <>
     mrYes then exit;

     lectura.RestablirArticles;
end;

end.
