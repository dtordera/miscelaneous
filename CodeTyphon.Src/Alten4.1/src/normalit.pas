unit normalit;

interface

     function  NormalitzaNom(n : string) : string;
     function  NormalitzaNIF(n : string) : string;
     function  NormalitzaDir(n : string) : string;
     function  NormalitzaTel(n : string) : string;
     function  NormalitzaPob(n : string) : string;

implementation

uses sysutils, dmsrc, global;

function NormalitzaNom(n : string) : string;
begin
     n := AnsiUppercase(Trim(NoDblSpace(n)));
     result := n;

     if dm.CR['NO_NORMALIT'] = 'SI' then exit;

     n := StringReplace(n,'( ','(',[rfReplaceAll]);
     n := StringReplace(n,' )',')',[rfReplaceAll]);

     n := StringReplace(n,'S.L.','S.L',[rfReplaceAll]);
     n := StringReplace(n,'S.L','S.L.',[rfReplaceAll]);
     n := StringReplace(n,'S. L.','S. L',[rfReplaceAll]);
     n := StringReplace(n,'S. L','S.L.',[rfReplaceAll]);
     n := StringReplace(n,'S. A.','S. A',[rfReplaceAll]);
     n := StringReplace(n,'S. A','S.A.',[rfReplaceAll]);
     n := StringReplace(n,'S.A.','S.A',[rfReplaceAll]);
     n := StringReplace(n,'S.A','S.A.',[rfReplaceAll]);

     n := StringReplace(n,'. ','.',[rfReplaceAll]);
     n := StringReplace(n,'.','. ',[rfReplaceAll]);
     n := StringReplace(n,'S. A. ','S.A.',[rfReplaceAll]);
     n := StringReplace(n,'S. L.','S.L.',[rfReplaceAll]);

     result := Trim(n);
end;

function NormalitzaNIF(n : string) : string;
var
     c : char;
begin
     n := AnsiUppercase(Trim(NoDblSpace(n)));
     result := n;

     if dm.CR['NO_NORMALIT'] = 'SI' then exit;

     n := StringReplace(n,' ','',[rfReplaceAll]);
     n := AnsiUppercase(Trim(n));
     n := StringReplace(n,'-','',[rfReplaceAll]);
     result := n;

     if result = '' then exit;

     c := n[1];

     if (c in ['A'..'Z']) and (c <> 'X') and (c <> 'P') then
     result := Copy(n,2,20) + c;
end;

