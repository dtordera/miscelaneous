unit SFilter;

interface

uses classes, ADOdb;

var  ultim,
     primer : boolean;
     alguna_paraula : boolean;
     inversa : boolean;
     SQL_Texte : string;
     function GetSQLExpression(f : string; eq : TADOQuery) : string;

const
     Comod_SQL = '%';
     fmt_dates_SQL = '#mm/dd/yyyy#';

implementation

uses sysutils, db;

var  o,
     d,
     n,
     t : TStrings;
     q : TADOQuery;

procedure PreparaVariables(f : string; eq : TADOQuery);
begin
     o := TStringList.Create;
     d := TStringList.Create;
     n := TStringList.Create;
     t := TStringList.Create;

     o.CommaText := f;
     q := eq;
end;

procedure AlliberaVariables;
begin
     t.Free;
     n.Free;
     d.Free;
     o.Free;
end;

procedure DiscriminaTexte;
var
     i,cnt : integer;
     txt,txt_s : string;
begin
     ultim  := false;
     primer := false;
     alguna_paraula := false;
     inversa := false;

     o.Commatext := AnsiUpperCase(o.CommaText);

     cnt := o.Count;

     i := 0;
     while (i < cnt) do
     begin
          // Cadena
          txt := o[i];
          // Cadena sense operador (per conversions)
          txt_s := StringReplace(txt,'<','',[rfReplaceAll,rfIgnoreCase]);
          txt_s := StringReplace(txt_s,'>','',[rfReplaceAll,rfIgnoreCase]);
          txt_s := StringReplace(txt_s,'#','',[rfReplaceAll,rfIgnoreCase]);

          // Numero
          if (txt <> txt_s) then
          try
               strtofloat(txt_s);
               txt := StringReplace(txt,'#','',[rfReplaceAll,rfIgnoreCase]);
               n.Add(txt);
               o.Delete(i);
               cnt := cnt - 1;
               dec(i);
          except
          end;

          //Data
          try
               strtodate(txt_s);
               d.Add(txt);
               o.Delete(i);
               cnt := cnt - 1;
               dec(i);
          except
          end;

          // avui, ahir
          txt_s := ansiuppercase(txt);
          if (txt_s = 'AVUI') or
              (txt_s = 'HOY') then
          begin
               d.Add(datetostr(Date));
               o.Delete(i);
               cnt := cnt - 1;
               dec(i);
          end
          else
          if (txt_s = 'AHIR') or
             (txt_s = 'AYER') then
          begin
               d.Add(datetostr(Date - 1));
               o.Delete(i);
               cnt := cnt - 1;
               dec(i);
          end
          else
          if (txt_s = 'ALGUNA') or
             (txt_s = 'ALGUNA_PARAULA') or
             (txt_s = 'ALGUNA_PALABRA') or
             (txt_s = 'O') then
          begin
               alguna_paraula := true;
               o.Delete(i);
               cnt := cnt - 1;
               dec(i);
          end
          else
          if (txt_s = 'NO') then
          begin
               inversa := true;
               o.Delete(i);
               cnt := cnt - 1;
               dec(i);
          end;

          // flags de primer, ultim
          ultim := (txt_s = 'ULTIM')  or (txt_s = 'ULTIMA') or (txt_s = 'ULTIMO') or
               (txt_s = 'ÚLTIMA') or (txt_s = 'ÚLTIMO') or (txt_s = 'ÚLTIM');

          primer := (txt_s = 'PRIMER') or (txt_s = 'PRIMERO') or (txt_s = 'PRIMERA');

          if ultim or primer then
          begin
                o.Delete(i);
                cnt := cnt - 1;
                dec(i);
          end;

          inc(i);
     end;
end;

function Camps_de_(s : string; q : TADOQuery) : TStringList;
var
        i,r : integer;
        camp_data_type : TFieldType;
        ret : TStringList;
        no_buscar_a_id : boolean;
begin
        s := ansilowercase(s);
        r := q.FieldCount;
        ret := TStringList.Create;    // S'ha d'alliberar exteriorment!

        no_buscar_a_id := false;

        for i := 0 to r-1 do // es discrimina segons tipus i tornem la llista
        begin
                if (no_buscar_a_id) and (q.Fields[i].FieldName = 'id') then continue;

                camp_data_type := q.Fields[i].DataType;
                if s = 'texte' then
                begin
                  if (camp_data_type = ftString) or
                     (camp_data_type = ftMemo) or
                     (camp_data_type = ftFmtMemo) or
                     (camp_data_type = ftFixedChar) or
                     (camp_data_type = ftWideString) then
                     ret.Add(q.Fields[i].FieldName);
                end
                else
                if (s = 'nombres') then
                begin
                  if (camp_data_type = ftSmallInt) or
                     (camp_data_type = ftInteger) or
                     (camp_data_type = ftWord) or
                     (camp_data_type = ftAutoInc) or
                     (camp_data_type = ftLargeInt) or
                     (camp_data_type = ftFloat) or
                     (camp_data_type = ftCurrency) then
                     ret.Add(q.Fields[i].FieldName);
                end
                else
                if (s = 'enters') then
                begin
                  if (camp_data_type = ftSmallInt) or
                     (camp_data_type = ftInteger) or
                     (camp_data_type = ftWord) or
                     (camp_data_type = ftAutoInc) or
                     (camp_data_type = ftLargeInt) then
                     ret.Add(q.Fields[i].FieldName);
                end
                else
                if (s = 'floats') then
                begin
                  if (camp_data_type = ftFloat) or
                     (camp_data_type = ftCurrency) then
                     ret.Add(q.Fields[i].FieldName);
                end
                else
                if (s = 'datetime') then
                begin
                  if (camp_data_type = ftDateTime) or
                     (camp_data_type = ftDate) or
                     (camp_data_type = ftTime) then
                     ret.Add(q.Fields[i].FieldName);
                end
                else
                if (s = 'memos') then
                begin
                  if (camp_data_type = ftMemo) or
                     (camp_data_type = ftFmtMemo) then
                     ret.Add(q.Fields[i].FieldName);
                end
                else
                if (s = 'boolean') then
                begin
                  if (camp_data_type = ftBoolean) then
                     ret.Add(q.Fields[i].FieldName);
                end;
        end;

        Camps_de_ := ret;      // Pasem punter...s'allibera desde fora.
