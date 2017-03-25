unit urForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UText, ULabel, ExtCtrls, UDBVAux;

type
  T_urForm = class(TForm)
    u1: TLabel;
    b1: TButton;
    b2: TButton;
    u2: TLabel;
    u3: TLabel;
    Titol: TEdit;
    Format: TEdit;
    Ample: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure uClick(Sender: TObject);
    procedure TitolChange(Sender: TObject);
    procedure FormatChange(Sender: TObject);
    procedure AmpleChange(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b1Click(Sender: TObject);
  private
  public
     ColumnResizing : integer;
     CI : TColumnsInfo;
     procedure SetControls;
  end;

var
  _urForm: T_urForm;

implementation

uses UDBView;

{$R *.dfm}

procedure T_urForm.SetControls;
const
     CL : array [boolean] of TColor = (clSilver,clYellow);
begin
     CI := (owner as TUDBView).Columns;

     Caption := CI[ColumnResizing].Title;
     Titol.Text  := Caption;
     Format.Text := CI[ColumnResizing].Format;
     Ample.Text  := inttostr(CI[ColumnResizing].Width);     

     u1.Color := CL[integer(CI[ColumnResizing].Alignment) = u1.Tag];
     u2.Color := CL[integer(CI[ColumnResizing].Alignment) = u2.Tag];
     u3.Color := CL[integer(CI[ColumnResizing].Alignment) = u3.Tag];

     b1.Enabled := ColumnResizing <> 1;
     b2.Enabled := ColumnResizing <> (Owner as TUDBView).TotalColumns - 1;
end;

procedure T_urForm.FormCreate(Sender: TObject);
begin
     Color := (Owner as TUDBView).Look.FixedRow;
end;

procedure T_urForm.uClick(Sender: TObject);
const
     CL : array [boolean] of TColor = (clSilver,clYellow);
begin
     CI[ColumnResizing].Alignment := TAlignment((sender as TComponent).Tag);

     u1.Color := CL[integer(CI[ColumnResizing].Alignment) = u1.Tag];
     u2.Color := CL[integer(CI[ColumnResizing].Alignment) = u2.Tag];
     u3.Color := CL[integer(CI[ColumnResizing].Alignment) = u3.Tag];

     (Owner as TUDBView).Invalidate;
end;

procedure T_urForm.TitolChange(Sender: TObject);
begin
     CI[ColumnResizing].Title := (sender as TEdit).Text;
     (Owner as TUDBView).Invalidate;
end;

procedure T_urForm.FormatChange(Sender: TObject);
begin
     CI[ColumnResizing].Format := (sender as TEdit).Text;
     (Owner as TUDBView).Invalidate;
end;

procedure T_urForm.AmpleChange(Sender: TObject);
begin
     try
     CI[ColumnResizing].Width := strtoint((sender as TEdit).Text);
     (Owner as TUDBView).Invalidate;     
     except
     end;
end;

procedure T_urForm.b2Click(Sender: TObject);
var
     C : TColumnInfo;
     SS : Tstrings;
     s : string;
begin
     ss := TstringList.Create;

     ss.CommaText := (owner as TUDBView).Data.VisibleFields;

     s := SS[ColumnResizing-1];
     ss[ColumnResizing-1] := ss[ColumnResizing];
     ss[ColumnResizing] := s;

     (Owner as TUDBView).Data.VisibleFields := ss.CommaText;

     C.Alignment := CI[ColumnResizing + 1].Alignment;
     C.Title     := CI[ColumnResizing + 1].Title;
     C.Width     := CI[ColumnResizing + 1].Width;
     C.Format    := CI[ColumnResizing + 1].Format;
     C.FieldType := CI[ColumnResizing + 1].FieldType;

     CI[ColumnResizing + 1].Alignment := CI[ColumnResizing].Alignment;
     CI[ColumnResizing + 1].Title := CI[ColumnResizing].Title;
     CI[ColumnResizing + 1].Width := CI[ColumnResizing].Width;
     CI[ColumnResizing + 1].Format := CI[ColumnResizing].Format;
     CI[ColumnResizing + 1].FieldType := CI[ColumnResizing].FieldType;

     CI[ColumnResizing].Alignment := C.Alignment;
     CI[ColumnResizing].Title := C.Title;
     CI[ColumnResizing].Width := C.Width;
     CI[ColumnResizing].Format := C.Format;
     CI[ColumnResizing].FieldType := C.FieldType;

     ColumnResizing := ColumnResizing + 1;

     b1.Enabled := ColumnResizing <> 1;
     b2.Enabled := ColumnResizing <> (Owner as TUDBView).TotalColumns - 1;

     if ColumnResizing > (Owner as TUDBView).FirstDrawCol + 1
     then (Owner as TUDBView).FirstDrawCol := ColumnResizing - 1
     else (Owner as TUDBView).Invalidate;
end;

procedure T_urForm.b1Click(Sender: TObject);
var
     C : TColumnInfo;
     SS : Tstrings;
     s : string;
begin
     ss := TstringList.Create;

     ss.CommaText := (owner as TUDBView).Data.VisibleFields;

     s := SS[ColumnResizing-1];
     ss[ColumnResizing-1] := ss[ColumnResizing-2];
     ss[ColumnResizing-2] := s;

     (Owner as TUDBView).Data.VisibleFields := ss.CommaText;

     C.Alignment := CI[ColumnResizing - 1].Alignment;
     C.Title     := CI[ColumnResizing - 1].Title;
     C.Width     := CI[ColumnResizing - 1].Width;
     C.Format    := CI[ColumnResizing - 1].Format;
     C.FieldType := CI[ColumnResizing - 1].FieldType;

     CI[ColumnResizing - 1].Alignment := CI[ColumnResizing].Alignment;
     CI[ColumnResizing - 1].Title := CI[ColumnResizing].Title;
     CI[ColumnResizing - 1].Width := CI[ColumnResizing].Width;
     CI[ColumnResizing - 1].Format := CI[ColumnResizing].Format;
     CI[ColumnResizing - 1].FieldType := CI[ColumnResizing].FieldType;

     CI[ColumnResizing].Alignment := C.Alignment;
     CI[ColumnResizing].Title := C.Title;
     CI[ColumnResizing].Width := C.Width;
     CI[ColumnResizing].Format := C.Format;
     CI[ColumnResizing].FieldType := C.FieldType;

     ColumnResizing := ColumnResizing - 1;

     b1.Enabled := ColumnResizing <> 1;
     b2.Enabled := ColumnResizing <> (Owner as TUDBView).TotalColumns - 1;

     if ColumnResizing < (Owner as TUDBView).FirstDrawCol
     then (Owner as TUDBView).FirstDrawCol := ColumnResizing
     else (Owner as TUDBView).Invalidate;

     (Owner as TUDBView).Invalidate;
end;

end.
