unit LlistCfg;

interface

uses udbvaux, classes, db;

type TCTaules = (   ctArticles,
                    ctAveries,
                    ctAveArt,
                    ctAveInt,
                    ctPersonals,
                    ctPressupostos,
                    ctc_Pressupostos,
                    ctc_Ventes,
                    ctc_Entrades,
                    ctVentes,
                    ctEntrades,
                    ctCaixa,
                    ctTorns,
                    ctMagatzem,
                    ctPoblacions,
                    ctMarques,
                    ctFamilies,
                    ctLinies,
                    ctAveArt_P,
                    ctAveInt_P,
                    ctPersonals_P,
                    ctc_general,
                    ctSegMag,
                    ctSumCli,
                    ctSumArt,
                    ctVisites,
                    ctMargeMig);

     TCInfo = array [TCTaules] of TColumnsInfo30;

const
     L = taLeftJustify;
     C = taCenter;
     R = taRightJustify;

     Dt = 'ddddd';
     Dh = 'ddddd (h:nn)';
     Hh = 'h:nn';
     F = '0.00';
     Fu = '0.0';
     FNz = F + '~';
     FPc = F + '%~';
     FPs = '0%';
     E = '';

     P = 50;
     N = 80;
     M = 120;
     H = 250;
     G = 400;
     X = 500;

     I = ftInteger;
     B = ftBoolean;
     D = ftFloat;
     S = ftString;
     T = ftDateTime;
     MM = ftMemo;

     CInfo : TCInfo =
     (

     {articles}

       ((),
        {id}             (Alignment : L ; Title : 'ref.'              ; Format : E        ; Width : N; FieldType : I),
        {descr}          (Alignment : L ; Title : 'descripció'        ; Format : E        ; Width : G; FieldType : S),
        {pvp}            (Alignment : R ; Title : 'P.V.P.'            ; Format : F        ; Width : N; FieldType : D),
        {stock}          (Alignment : C ; Title : 'stock'             ; Format : E        ; Width : P; FieldType : B),
        {familia}        (Alignment : L ; Title : 'família'           ; Format : E        ; Width : M; FieldType : S),
        {marca}          (Alignment : L ; Title : 'marca'             ; Format : E        ; Width : M; FieldType : S),
        {linia}          (Alignment : L ; Title : 'línia'             ; Format : E        ; Width : M; FieldType : S),
        {PBase}          (Alignment : R ; Title : 'P.Base'            ; Format : F        ; Width : N; FieldType : D),
        {PCost}          (Alignment : R ; Title : 'P.Cost'            ; Format : F        ; Width : N; FieldType : D),
        {PRec}           (Alignment : R ; Title : 'P.Rec.'            ; Format : F        ; Width : N; FieldType : D),
        {PMin}           (Alignment : R ; Title : 'P.Mín.'            ; Format : F        ; Width : N; FieldType : D),
        {Marge}          (Alignment : R ; Title : 'marge'             ; Format : FPc      ; Width : N; FieldType : D),
        {Marge_mar}      (Alignment : R ; Title : 'marge mar.'        ; Format : FPc      ; Width : N; FieldType : D),
        {data_registre}  (Alignment : C ; Title : 'data registre'     ; Format : Dt       ; Width : M; FieldType : T),
        {id_mar}         (Alignment : C ; Title : 'ref.marc.'         ; Format : E        ; Width : N; FieldType : I),
        {id_fam}         (Alignment : C ; Title : 'ref.fam.'          ; Format : E        ; Width : N; FieldType : I),
        {id_lin}         (Alignment : C ; Title : 'ref.fam.'          ; Format : E        ; Width : N; FieldType : I),
        {codi_barres}    (Alignment : L ; Title : 'codi de barres'    ; Format : E        ; Width : G; FieldType : S),
        {} (),(),
        {} (),(),(),(),(),(),(),(),(),()
        ),

     {averies}

     (
        (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {data}           (Alignment : C ; Title : 'Data'                   ; Format : Dt       ; Width : M; FieldType : T),
        {nom_cli}        (Alignment : L ; Title : 'Nom client'             ; Format : E        ; Width : G; FieldType : S),
        {anomalies}      (Alignment : L ; Title : 'Anomalíes detectades'   ; Format : E        ; Width : X; FieldType : S),
        {garantia}       (Alignment : C ; Title : 'Garantia'               ; Format : E        ; Width : P; FieldType : B),
        {data_entrada}   (Alignment : C ; Title : 'Data d''entrada'        ; Format : Dt       ; Width : M; FieldType : T),
        {data_entrega}   (Alignment : C ; Title : 'Data d''entrega'        ; Format : Dt       ; Width : M; FieldType : T),
        {rep_a_domicili} (Alignment : C ; Title : 'A domicili'             ; Format : E        ; Width : P; FieldType : B),
        {disp_hor}       (Alignment : L ; Title : 'Disponibilitat horaria' ; Format : E        ; Width : G; FieldType : S),
        {data_visita}    (Alignment : C ; Title : 'Data visita'            ; Format : Dt       ; Width : M; FieldType : T),
        {rep_externa}    (Alignment : C ; Title : 'Externa'                ; Format : E        ; Width : P; FieldType : B),
        {nom_rep}        (Alignment : L ; Title : 'Reparador'              ; Format : E        ; Width : G; FieldType : S),
        {enviat}         (Alignment : C ; Title : 'Enviat'                 ; Format : E        ; Width : P; FieldType : B),
        {data_enviament} (Alignment : C ; Title : 'Data enviament'         ; Format : Dt       ; Width : M; FieldType : T),
        {data_reparacio} (Alignment : C ; Title : 'Data de reparació'      ; Format : Dt       ; Width : M; FieldType : T),
        {rep_finalitzada}(Alignment : C ; Title : 'Finalitz.'              ; Format : E        ; Width : P; FieldType : B),
        {ref_origen}     (Alignment : C ; Title : 'ref.origen'             ; Format : E        ; Width : N; FieldType : I),
        {ref_origen_lin} (Alignment : C ; Title : 'lín.origen'             ; Format : E        ; Width : P; FieldType : S),
        {ref_factura}    (Alignment : C ; Title : 'ref.fact.'              ; Format : E        ; Width : N; FieldType : I),
        {ref_factura_lin}(Alignment : C ; Title : 'lín.fact.'              ; Format : E        ; Width : P; FieldType : S),
        {id_rep}         (Alignment : C ; Title : 'ref.rep.'               ; Format : E        ; Width : N; FieldType : I),
        {id_cli}         (Alignment : C ; Title : 'ref.client'             ; Format : E        ; Width : N; FieldType : I),
        {dir_cli}        (Alignment : L ; Title : 'Direcció client'        ; Format : E        ; Width : H; FieldType : S),
        {tel_cli}        (Alignment : L ; Title : 'Telèfon client'         ; Format : E        ; Width : H; FieldType : S),
        {nif_cli}        (Alignment : L ; Title : 'N.I.F. client'          ; Format : E        ; Width : H; FieldType : S),
        {pob_cli}        (Alignment : L ; Title : 'Població'               ; Format : E        ; Width : M; FieldType : S),
        {cp_cli}         (Alignment : L ; Title : 'C.P.'                   ; Format : E        ; Width : P; FieldType : S),
        {observacions}   (Alignment : L ; Title : 'Observacions'           ; Format : E        ; Width : X; FieldType : MM),
        {ates_per}       (Alignment : L ; Title : 'Atés per'               ; Format : E        ; Width : M; FieldType : S),
        {n_serie}        (Alignment : L ; Title : 'Nombres de sèrie'       ; Format : E        ; Width : G; FieldType : MM)
        ),

       {aveart}
       (
        (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {id_ref}         (Alignment : C ; Title : 'averia'                 ; Format : E        ; Width : N; FieldType : I),
        {id_elem}        (Alignment : C ; Title : 'ref.art.'               ; Format : E        ; Width : N; FieldType : I),
        {id_lin}         (Alignment : C ; Title : 'ref.lín.'               ; Format : E        ; Width : N; FieldType : I),
        {concepte}       (Alignment : L ; Title : 'Article a reparar'      ; Format : E        ; Width : G; FieldType : S),
        {uts}            (Alignment : R ; Title : 'Uts.'                   ; Format : Fu       ; Width : N; FieldType : D),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

       {aveint}
       (
        (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {id_ref}         (Alignment : C ; Title : 'averia'                 ; Format : E        ; Width : N; FieldType : I),
        {id_elem}        (Alignment : C ; Title : 'ref.art.'               ; Format : E        ; Width : N; FieldType : I),
        {id_lin}         (Alignment : C ; Title : 'ref.lín.'               ; Format : E        ; Width : N; FieldType : I),
        {concepte}       (Alignment : L ; Title : 'Intervenció / material' ; Format : E        ; Width : G; FieldType : S),
        {uts}            (Alignment : R ; Title : 'Uts.'                   ; Format : Fu       ; Width : N; FieldType : D),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

       {personals}
       (
       (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {nom}            (Alignment : L ; Title : 'Nom'                    ; Format : E        ; Width : G; FieldType : S),
        {nif}            (Alignment : L ; Title : 'N.I.F.'                 ; Format : E        ; Width : H; FieldType : S),
        {tel}            (Alignment : L ; Title : 'Telèfon'                ; Format : E        ; Width : H; FieldType : S),
        {dir}            (Alignment : L ; Title : 'Direcció'               ; Format : E        ; Width : G; FieldType : S),
        {pob}            (Alignment : L ; Title : 'Població'               ; Format : E        ; Width : M; FieldType : S),
        {cp}             (Alignment : L ; Title : 'C.P.'                   ; Format : E        ; Width : P; FieldType : S),
        {a_compte}       (Alignment : R ; Title : 'A compte'               ; Format : FNz      ; Width : N; FieldType : D),
        {en_deute}       (Alignment : R ; Title : 'En deute'               ; Format : FNz      ; Width : N; FieldType : D),
        {ultima_accio}   (Alignment : C ; Title : 'Última acció'           ; Format : Dt       ; Width : M; FieldType : T),
        {repetit}        (Alignment : C ; Title : 'Repetit'                ; Format : E+'~'    ; Width : P; FieldType : B),
        {tipus}          (Alignment : C ; Title : 'Tipus'                  ; Format : E        ; Width : P; FieldType : S),
        {obs}            (Alignment : L ; Title : 'Observacions'           ; Format : E        ; Width : X; FieldType : MM),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

       {pressupostos}

      (
        (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {data}           (Alignment : C ; Title : 'Data'                   ; Format : Dt       ; Width : M; FieldType : T),
        {realitzat}      (Alignment : C ; Title : 'Realitzat'              ; Format : E        ; Width : P; FieldType : B),
        {nom_cli}        (Alignment : L ; Title : 'Nom client'             ; Format : E        ; Width : G; FieldType : S),
        {total}          (Alignment : R ; Title : 'TOTAL'                  ; Format : F        ; Width : N; FieldType : D),
        {base}           (Alignment : R ; Title : 'Base'                   ; Format : F        ; Width : N; FieldType : D),
        {iva}            (Alignment : R ; Title : 'I.V.A.'                 ; Format : F        ; Width : N; FieldType : D),
        {iva_p}          (Alignment : R ; Title : 'I.V.A.(%)'              ; Format : FPs      ; Width : N; FieldType : D),
        {descompte}      (Alignment : R ; Title : 'Descomp.'               ; Format : FNz      ; Width : N; FieldType : D),
        {descompte_p}    (Alignment : R ; Title : 'Descomp.(%)'            ; Format : FPc      ; Width : N; FieldType : D),
        {subtotal}       (Alignment : R ; Title : 'Subtotal'               ; Format : F        ; Width : N; FieldType : D),
        {ref_factura}    (Alignment : C ; Title : 'ref.factura'            ; Format : E        ; Width : N; FieldType : I),
        {id_cli}         (Alignment : C ; Title : 'ref.client'             ; Format : E        ; Width : N; FieldType : I),
        {dir_cli}        (Alignment : L ; Title : 'Direcció client'        ; Format : E        ; Width : H; FieldType : S),
        {tel_cli}        (Alignment : L ; Title : 'Telèfon client'         ; Format : E        ; Width : H; FieldType : S),
        {nif_cli}        (Alignment : L ; Title : 'N.I.F. client'          ; Format : E        ; Width : H; FieldType : S),
        {pob_cli}        (Alignment : L ; Title : 'Població'               ; Format : E        ; Width : M; FieldType : S),
        {cp_cli}         (Alignment : L ; Title : 'C.P.'                   ; Format : E        ; Width : P; FieldType : S),
        {observacions}   (Alignment : L ; Title : 'Observacions'           ; Format : E        ; Width : X; FieldType : MM),
        {ref_factura_lin}(Alignment : C ; Title : 'lín.fact.'              ; Format : E        ; Width : P; FieldType : S),
        {ates_per}       (Alignment : L ; Title : 'Atés per'               ; Format : E        ; Width : M; FieldType : S),
        {n_serie}        (Alignment : L ; Title : 'Nombres de sèrie'       ; Format : E        ; Width : G; FieldType : MM),
        {peu}            (Alignment : L ; Title : 'Peu d''informe'         ; Format : E        ; Width : G; FieldType : S),
       (),(),(),(),(),(),()
        ),

     {c_pressupostos}

        (
          (),
          {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
          {id_ref}         (Alignment : C ; Title : 'pressupost'             ; Format : E        ; Width : N; FieldType : I),
          {id_elem}        (Alignment : C ; Title : 'ref.art.'               ; Format : E+'~'    ; Width : N; FieldType : I),
          {id_lin}         (Alignment : C ; Title : 'ref.lín.'               ; Format : E        ; Width : N; FieldType : I),
          {concepte}       (Alignment : L ; Title : 'Intervenció / material' ; Format : E        ; Width : G; FieldType : S),
          {uts}            (Alignment : R ; Title : 'Uts.'                   ; Format : Fu       ; Width : N; FieldType : D),
          {preu}           (Alignment : R ; Title : 'Preu'                   ; Format : F        ; Width : N; FieldType : D),
          {import}         (Alignment : R ; Title : 'Import'                 ; Format : F        ; Width : N; FieldType : D),
          (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

     {c_ventes}

        (
          (),
          {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
          {id_ref}         (Alignment : C ; Title : 'venta'                  ; Format : E        ; Width : N; FieldType : I),
          {id_elem}        (Alignment : C ; Title : 'ref.art.'               ; Format : E+'~'    ; Width : N; FieldType : I),
          {id_lin}         (Alignment : C ; Title : 'ref.lín.'               ; Format : E        ; Width : N; FieldType : I),
          {concepte}       (Alignment : L ; Title : 'Concepte'               ; Format : E        ; Width : G; FieldType : S),
          {uts}            (Alignment : R ; Title : 'Uts.'                   ; Format : Fu       ; Width : N; FieldType : D),
          {preu}           (Alignment : R ; Title : 'Preu'                   ; Format : F        ; Width : N; FieldType : D),
          {import}         (Alignment : R ; Title : 'Import'                 ; Format : F        ; Width : N; FieldType : D),
          {marge}          (Alignment : R ; Title : 'Marge'                  ; Format : Fpc      ; Width : N; FieldType : D),
          {id_fam}         (Alignment : C ; Title : 'ref.fam.'               ; Format : E        ; Width : N; FieldType : I),
          (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

     {c_entrades}

        (
          (),
          {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
          {id_ref}         (Alignment : C ; Title : 'entrada'                ; Format : E        ; Width : N; FieldType : I),
          {id_elem}        (Alignment : C ; Title : 'ref.art.'               ; Format : E+'~'    ; Width : N; FieldType : I),
          {id_lin}         (Alignment : C ; Title : 'ref.lín.'               ; Format : E        ; Width : N; FieldType : I),
          {concepte}       (Alignment : L ; Title : 'Concepte'               ; Format : E        ; Width : G; FieldType : S),
          {uts}            (Alignment : R ; Title : 'Uts.'                   ; Format : Fu       ; Width : N; FieldType : D),
          {preu}           (Alignment : R ; Title : 'Preu'                   ; Format : F        ; Width : N; FieldType : D),
          {import}         (Alignment : R ; Title : 'Import'                 ; Format : F        ; Width : N; FieldType : D),
          (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {ventes}

//          {ventes}         ('id,DATA,PAGADA,NOM_CLI,TOTAL,BASE,IVA,IVA_P,DESCOMPTE,DESCOMPTE_P,SUBTOTAL,PENDENT,A_COMPTE,DATA_COBRO,ABONAMENT_DE,ABONADA,linea_venta,')
//          {ventes}         ('id_linea_venta,id_CLI,DIR_CLI,TEL_CLI,NIF_CLI,POB_CLI,CP_CLI,OBSERVACIONS,ref_averia,ref_pressupost');

        (
        (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {data}           (Alignment : C ; Title : 'Data'                   ; Format : Dt       ; Width : M; FieldType : T),
        {pagada}         (Alignment : C ; Title : 'Pagada'                 ; Format : E        ; Width : P; FieldType : B),
        {nom_cli}        (Alignment : L ; Title : 'Nom client'             ; Format : E        ; Width : G; FieldType : S),
        {total}          (Alignment : R ; Title : 'TOTAL'                  ; Format : F        ; Width : N; FieldType : D),
        {base}           (Alignment : R ; Title : 'Base'                   ; Format : F        ; Width : N; FieldType : D),
        {iva}            (Alignment : R ; Title : 'I.V.A.'                 ; Format : F        ; Width : N; FieldType : D),
        {iva_p}          (Alignment : R ; Title : 'I.V.A.(%)'              ; Format : FPs      ; Width : N; FieldType : D),
        {descompte}      (Alignment : R ; Title : 'Descomp.'               ; Format : FNz      ; Width : N; FieldType : D),
        {descompte_p}    (Alignment : R ; Title : 'Descomp.(%)'            ; Format : FPc      ; Width : N; FieldType : D),
        {subtotal}       (Alignment : R ; Title : 'Subtotal'               ; Format : F        ; Width : N; FieldType : D),
        {pendent}        (Alignment : R ; Title : 'Pendent'                ; Format : FNz      ; Width : N; FieldType : D),
        {a_compte}       (Alignment : R ; Title : 'A compte'               ; Format : FNz      ; Width : N; FieldType : D),
        {data_cobro}     (Alignment : C ; Title : 'Últim cobrament'        ; Format : Dt       ; Width : M; FieldType : T),
        {abonada}        (Alignment : C ; Title : 'Abonada'                ; Format : E+'~'    ; Width : N; FieldType : B),        
        {abonament_de}   (Alignment : C ; Title : 'Abona a'                ; Format : E+'~'    ; Width : N; FieldType : I),
        {linea_venta}    (Alignment : L ; Title : 'Línia venta articles'   ; Format : E        ; Width : H; FieldType : S),
        {id_linea_venta} (Alignment : L ; Title : 'id_linea_venta'         ; Format : E+'~'    ; Width : P; FieldType : I),
        {id_cli}         (Alignment : C ; Title : 'ref.client'             ; Format : E        ; Width : N; FieldType : I),
        {dir_cli}        (Alignment : L ; Title : 'Direcció client'        ; Format : E        ; Width : H; FieldType : S),
        {tel_cli}        (Alignment : L ; Title : 'Telèfon client'         ; Format : E        ; Width : H; FieldType : S),
        {nif_cli}        (Alignment : L ; Title : 'N.I.F. client'          ; Format : E        ; Width : H; FieldType : S),
        {pob_cli}        (Alignment : L ; Title : 'Població'               ; Format : E        ; Width : M; FieldType : S),
        {cp_cli}         (Alignment : L ; Title : 'C.P.'                   ; Format : E        ; Width : P; FieldType : S),
        {observacions}   (Alignment : L ; Title : 'Observacions'           ; Format : E        ; Width : X; FieldType : MM),
        {ref_averia}     (Alignment : C ; Title : 'Averia'                 ; Format : E+'~'    ; Width : N; FieldType : I),
        {ref_pressupost} (Alignment : C ; Title : 'Pressupost'             ; Format : E+'~'    ; Width : N; FieldType : I),
        {ates_per}       (Alignment : L ; Title : 'Atés per'               ; Format : E        ; Width : M; FieldType : S),
        {n_serie}        (Alignment : L ; Title : 'Nombres de sèrie'       ; Format : E        ; Width : G; FieldType : MM),
        ()
        ),

     {entrades}

//          {entrades}       ('id,DATA,REF_ALBARA,PAGADA,NOM_PRV,TOTAL,BASE,IVA,IVA_P,id_PRV,DIR_PRV,TEL_PRV,NIF_PRV,POB_PRV,CP_PRV,OBSERVACIONS')

      (
        (),
        {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {data}           (Alignment : C ; Title : 'Data'                   ; Format : Dt       ; Width : M; FieldType : T),
        {ref_albara}     (Alignment : L ; Title : 'Ref.albarà'             ; Format : E        ; Width : H; FieldType : S),
        {pagada}         (Alignment : C ; Title : 'Pagada'                 ; Format : E        ; Width : P; FieldType : B),
        {nom_prv}        (Alignment : L ; Title : 'Nom proveedor'          ; Format : E        ; Width : G; FieldType : S),
        {total}          (Alignment : R ; Title : 'TOTAL'                  ; Format : F        ; Width : N; FieldType : D),
        {base}           (Alignment : R ; Title : 'Base'                   ; Format : F        ; Width : N; FieldType : D),
        {iva}            (Alignment : R ; Title : 'I.V.A.'                 ; Format : F        ; Width : N; FieldType : D),
        {iva_p}          (Alignment : R ; Title : 'I.V.A.(%)'              ; Format : FPs      ; Width : N; FieldType : D),
        {id_prv}         (Alignment : C ; Title : 'ref.proveedor'          ; Format : E        ; Width : N; FieldType : I),
        {dir_prv}        (Alignment : L ; Title : 'Direcció proveedor'     ; Format : E        ; Width : H; FieldType : S),
        {tel_prv}        (Alignment : L ; Title : 'Telèfon proveedor'      ; Format : E        ; Width : H; FieldType : S),
        {nif_prv}        (Alignment : L ; Title : 'N.I.F. proveedor'       ; Format : E        ; Width : H; FieldType : S),
        {pob_prv}        (Alignment : L ; Title : 'Població'               ; Format : E        ; Width : M; FieldType : S),
        {cp_prv}         (Alignment : L ; Title : 'C.P.'                   ; Format : E        ; Width : P; FieldType : S),
        {observacions}   (Alignment : L ; Title : 'Observacions'           ; Format : E        ; Width : X; FieldType : MM),
       (),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {caixa}
        (
        (),
        {data}           (Alignment : C ; Title : 'Hora'                   ; Format : Hh       ; Width : N; FieldType : T),
        {linea_fact}     (Alignment : C ; Title : 'lin.fact.'              ; Format : E        ; Width : P; FieldType : S),
        {venta}          (Alignment : C ; Title : 'venta'                  ; Format : E        ; Width : N; FieldType : I),
        {tipus pag}      (Alignment : C ; Title : 't.pag.'                 ; Format : E        ; Width : P; FieldType : S),
        {Cobrat}         (Alignment : R ; Title : 'Cobrat'                 ; Format : F        ; Width : N; FieldType : D),
        {Base}           (Alignment : R ; Title : 'Base'                   ; Format : F        ; Width : N; FieldType : D),
        {I.V.A}          (Alignment : R ; Title : 'I.V.A.'                 ; Format : F        ; Width : N; FieldType : D),
        {Descompte}      (Alignment : R ; Title : 'Descomp.'               ; Format : F        ; Width : N; FieldType : D),
        {comentari}      (Alignment : L ; Title : 'Comentari'              ; Format : E        ; Width : H; FieldType : S),
        {id_torn}        (Alignment : C ; Title : 'Torn'                   ; Format : E        ; Width : N; FieldType : I),
        {id}             (Alignment : C ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {torns}

        (
        (),
        {id}             (Alignment : C ; Title : 'Torn'                   ; Format : E        ; Width : N; FieldType : I),
        {obertura}       (Alignment : C ; Title : 'Obertura'               ; Format : Dh       ; Width : H; FieldType : T),
        {tancament}      (Alignment : C ; Title : 'Tancament'              ; Format : Dh       ; Width : H; FieldType : T),
        {tancat}         (Alignment : C ; Title : 'Tancat'                 ; Format : E        ; Width : P; FieldType : B),
        {reobert}        (Alignment : C ; Title : 'Reobert'                ; Format : E        ; Width : P; FieldType : B),
        {Total_directe}  (Alignment : R ; Title : 'Mov.directe'            ; Format : F        ; Width : N; FieldType : D),        
        {total_torn}     (Alignment : R ; Title : 'TOTAL'                  ; Format : F        ; Width : N; FieldType : D),
        {n_ventes_torn}  (Alignment : C ; Title : 'nºventes'               ; Format : E        ; Width : P; FieldType : I),
        {base_torn}      (Alignment : R ; Title : 'Base'                   ; Format : F        ; Width : N; FieldType : D),
        {iva_torn}       (Alignment : R ; Title : 'I.V.A'                  ; Format : F        ; Width : N; FieldType : D),
        {descomptes_torn}(Alignment : R ; Title : 'Descomp.'               ; Format : F        ; Width : N; FieldType : D),
        {n_ventes_A}     (Alignment : C ; Title : 'nºventes(A)'            ; Format : E        ; Width : P; FieldType : I),
        {base_A}         (Alignment : R ; Title : 'Base(A)'                ; Format : F        ; Width : N; FieldType : D),
        {iva_A}          (Alignment : R ; Title : 'I.V.A(A)'               ; Format : F        ; Width : N; FieldType : D),
        {descomptes_A}   (Alignment : R ; Title : 'Descomp.(A)'            ; Format : F        ; Width : N; FieldType : D),
        {total_A}        (Alignment : R ; Title : 'TOTAL(A)'               ; Format : F        ; Width : N; FieldType : D),
        {n_ventes_B}     (Alignment : C ; Title : 'nºventes(B)'            ; Format : E        ; Width : P; FieldType : I),
        {base_B}         (Alignment : R ; Title : 'Base(B)'                ; Format : F        ; Width : N; FieldType : D),
        {iva_B}          (Alignment : R ; Title : 'I.V.A(B)'               ; Format : F        ; Width : N; FieldType : D),
        {descomptes_B}   (Alignment : R ; Title : 'Descomp.(B)'            ; Format : F        ; Width : N; FieldType : D),
        {total_B}        (Alignment : R ; Title : 'TOTAL(B)'               ; Format : F        ; Width : N; FieldType : D),
        (),(),(),(),(),(),(),(),()
        ),

        {magatzem}

        (
        (),
        {id}             (Alignment : C ; Title : 'Torn'                   ; Format : E        ; Width : N; FieldType : I),
        {descr}          (Alignment : L ; Title : 'Article'                ; Format : E        ; Width : G; FieldType : S),
        {ultima_mod}     (Alignment : C ; Title : 'Última mod.'            ; Format : Dt       ; Width : M; FieldType : T),
        {uts_actuals}    (Alignment : R ; Title : 'Uts.actuals'            ; Format : E        ; Width : N; FieldType : D),
        {uts_anteriors}  (Alignment : R ; Title : 'Uts.anteriors'          ; Format : E        ; Width : N; FieldType : D),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {poblacions}
        (
        (),
        {id}             (Alignment : C ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {poblacio}       (Alignment : L ; Title : 'Població'               ; Format : E        ; Width : H; FieldType : S),
        {cp}             (Alignment : C ; Title : 'C.P.'                   ; Format : E        ; Width : P; FieldType : S),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {marques}
        (
        (),
        {id}             (Alignment : C ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {descr}          (Alignment : L ; Title : 'marca'                  ; Format : E        ; Width : M; FieldType : S),
        {marge}          (Alignment : C ; Title : 'marge'                  ; Format : '0.00%~< >'; Width : N; FieldType : D),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {families}
        (
        (),
        {id}             (Alignment : C ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {descr}          (Alignment : L ; Title : 'família'                ; Format : E        ; Width : H; FieldType : S),
        {id_lin}         (Alignment : C ; Title : 'ref.lin'                ; Format : E        ; Width : P; FieldType : I),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {linies}
        (
        (),
        {id}             (Alignment : C ; Title : 'ref.'                   ; Format : E        ; Width : N; FieldType : I),
        {descr}          (Alignment : L ; Title : 'línia'                  ; Format : E        ; Width : H; FieldType : S),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {aveArt_p}
        (
        (),
        {id_elem}        (Alignment : C; Title : 'ref.art.'                ; Format : E        ; Width : N; FieldType : I),
        {concepte}       (Alignment : L; Title : 'Article a reparar'       ; Format : E        ; Width : G; FieldType : S),
        {uts}            (Alignment : R; Title : 'uts.'                    ; Format : E        ; Width : N; FieldType : D),
        {id_ref}         (Alignment : C; Title : ''; Format : E; Width : 0; FieldType : I),
        {id}             (Alignment : C; Title : ''; Format : E; Width : 0; FieldType : I),
        {id_lin}         (Alignment : C; Title : ''; Format : E; Width : 0; FieldType : I),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {aveInt_p}
        (
        (),
        {id_elem}        (Alignment : C; Title : 'ref.art.'                ; Format : E        ; Width : N; FieldType : I),
        {concepte}       (Alignment : L; Title : 'Intervencions /mat.'     ; Format : E        ; Width : G; FieldType : S),
        {uts}            (Alignment : R; Title : 'uts./h.'                 ; Format : E        ; Width : N; FieldType : D),
        {id_ref}         (Alignment : C; Title : ''; Format : E; Width : 0; FieldType : I),
        {id}             (Alignment : C; Title : ''; Format : E; Width : 0; FieldType : I),
        {id_lin}         (Alignment : C; Title : ''; Format : E; Width : 0; FieldType : I),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

        {personals_p}
        (
          (),
        {id}             (Alignment : C; Title : 'ref.' ; Format : E; Width : N; FieldType : I),
        {tipus}          (Alignment : C; Title : 'tipus'; Format : E; Width : N; FieldType : S),
        {nom}            (Alignment : L; Title : 'Nom'  ; Format : E; Width : G; FieldType : S),
        {dir}            (Alignment : L; Title : 'Direcció'  ; Format : E; Width : H; FieldType : S),
        {pob}            (Alignment : L; Title : 'Població'  ; Format : E; Width : H; FieldType : S),
        {nif}            (Alignment : L; Title : 'N.I.F.';  Format : E; Width : 0; FieldType : S),
        {cp}             (Alignment : L; Title : 'CP'; Format : E; Width : 0; FieldType : S),
        {tel}            (Alignment : L; Title : 'CP'; Format : E; Width : 0; FieldType : S),
        (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

     {c_general}

        (
          (),
          {id}             (Alignment : L ; Title : 'ref.'                   ; Format : E        ; Width : 0; FieldType : I),
          {id_ref}         (Alignment : C ; Title : 'venta'                  ; Format : E        ; Width : 0; FieldType : I),
          {id_elem}        (Alignment : C ; Title : 'ref.art.'               ; Format : E+'~'    ; Width : P; FieldType : I),
          {id_lin}         (Alignment : C ; Title : 'ref.lín.'               ; Format : E        ; Width : 0; FieldType : I),
          {concepte}       (Alignment : L ; Title : 'Concepte'               ; Format : E        ; Width : H+70; FieldType : S),
          {uts}            (Alignment : R ; Title : 'uts./h.'                ; Format : Fu       ; Width : P; FieldType : D),
          {preu}           (Alignment : R ; Title : 'Preu'                   ; Format : F        ; Width : N; FieldType : D),
          {import}         (Alignment : R ; Title : 'Import'                 ; Format : F        ; Width : N; FieldType : D),
          (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
        ),

     {segmag}
       (
          (),
          {id}             (Alignment : L; Title : 'ref.';Format : E; Width : 0; FieldType : I),
          {data}           (Alignment : C; Title : 'data';Format : Dt; Width : M; FieldType : T),
          {id_ref}         (Alignment : C; Title : 'ref.';Format : E; Width : P; FieldType : I),
          {tp_ref}         (Alignment : C; Title : 'tipus ref.';Format : E; Width : P; FieldType : S),
          {uts_mod}        (Alignment : R; Title : 'uts.mod.'  ;Format : '0.0'; Width : N; FieldType : D),
          (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

     {sumacli}
       (
          (),
          {id_cli}  (Alignment : L; Title : 'ref.cli'; Format : E; Width : N; FieldType : I),
          {nom_cli} (Alignment : L; Title : 'Client'; Format : E; Width : H; FieldType : S),
          {dir_cli} (Alignment : L; Title : 'Direcció'; Format : E; Width : M; FieldType : S),
          {Base}           (Alignment : R ; Title : 'Base'                   ; Format : F        ; Width : N; FieldType : D),
          {I.V.A}          (Alignment : R ; Title : 'I.V.A.'                 ; Format : F        ; Width : N; FieldType : D),
          {Subtotal}       (Alignment : R ; Title : 'Subtotal'               ; Format : F        ; Width : N; FieldType : D),
          {Descompte}      (Alignment : R ; Title : 'Descomp.'               ; Format : F        ; Width : N; FieldType : D),
          {Total}          (Alignment : R ; Title : 'Total'                  ; Format : F        ; Width : N; FieldType : D),
          (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

       {sumart}

       (
       (),
       {id}    (Alignment : L; Title : 'ref.'; Format : E; Width : N; FieldType : I),
       {linia} (Alignment : L; Title : 'línia'; Format : E; Width : H; FieldType : S),
       {total} (Alignment : R; Title : 'TOTAL'; Format : F; Width : N; FieldType : D),
       {uts}   (Alignment : R; Title : 'uts.'; Format : E; Width : P; FieldType : D),
       (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

       {visites}

       (
       (),
       {id}                   (Alignment : L; Title : 'ref.'; Format : E; Width : N; FieldType : I),
       {data_visita}          (Alignment : C; Title : 'data visita';Format : Dt; Width : M; FieldType : T),
       {disp_hor}             (Alignment : L; Title : 'disp. horaria';Format : Dt; Width : M; FieldType : T),
       {nom_cli}              (Alignment : L; Title : 'client';Format : E; Width : G; FieldType : S),
       {anomalies}            (Alignment : L; Title : 'Anomalíes a reparar'; Format : E; Width : X; FieldType : MM),
       (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       ),

       {marge_mig}
       (
       (),
       {id_fam}   (Alignment : L; Title : 'ref.fam.'; Format : E; Width : N; FieldType : I),
       {familia}  (Alignment : L; Title : 'família'; Format : E; Width : G; FieldType : S),
       {marge_mig}(Alignment : R; Title : 'marge mig'; Format : FPc; Width : N; FieldType : D),
       (),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),(),()
       )
     );

     VisFields : array [TCTaules] of string =
     (
          {articles}       ('id,DESCR,PVP,STOCK,FAMILIA,MARCA,LINIA,PBase,PCost,PRec,PMin,Marge,Marge_mar,DATA_REGISTRE,id_mar,id_fam,id_lin,codi_barres'),
          {averies}        ('id,data,nom_cli,anomalies,garantia,data_entrada,data_entrega,rep_a_domicili,disp_hor,data_visita,rep_externa,nom_rep,enviat,'),
          {aveart}         ('id,id_ref,id_elem,id_lin,concepte,uts'),
          {aveint}         ('id,id_ref,id_elem,id_lin,concepte,uts'),
          {personals}      ('id,NOM,NIF,TEL,DIR,POB,CP,A_COMPTE,EN_DEUTE,ULTIMA_ACCIO,repetit,tipus,obs'),
          {pressupostos}   ('id,DATA,REALITZAT,NOM_CLI,TOTAL,BASE,IVA,IVA_P,DESCOMPTE,DESCOMPTE_P,SUBTOTAL,REF_FACTURA,id_CLI,DIR_CLI,TEL_CLI,NIF_CLI,POB_CLI,CP_CLI,OBSERVACIONS,ref_factura_lin,ates_per,n_serie,peu'),
          {c_pressupostos} ('id,id_ref,id_elem,id_lin,concepte,uts,preu,import'),
          {c_ventes}       ('id,id_ref,id_elem,id_lin,concepte,uts,preu,import,marge,id_fam'),
          {c_entrades}     ('id,id_ref,id_elem,id_lin,concepte,uts,preu,import'),
          {ventes}         ('id,DATA,PAGADA,NOM_CLI,TOTAL,BASE,IVA,IVA_P,DESCOMPTE,DESCOMPTE_P,SUBTOTAL,PENDENT,A_COMPTE,DATA_COBRO,ABONADA,ABONAMENT_DE,linea_venta,'),
          {entrades}       ('id,DATA,REF_ALBARA,PAGADA,NOM_PRV,TOTAL,BASE,IVA,IVA_P,id_PRV,DIR_PRV,TEL_PRV,NIF_PRV,POB_PRV,CP_PRV,OBSERVACIONS'),
          {caixa}          ('data,linea_fact,venta,tipus_pagament,cobrat,base,iva,descompte,comentari,id_torn,id'),
          {torns}          ('id,obertura,tancament,tancat,reobert,total_directe,total_torn,n_ventes_torn,base_torn,iva_torn,'),
          {magatzem}       ('id,DESCR,ultima_mod,uts_actuals,uts_anteriors'),
          {poblacions}     ('id,poblacio,cp'),
          {marques}        ('id,descr,marge'),
          {families}       ('id,descr,id_lin'),
          {linies}         ('id,descr'),
          {aveArt_p}       ('id_elem,concepte,uts,id_ref,id,id_lin'),
          {aveInt_p}       ('id_elem,concepte,uts,id_ref,id,id_lin'),
          {personals_p}    ('id,tipus,nom,dir,pob,nif,cp,tel'),
          {c_general}      ('id,id_ref,id_elem,id_lin,concepte,uts,preu,import'),
          {segmag}         ('id,data,id_ref,tp_ref,uts_mod'),
          {sumcli}         ('id_cli,nom_cli,dir_cli,base,iva,subtotal,descompte,total'),
          {sumart}         ('id,linia,total,uts'),
          {visites}        ('id,data_visita,disp_hor,nom_cli,anomalies'),
          {marge_mig}      ('id_fam,familia,marge_mig')
     );
     VisFields2 : array [TCTaules] of string =
     (
          {articles}       (''),
          {averies}        ('data_enviament,data_reparacio,rep_finalitzada,ref_origen,ref_origen_lin,ref_factura,ref_factura_lin,id_rep,id_cli,dir_cli,tel_cli,nif_cli,pob_cli,cp_cli,observacions,ates_per,n_serie'),
          {aveart}         (''),
          {aveint}         (''),
          {personals}      (''),
          {pressupostos}   (''),
          {c_pressupostos} (''),
          {c_ventes}       (''),
          {c_entrades}     (''),
          {ventes}         ('id_linea_venta,id_CLI,DIR_CLI,TEL_CLI,NIF_CLI,POB_CLI,CP_CLI,OBSERVACIONS,ref_averia,ref_pressupost,ates_per,n_serie'),
          {entrades}       (''),
          {caixa}          (''),
          {torns}          ('descomptes_torn,n_ventes_A,base_A,iva_A,descomptes_A,total_A,n_ventes_B,base_B,iva_B,descomptes_B,total_B'),
          {magatzem}       (''),
          {poblacions}     (''),
          {marques}        (''),
          {families}       (''),
          {linies}         (''),
          {aveArt_p}       (''),
          {aveInt_p}       (''),
          {Personals_p}    (''),
          {c_general}      (''),
          {SegMag}         (''),
          {SumCli}         (''),
          {SumArt}         (''),
          {Visites}        (''),
          {marge_mig}      ('')
     );

procedure AssignaColumnInfo;

implementation

uses marques,families,linies,poblacions, personals, ventesB, entrades, articles, pressupostos, ventesA, caixa,
     averies, magatzem, cventesA,cventesB,cPressupostos,caveries,centrades;

procedure AssignaColumnInfo;
begin
     _articles.v.AssignColumnInfo(CInfo[ctArticles],VisFields[ctArticles]);
     _averies.v.AssignColumnInfo(CInfo[ctAveries],VisFields[ctAveries] + VisFields2[ctAveries]);
     _averies.vCArt.AssignColumnInfo(CInfo[ctAveArt],VisFields[ctAveart]);
     _averies.vCInt.AssignColumnInfo(CInfo[ctAveInt],VisFields[ctAveInt]);
     _personals.v.AssignColumnInfo(CInfo[ctPersonals],VisFields[ctPersonals]);
     _pressupostos.v.AssignColumnInfo(CInfo[ctPressupostos],VisFields[ctPressupostos]);
     _pressupostos.vC.AssignColumnInfo(CInfo[ctc_Pressupostos],VisFields[ctC_Pressupostos]);
     _ventesA.v.AssignColumnInfo(CInfo[ctVentes],VisFields[ctVentes]+VisFields2[ctVentes]);
     _ventesB.v.AssignColumnInfo(CInfo[ctVentes],VisFields[ctVentes]+VisFields2[ctVentes]);
     _ventesA.vC.AssignColumnInfo(CInfo[ctc_Ventes],VisFields[ctc_Ventes]);
     _ventesB.vC.AssignColumnInfo(CInfo[ctc_Ventes],VisFields[ctc_Ventes]);
     _entrades.v.AssignColumnInfo(CInfo[ctEntrades],VisFields[ctEntrades]);
     _entrades.vC.AssignColumnInfo(CInfo[ctc_Entrades],VisFields[ctc_Entrades]);
     _caixa.vC.AssignColumnInfo(CInfo[ctCaixa],VisFields[ctCaixa]);
     _caixa.v.AssignColumnInfo(CInfo[ctTorns],VisFields[ctTorns]+VisFields2[ctTorns]);
     _magatzem.v.AssignColumnInfo(CInfo[ctMagatzem],VisFields[ctMagatzem]);

     _cAveries.vCArt.AssignColumnInfo(CInfo[ctAveArt],VisFields[ctAveArt]);
     _cAveries.vCInt.AssignColumnInfo(CInfo[ctAveInt],VisFields[ctAveInt]);
     _cventesA.v.AssignColumnInfo(CInfo[ctc_Ventes],VisFields[ctc_Ventes]);
     _cventesB.v.AssignColumnInfo(CInfo[ctc_Ventes],VisFields[ctc_Ventes]);
     _cpressupostos.v.AssignColumnInfo(CInfo[ctc_Pressupostos],VisFields[ctc_Pressupostos]);
     _centrades.v.AssignColumnInfo(CInfo[ctc_entrades],VisFields[ctc_entrades]);

     _poblacions.v.AssignColumnInfo(CInfo[ctPoblacions],VisFields[ctPoblacions]);
     _marques.v.AssignColumnInfo(CInfo[ctMarques],VisFields[ctMarques]);
     _families.v.AssignColumnInfo(CInfo[ctFamilies],VisFields[ctFamilies]);
     _linies.v.AssignColumnInfo(CInfo[ctLinies],VisFields[ctLinies]);
end;

end.