end;

function FercadenaBoolean : string;
var
        i,r : integer;
        camps_de_boolean : TStringList;
        txt : string;
        s   : string;
begin
        txt := '';

        camps_de_boolean := Camps_de_('boolean',q); // busquem quins camps son boolean al query

        if camps_de_boolean.Count = 0 then
        begin
                camps_de_boolean.Free;
                Fercadenaboolean := '';
                exit;
        end;

        r := o.Count;
        for i := 0 to r - 1 do // anem posant, amb operadors, els camps al resultat
        begin
                s := ansiuppercase(o[i]);
                if camps_de_boolean.IndexOf(s) <> -1 then
                begin
                   if txt = '' then txt := ansiuppercase(s) + ' = true' else txt := txt + ' and ' + ansiuppercase(s) + ' = true';
                   o.Delete(i);
                end;
        end;

        camps_de_boolean.Free;     // alliberem

        Fercadenaboolean := txt; // tornem cadena creada
end;

function FerCadenanombres : string;
var
        i,r : integer;
        txt : string;
        camps_de_nombres : TStringList;
        en_valors : string;
        operadors : string;
        val_s : string;
        val_min : double;
        val_max : double;
        val : double;
begin
        txt := '';

        val_min := -99999999;
        val_max :=  99999999;
        camps_de_nombres := Camps_de_('nombres',q); // agafem camps de nombres

        if camps_de_nombres.Count = 0 then
        begin
                camps_de_nombres.Free;          // sortim
                Fercadenanombres := '';
                exit;
        end;

        r := n.Count;
        for i := 0 to r - 1 do
        begin
             val_s := StringReplace(n[i],'<','',[rfReplaceAll,rfIgnoreCase]);
             val_s := StringReplace(val_s,'>','',[rfReplaceAll,rfIgnoreCase]);
             val   := strtofloat(val_s);

             if (Pos('<',n[i]) <> 0) then
             begin
                  if val < val_max then val_max := val;
             end
             else
             if (Pos('>',n[i]) <> 0) then
             begin
                  if val > val_min then val_min := val;
             end
             else
             begin
                  if en_valors <> '' then en_valors := en_valors + ',' + n[i] else
                  en_valors := '(' + n[i];
             end;
        end;

        operadors := '';

        if (val_min > -99999999) and (val_max < 99999999) then
        begin
                operadors := ' between ' + inttostr(Round(val_min)) + ' and ' + inttostr(Round(val_max));
        end
        else
        begin
               if val_min > -99999999 then
                  operadors := ' >' + inttostr(Round(val_min));

               if val_max < 99999999 then
                  operadors := ' <' + inttostr(Round(val_max));
        end;

        if en_valors <> '' then en_valors := en_valors + ')';

        txt := '';
        r := camps_de_nombres.Count;
        for i := 0 to r - 1 do
        begin
                if en_valors <> '' then // varis valors concrets
                begin
                    if txt <> '' then txt := txt + ' or ';
                    txt := txt + '(' + camps_de_nombres[i] + ' in ' + en_valors + ')';
                end;

                if operadors <> '' then // valors amb operadors
                begin
                    if txt <> '' then txt := txt + ' or ';
                    txt := txt + '(' + camps_de_nombres[i] + operadors + ')';
                end;
        end;

        Fercadenanombres := txt;
        camps_de_nombres.Free;
end;

function FerCadenaTexte : string;
var
        i,r : integer;
        txt : string;
        camps_txt : string;
        camps_de_texte : TStringList;
const
        op : array [boolean] of string = (' and ',' or ');
