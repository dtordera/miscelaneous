unit llegcol;

interface

uses Windows, graphics, Forms, ExtCtrls, stdctrls, Gradient, Controls;

     procedure LlegendaPersonals;
     procedure LlegendaArticles;
     procedure LlegendaVentes;
     procedure LlegendaCaixa;
     procedure Llegendapressupostos;
     procedure LlegendaAveries;
     procedure LLegendaEntrades;
     procedure LlegendaMagatzem;

implementation

uses main, global;

procedure Llegenda(t : string; m : array of String; c : array of TColor);
var
     f : TForm;
     i : integer;
     w : integer;
     x : integer;
     s : TShape;
     l : TLabel;
     b : TButton;
     nc : TGradientNC;
begin
     x := length(m);
     w := 0;

     f := TForm.Create(Application);
     f.BorderStyle := bsToolWindow;
     f.Position    := poScreenCenter;
     f.Color       := _main.Color;
     f.Caption     := t;

     nc := TGradientNC.Create(f);
     nc.Parent := f;
     nc.Direccio := E;
     nc.Align := alRight;
     nc.ColorInicial := _main.fonsmain.ColorInicial;
     nc.ColorFinal   := _main.fonsmain.ColorFinal;

     b := TButton.Create(f);
     b.Parent := f;
     b.Cancel := true;
     b.ModalResult := mrCancel;
     b.Width := 0;

     for i := 0 to x - 1 do
     begin
          s := TShape.Create(f);
          s.Parent := f;
          s.Left   := 10;
          s.Top    := 10 + 19 * i;
          s.Width  := 40;
          s.Height := 20;
          s.Brush.Color  := c[i];

          l := TLabel.Create(f);
          l.Parent := f;
          l.Left   := 10 + 40 + 20;
          l.Top    := 10 + 19 * i;
          l.AutoSize := true;
          l.Transparent := true;
          l.Font.Color := _main.tArticles.Font.Color;
          l.Caption := m[i];
          if l.Width > w then w := l.Width;
     end;

     i := x - 1;

     f.ClientWidth  := 10 + 40 + 20 + w + 10;
     f.ClientHeight := 10 + 19*i + 20 + 10;
     nc.Width := f.ClientWidth - 100;
     nc.SendToBack;

     f.ShowModal;

     f.Release;
end;

procedure LlegendaEntrades;
begin
     Llegenda('Entrades',
     [
          'Normalitzacions d''inventari'
     ],
     [
     C_NORMALIT
     ]);
end;

procedure LlegendaMagatzem;
begin
     Llegenda('Magatzem',
     [
          'Unitats cero o menors de cero'
     ],
     [
     C_UTS_CERO
     ]);
end;

procedure LlegendaAveries;
begin
     Llegenda('Averies',
     [
     'Reparació finalitzada'
     ],
     [
     C_REP_FINALITZADA
     ]
     );
end;

procedure Llegendapressupostos;
begin
     Llegenda('Pressupostos',
     [
     'Pressupost realitzat'
     ],
     [
     C_REALITZATS
     ]
     );
end;

procedure LlegendaCaixa;
begin
     Llegenda('Caixa',
     [
     'Torn obert',
     'Abonament'
     ],
     [
     C_TORN_OBERT,
     C_ABONAMENT
     ]
     );
end;

procedure LlegendaPersonals;
begin
     Llegenda('Personals',
     [
     'Amb més de dos anys d''inactivitat',
     'Registre repetit a 2 camps identificadors',
     'Registre repetit a 3 camps. Probablement mateix registre entrat varis cops.',
     'Registre entrat varis cops (4 camps repetits)'
     ],
     [
     C_MESDOSANYS,
     C_REPETIT_2,
     C_REPETIT_3,
     C_REPETIT_4
     ]);
end;

procedure LlegendaArticles;
begin
     Llegenda('Articles',
     [
     'No entrats desde fitxer',
     'Amb PVP calculat desde preu de cost, aplicant marge per defecte',
     'Amb PVP calculat desde preu de cost, aplicant marge de marca',
     'Amb marge negatiu (preu cost > preu recomenat, preu mínim)',
     'Obsolets (tots els preus a cero)'
     ],
     [
     C_ENTRADADIRECTA,
     C_MARGEDEFECTE,
     C_MARGEMARCA,
     C_MARGENOVALID,
     C_OBSOLET
     ]);
end;

 procedure LlegendaVentes;
begin
     Llegenda('Ventes',
     [
     'Venta amb deute',
     'Venta amb abonaments',
     'Abonament d''una altra venta'
     ],
     [
     C_ENDEUTE,
     C_ABONADA,
     C_ABONAMENT
     ]);
end;

end.