function NormalitzaDir(n : string) : string;
begin
     n := AnsiUpperCase(Trim(NoDblSpace(n)));
     result := n;

     if dm.CR['NO_NORMALIT'] = 'SI' then exit;

     n := StringReplace(n,', ',',',[rfReplaceAll]);
     n := StringReplace(n,',',', ',[rfReplaceAll]);

     n := StringReplace(n,'. ','.',[rfReplaceAll]);
     n := StringReplace(n,'.','. ',[rfReplaceAll]);

     n := StringReplace(n,'( ','(',[rfReplaceAll]);
     n := StringReplace(n,' )',')',[rfReplaceAll]);
     n := StringReplace(n,' (','(',[rfReplaceAll]);
     n := StringReplace(n,'(',' (',[rfReplaceAll]);
     n := StringReplace(n,') ',')',[rfReplaceAll]);
     n := StringReplace(n,')',') ',[rfReplaceAll]);

     n := StringReplace(n,'RBLA.','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RBLA ','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RAM.','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RAM ','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RAMB.','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RAMB ','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RBA.','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RBA ','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RMB.','RB.',[rfReplaceAll]);
     n := StringReplace(n,'RMB ','RB.',[rfReplaceAll]);

     n := StringReplace(n,'RECO ','RAC�',[rfReplaceAll]);
     n := StringReplace(n,'RIPOLLES ','RIPOLL�S',[rfReplaceAll]);

     n := StringReplace(n,'�','�',[rfReplaceAll]);
     n := StringReplace(n,'SEBERO ','SEVERO',[rfReplaceAll]);
     n := StringReplace(n,'MOLI ','MOL�',[rfReplaceAll]);

     n := StringReplace(n,'SNT ','SANT ',[rfReplaceAll]);
     n := StringReplace(n,'SOLI IXENT','SOL IXENT',[rfReplaceAll]);
     n := StringReplace(n,'SOLI XENT','SOL IXENT',[rfReplaceAll]);
     n := StringReplace(n,'SORALL ','SORRALL ',[rfReplaceAll]);
     n := StringReplace(n,'STA ','STA.',[rfReplaceAll]);
     n := StringReplace(n,'TEOLONGO ','THEOLONGO',[rfReplaceAll]);
     n := StringReplace(n,'BACHIO ','BACCHIO',[rfReplaceAll]);

     n := StringReplace(n,'TRAVESSERA','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRAVESIA ','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRAVESSIA ','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRAVE.','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRAVE ','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRA.','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRAV ','TRAV.',[rfReplaceAll]);
     n := StringReplace(n,'TRAV,','TRAV.',[rfReplaceAll]);

     n := StringReplace(n,'TURO ','TUR� ',[rfReplaceAll]);
     n := StringReplace(n,'UNIO ','UNI� ',[rfReplaceAll]);
     n := StringReplace(n,'URBANITZACI� ','URB.',[rfReplaceAll]);
     n := StringReplace(n,'URBANITZACIO ','URB.',[rfReplaceAll]);
     n := StringReplace(n,'CATALA ','CATAL� ',[rfReplaceAll]);
     n := StringReplace(n,'VICTOR ','V�CTOR ',[rfReplaceAll]);
     n := StringReplace(n,'BARREQUER ','BARRAQUER ',[rfReplaceAll]);
     n := StringReplace(n,'VIL�LA','VILA',[rfReplaceAll]);
     n := StringReplace(n,'VIL.LA','VILA',[rfReplaceAll]);

     n := StringReplace(n,'BARBARA ','B�RBARA ',[rfReplaceAll]);
     n := StringReplace(n,'SEBASTIA ','SEBASTI� ',[rfReplaceAll]);

     n := StringReplace(n,'ACCESO ','ACC�S',[rfReplaceAll]);
     n := StringReplace(n,'ACCES ','ACC�S',[rfReplaceAll]);
     n := StringReplace(n,'AC.','ACC�S ',[rfReplaceAll]);
     n := StringReplace(n,'A FORES','AFORES',[rfReplaceAll]);
     n := StringReplace(n,'AVD.','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AV ','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AV/','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVENIDA ','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AGDA.','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVINGUDA ','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVDA.','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVGD.','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVGDA.','AV.',[rfReplaceAll]);

     n := StringReplace(n,'AVG.','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVG ','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVG,','AV.',[rfReplaceAll]);
     n := StringReplace(n,'AVDA ','AV.',[rfReplaceAll]);
     n := StringReplace(n,'PLA�A ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAZA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLZA. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLA. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PZA. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PL. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLA�. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLA� ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAC.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAZ.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'P�A.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'P�A','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLC.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLZA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'POL IND ','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL. INDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL.IND ','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL INDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL.NDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL�GON IND.','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL�GON INDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'PORTANOVA','PORTA NOVA',[rfReplaceAll]);
     n := StringReplace(n,'POUI NOU','POU NOU',[rfReplaceAll]);
     n := StringReplace(n,'PRAT DE LA RIBA','PRAT DE LA RIVA',[rfReplaceAll]);
     n := StringReplace(n,'PROBEN�A','PROVEN�A',[rfReplaceAll]);
     n := StringReplace(n,'PROVENZA','PROVEN�A',[rfReplaceAll]);
     n := StringReplace(n,'PASSEIG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PSS.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PG.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASEIG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASSEG.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASSEI.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASEEIG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PAASEIG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASSEIG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASSG.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASS.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PSG.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PSG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PSSG.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PSSG ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PAS.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASEO','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PSEO ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASG.','PS.',[rfReplaceAll]);
     n := StringReplace(n,'PASS ','PS.',[rfReplaceAll]);
     n := StringReplace(n,'ATICO ','ATIC',[rfReplaceAll]);
     n := StringReplace(n,'ATC.','ATIC',[rfReplaceAll]);
     n := StringReplace(n,'BAJOS ','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BJOS ','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BAIXOS ','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BAIXOS','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BXS.','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BXS','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BJ. ','BX. ',[rfReplaceAll]);
     n := StringReplace(n,'BJ ','BX.',[rfReplaceAll]);
     n := StringReplace(n,'APART.','AP.',[rfReplaceAll]);
     n := StringReplace(n,'URB ','URB.',[rfReplaceAll]);
     n := StringReplace(n,'EDIF.','EDF.',[rfReplaceAll]);
     n := StringReplace(n,'ED.','EDF.',[rfReplaceAll]);
     n := StringReplace(n,'C /','C. ',[rfReplaceAll]);
     n := StringReplace(n,'C/','C.',[rfReplaceAll]);
     n := StringReplace(n,'CAMP.','CAMPING ',[rfReplaceAll]);
     n := StringReplace(n,'RECEPCION ','RECEPCI� ',[rfReplaceAll]);
     n := StringReplace(n,'- ','-',[rfReplaceAll]);
     n := StringReplace(n,' -','-',[rfReplaceAll]);
     n := StringReplace(n,'M�','MARIA',[rfReplaceAll]);
     n := StringReplace(n,'M� LLUISA','MARIA LLUISA',[rfReplaceAll]);
     n := StringReplace(n,'M� LUISA','MARIA LLUISA',[rfReplaceAll]);
     n := StringReplace(n,'�','�',[rfReplaceAll]);

     n := StringReplace(n,' 1 B',' 1B',[rfReplaceAll]);
     n := StringReplace(n,' 1-B',' 1B',[rfReplaceAll]);
     n := StringReplace(n,' 2 B',' 2B',[rfReplaceAll]);
     n := StringReplace(n,' 2-B',' 2B',[rfReplaceAll]);
     n := StringReplace(n,' 3 B',' 3B',[rfReplaceAll]);
     n := StringReplace(n,' 3-B',' 3B',[rfReplaceAll]);
     n := StringReplace(n,' 4 B',' 4B',[rfReplaceAll]);
     n := StringReplace(n,' 4-B',' 4B',[rfReplaceAll]);

     n := StringReplace(n,' 1 A',' 1A',[rfReplaceAll]);
     n := StringReplace(n,' 1-A',' 1A',[rfReplaceAll]);
     n := StringReplace(n,' 2 A',' 2A',[rfReplaceAll]);
     n := StringReplace(n,' 2-A',' 2A',[rfReplaceAll]);
     n := StringReplace(n,' 3 A',' 3A',[rfReplaceAll]);
     n := StringReplace(n,' 3-A',' 3A',[rfReplaceAll]);
     n := StringReplace(n,' 4 A',' 4A',[rfReplaceAll]);
     n := StringReplace(n,' 4-A',' 4A',[rfReplaceAll]);

     n := StringReplace(n,' 1 C',' 1C',[rfReplaceAll]);
     n := StringReplace(n,' 1-C',' 1C',[rfReplaceAll]);
     n := StringReplace(n,' 2 C',' 2C',[rfReplaceAll]);
     n := StringReplace(n,' 2-C',' 2C',[rfReplaceAll]);
     n := StringReplace(n,' 3 C',' 3C',[rfReplaceAll]);
     n := StringReplace(n,' 3-C',' 3C',[rfReplaceAll]);
     n := StringReplace(n,' 4 C',' 4C',[rfReplaceAll]);
     n := StringReplace(n,' 4-C',' 4C',[rfReplaceAll]);

     n := StringReplace(n,' 1 D',' 1D',[rfReplaceAll]);
     n := StringReplace(n,' 1-D',' 1D',[rfReplaceAll]);
     n := StringReplace(n,' 2 D',' 2D',[rfReplaceAll]);
     n := StringReplace(n,' 2-D',' 2D',[rfReplaceAll]);
     n := StringReplace(n,' 3 D',' 3D',[rfReplaceAll]);
     n := StringReplace(n,' 3-D',' 3D',[rfReplaceAll]);
     n := StringReplace(n,' 4 D',' 4D',[rfReplaceAll]);
     n := StringReplace(n,' 4-D',' 4D',[rfReplaceAll]);

     n := StringReplace(n,'B-1',' BX.-1',[rfReplaceAll]);
     n := StringReplace(n,'B-2',' BX.-2',[rfReplaceAll]);
     n := StringReplace(n,'B-3',' BX.-3',[rfReplaceAll]);
     n := StringReplace(n,'B-4',' BX.-4',[rfReplaceAll]);
     n := StringReplace(n,'B-5',' BX.-5',[rfReplaceAll]);
     n := StringReplace(n,'B-6',' BX.-6',[rfReplaceAll]);
     n := StringReplace(n,'B-7',' BX.-7',[rfReplaceAll]);
     n := StringReplace(n,'B-8',' BX.-8',[rfReplaceAll]);
     n := StringReplace(n,'B-9',' BX.-9',[rfReplaceAll]);

     n := StringReplace(n,'1�1�','1-1',[rfReplaceAll]);
     n := StringReplace(n,'1�2�','1-2',[rfReplaceAll]);
     n := StringReplace(n,'1�3�','1-3',[rfReplaceAll]);
     n := StringReplace(n,'1�4�','1-4',[rfReplaceAll]);
     n := StringReplace(n,'1�5�','1-5',[rfReplaceAll]);
     n := StringReplace(n,'1�6�','1-6',[rfReplaceAll]);
     n := StringReplace(n,'1�7�','1-7',[rfReplaceAll]);
     n := StringReplace(n,'1�8�','1-8',[rfReplaceAll]);
     n := StringReplace(n,'1�9�','1-9',[rfReplaceAll]);

     n := StringReplace(n,'2�1�','2-1',[rfReplaceAll]);
     n := StringReplace(n,'2�2�','2-2',[rfReplaceAll]);
     n := StringReplace(n,'2�3�','2-3',[rfReplaceAll]);
     n := StringReplace(n,'2�4�','2-4',[rfReplaceAll]);
     n := StringReplace(n,'2�5�','2-5',[rfReplaceAll]);
     n := StringReplace(n,'2�6�','2-6',[rfReplaceAll]);
     n := StringReplace(n,'2�7�','2-7',[rfReplaceAll]);
     n := StringReplace(n,'2�8�','2-8',[rfReplaceAll]);
     n := StringReplace(n,'2�9�','2-9',[rfReplaceAll]);

     n := StringReplace(n,'3�1�','3-1',[rfReplaceAll]);
     n := StringReplace(n,'3�2�','3-2',[rfReplaceAll]);
     n := StringReplace(n,'3�3�','3-3',[rfReplaceAll]);
     n := StringReplace(n,'3�4�','3-4',[rfReplaceAll]);
     n := StringReplace(n,'3�5�','3-5',[rfReplaceAll]);
     n := StringReplace(n,'3�6�','3-6',[rfReplaceAll]);
     n := StringReplace(n,'3�7�','3-7',[rfReplaceAll]);
     n := StringReplace(n,'3�8�','3-8',[rfReplaceAll]);
     n := StringReplace(n,'3�9�','3-9',[rfReplaceAll]);

     n := StringReplace(n,'4�1�','4-1',[rfReplaceAll]);
     n := StringReplace(n,'4�2�','4-2',[rfReplaceAll]);
     n := StringReplace(n,'4�3�','4-3',[rfReplaceAll]);
     n := StringReplace(n,'4�4�','4-4',[rfReplaceAll]);
     n := StringReplace(n,'4�5�','4-5',[rfReplaceAll]);
     n := StringReplace(n,'4�6�','4-6',[rfReplaceAll]);
     n := StringReplace(n,'4�7�','4-7',[rfReplaceAll]);
     n := StringReplace(n,'4�8�','4-8',[rfReplaceAll]);
     n := StringReplace(n,'4�9�','4-9',[rfReplaceAll]);

     n := StringReplace(n,'5�1�','5-1',[rfReplaceAll]);
     n := StringReplace(n,'5�2�','5-2',[rfReplaceAll]);
     n := StringReplace(n,'5�3�','5-3',[rfReplaceAll]);
     n := StringReplace(n,'5�4�','5-4',[rfReplaceAll]);
     n := StringReplace(n,'5�5�','5-5',[rfReplaceAll]);
     n := StringReplace(n,'5�6�','5-6',[rfReplaceAll]);
     n := StringReplace(n,'5�7�','5-7',[rfReplaceAll]);
     n := StringReplace(n,'5�8�','5-8',[rfReplaceAll]);
     n := StringReplace(n,'5�9�','5-9',[rfReplaceAll]);

     n := StringReplace(n,'6�1�','6-1',[rfReplaceAll]);
     n := StringReplace(n,'6�2�','6-2',[rfReplaceAll]);
     n := StringReplace(n,'6�3�','6-3',[rfReplaceAll]);
     n := StringReplace(n,'6�4�','6-4',[rfReplaceAll]);
     n := StringReplace(n,'6�5�','6-5',[rfReplaceAll]);
     n := StringReplace(n,'6�6�','6-6',[rfReplaceAll]);
     n := StringReplace(n,'6�7�','6-7',[rfReplaceAll]);
     n := StringReplace(n,'6�8�','6-8',[rfReplaceAll]);
     n := StringReplace(n,'6�9�','6-9',[rfReplaceAll]);

     n := StringReplace(n,'7�1�','7-1',[rfReplaceAll]);
     n := StringReplace(n,'7�2�','7-2',[rfReplaceAll]);
     n := StringReplace(n,'7�3�','7-3',[rfReplaceAll]);
     n := StringReplace(n,'7�4�','7-4',[rfReplaceAll]);
     n := StringReplace(n,'7�5�','7-5',[rfReplaceAll]);
     n := StringReplace(n,'7�6�','7-6',[rfReplaceAll]);
     n := StringReplace(n,'7�7�','7-7',[rfReplaceAll]);
     n := StringReplace(n,'7�8�','7-8',[rfReplaceAll]);
     n := StringReplace(n,'7�9�','7-9',[rfReplaceAll]);

     n := StringReplace(n,'8�1�','8-1',[rfReplaceAll]);
     n := StringReplace(n,'8�2�','8-2',[rfReplaceAll]);
     n := StringReplace(n,'8�3�','8-3',[rfReplaceAll]);
     n := StringReplace(n,'8�4�','8-4',[rfReplaceAll]);
     n := StringReplace(n,'8�5�','8-5',[rfReplaceAll]);
     n := StringReplace(n,'8�6�','8-6',[rfReplaceAll]);
     n := StringReplace(n,'8�7�','8-7',[rfReplaceAll]);
     n := StringReplace(n,'8�8�','8-8',[rfReplaceAll]);
     n := StringReplace(n,'8�9�','8-9',[rfReplaceAll]);

     n := StringReplace(n,'9�1�','9-1',[rfReplaceAll]);
     n := StringReplace(n,'9�2�','9-2',[rfReplaceAll]);
     n := StringReplace(n,'9�3�','9-3',[rfReplaceAll]);
     n := StringReplace(n,'9�4�','9-4',[rfReplaceAll]);
     n := StringReplace(n,'9�5�','9-5',[rfReplaceAll]);
     n := StringReplace(n,'9�6�','9-6',[rfReplaceAll]);
     n := StringReplace(n,'9�7�','9-7',[rfReplaceAll]);
     n := StringReplace(n,'9�8�','9-8',[rfReplaceAll]);
     n := StringReplace(n,'9�9�','9-9',[rfReplaceAll]);

     n := StringReplace(n,'�','',[rfReplaceAll]);

     n := StringReplace(n,'CARRER ','C.',[rfReplaceAll]);
     n := StringReplace(n,'CARR.','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CRTRA.','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CARTR.','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CARRETERA','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CARRET.','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CARRTE.','CRTA.',[rfREplaceAll]);
     n := StringReplace(n,'CALLE ','C.',[rfreplaceAll]);
     n := StringReplace(n,'CL.','C.',[rfReplaceAll]);
     n := StringReplace(n,'CRA ','CRTA.',[rfREplaceAll]);
     n := StringReplace(n,'CRER ','C.',[rfReplaceAll]);
     n := StringReplace(n,'CRT.','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CRT ','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CRTA ','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CT.','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CT ','CRTA.',[rfReplaceAll]);
     n := StringReplace(n,'CTR.','CRTA.',[rfReplaceAll]);

     n := StringReplace(n,'EXPLANADA ','EXPL.',[rfReplaceAll]);
     n := StringReplace(n,'EXPLENADA ','EXPL.',[rfReplaceAll]);
     n := StringReplace(n,'ESPLANADA ','EXPL.',[rfReplaceAll]);
     n := StringReplace(n,'ESPLENADA ','EXPL.',[rfReplaceAll]);
     n := StringReplace(n,'ESPLANA.','EXPL.',[rfReplaceAll]);
     n := StringReplace(n,'ESPLANAD ','EXPL.',[rfReplaceAll]);
     n := StringReplace(n,'ESPLA.','EXPL.',[rfREplaceAll]);
     n := StringReplace(n,'ESPLAN.','EXPL.',[rfReplaceAll]);

     n := StringReplace(n,'ESTC.','ESTACI�',[rfReplaceAll]);
     n := StringReplace(n,'GUILLERIAS','GUILLERIES',[rfReplaceAll]);
     n := StringReplace(n,'CATALU�A','CATALUNYA',[rfReplaceAll]);
     n := StringReplace(n,' DEN ',' D''EN ',[rfReplaceAll]);
     n := StringReplace(n,' D�N ',' D''EN ',[rfReplaceAll]);
     n := StringReplace(n,' S.N.',' s/n',[rfReplaceAll]);
     n := StringReplace(n,'ISLAS BALEARES','ILLES BALEARS',[rfReplaceAll]);
     n := StringReplace(n,'EIVIZA','EIV�SSA',[rfReplaceAll]);
     n := StringReplace(n,'ISLAS MEDAS','ILLES MEDES',[rfReplaceAll]);
     n := StringReplace(n,'ISLAS MEDES','ILLES MEDES',[rfReplaceAll]);
     n := StringReplace(n,'J. CARLES','JOAN CARLES',[rfReplaceAll]);
     n := StringReplace(n,'J.CARLES','JOAN CARLES',[rfReplaceAll]);
     n := StringReplace(n,'JAIME I','JAUME I',[rfReplaceAll]);
     n := StringReplace(n,'JAUME 1','JAUME I',[rfReplaceAll]);
     n := StringReplace(n,'JOAQUIN','JOAQUIM',[rfReplaceAll]);
     n := StringReplace(n,'JOIAQUIM','JOAQUIM',[rfReplaceAll]);
     n := StringReplace(n,'JOAQUM','JOAQUIM',[rfReplaceAll]);
     n := StringReplace(n,'JUAME','JAUME',[rfReplaceAll]);
     n := StringReplace(n,'PARCK','PARK',[rfReplaceAll]);
     n := StringReplace(n,'MAESTRANZA','MAESTRAN�A',[rfReplaceAll]);
     n := StringReplace(n,'MARESMA','MARESME',[rfReplaceAll]);
     n := StringReplace(n,'MER�E','MERC�',[rfReplaceAll]);
     n := StringReplace(n,'CORDOVA','CORDOBA',[rfReplaceAll]);
     n := StringReplace(n,'MILGUEL','MIGUEL',[rfReplaceAll]);
     n := StringReplace(n,'MNTFERRANT','MONTFERRANT',[rfReplaceAll]);
     n := StringReplace(n,'MONTSARRAT','MONTSERRAT',[rfReplaceAll]);
     n := StringReplace(n,'MOSEN ','MOSS�N ',[rfReplaceAll]);
     n := StringReplace(n,'MOSSEN ','MOSS�N ',[rfReplaceAll]);
     n := StringReplace(n,'MA�IA','MACI�',[rfReplaceAll]);
     n := StringReplace(n,'MACIA','MACI�',[rfReplaceAll]);
     n := StringReplace(n,'NARCIS ','NARC�S ',[rfReplaceAll]);
     n := StringReplace(n,'NERVION','NERVI�N',[rfReplaceAll]);
     n := StringReplace(n,' SRA ',' SRA. ',[rfReplaceAll]);
     n := StringReplace(n,'PAISOS CATALANS','PA�SSOS CATALANS',[rfReplaceAll]);
     n := StringReplace(n,'PALAMOS ','PALAM�S ',[rfReplaceAll]);
     n := StringReplace(n,'PARADIS ','PARAD�S ',[rfReplaceAll]);
     n := StringReplace(n,'PASAGE ','PASAJE ',[rfReplaceAll]);
     n := StringReplace(n,'PSTGE ','PASSATGE ',[rfReplaceAll]);
     n := StringReplace(n,'PASSAJE ','PASSATGE ',[rfReplaceAll]);
     n := Stringreplace(n,'PASST.','PASSATGE ',[rfReplaceAll]);
     n := StringReplace(n,'PASSTGE','PASSATGE ',[rfReplaceAll]);
     n := StringReplace(n,'BENTURA ','VENTURA ',[rfReplaceAll]);
     n := StringReplace(n,'VENTUAR ','VENTURA ',[rfReplaceAll]);
     n := StringReplace(n,'SIRCOMBALACI� ','CIRCUNVALACI� ',[rfReplaceAll]);

     n := Trim(NoDblSpace(n));
     n := StringReplace(n,'. ','.',[rfReplaceAll]);
     n := StringReplace(n,'.','. ',[rfReplaceAll]);
     n := StringReplace(n,'; ',';',[rfReplaceAll]);
     n := StringReplace(n,';','; ',[rfReplaceAll]);

     result := Trim(NoDblSpace(n));
