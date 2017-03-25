unit Gradient;

interface

uses
  windows, classes,controls,extctrls, graphics;

type TDireccio = (N,S,E,O);

type TGradient = class(TCustomPanel)
     private
          FColorInicial : TColor;
          FColorFinal   : TColor;
          FDireccio     : TDireccio;
     protected
          function  FerGradient : TBitmap;
          function  FerGradientVertical(ci,cf : TColor): TBitmap;
          function  FerGradientHoritzontal(ci,cf : TColor): TBitmap;

          procedure SetFColorInicial(ci : TColor);
          procedure SetFColorFinal(cf : TColor);
          procedure SetFDireccio(d : TDireccio);
     public
          procedure   Paint; override;
          constructor Create(AOwner : TComponent); override;
     published
          property ColorInicial : TColor read FColorInicial write SetFColorInicial;
          property ColorFinal : TColor read FColorFinal write SetFColorFinal;
          property Direccio : TDireccio read FDireccio write SetFDireccio;
          property OnClick;
          property OnResize;
          property BevelOuter;
          property BevelInner;
          property Ctl3D;
          property Align;
          property TabOrder;
          property TabStop;
end;

type TGradientNC = class(TGraphicControl)
     private
          FColorInicial : TColor;
          FColorFinal   : TColor;
          FDireccio     : TDireccio;
     protected
          function  FerGradient : TBitmap;
          function  FerGradientVertical(ci,cf : TColor): TBitmap;
          function  FerGradientHoritzontal(ci,cf : TColor): TBitmap;

          procedure SetFColorInicial(ci : TColor);
          procedure SetFColorFinal(cf : TColor);
          procedure SetFDireccio(d : TDireccio);
     public
          procedure   Paint; override;
          constructor Create(AOwner : TComponent); override;
     published
          property ColorInicial : TColor read FColorInicial write SetFColorInicial;
          property ColorFinal : TColor read FColorFinal write SetFColorFinal;
          property Direccio : TDireccio read FDireccio write SetFDireccio;
          property OnClick;
          property Align;
end;

procedure Register;

implementation

constructor TGradient.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     Align := alClient;
     BevelOuter := bvNone;
     BevelInner := bvNone;
     Ctl3D := false;
     ColorInicial := clNavy;
     ColorFinal   := clWhite;
     Direccio := N;

     DoubleBuffered := true;
end;

procedure TGradient.SetFColorInicial(ci : TColor);
begin
     FColorInicial := ci;
     invalidate;
end;

procedure TGradient.SetFColorFinal(cf : TColor);
begin
     FColorFinal := cf;
     invalidate;
end;

function TGradient.FerGradient : TBitmap;
var
     b : TBitmap;
begin
     case Direccio of
     N : b := FerGradientVertical(FColorFinal,FColorInicial);
     S : b := FerGradientVertical(FColorInicial,FColorFinal);
     E : b := FerGradientHoritzontal(FColorInicial,FColorFinal);
     O : b := FerGradientHoritzontal(FColorFinal,FColorInicial);
     else
     b := nil;
     end;

     result := b;
end;

procedure TGradient.SetFDireccio(d : TDireccio);
begin
     FDireccio := d;

     invalidate;
end;

function TGradient.FerGradientVertical(ci,cf : TColor) : TBitmap;
var
     bt : TBitmap;
     ri,gi,bi : integer;
     rf,gf,bf : integer;
     r,g,b    : integer;
     dr,dg,db : double;
     i : integer;
begin
     bt := TBitmap.Create;
     bt.Width  := Width;
     bt.Height := Height;

     if Height = 0 then begin result := bt; exit; end;

     ri := ci mod $0100;
     gi := (ci div $000000100) mod $0100;
     bi := ci div $00010000;

     rf := cf mod $0100;
     gf := (cf div $000000100) mod $0100;
     bf := cf div $00010000;

     dr := (rf - ri) / Height;
     dg := (gf - gi) / Height;
     db := (bf - bi) / Height;

     for i := 0 to Height  do
     begin
          r := ri + Round(dr*i);
          g := gi + Round(dg*i);
          b := bi + Round(db*i);

          bt.Canvas.Pen.Color := (b * $00010000) + (g * $00000100) + r;
          bt.Canvas.MoveTo(0,i);
          bt.Canvas.LineTo(Width,i);
     end;

     result := bt;
end;

function TGradient.FerGradientHoritzontal(ci,cf : TColor) : TBitmap;
var
     bt : TBitmap;
     ri,gi,bi : integer;
     rf,gf,bf : integer;
     r,g,b    : integer;
     dr,dg,db : double;
     i : integer;
