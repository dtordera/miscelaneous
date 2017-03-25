//
//      RTScript component . Component per a control de components i propietats en temps real.
//


unit RTScript;

interface

uses
  classes,controls,db,forms,sysutils,stdctrls, windows,typinfo,dialogs;

type THKPersistent = class(TPersistent);
type THKControl    = class(TControl);
type THKCustomEdit = class(TCustomEdit);
type THKCustomMemo = class(TCustomMemo);

type TRTScript = class(TComponent)
     private
          FActive : boolean;
          FLog    : boolean;
          FScript : TStrings;
          FConObj : TComponent;
          FExKey  : TShortCut;
          FOnApply : TNotifyEvent;
     protected
          procedure WriteLog                (s : string);
          procedure SetScript               (s  : TStrings);
          procedure SetComEdit              (s  : TCustomEdit);
          procedure SetComMemo              (s  : TCustomMemo);
          procedure ApplyScript             (sl : TStrings; owner : TComponent);
          procedure ComEditKeyPress         (sender : TObject; var Key : char);
          procedure ComMemoChange           (sender : TObject);
          procedure ComMemoKeyDown          (Sender: TObject; var Key: Word;
                                             Shift: TShiftState);
     public
          ComEdit       : TCustomEdit;
          ComMemo       : TCustomMemo;
          Log           : TStrings;
          constructor Create                (AOwner : TComponent); override;
          destructor  Destroy;              override;
          function    IsComplex             (s : string)      : boolean;
          function    First                 (s : string)      : string;
          function    Last                  (s : string)      : string;
          function    Rest                  (s : string)      : string;
          function    AllExceptLast         (s : string)      : string;
          function    GetString             (s : string)      : string;
          function    ParamsToStr           (p : TParams)     : string;
          function    StringToParams        (s : string)      : TParams;
          function    GetBaseOwner          (c : TPersistent) : TObject;
          function    GetBaseComponentOwner (c : TPersistent) : TComponent;
          function    GetBaseFormOwner      (c : TPersistent) : TForm;
          function    GetObject             (c : TObject; s : string)    : TObject;
          function    GetMethod             (c : TObject; s : string)    : TMethod;
          function    GetProp               (c:TObject;s : string)       : string;
          procedure   SetProp               (c:TObject;s : string);
          function    StringGetProp         (c : TObject; pn : string)   : string;
          procedure   StringSetProp         (c : TObject; pn, pv : string);
          function    RunTimeCreate         (c : TComponent; s : string) : TControl;
          procedure   ExecuteMethod         (p : TObject; s : string);
          procedure   DestroyObject         (p : TObject; s : string);
          procedure   Assign_               (c : TObject; s : string);
          procedure   ShowClass             (cp : String; o : TOBject);
          function    GetClass              (o : TObject) : string;
          procedure   CopyScript            (s : TStrings);
          procedure   Clear;
          procedure   Apply;
     published
          property    Script : TStrings read FScript write SetScript;
          property    Active : boolean read FActive write FActive default false;
          property    ConnectionObject : TComponent read FConObj write FConObj;
          property    CommandLine : TCustomEdit read ComEdit write SetComEdit;
          property    ScriptMemo  : TCustomMemo read ComMemo write SetComMemo;
          property    ExecuteKey  : TShortCut read FExKey write FExKey default VK_F9;
          property    LogEnabled  : boolean read FLog write FLog default false;
          property    OnApply : TNotifyEvent read FOnApply write FOnApply;
end;

procedure Register;

implementation

uses graphics;

constructor TRTScript.Create(AOwner : TComponent);
begin
        inherited Create(AOwner);
        FScript := TStringList.Create;
        Log     := TstringList.Create;
        FExKey  := 120;
        FConObj := AOwner;
end;

procedure TRTScript.ComMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        if Key = FExKey then
        begin
                WriteLog('-> Executing script from ' + (sender as TPersistent).GetNamePath);
                FScript.Assign(ComMemo.Lines);
                Apply;
        end
        else
        inherited;
end;

procedure TRTScript.WriteLog(s : string);
begin
        if not FLog then exit;
        Log.Add(s);
end;

procedure TRTScript.SetComEdit(s : TCustomEdit);
begin
        ComEdit := s;

        if Assigned(ComEdit) then
        try
        THKCustomEdit(ComEdit).OnKeyPress := ComEditKeyPress;
        except
        raise exception.Create(self.name + '.CommandLine must be class TCustomEdit or descendant');
        end;
