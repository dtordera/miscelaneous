unit RTScriptfnc;

interface

uses classes, db, forms;

type THKPersistent = class(TPersistent);

procedure SetProp(c:TObject;s : string);
function  StringGetProp (c : TObject; pn : string) : string;
procedure StringSetProp (c : TObject; pn, pv : string);
procedure ShowProperties(m : TStrings;o : TObject);
function  First(s : string) : string;
function  Rest(s : string) : string;
function  ParamsToStr(p : TParams) : string;
function  GetBaseOwner(c : TPersistent) : TObject;
function  GetBaseComponentOwner(c : TPersistent) : TComponent;
function  GetBaseFormOwner(c : TPersistent) : TForm;
function  GetObject(c : TObject; s : string) : TObject;
function  Last(s : string): string;
function  GetString(s : string) : string;
function  AllExceptLast(s : string) : string;
function  StringToParams(s : string) : TParams;
function  GetProp(c:TObject;s : string) : string;
function  GetClass(o : TObject) : string;
function  GetMethod(c : TObject; s : string) : TMethod;

implementation

uses typinfo, sysutils,controls,graphics;

function IsComplex(s : string) : boolean;
begin
        result := Pos('.',s) <> 0;
end;

function First(s : string) : string;
begin
        result := Copy(s,0,Pos('.',s)-1);
end;

function Rest(s : string) : string;
begin
        result := Copy(s,Pos('.',s)+1,10000);
end;

function ParamsToStr(p : TParams) : string;
var
        i : integer;
begin
        result := '';

        for i := 0 to p.Count - 1 do
                result := result + p[i].Name + '=' + p[i].Text + ';';
end;

function GetBaseOwner(c : TPersistent) : TObject;
var
        a,o   : TObject;
begin
        a   := THKPersistent(c);
        o   := a;
        while (a <> nil) and (a.ClassName <> 'TPersistent') do
        begin
                o := a;
                a := THKPersistent(THKPersistent(o).GetOwner);
        end;
        result := TPersistent(o);
end;

function GetBaseComponentOwner(c : TPersistent) : TComponent;
var
        a,o   : TObject;
begin
        a   := THKPersistent(c);
        o   := a;
        while (a <> nil) and (a.ClassName <> 'TApplication') do
        begin
                o := a;
                a := THKPersistent(THKPersistent(o).GetOwner);
        end;
        result := TComponent(o);
end;

function GetBaseFormOwner(c : TPersistent) : TForm;
var
        a,o   : TObject;
begin
        a   := THKPersistent(c);
        o   := a;
        while (a <> nil) and not (a is TForm) do
        begin
                o := a;
                a := THKPersistent(THKPersistent(o).GetOwner);
        end;
        result := TForm(o);
end;

function GetObject(c : TObject; s : string) : TObject;
var
        root : TObject;
begin
        Trim(s);

        try
        root := c;
        result := (c as TComponent).FindComponent(s);   // Es busca com a component del donat
        except
        root := nil;
        result := nil;
        end;

        if (root = nil) or (result = nil) then  // Es busca com a 'company' del donat
        try
        root := THKPersistent(c).GetOwner;
        result := (root as TComponent).FindComponent(s);
        except
        root := nil;
        result := nil;
        end;

        if (root = nil) or (result = nil) then  // es busca com a propietat
        try
        root := c;
        result := GetObjectProp(root,s);
        except
        root := nil;
        result := nil;
        end;

        if (root = nil) or (result = nil) then  // es busca desde el component ultim del donat
        try
        root := GetBaseComponentOwner(TPersistent(c));
        result := (root as TComponent).FindComponent(s);
        except
        root := nil;
        result := nil;
        end;

        if (root = nil) or (result = nil) then  // es busca desde el owner ultim del donat
        try
        root := GetBaseOwner(TPersistent(c));
        result := (root as TComponent).FindComponent(s);
        except
        root := nil;
        result := nil;
        end;

        if (root = nil) or (result = nil) then
        try
        root := Application;
        result := (root as TComponent).FindComponent(s);
        except
        root := nil;
        result := nil;
        end;

        if (root = nil) or (result = nil) then
        if IsComplex(s) then result := GetObject(GetObject(c,First(s)),Rest(s));
