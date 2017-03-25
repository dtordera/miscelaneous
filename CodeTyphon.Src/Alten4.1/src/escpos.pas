unit escpos;

interface

type TEscPosModes = (mFontB,mEmphasized,mDoubleHeight,mDoubleWidth,mUnderlined);
type TEscPosMode = set of TEscPosModes;
type TEscJustification = (jLeft,jCenter,jRight);

     function EscPos_(M : TEscPosMode) : string;
     function Justification(M : TEscJustification) : string;

implementation

function EscPos_(M : TEscPosMode) : string;
var
     r : word;
begin
     r := 0;
     if mFontB in M        then r := r + 1;
     if mEmphasized in M   then r := r + 8;
     if mDoubleHeight in M then r := r + 16;
     if mDoubleWidth in M  then r := r + 32;
     if mUnderlined in M   then r := r + 128;

     result := #27+'!'+Char(r);
end;

function Justification(M : TEscJustification) : string;
begin
     result := #27 + 'a' + Char(Integer(M));
end;

end.

