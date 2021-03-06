unit mainaux;

interface

uses classes, main, forms, extctrls, global, dialogs, utext, sysutils, typinfo;

     procedure CreaIExecuta(o,m : string);
     procedure Executa(o : TObject; m : string);
     procedure PosaOrdreLlistes(ol : TOrdreLlistes; F : TCustomForm = nil);
     procedure TancarTotesLesLlistes;
     procedure MinimitzaLlistes;
     procedure PosaPanelDavant(p : TCustomPanel);
     procedure PosaMargeALlistes;
     procedure PreparaArrayLlistaPrevia;
     procedure PreparaArrayLlistes;
     procedure AlliberaArrayLlistes;
     procedure N_Click;
     procedure M_Click;
     procedure E_Click;
     procedure I_Click;
     procedure ContarRegistres;
     procedure SumaRegistresVisibles;
     procedure SumaSegonsClients;
     procedure SumaSegonsLiniaArticles;
     procedure MargeMitjaSegonsFamilia;     
     procedure BuscaErrors;
     procedure PosaUTextOrdrePanels;

type THKPersistent = class(TPersistent);

implementation

uses dmsrc, udbview, db, ADOdb, sumcli, printers, sumlinart, personals, margemitj;

var
     NoThisForm : TCustomForm;

const
     B : array [boolean] of integer = (0,1);
     FBStyle : array [boolean] of TFormBorderStyle = (bsSizeable,bsNone);

procedure PosaUTextOrdrePanels;
begin
     with _main do
     begin
          tTancar.Left := paOrdenarLlistes.Width - 5 - tTancar.Width;
          tMinimitzar.Left := tTancar.Left - tMinimitzar.Width - 1;
          tMaximitzar.Left := tMinimitzar.Left - tMaximitzar.Width - 1;
          tMosaic.Left := tMaximitzar.Left - tMosaic.Width - 1;
          tFiles.Left := tMosaic.Left - tFiles.Width - 1;
          tColumnes.Left := tFiles.Left - tColumnes.Width - 1;
     end;
end;

function TrobaPanelActiu : TCustomPanel;
var
     i : integer;
begin
     result := nil;
     with _main.fonsordres do
     for i := 0 to ControlCount - 1 do
     if (Controls[i] is TCustomPanel) and
     (Controls[i] as TCustomPanel).visible and
     (Controls[i] <> _main.Llistes) then
     begin
          result := Controls[i] as TCustomPanel;
          break;
     end;
end;

procedure ImpresoresInstalades;
begin
     if Printer.Printers.IndexOf(dm.CR['IMPRESORA_1']) = -1 then
     mDlg('No es troba l''impresora de fulls ' + dm.CR['IMPRESORA_1'],mtError,[mbOk]);

     if Printer.Printers.IndexOf(dm.CR['IMPRESORA_2']) = -1 then
     mDlg('No es troba l''impresora de tickets ' + dm.CR['IMPRESORA_2'],mtError,[mbOk]);
end;

procedure BuscaErrors;
begin
     ImpresoresInstalades;
end;

procedure N_Click;
var
     p : TCustomPanel;
     j : integer;
begin
     p := TrobaPanelActiu;

     if p = nil then exit;

     for j := 0 to p.ControlCount - 1 do
     if copy(p.Controls[j].Name,0,2) = 'tn' then
     begin
          (P.Controls[j] as TCustomUText).React;
          break;
     end;
end;

procedure M_Click;
var
     p : TCustomPanel;
     j : integer;
begin
     p := TrobaPanelActiu;

     if p = nil then exit;

     for j := 0 to p.ControlCount - 1 do
     if copy(p.Controls[j].Name,0,2) = 'tm' then
     begin
          (P.Controls[j] as TCustomUText).React;
          break;
     end;
end;

procedure E_Click;
var
     p : TCustomPanel;
     j : integer;
begin
     p := TrobaPanelActiu;

     if p = nil then exit;

     for j := 0 to p.ControlCount - 1 do
     if copy(p.Controls[j].Name,0,2) = 'td' then
     begin
          (P.Controls[j] as TCustomUText).React;
          break;
     end;
end;

