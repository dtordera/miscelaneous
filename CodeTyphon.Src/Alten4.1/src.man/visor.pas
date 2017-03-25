unit visor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UText, ExtCtrls, DB, ADODB, BDInfo,
  UDBView;

type
  T_visor = class(TForm)
    cg: TADOConnection;
    Panel1: TPanel;
    LUText1: TLUText;
    Edit1: TEdit;
    Panel2: TPanel;
    BDInfo2: TBDInfo;
    BDInfo1: TBDInfo;
    v: TUDBView;
    procedure LUText1Load(sender: TObject; var Accept: Boolean);
    procedure BDInfo1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _visor: T_visor;

implementation

uses main;

{$R *.dfm}

procedure T_visor.LUText1Load(sender: TObject; var Accept: Boolean);
begin
     CG.Connected := false;
     CG.ConnectionString := ConnectString(LUText1.Caption);
     try
          CG.Connected := true;
          BDInfo1.Connection := CG;
          BDInfo2.Connection := CG;
          BDInfo2.Table := BDInfo1.Items[0];
          v.Data.Connection := CG;
          v.Data.Table := BDInfo1.Items[0];
          v.Data.Active := true;
     except
          Accept := false;
          MessageDLG('Base de dades no vàlida. Probablement fitxer corromput',mtError,[mbOk],0);
     end;
end;

procedure T_visor.BDInfo1Click(Sender: TObject);
begin
     v.Data.Table := BDInfo1.Items[BDInfo1.ItemIndex];
     BDInfo2.Table := BDInfo1.Items[BDInfo1.ItemIndex];
end;

procedure T_visor.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
     13 : begin v.Data.DoSQL(Edit1.Text); key := 0; end;
     end;
end;

end.