begin
     bt := TBitmap.Create;
     bt.Width  := Width;
     bt.Height := Height;

     if Width = 0 then begin result := bt; exit; end;

     ri := ci mod $0100;
     gi := (ci div $00000100) mod $0100;
     bi := ci div $00010000;

     rf := cf mod $0100;
     gf := (cf div $00000100) mod $0100;
     bf := cf div $00010000;

     dr := (rf - ri) / Width;
     dg := (gf - gi) / Width;
     db := (bf - bi) / Width;

     for i := 0 to Width do
     begin
          r := ri + Round(dr*i);
          g := gi + Round(dg*i);
          b := bi + Round(db*i);

          bt.Canvas.Pen.Color := (b * $00010000) + (g * $00000100) + r;
          bt.Canvas.MoveTo(i,0);
          bt.Canvas.LineTo(i,Height);
     end;

     result := bt;
end;

procedure TGradient.Paint;
var
     b : TBitmap;
begin
     b := FerGradient;
     bitblt(Canvas.Handle,0,0,Width,Height,b.Canvas.Handle,0,0,SRCCOPY);
     b.Free;
end;

procedure Register;
begin
     RegisterComponents('pkCUSTCTRLS', [TGradient,TGradientNC]);
end;

constructor TGradientNC.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     ColorInicial := clNavy;
     ColorFinal   := clWhite;
     Direccio := N;
end;

procedure TGradientNC.SetFColorInicial(ci : TColor);
begin
     FColorInicial := ci;
     invalidate;
end;

procedure TGradientNC.SetFColorFinal(cf : TColor);
begin
     FColorFinal := cf;
     invalidate;
end;

function TGradientNC.FerGradient : TBitmap;
var
     b : TBitmap;
begin
     case Direccio of
     N : b := FerGradientVertical(FColorFinal,FColorInicial);
     S : b := FerGradientVertical(FColorInicial,FColorFinal);
     E : b := FerGradientHoritzontal(FColorInicial,FColorFinal);
     O : b := FerGradientHoritzontal(FColorFinal,FColorInicial);
     else
     b := nil;
     end;

     result := b;
end;

procedure TGradientNC.SetFDireccio(d : TDireccio);
begin
     FDireccio := d;

     invalidate;
end;

function TGradientNC.FerGradientVertical(ci,cf : TColor) : TBitmap;
var
     bt : TBitmap;
     ri,gi,bi : integer;
     rf,gf,bf : integer;
     r,g,b    : integer;
     dr,dg,db : double;
     i : integer;
begin
     bt := TBitmap.Create;
     bt.Width  := Width;
     bt.Height := Height;

     if Height = 0 then begin result := bt; exit; end;

     ri := ci mod $0100;
     gi := (ci div $000000100) mod $0100;
     bi := ci div $00010000;

     rf := cf mod $0100;
     gf := (cf div $000000100) mod $0100;
     bf := cf div $00010000;

     dr := (rf - ri) / Height;
     dg := (gf - gi) / Height;
     db := (bf - bi) / Height;

     for i := 0 to Height  do
     begin
          r := ri + Round(dr*i);
          g := gi + Round(dg*i);
          b := bi + Round(db*i);

          bt.Canvas.Pen.Color := (b * $00010000) + (g * $00000100) + r;
          bt.Canvas.MoveTo(0,i);
          bt.Canvas.LineTo(Width,i);
     end;

     result := bt;
end;

function TGradientNC.FerGradientHoritzontal(ci,cf : TColor) : TBitmap;
var
     bt : TBitmap;
     ri,gi,bi : integer;
     rf,gf,bf : integer;
     r,g,b    : integer;
     dr,dg,db : double;
     i : integer;
begin
     bt := TBitmap.Create;
     bt.Width  := Width;
     bt.Height := Height;

     if Width = 0 then begin result := bt; exit; end;

     ri := ci mod $0100;
     gi := (ci div $00000100) mod $0100;
     bi := ci div $00010000;

     rf := cf mod $0100;
     gf := (cf div $00000100) mod $0100;
     bf := cf div $00010000;

     dr := (rf - ri) / Width;
     dg := (gf - gi) / Width;
     db := (bf - bi) / Width;

     for i := 0 to Width do
     begin
          r := ri + Round(dr*i);
          g := gi + Round(dg*i);
          b := bi + Round(db*i);

          bt.Canvas.Pen.Color := (b * $00010000) + (g * $00000100) + r;
          bt.Canvas.MoveTo(i,0);
          bt.Canvas.LineTo(i,Height);
     end;

     result := bt;
end;

procedure TGradientNC.Paint;
var
     b : TBitmap;
begin
     b := FerGradient;
     bitblt(Canvas.Handle,0,0,Width,Height,b.Canvas.Handle,0,0,SRCCOPY);
     b.Free;
end;

end.