procedure I_Click;
var
     p : TCustomPanel;
     j : integer;
begin
     p := TrobaPanelActiu;

     if p = nil then exit;

     for j := 0 to p.ControlCount - 1 do
     if copy(p.Controls[j].Name,0,2) = 'tv' then
     begin
          (P.Controls[j] as TCustomUText).React;
          break;
     end;
end;

procedure PosaMargeALlistes;
var
     i : integer;
begin
     with _main.fonsmain do
     for i := 0 to ControlCount - 1 do
     if Components[i] is TCustomForm then
     begin
          (Components[i] as TCustomForm).BorderStyle := FBStyle[dm.CR['LLISTES_FIXES'] = 'SI'];
          (Components[i].FindComponent('pCaption') as TCustomPanel).Visible := dm.CR['LLISTES_FIXES'] = 'SI';
     end;
end;

procedure PreparaArrayLlistaPrevia;
begin
     setlength(_main.ALlistaPrevia,0);
end;

procedure PreparaArrayLlistes;
var
     i : integer;
begin
     setlength(_main.ALlistes,0);

     with _main.fonsmain do
     for i := 0 to ControlCount - 1 do
     if Components[i] is TCustomForm
     then begin
               setlength(_main.ALlistes,length(_main.ALlistes) + 1);
               _main.ALlistes[length(_main.ALlistes)-1] := Components[i] as TCustomForm;
          end;
end;

procedure AlliberaArrayLlistes;
begin
     setlength(_main.ALlistes,0);
end;

procedure PosaPanelDavant(p : TCustomPanel);
var
     i : integer;
begin
     p.Visible := true;

     for i := 0 to p.Parent.ControlCount - 1 do
     if (p.Parent.Controls[i] is TCustomPanel) and (p.Parent.Controls[i] <> p)
     and (p.Parent.Controls[i] <> _main.Llistes)
     and (p.Parent.Controls[i].Visible)
     then p.Parent.Controls[i].Visible := false;
end;

procedure TancarTotesLesLlistes;
var
     i : integer;
begin
     with _main do
     begin
          for i := 0 to fonsmain.ComponentCount - 1 do
          if (fonsmain.Components[i] is TForm)
          and (fonsmain.Components[i] as TForm).Visible
          then (fonsmain.Components[i] as TForm).Close;

          tArticles.SetFocus;
     end;
end;

procedure MaximitzarLlistes;
var
     i : integer;
begin
     with _main.fonsmain do
     for i := 0 to ComponentCount - 1 do
     if (Components[i] is TForm) then
     begin
          if (Components[i] as TForm) = NoThisForm then continue;

          (Components[i] as TForm).WindowState := wsNormal;
          (Components[i] as TForm).Width  := clientwidth;
          (Components[i] as TForm).Height := clientheight;
          (Components[i] as TForm).Top    := 0;
          (Components[i] as TForm).Left   := 0;
     end;
end;

procedure MinimitzaLlistes;
var
     i : integer;
begin
     with _main.fonsmain do
     for i := 0 to ComponentCount - 1 do
     if (Components[i] is TForm) then
          (Components[i] as TForm).WindowState := wsMinimized;
end;

function NombreLlistesVisibles : integer;
var
     i : integer;
begin
     result := 0;

     with _main.fonsmain do
     for i := 0 to ComponentCount - 1 do
     result := result + B[(Components[i] is TForm) and (Components[i] as TForm).Visible and ((Components[i] as TForm) <> NoThisForm)];
end;

procedure EnColumnes;
var
     i : integer;
     c : integer;
     w : integer;
begin
     with _main.fonsmain do
     begin
          try    w := ClientWidth div NombreLlistesVisibles;
          except w := ClientWidth;
          end;

          c := 0;
          for i := 0 to ComponentCount - 1 do
          if (Components[i] is TForm) and (Components[i] as TForm).Visible and ((Components[i] as TForm).WindowState <> wsMinimized) then
          begin
               if (Components[i] as TForm) = NoThisForm then continue;

               if (Components[i] as TForm).WindowState <> wsNormal then (Components[i] as TForm).WindowState := wsNormal;
               if (Components[i] as TForm).Width <> w  then (Components[i] as TForm).Width := w;
               if (Components[i] as TForm).Height <> ClientHeight then (Components[i] as TForm).Height := ClientHeight;
               if (Components[i] as TForm).Top <> 0 then (Components[i] as TForm).Top := 0;
               if (Components[i] as TForm).Left <> c then (Components[i] as TForm).Left := c;
               c := c + w;
          end;

     end;