begin
        txt := '';
        camps_txt := '(';
        camps_de_texte := Camps_de_('texte',q);

        if camps_de_texte.Count = 0 then
        begin
                camps_de_texte.Free;
                Fercadenatexte := '';
                exit;
        end;

        r := camps_de_texte.Count;       // creem la part del camp
        for i := 0 to r - 1 do
        begin
             if camps_txt <> '(' then camps_txt := camps_txt + '+'' ''+';
             camps_txt := camps_txt + 'IIF('+Camps_de_texte[i] + ',' + Camps_de_texte[i] + ',''0'')';
        end;

        r := o.Count;
        for i := 0 to r - 1 do           // la part amb els textes
        begin
             if txt <> '' then txt := txt + op[alguna_paraula];
             txt := txt + camps_txt + ' like '+AnsiQuotedStr(Comod_SQL +o[i]+Comod_SQL,'''') + ')';
        end;

        Camps_de_texte.Free;
        Fercadenatexte := txt;        // asignem i alliberem
end;

function FerCadenaDates : string;
var
        i,r : integer;
        txt : string;
        camps_de_dates : TStringList;
        en_valors : string;
        operadors : string;
        val_s : string;
        val_min : TDateTime;
        val_max : TDateTime;
        val : TDateTime;
begin
        txt := '';

        val_min := strtodate('1/1/1899'); // dates minima i maxima
        val_max := strtodate('31/12/9999');
        camps_de_dates := Camps_de_('datetime',q); // agafem camps de dates

        if camps_de_dates.Count = 0 then
        begin
                camps_de_dates.Free;
                FerCadenaDates := '';
                exit;
        end;

        r := d.Count;
        en_valors := '';
        for i := 0 to r - 1 do
        begin
             val_s := StringReplace(d[i],'<','',[rfReplaceAll,rfIgnoreCase]); // value absolut sense operadors
             val_s := StringReplace(val_s,'>','',[rfReplaceAll,rfIgnoreCase]);
             val   := strtodate(val_s);

             if (StrPos(PChar(d[i]),'<')<> nil) then // si hi ha operador,
             begin
                  if val < val_max then val_max := val;
             end
             else
             if (StrPos(PChar(d[i]),'>') <> nil) then
             begin
                  if val > val_min then val_min := val;
             end
             else
             begin
                  if en_valors <> '' then en_valors := en_valors + ',' + FormatDateTime(fmt_dates_SQL,val) else
                  en_valors := '(' + FormatDateTime(fmt_dates_SQL,Val);
             end;
        end;

        operadors := '';

        if (val_min > strtodate('1/1/1899')) and (val_max < strtodate('31/12/9999')) then
        begin
                operadors := ' between ' + FormatDateTime(fmt_dates_SQL,val_min) + ' and ' + FormatDateTime(fmt_dates_SQL,val_max);
        end
        else
        begin
               if val_min > strtodate('1/1/1899') then
                  operadors := ' >' + FormatDateTime(fmt_dates_SQL,val_min);

               if val_max < strtodate('31/12/9999') then
                  operadors := ' <' + FormatDateTime(fmt_dates_SQL,val_max);
        end;

        if en_valors <> '' then en_valors := en_valors + ')'; // cas que siguin varies dates

        txt := '';
        r := camps_de_dates.Count;
        for i := 0 to r - 1 do
        begin
                if en_valors <> '' then // cas que hi hagin en valors concrets
                begin
                    if txt <> '' then txt := txt + ' or ';
                    txt := txt + '(' + camps_de_dates[i] + ' in ' + en_valors + ')';
                end;

                if operadors <> '' then // utilitzant operadors
                begin
                    if txt <> '' then txt := txt + ' or ';
                    txt := txt + '(' + camps_de_dates[i] + operadors + ')';
                end;
        end;

        camps_de_dates.Free;    // alliberem
        Fercadenadates := txt;        // tornem cadena creada
end;

procedure FerCadenaSQL;
var
        cadena_txt : string;
        cadena_num : string;
        cadena_dat : string;
        cadena_bol : string;
begin
        SQL_Texte := '';

        cadena_bol := FerCadenaBoolean;       // cadena bool
        cadena_num := FerCadenaNombres;       // cadena de nombres
        cadena_txt := FerCadenatexte;         // cadena textes
        cadena_dat := FerCadenaDates;         // cadena dates

        // sumem cadenes creades amb operadors
        if cadena_num <> '' then SQL_texte := SQL_texte + cadena_num;

        if cadena_txt <> '' then
        begin
                if SQL_texte <> '' then SQL_texte := SQL_texte + ' or ';
                SQL_texte := SQL_texte + cadena_txt;
        end;
        if cadena_dat <> '' then
        begin
                if SQL_texte <> '' then SQL_texte := SQL_texte + ' and ';
                SQL_texte := SQL_texte + cadena_dat;
        end;

        if cadena_bol <> '' then
        begin
                if SQL_texte <> '' then SQL_texte := SQL_texte + ' and ';
                SQL_texte := SQL_texte + cadena_bol;
        end;

        if inversa
        and (SQL_texte <> '') then SQL_texte := ' not (' + SQL_texte + ')';

        if SQL_texte <> '' then SQL_texte := ' where ' + SQL_Texte;
end;

function GetSQLExpression(f : string; eq : TADOQuery) : string;
begin
     PreparaVariables(f,eq);
     DiscriminaTexte;
     FerCadenaSQL;
     AlliberaVariables;
     result := SQL_Texte;
end;

end.
