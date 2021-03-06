unit elinies;

interface                                     

uses Windows, UDBAlter, Forms, Controls, StdCtrls, UText, ExtCtrls, ULabel,
  Classes, Gradient;

type
  T_elinies = class(TForm)
    UText1: TUText;
    Bevel1: TBevel;
    btAnterior: TUText;
    btSeguent: TUText;
    btEntrar: TUText;
    GradientNC1: TGradientNC;
    UDBAlterForm: TUDBAlterForm;
    dDESCR: TTLabel;
    dID: TNLabel;
    tREF: TUText;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
     private
     public
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
end;

implementation

uses dmsrc, linies, estilcolor;

{$R *.dfm}

procedure T_elinies.Nou;
begin
     UDBAlterForm.New;
end;

procedure T_elinies.Modificar;
begin
     UDBAlterForm.Modify;
end;

procedure T_elinies.Eliminar;
begin
     UDBAlterForm.Delete;
end;

procedure T_elinies.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
end;

procedure T_elinies.FormActivate(Sender: TObject);
begin
     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_elinies.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : modalresult := mrCancel;
     end;
end;

end.