end;

procedure EnFiles;
var
     i : integer;
     c : integer;
     h : integer;
begin
     with _main.fonsmain do
     begin
          try    h := ClientHeight div NombreLlistesVisibles;
          except h := ClientHeight;
          end;

          c := 0;
          for i := 0 to ComponentCount - 1 do
          if (Components[i] is TForm) and (Components[i] as TForm).Visible and ((Components[i] as TForm).WindowState <> wsMinimized) then
          begin
               if (Components[i] as TForm) = NoThisForm then continue;

               if (Components[i] as TForm).WindowState <> wsNormal then (Components[i] as TForm).WindowState := wsNormal;
               if (Components[i] as TForm).Width <> ClientWidth    then (Components[i] as TForm).Width  := ClientWidth;
               if (Components[i] as TForm).Height <> h then  (Components[i] as TForm).Height := h;
               if (Components[i] as TForm).Top <> c then (Components[i] as TForm).Top    := c;
               if (Components[i] as TForm).Left <> 0 then (Components[i] as TForm).Left   := 0;
               c := c + h;
          end;
     end;
end;

function SqrtInt(i : integer) : integer;
begin
     result := 0;
     while result*result < i do inc(result);
end;

procedure Mosaic;
var
     i : integer;
     c : integer;
     h : integer;
     w : integer;
     n : integer;
begin
     with _main.fonsmain do
     begin
          n := sqrtint(NombreLlistesVisibles);

          try    h := ClientHeight div n;
          except h := ClientHeight;
          end;

          try    w := ClientWidth div n;
          except w := ClientWidth;
          end;

          c := 0;
          for i := 0 to ComponentCount - 1 do
          if (Components[i] is TForm) and (Components[i] as TForm).Visible and ((Components[i] as TForm).WindowState <> wsMinimized) then
          begin
               if (Components[i] as TForm) = NoThisForm then continue;

               if (Components[i] as TForm).WindowState <> wsNormal
               then (Components[i] as TForm).WindowState := wsNormal;

               if (Components[i] as TForm).Width <> w then (Components[i] as TForm).Width  := w;
               if (Components[i] as TForm).Height <> h then (Components[i] as TForm).Height := h;
               if (Components[i] as TForm).Top <> (c div n)*h then (Components[i] as TForm).Top := (c div n)*h;
               if (Components[i] as TForm).Left <> (c mod n)*w then (Components[i] as TForm).Left := (c mod n)*w;
               c := c + 1;
          end;
     end;
end;

procedure PosaOrdreLlistes(ol : TOrdreLlistes; F : TCustomForm = nil);
begin
     _main.OrdreLlistes := ol;
     NoThisForm := F;

     case ol of
     olCap :  ;
     olFiles : EnFiles;
     olMosaic : Mosaic;
     olColumnes : EnColumnes;
     olMaximitzar : MaximitzarLlistes;
     end;
end;

function GetObject(c : TObject; s : string): TObject;
var
     n : integer;
begin
     s := trim(s);
     n := Pos('.',s);
     result := nil;

     if s = '' then result := c;
     if c = nil then c := THKPersistent(c).GetOwner;

     if n <> 0 then
     result := GetObject(GetObject(c,Copy(s,0,n-1)),Copy(s,n+1,Length(s)-n));

     if result = nil then
     try
          result := typinfo.GetObjectProp(c,s);
     except
          result := nil;
     end;

     if result = nil then
     try
          result := (c as TComponent).FindComponent(s);
     except
          result := nil;
     end;
end;

function GetMethod(c : TObject; s : string) : TMethod;
var
     o : TObject;
     ael,lst : string;
