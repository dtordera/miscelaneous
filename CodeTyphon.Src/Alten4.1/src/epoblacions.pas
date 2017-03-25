unit epoblacions;

interface

uses Windows, UDBAlter, Controls, StdCtrls, UText, ULabel, ExtCtrls,
  Classes, Gradient, Forms, estilcolor;

type
  T_epoblacions = class(TForm)
    btEntrar: TUText;
    Bevel1: TBevel;
    UText4: TUText;
    dPOBLACIO: TTLabel;
    btAnterior: TUText;
    btSeguent: TUText;
    UDBAlterForm: TUDBAlterForm;
    UText1: TUText;
    dCP: TKLabel;
    GradientNC1: TGradientNC;
    dID: TNLabel;
    tREF: TUText;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
     procedure Nou;
     function  Nou_ : TModalResult;
     procedure Modificar;
     procedure Eliminar;
  end;

implementation

uses poblacions;

{$R *.dfm}

procedure T_epoblacions.Nou;
begin
     Nou_;
end;

function T_epoblacions.Nou_ : TModalResult;
begin
     result := UDBAlterForm.New;
end;

procedure T_epoblacions.Modificar;
begin
     UDBAlterForm.Modify;
end;

procedure T_epoblacions.Eliminar;
begin
     UDBAlterForm.Delete;
end;

procedure T_epoblacions.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
end;

procedure T_epoblacions.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_epoblacions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     VK_ESCAPE : modalresult := mrCancel;
     end;
end;

end.