end;

procedure TRTScript.SetComMemo(s : TCustomMemo);
begin
        ComMemo := s;
        if Assigned(comMemo) and Assigned(FScript) then
        try
        THKCustomMemo(ComMemo).OnChange := nil;
        ComMemo.Lines.Assign(FScript);
        except
        raise exception.Create(self.Name + '.SetComMemo(): assigning FScript');
        end;

        if Assigned(ComMemo) then
        try
        THKCustomMemo(ComMemo).OnKeyDown  := ComMemoKeyDown;
        THKCustomMemo(ComMemo).OnChange   := ComMemoChange;
        except
        raise exception.Create(self.Name + '.ScriptMemo must be class TCustomMemo or descendant');
        end;
end;

procedure TRTScript.ComMemoChange(sender : TObject);
begin
        FScript.Assign(ComMemo.Lines);
end;

procedure TRTScript.ComEditKeyPress(sender : TObject; var Key : char);
var
        s : TStrings;
begin
        if Key = #13 then
        begin
                WriteLog('-> CommandLine ' + (sender as TPersistent).GetNamePath + ':' + ComEdit.Text + ' ...');
                s := TStringList.Create;
                s.Add(ComEdit.Text);
                self.Applyscript(s,(THKPersistent(sender).GetOwner as TComponent));
                s.Free;
                ComEdit.SelectAll;
                Key := #0;
        end
        else
        inherited;
end;

destructor TRTScript.Destroy;
begin
        if Assigned(FScript) then FScript.Free;
        if Assigned(Log)     then Log.Free;
        inherited Destroy;        
end;

procedure TRTScript.SetScript(s : TStrings);
begin
        FScript.Assign(s);
        if Assigned(ComMemo) then ComMemo.Lines.Assign(s);
end;

function TRTScript.IsComplex(s : string) : boolean;
begin
        result := Pos('.',s) <> 0;
end;

function TRTScript.First(s : string) : string;
begin
        result := Copy(s,0,Pos('.',s)-1);
end;

function TRTScript.Rest(s : string) : string;
begin
        result := Copy(s,Pos('.',s)+1,10000);
end;

function TRTScript.ParamsToStr(p : TParams) : string;
var
        i : integer;
begin
        result := '';

        for i := 0 to p.Count - 1 do
                result := result + p[i].Name + '=' + p[i].Text + ';';
end;

function TRTScript.GetBaseOwner(c : TPersistent) : TObject;
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

function TRTScript.GetBaseComponentOwner(c : TPersistent) : TComponent;
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

function TRTScript.GetBaseFormOwner(c : TPersistent) : TForm;
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

function TRTScript.GetObject(c : TObject; s : string) : TObject;
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

function TRTScript.Last(s : string): string;
begin
        if Pos('.',s) = 0 then result := s
        else
        result := strRscan(PChar(s),'.')+1;
end;

