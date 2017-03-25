unit rtscriptmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, RTScript;

type
  TForm1 = class(TForm)
    RTScript1: TRTScript;
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Popup11: TMenuItem;
    Popup21: TMenuItem;
    Button2: TButton;
    Memo2: TMemo;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N1(sender : TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
     ShowMessage('Button 1 click');
end;

procedure TForm1.N1(sender : TObject);
begin
     ShowMessage('This is ' + (sender as TComponent).Name + ' Onclick');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     RTScript1.Script.Assign(Memo2.Lines);
     RTScript1.Log.Clear;
     RTScript1.Apply;
     Memo1.Lines.Assign(RTScript1.Log);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     ShowMessage('Button3Click');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     RegisterClasses([TButton]);
end;

end.