end;

function Last(s : string): string;
begin
        if Pos('.',s) = 0 then result := s
        else
        result := strRscan(PChar(s),'.')+1;
end;

function GetString(s : string) : string;
begin
        s := Trim(s);
        s := StringReplace(s,'\' + '''','¿¿%$%??',[rfReplaceAll,rfIgnoreCase]);
        s := Stringreplace(s,'''','',[rfReplaceAll,rfIgnoreCase]);
        s := StringReplace(s,'¿¿%$%??','''',[rfReplaceAll,rfIgnoreCase]);
        s := StringReplace(s,'\r',#13#10,[rfReplaceAll,rfIgnoreCase]);
        s := stringreplace(s,'\b',#8,[rfReplaceAll,rfIgnoreCase]);
        result := s;
end;

function AllExceptLast(s : string) : string;
var
        n : integer;
begin
        n := Length(Last(s))+1;
        result := Copy(s,0,Length(s)-n);
end;

function StringGetProp(c : TObject; pn : string) : string;
begin
        trim(pn);
        if Pos('self.',pn) <> 0 then
        pn := stringreplace(pn,'self.',THKPersistent(c).GetOwner.GetNamePath+'.',[rfReplaceAll,rfIgnoreCase]);

        try
        case typinfo.PropType(c,pn) of
        tkInteger : result := inttostr(GetOrdProp(c,pn));
        tkInt64   : result := inttostr(GetInt64Prop(c,pn));
        tkFloat   : result := floattostr(GetFloatProp(c,pn));
        tkChar,
        tkWChar,
        tkString,
        tkLString,
        tkWString : result := GetStrProp(c,pn);
        tkVariant : result := GetVariantProp(c,pn);
        tkMethod  : result := GetBaseComponentOwner(c as TPersistent).GetNamePath + '.' + GetBaseComponentOwner(c as TPersistent).MethodName(GetMethodProp(c,pn).Code);
        tkEnumeration : result := GetEnumProp(c,pn);
        tkSet         : result := GetSetProp(c,pn);
        tkClass       : if (GetObjectPropClass(c,pn).ClassName = 'TStrings') then
                                result := (GetObjectProp(c,pn) as TStrings).CommaText
                        else
                        if (GetObjectPropClass(c,pn).ClassName = 'TParams') then
                                result := ParamsToStr(GetObjectProp(c,pn) as TParams)
                        else
                                result := (GetObjectProp(c,pn) as TPersistent).GetNamePath;
        else
                result := GetPropValue(c,pn);
        end;
        except
                result := '';
        end;
end;

function StringToParams(s : string) : TParams;
var
        p  : TParam;
        ps : TParams;
        name,value : string;
        n,f : integer;
begin
        ps := TParams.Create;

        while s <> '' do
        begin
                n := Pos('=',s);
                f := Pos(';',s);

                name := Trim(Copy(s,0,n-1));
                value := Copy(s,n+1,f-n-1);

                p := TParam.Create(ps);
                p.name := name;
                p.value := value;

                s := Copy(s,f+1,Length(s)-f);
        end;
        result := ps;
end;

function GetProp(c:TObject;s : string) : string;
begin
        if IsComplex(s) then
        result := StringGetProp(GetObject(c,AllExceptLast(s)),Last(s))
        else
        StringGetProp(c,s);
end;

function GetClass(o : TObject) : string;
begin
        result := (o as TPersistent).GetNamePath + ' (' + o.classname+')';
end;

function GetMethod(c : TObject; s : string) : TMethod;
var
        root : TObject;
        obj  : TObject;
        own  : TObject;
begin
        s := Trim(s);

        try
        // .OnProperty,.Method
        root := THKPersistent(c).GetOwner;
        result.data := Pointer(c);
        result.code := (root as TPersistent).MethodAddress(s);
        except
        result.data := nil;
        result.code := nil;
        end;

        if result.code <> nil then exit;

        // Owner.Method
        try
        root  := GetBaseOwner(c as TPersistent);
        own   := (root as TComponent).FindComponent(First(s));
        result.data := Pointer(c);
        result.code := (own as TPersistent).MethodAddress(Rest(s));
        except
        result.data := nil;
        result.code := nil;
        end;

        if result.code <> nil then exit;

        // Component...OnProperty ; owner...component...OnProperty
        try
        root := GetBaseComponentOwner(c as TPersistent);
        obj  := GetObject(root,AllExceptLast(s));

        result := GetMethodProp(obj,Last(s));
        except
        result.data := nil;
        result.code := nil;
        end;

        if result.code <> nil then exit;
        {no es contempla Component.Property}

end;

procedure StringSetProp(c : TObject; pn, pv : string);
var
//        m : TMethod;
        params : TParams;
        s : string;
        tpv : string;
begin
        tpv := Trim(pv);

//        m := GetMethod(c,pv);
        s := GetProp(c,tpv);

        if Ansilowercase(pn) = 'cursor' then
        pv := inttostr(StringToCursor(GetString(tpv)));

        if Ansilowercase(pn) = 'color' then
        pv := inttostr(StringToColor(GetString(tpv)));

        if s <> '' then pv := s;

        try
        case typinfo.PropType(c,pn) of
        tkInteger     : SetOrdProp(c,pn,strtoint(pv));
        tkInt64       : SetInt64Prop(c,pn,strtoint64(pv));
        tkFloat       : SetFloatProp(c,pn,strtofloat(pv));
        tkChar,
        tkWChar,
        tkString,
        tkLString,
        tkWString     : SetStrProp(c,pn,GetString(pv));
        tkVariant     : SetVariantProp(c,pn,pv);
//        tkMethod      : SetMethodProp(c,pn,m);
        tkEnumeration : SetEnumProp(c,pn,Trim(pv));
        tkSet         : SetSetProp(c,pn,Trim(pv));
        tkClass       : if (GetObjectPropClass(c,pn).ClassName = 'TStrings') then
                                (GetObjectProp(c,pn) as TStrings).CommaText := pv
                        else
                        if (GetObjectPropClass(c,pn).ClassName = 'TParams') then
                        begin
                                params := StringToParams(pv);
                                (GetObjectProp(c,pn) as TParams).Assign(params);
                                params.Free;
                        end
                        else SetObjectProp(c,pn,GetObject(c,tpv));
        else
                        SetPropValue(c,pn,pv);
        end;
        except
                if IsComplex(pv) then StringSetProp(c,pn,GetProp(c,pv));
        end;
end;

procedure ShowProperties(m : TStrings;o : TObject);
var
     ss : TStringList;
     PI  : PTypeInfo;
     PT  : PTypeData;
     PP  : PPropList;
     t   : TTypeKinds;
     i   : integer;
     tot : integer;
     pn : string;
begin
     ss := TStringList.Create;

     PI   := o.ClassInfo;
     PT   := GetTypeData(PI);
     getmem(PP,PT^.PropCount*SizeOf(Pointer));

     t := [tkInteger,tkInt64,tkFloat,tkChar,tkWChar,tkString,tkLString,tkWString,
        tkVariant,tkMethod,tkEnumeration,tkSet,tkEnumeration];

     tot  := GetPropList(PI,t,PP);
     for i:=0 to tot -1 do
     begin
          pn := pp^[i]^.name;
     try  ss.Add(pn + ' = ' + stringgetprop(o,pp^[i]^.Name));
     except
          continue;
     end;
     end;

     m.Assign(ss);
     ss.Free;
end;

procedure SetProp(c:TObject;s : string);
var
        pn,pv : string;
begin
        pn := Trim(Copy(s,0,Pos('=',s)-1));
        pv := Copy(s,Pos('=',s)+1,Length(s)-Length(pn));

        pn := stringreplace(pn,'self.',THKPersistent(c).GetOwner.GetNamePath+'.',[rfreplaceAll,rfIgnoreCase]);
        pv := stringreplace(pv,'self.',THKPersistent(c).GetOwner.GetNamePath+'.',[rfreplaceAll,rfIgnoreCase]);

        if IsComplex(pn) then StringSetProp(GetObject(c,AllExceptLast(pn)),Last(pn),pv)
        else                  StringSetProp(c,pn,pv);
end;

end.