function TRTScript.GetString(s : string) : string;
begin
        s := Trim(s);
        s := StringReplace(s,'\' + '''','¿¿%$%??',[rfReplaceAll,rfIgnoreCase]);
        s := Stringreplace(s,'''','',[rfReplaceAll,rfIgnoreCase]);
        s := StringReplace(s,'¿¿%$%??','''',[rfReplaceAll,rfIgnoreCase]);
        s := StringReplace(s,'\r',#13#10,[rfReplaceAll,rfIgnoreCase]);
        s := stringreplace(s,'\b',#8,[rfReplaceAll,rfIgnoreCase]);
        result := s;
end;

function TRTScript.AllExceptLast(s : string) : string;
var
        n : integer;
begin
        n := Length(Last(s))+1;
        result := Copy(s,0,Length(s)-n);
end;

function TRTScript.StringGetProp(c : TObject; pn : string) : string;
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

function TRTScript.StringToParams(s : string) : TParams;
var
        p  : TParam;
        ps : TParams;
        name,value : string;
        n,f : integer;
begin
        ps := TParams.Create;
        WriteLog('  Passing ' + s + ' to params');

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

function TRTScript.GetProp(c:TObject;s : string) : string;
begin
        if IsComplex(s) then
        result := StringGetProp(GetObject(c,AllExceptLast(s)),Last(s))
        else
        StringGetProp(c,s);
end;

procedure TRTScript.ShowClass(cp : String; o : TOBject);
begin
        ShowMessage(cp + ' : ' + (o as TPersistent).GetNamePath + ' (' + o.classname+')');
end;

function TRTScript.GetClass(o : TObject) : string;
begin
        result := (o as TPersistent).GetNamePath + ' (' + o.classname+')';
end;

function TRTScript.GetMethod(c : TObject; s : string) : TMethod;
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

procedure TRTScript.StringSetProp(c : TObject; pn, pv : string);
var
        m : TMethod;
        params : TParams;
        s : string;
        tpv : string;
begin
        tpv := Trim(pv);

        m := GetMethod(c,pv);
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
        tkMethod      : SetMethodProp(c,pn,m);
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
                if IsComplex(pv) then StringSetProp(c,pn,GetProp(c,pv))
                else
                WriteLog('#    error setting ' + pn + ' to ' + pv + ' in ' + GetClass(c));
        end;
end;

procedure TRTScript.SetProp(c:TObject;s : string);
var
        pn,pv : string;
begin
        pn := Trim(Copy(s,0,Pos('=',s)-1));
        pv := Copy(s,Pos('=',s)+1,Length(s)-Length(pn));

        pn := stringreplace(pn,'self.',THKPersistent(c).GetOwner.GetNamePath+'.',[rfreplaceAll,rfIgnoreCase]);
        pv := stringreplace(pv,'self.',THKPersistent(c).GetOwner.GetNamePath+'.',[rfreplaceAll,rfIgnoreCase]);

        WriteLog('>    setting property : ' + pn + ' to ' + pv + ' on ' + GetClass(c));

        if IsComplex(pn) then StringSetProp(GetObject(c,AllExceptLast(pn)),Last(pn),pv)
        else                  StringSetProp(c,pn,pv);
end;

procedure TRTScript.Assign_(c : TObject; s : string);
var  o1,o2 : string;
     ob1,ob2 : TObject;
     PT  : PTypeData;
     PI  : PTypeInfo;
     PP  : PPropList;
     tot : integer;
     i   : integer;
     t   : TTypeKinds;
     pv,pn : string;
begin
     o1 := Trim(Copy(s,0,Pos('=',s)-1));
     o2 := Trim(Copy(s,Pos('=',s)+1,1000));

     ob1 := GetObject(c,o1);

     if ob1 = nil  then
     WriteLog('#  error: (.assign) ' + o1 + ' not found in ' + GetClass(c));

     ob2 := GetObject(c,o2);
     if ob2 = nil then
     WriteLog('#  error: (.assign) ' + o2 + ' not found in ' + GetClass(c));

     if (ob1 = nil) or (ob2 = nil) then exit;

     PI   := ob1.ClassInfo;
     PT   := GetTypeData(PI);
     getmem(PP,PT^.PropCount*SizeOf(Pointer));

     t := [tkInteger,tkInt64,tkFloat,tkChar,tkWChar,tkString,tkLString,tkWString,
        tkVariant,tkMethod,tkEnumeration,tkSet,tkEnumeration];

     tot  := GetPropList(PI,t,PP);
     for i:=0 to tot -1 do
     begin
          pn := pp^[i]^.name;
          if lowercase(pn) = 'name' then continue;
          if not typinfo.IsPublishedProp(ob2,pn) then continue;
     try  pv := stringgetprop(ob2,pp^[i]^.Name);
     except
          continue;
     end;

     try
          StringSetProp(ob1,pn,pv);
     except
          continue;
     end;
     end;

     freemem(PP);
end;

function TRTScript.RunTimeCreate(c : TComponent; s : string) : TControl;
var
        MetaClass : TPersistentClass;
        ComponentMetaClass : TComponentClass;
        o : TComponent;
        cl, nm, pr : string;
        n,a,b : integer;
begin
        try
        n  := Pos('=',s);
        a  := Pos('(',s);
        b  := pos(')',s);
        nm := Trim(Copy(s,0,n-1));
        cl := Trim(Copy(s,n+1,a-n-1));
        pr := Trim(Copy(s,a+1,b-1-a));

        MetaClass := classes.GetClass(cl);
        ComponentMetaClass := TComponentClass(MetaClass);
        o := ComponentMetaClass.Create(c);
        o.Name := nm;
        (o as TControl).Parent := GetObject(c,pr) as TWinControl;
        (o as Tcontrol).bringToFront;
        (o as TControl).Top := 10;
        (o as TControl).Left := 10;
        (o as TControl).Visible := true;
        result := (o as TControl);
        except
        result := nil;
        WriteLog('#  error: (.RunTimeCreate) failed creating ' + nm + '(' + cl + ') from ' + GetClass(c) +' . Are classes registered? (RegisterClass())');
        end;
end;

procedure TRTScript.ExecuteMethod(p: TObject; s : string);
type
   TExec = procedure of object;
var
   Routine: TMethod;
   Exec: TExec;
   obj : TObject;
   ael : string;
   Lst : string;
   fst : string;
begin
        obj := nil;
        try
        ael := AllExceptLast(Trim(s));
        lst := Last(Trim(s));
        fst := First(Trim(s));

        obj := GetObject(p,ael);

        try
        Routine.data := Pointer(obj) ;
        Routine.code := obj.MethodAddress(Last(trim(s))) ;
        except
        Routine.code := nil;
        Routine.data := nil;
        end;

        if Assigned(Routine.Code) then
        begin
        Exec := TExec(Routine) ;
        Exec;
        exit;
        end
        else
        Routine := GetMethodProp(obj,Last(trim(s)));

        if Assigned(Routine.Code) then
        begin
        Exec := TExec(Routine) ;
        Exec;
        end
        else
        Routine := GetMethod(obj,Last(trim(s)));

        if Assigned(Routine.Code) then
        begin
        Exec := TExec(Routine);
        Exec;
        end;

        except
        WriteLog('#  error: (.ExecuteMethod) failed executing ' + s + ' in ' + GetClass(obj) + ' from ' + GetClass(p));
        end;
end;

procedure TRTScript.DestroyObject(p : TObject; s : string);
begin
        try
        GetObject(p,s).Destroy;
        except
        WriteLog('#  error: (.DestroyObject) failed trying to destroy ' + s + ' from ' + GetClass(p));
        end;
end;


procedure TRTScript.ApplyScript(sl : TStrings; owner : TComponent);
var
        i : integer;
        p : TObject;
        s : string;
begin
        if not FActive then exit;

        p := owner;

        WriteLog(':'+ (self as TPersistent).GetNamePath + '.ApplyScript >> ');
        for i := 0 to sl.Count - 1 do
        begin
                s := Trim(sl[i]);
                if (Copy(s,0,2) = '//') or (s = '') then continue; // comentaris

                if s[1] = '@' then // component
                begin
                        s := stringreplace(s,'@','',[rfReplaceAll,rfIgnorecase]);
                        p := GetObject(owner,s);
                        if p = nil then
                        WriteLog('@ error: ' + s + ' not found')
                        else
                        WriteLog('>@ Active component : ' + s + ' -> ' + GetClass(p));
                end
                else
                if s[1] = '!' then // create
                begin
                        s := StringReplace(s,'!','',[rfReplaceAll,rfIgnorecase]);
                        WriteLog('>! creating ' + s + ' ...');
                        p := RunTimeCreate(owner,s);
                end
                else
                if s[1] = '>' then // execute method
                begin
                        s := stringReplace(s,'>','',[rfReplaceAll,rfIgnoreCase]);
                        WriteLog('>> Execute ' + s + ' ...');
                        ExecuteMethod(owner,s);
                end
                else
                if s[1] = '*' then // destroy
                begin
                        s := stringreplace(s,'*','',[rfReplaceAll,rfIgnorecase]);
                        WriteLog('>* Destroying ' + s + ' ...');
                        DestroyObject(owner,s);
                end
                else
                if s[1] = '$' then // assign
                begin
                        s := stringreplace(s,'$','',[rfReplaceAll,rfIgnoreCase]);
                        WriteLog('>$ assign ' + s + ' ...');
                        Assign_(owner,s);
                end
                else
                if p = nil then
                begin
                        WriteLog('!  No current object defined. Searching from connection object ' + GetClass(owner));
                        SetProp(owner,s);
                end
                else
                SetProp(p,s);
        end;

        if Assigned(FOnApply) then FOnApply(self);
end;

procedure TRTScript.Apply;
begin
        ApplyScript(FScript,FConObj as TComponent);
end;

procedure TRTScript.Clear;
begin
        FScript.Clear;
        inherited;
end;

procedure TRTScript.CopyScript(s : TStrings);
begin
        FScript.Assign(s);
end;

procedure Register;
begin
     RegisterComponents('pkULIB', [TRTScript]);
end;

end.