begin
     s := trim(s);
     result.code := nil;
     result.data := nil;
     if pos('.',s) = 0 then
     begin
          lst := s;
          o := c;
     end
     else
     begin
          lst := strRscan(PChar(s),'.')+1;
          ael := Copy(s,0,Length(s)-length(lst));
          o := GetObject(c,ael);
     end;

     try
     result := GetMethodProp(o,lst);
     except
     result.code := nil;
     result.data := nil;
     end;

     if result.code = nil then
     try
     result.data := Pointer(o);
     result.code := o.MethodAddress(lst);
     except
     result.code := nil;
     result.data := nil;
     end;
end;

procedure ExecMethod(c : TObject; s : string);
type
   TExec = procedure of object;
var
     m : TMethod;
     Exec : TExec;
begin
      m := GetMethod(c,s);

      if assigned(m.code) then
      begin
        Exec := TExec(m);
        Exec;
      end;
end;

procedure CreaIExecuta(o,m : string);
var
     c : TPersistentClass;
     p : TComponentClass;
     e : TComponent;
begin
     C := classes.GetClass(o);
     P := TComponentClass(C);
     e := P.Create(Application);
     ExecMethod(e,m);
     e.Free;
end;

procedure Executa(o : TObject; m : string);
begin
     ExecMethod(o,m);
end;

procedure SumaSegonsClients;
begin
     T_sumcli.Create(Application).ShowModal;
end;

procedure SumaSegonsLiniaArticles;
begin
     T_sumlinart.Create(Application).ShowModal;
end;

procedure MargeMitjaSegonsFamilia;
begin
     T_margemitj.Create(Application).ShowModal;
end;

procedure SumaRegistresVisibles;
var
     v : TUDBView;
     c : string;
     i : integer;
     q : TADOQuery;
     s : string;
begin
     if not Assigned(_main.ActiveControl) or not (_main.ActiveControl is TUDBView) then
     begin
          mDlg('Cap llista seleccionada',mtInformation,[mbOk]);
          exit;
     end;

     c := (_main.ActiveControl.Parent as TCustomForm).Caption;
     v := _main.ActiveControl as TUDBView;

     s := '';

     for i := 0 to v.Data.Dataset.FieldCount - 1 do
          if (v.Data.Dataset.Fields[i].DataType = ftFloat) and (Copy(v.Data.Dataset.Fields[i].FieldName,length(v.Data.Dataset.Fields[i].FieldName)-1,2) <> '_P') then
               s := s + 'sum(' + v.Data.Dataset.Fields[i].FieldName + ') as suma_'+v.Data.Dataset.Fields[i].FieldName + ',';

     if s = '' then
     begin
          mDlg('No hi han camps per sumar a aquesta taula',mtInformation,[mbOk]);
          exit;
     end;

     if s[Length(s)] = ',' then s[Length(s)] := ' ';

     q := TADOQuery.Create(nil);
     q.Connection := dm.CG;

     q.Active := false;
     q.SQL.Text := 'select ' + s + ' from ' + v.Data.Table + ' ' + v.Data.Filter;
     q.Active := true;

     s := 'Sumes a la taula ' + c + #13#10#13#10;

     for i := 0 to v.Data.Dataset.FieldCount - 1 do
          if (v.Data.Dataset.Fields[i].DataType = ftFloat) and (Copy(v.Data.Dataset.Fields[i].FieldName,length(v.Data.Dataset.Fields[i].FieldName)-1,2) <> '_P') then
          s := s + '  Suma ' + Esquerra(v.Columns[i+1].Title,12) + #9 + ' = ' + FormatFloat('0.00',q.FieldByName('suma_'+v.Data.Dataset.Fields[i].FieldName).AsFloat) + #13#10;

     s := s  + RC(' ',55);
     q.Free;

     mDlg(s,mtInformation,[mbOk]);
end;

procedure ContarRegistres;
begin
     if not Assigned(_main.ActiveControl) or not (_main.ActiveControl is TUDBView) then
          mDlg('Cap llista seleccionada',mtInformation,[mbOk])
     else
     begin
          mDlg('N� de registres : ' + inttostr((_main.ActiveControl as TUDBView).Data.Dataset.RecordCount),mtInformation,[mbOk]);
     end;
end;

end.

