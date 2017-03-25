unit emarques;

interface

uses Windows, UDBAlter, Forms, Controls, StdCtrls, UText, ExtCtrls, ULabel,
  Classes, Gradient;

type
  T_emarques = class(TForm)
    UText1: TUText;
    UText7: TUText;
    dMARGE: TNLabel;
    Bevel1: TBevel;
    btAnterior: TUText;
    btSeguent: TUText;
    btEntrar: TUText;
    UDBAlterForm: TUDBAlterForm;
    dDESCR: TTLabel;
    GradientNC1: TGradientNC;
    dID: TNLabel;
    tRef: TUText;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UDBAlterFormLoadDefValues(Sender: TObject);
     private
     public
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
end;

implementation

uses marques, estilcolor;

{$R *.dfm}

procedure T_emarques.Nou;
begin
     UDBAlterForm.New;
end;

procedure T_emarques.Modificar;
begin
     UDBAlterForm.Modify;
end;

procedure T_emarques.Eliminar;
begin
     UDBAlterForm.Delete;
end;

procedure T_emarques.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
end;

procedure T_emarques.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_emarques.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : modalresult := mrCancel;
     end;
end;

procedure T_emarques.UDBAlterFormLoadDefValues(Sender: TObject);
begin
     dMARGE.Value := 0;
end;

end.