end;

function NormalitzaTEL(n : string) : string;
begin
     n := AnsiUppercase(Trim(NoDblSpace(n)));
     result := n;

     if dm.CR['NO_NORMALIT'] = 'SI' then exit;

     n := StringReplace(n,'-',';',[rfReplaceAll]);
     n := StringReplace(n,' ,',',',[rfReplaceAll]);
     n := StringReplace(n,', ',',',[rfReplaceAll]);
     n := StringReplace(n,' ;',';',[rfReplaceAll]);
     n := StringReplace(n,'; ',';',[rfReplaceAll]);

     n := StringReplace(n,';','; ',[rfReplaceAll]);
     n := StringReplace(n,',',', ',[rfReplaceAll]);

     result := AnsiUppercase(Trim(NoDblSpace(n)));
end;

function NormalitzaPob(n : string) : string;
begin
     n := AnsiUppercase(Trim(NoDblSpace(n)));
     result := n;

     if dm.CR['NO_NORMALIT'] = 'SI' then exit;

     n := StringReplace(n,'1','',[rfReplaceAll]);
     n := StringReplace(n,'2','',[rfReplaceAll]);
     n := StringReplace(n,'3','',[rfReplaceAll]);
     n := StringReplace(n,'4','',[rfReplaceAll]);
     n := StringReplace(n,'5','',[rfReplaceAll]);
     n := StringReplace(n,'6','',[rfReplaceAll]);
     n := StringReplace(n,'7','',[rfReplaceAll]);
     n := StringReplace(n,'8','',[rfReplaceAll]);
     n := StringReplace(n,'9','',[rfReplaceAll]);
     n := StringReplace(n,'0','',[rfReplaceAll]);

     result := AnsiUpperCase(Trim(NoDblSpace(n)));
end;
end.
