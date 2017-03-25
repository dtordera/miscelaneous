unit peinfor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ULabel, UText, ExtCtrls, Gradient;

type
  T_peinfor = class(TForm)
    UText2: TUText;
    dPEU: TXLabel;
    Shape1: TShape;
    btEntrar: TUText;
    GradientNC1: TGradientNC;
    UText1: TUText;
    dESTAB: TXLabel;
    procedure FormCreate(Sender: TObject);
    procedure btEntrarReact(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
end;

implementation

{$R *.dfm}

uses estilcolor, global;

procedure T_peinfor.FormCreate(Sender: TObject);
var
     ss : TStrings;
begin
     _estilcolor.Apply(self);

     ss := TStringList.Create;

     try    ss.LoadFromFile(BINDIR + 'STP\es.inf');
            dESTAB.Caption := ss.Text;
     except dESTAB.Caption := '';
     end;

     try    ss.LoadFromFile(BINDIR + 'STP\pi.inf');
            dPEU.Caption := ss.Text;
     except dPEU.Caption := '';
     end;

     ss.Free;
end;

procedure T_peinfor.btEntrarReact(Sender: TObject);
begin
     ModalResult := mrOk;
end;

procedure T_peinfor.FormClose(Sender: TObject; var Action: TCloseAction);
var
     ss : TStrings;
begin
     ss := TStringList.Create;

     case ModalResult of
     mrOk : begin
            try   ss.Text := dESTAB.Caption;
                  ss.SaveToFile(BINDIR + 'STP\es.inf');
            except
            end;

            try   ss.Text := dPEU.Caption;
                  ss.SaveToFile(BINDIR + 'STP\pi.inf');
            except
            end;
            end;
     end;
end;

end.
