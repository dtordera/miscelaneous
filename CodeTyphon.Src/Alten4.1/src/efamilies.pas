unit efamilies;

interface

uses Windows, UDBAlter, Forms, Controls, StdCtrls, UText, ExtCtrls, ULabel,
  LlistCfg,Classes, Gradient, UDBLabel, udbview, ADOdb;

type
  T_efamilies = class(TForm)
    UText1: TUText;
    UText7: TUText;
    Bevel1: TBevel;
    btAnterior: TUText;
    btSeguent: TUText;
    btEntrar: TUText;
    UDBAlterForm: TUDBAlterForm;
    dDESCR: TTLabel;
    GradientNC1: TGradientNC;
    dID: TNLabel;
    dID_LIN: TUDBLabel;
    dLINIA: TULabel;
    tREF: TUText;
    procedure ActualitzaLinia;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btSeguentClick(Sender: TObject);
    procedure btAnteriorClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dID_LINShowPickForm(sender: TObject; F: TCustomForm;
      U: TUDBView);
     private
     public
          procedure Nou;
          procedure Modificar;
          procedure Eliminar;
end;

implementation

uses dmsrc, families, linies, global, estilcolor;

{$R *.dfm}

procedure T_efamilies.Nou;
begin
     UDBAlterForm.New;
end;

procedure T_efamilies.Modificar;
begin
     UDBAlterForm.Modify;
end;

procedure T_efamilies.Eliminar;
begin
     UDBAlterForm.Delete;
end;

procedure T_efamilies.ActualitzaLinia;
var
     q : TADOQuery;
begin
     if dID_LIN.Caption = '' then
     begin
          dLINIA.Caption := '';
          exit;
     end;

     dLINIA.OnChange := nil;

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select * from linies where id = ' + dID_LIN.Caption;
     q.Active := true;

     dLINIA.Caption := q.FieldByName('descr').AsString;

     q.Free;

     if ActiveControl is TCustomUText then (Activecontrol as TCustomUText).ApplyMouseOverStyle;
end;

procedure T_efamilies.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm);
     dID_LIN.Data.Connection := dm.CG;
end;

procedure T_efamilies.FormActivate(Sender: TObject);
begin
     ActualitzaLinia;
end;

procedure T_efamilies.btSeguentClick(Sender: TObject);
begin
     ActualitzaLinia;
end;

procedure T_efamilies.btAnteriorClick(Sender: TObject);
begin
     ActualitzaLinia;
end;

procedure T_efamilies.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     27 : modalresult := mrCancel;
     end;
end;

procedure T_efamilies.dID_LINShowPickForm(sender: TObject; F: TCustomForm;
  U: TUDBView);
begin
     u.Look.Assign(_linies.v.Look);
     u.AssignColumnInfo(CInfo[ctLinies],VisFields[ctLinies]);
end;

end.
