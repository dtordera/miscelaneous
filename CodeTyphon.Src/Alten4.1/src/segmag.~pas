unit segmag;

interface

uses Windows, Menus, Classes, Controls, UDBView, Forms, Sysutils;

type
  T_segmag = class(TForm)
    PopupMenu: TPopupMenu;
    Sumes1: TMenuItem;
    v: TUDBView;
    procedure FormCreate(Sender: TObject);
    procedure vReturn(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses estilcolor, dmsrc, global, LlistCfg, main, ventesA, ventesB, entrades, ADOdb;

procedure T_segmag.FormCreate(Sender: TObject);
begin
     _estilcolor.Apply(sender as TCustomForm,true);
     v.AssignColumnInfo(CInfo[ctSegMag],VisFields[ctSegMag]);
     ClientWidth := v.TotalWidth;
end;

procedure T_segmag.vReturn(Sender: TObject);
begin
     if v.FieldByName('tp_ref').AsString = 'A' then
     begin
          _main.tVentesA.React;
          _ventesA.v.Data.Filter := 'where id = ' + v.FieldByName('id_ref').AsString;
     end
     else
     if v.FieldByName('tp_ref').AsString = 'B' then
     begin
          _main.tVentesB.React;
          _ventesB.v.Data.Filter := 'where id = ' + v.FieldByName('id_ref').AsString;
     end
     else
     if v.FieldByName('tp_ref').AsString = 'E' then
     begin
          _main.tEntrades.React;
          _entrades.v.Data.Filter := 'where id = ' + v.FieldByName('id_ref').AsString;
     end;
end;

procedure T_segmag.PopupMenuPopup(Sender: TObject);
var
     q : TADOQuery;
     s : double;
begin
     q := TADOQuery.Create(nil);
     q.Connection := dm.CT;

     q.SQL.Text := v.Data.SQLText;
     q.Active := true;
     q.First;

     s := 0;
     while q.FieldByName('id').AsInteger <> v.FieldByName('id').AsInteger do
     begin
          s := s + q.FieldByName('uts_mod').AsFloat;
          q.Next;
     end;

     s := s + v.FieldByName('uts_mod').AsFloat;

     Sumes1.Caption := 'Suma d''unitats : ' + FormatFloat('0.00',s);

     q.Free;
end;

end.
