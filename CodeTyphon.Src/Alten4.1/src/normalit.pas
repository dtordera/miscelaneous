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

     n := StringReplace(n,'RECO ','RACÒ',[rfReplaceAll]);
     n := StringReplace(n,'RIPOLLES ','RIPOLLÉS',[rfReplaceAll]);

     n := StringReplace(n,'Á','À',[rfReplaceAll]);
     n := StringReplace(n,'SEBERO ','SEVERO',[rfReplaceAll]);
     n := StringReplace(n,'MOLI ','MOLÍ',[rfReplaceAll]);

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

     n := StringReplace(n,'TURO ','TURÓ ',[rfReplaceAll]);
     n := StringReplace(n,'UNIO ','UNIÓ ',[rfReplaceAll]);
     n := StringReplace(n,'URBANITZACIÓ ','URB.',[rfReplaceAll]);
     n := StringReplace(n,'URBANITZACIO ','URB.',[rfReplaceAll]);
     n := StringReplace(n,'CATALA ','CATALÀ ',[rfReplaceAll]);
     n := StringReplace(n,'VICTOR ','VÍCTOR ',[rfReplaceAll]);
     n := StringReplace(n,'BARREQUER ','BARRAQUER ',[rfReplaceAll]);
     n := StringReplace(n,'VIL·LA','VILA',[rfReplaceAll]);
     n := StringReplace(n,'VIL.LA','VILA',[rfReplaceAll]);

     n := StringReplace(n,'BARBARA ','BÀRBARA ',[rfReplaceAll]);
     n := StringReplace(n,'SEBASTIA ','SEBASTIÀ ',[rfReplaceAll]);

     n := StringReplace(n,'ACCESO ','ACCÉS',[rfReplaceAll]);
     n := StringReplace(n,'ACCES ','ACCÉS',[rfReplaceAll]);
     n := StringReplace(n,'AC.','ACCÉS ',[rfReplaceAll]);
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
     n := StringReplace(n,'PLAÇA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAZA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLZA. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLA. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PZA. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PL. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAÇ. ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAÇ ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAC.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLAZ.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PÇA.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PÇA','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLC.','PL.',[rfReplaceAll]);
     n := StringReplace(n,'PLZA ','PL.',[rfReplaceAll]);
     n := StringReplace(n,'POL IND ','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL. INDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL.IND ','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL INDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POL.NDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POLÍGON IND.','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'POLÍGON INDUSTRIAL','POL.IND.',[rfReplaceAll]);
     n := StringReplace(n,'PORTANOVA','PORTA NOVA',[rfReplaceAll]);
     n := StringReplace(n,'POUI NOU','POU NOU',[rfReplaceAll]);
     n := StringReplace(n,'PRAT DE LA RIBA','PRAT DE LA RIVA',[rfReplaceAll]);
     n := StringReplace(n,'PROBENÇA','PROVENÇA',[rfReplaceAll]);
     n := StringReplace(n,'PROVENZA','PROVENÇA',[rfReplaceAll]);
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
     n := StringReplace(n,'RECEPCION ','RECEPCIÓ ',[rfReplaceAll]);
     n := StringReplace(n,'- ','-',[rfReplaceAll]);
     n := StringReplace(n,' -','-',[rfReplaceAll]);
     n := StringReplace(n,'Mª','MARIA',[rfReplaceAll]);
     n := StringReplace(n,'Mº LLUISA','MARIA LLUISA',[rfReplaceAll]);
     n := StringReplace(n,'Mº LUISA','MARIA LLUISA',[rfReplaceAll]);
     n := StringReplace(n,'ª','º',[rfReplaceAll]);

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

     n := StringReplace(n,'1º1º','1-1',[rfReplaceAll]);
     n := StringReplace(n,'1º2º','1-2',[rfReplaceAll]);
     n := StringReplace(n,'1º3º','1-3',[rfReplaceAll]);
     n := StringReplace(n,'1º4º','1-4',[rfReplaceAll]);
     n := StringReplace(n,'1º5º','1-5',[rfReplaceAll]);
     n := StringReplace(n,'1º6º','1-6',[rfReplaceAll]);
     n := StringReplace(n,'1º7º','1-7',[rfReplaceAll]);
     n := StringReplace(n,'1º8º','1-8',[rfReplaceAll]);
     n := StringReplace(n,'1º9º','1-9',[rfReplaceAll]);

     n := StringReplace(n,'2º1º','2-1',[rfReplaceAll]);
     n := StringReplace(n,'2º2º','2-2',[rfReplaceAll]);
     n := StringReplace(n,'2º3º','2-3',[rfReplaceAll]);
     n := StringReplace(n,'2º4º','2-4',[rfReplaceAll]);
     n := StringReplace(n,'2º5º','2-5',[rfReplaceAll]);
     n := StringReplace(n,'2º6º','2-6',[rfReplaceAll]);
     n := StringReplace(n,'2º7º','2-7',[rfReplaceAll]);
     n := StringReplace(n,'2º8º','2-8',[rfReplaceAll]);
     n := StringReplace(n,'2º9º','2-9',[rfReplaceAll]);

     n := StringReplace(n,'3º1º','3-1',[rfReplaceAll]);
     n := StringReplace(n,'3º2º','3-2',[rfReplaceAll]);
     n := StringReplace(n,'3º3º','3-3',[rfReplaceAll]);
     n := StringReplace(n,'3º4º','3-4',[rfReplaceAll]);
     n := StringReplace(n,'3º5º','3-5',[rfReplaceAll]);
     n := StringReplace(n,'3º6º','3-6',[rfReplaceAll]);
     n := StringReplace(n,'3º7º','3-7',[rfReplaceAll]);
     n := StringReplace(n,'3º8º','3-8',[rfReplaceAll]);
     n := StringReplace(n,'3º9º','3-9',[rfReplaceAll]);

     n := StringReplace(n,'4º1º','4-1',[rfReplaceAll]);
     n := StringReplace(n,'4º2º','4-2',[rfReplaceAll]);
     n := StringReplace(n,'4º3º','4-3',[rfReplaceAll]);
     n := StringReplace(n,'4º4º','4-4',[rfReplaceAll]);
     n := StringReplace(n,'4º5º','4-5',[rfReplaceAll]);
     n := StringReplace(n,'4º6º','4-6',[rfReplaceAll]);
     n := StringReplace(n,'4º7º','4-7',[rfReplaceAll]);
     n := StringReplace(n,'4º8º','4-8',[rfReplaceAll]);
     n := StringReplace(n,'4º9º','4-9',[rfReplaceAll]);

     n := StringReplace(n,'5º1º','5-1',[rfReplaceAll]);
     n := StringReplace(n,'5º2º','5-2',[rfReplaceAll]);
     n := StringReplace(n,'5º3º','5-3',[rfReplaceAll]);
     n := StringReplace(n,'5º4º','5-4',[rfReplaceAll]);
     n := StringReplace(n,'5º5º','5-5',[rfReplaceAll]);
     n := StringReplace(n,'5º6º','5-6',[rfReplaceAll]);
     n := StringReplace(n,'5º7º','5-7',[rfReplaceAll]);
     n := StringReplace(n,'5º8º','5-8',[rfReplaceAll]);
     n := StringReplace(n,'5º9º','5-9',[rfReplaceAll]);

     n := StringReplace(n,'6º1º','6-1',[rfReplaceAll]);
     n := StringReplace(n,'6º2º','6-2',[rfReplaceAll]);
     n := StringReplace(n,'6º3º','6-3',[rfReplaceAll]);
     n := StringReplace(n,'6º4º','6-4',[rfReplaceAll]);
     n := StringReplace(n,'6º5º','6-5',[rfReplaceAll]);
     n := StringReplace(n,'6º6º','6-6',[rfReplaceAll]);
     n := StringReplace(n,'6º7º','6-7',[rfReplaceAll]);
     n := StringReplace(n,'6º8º','6-8',[rfReplaceAll]);
     n := StringReplace(n,'6º9º','6-9',[rfReplaceAll]);

     n := StringReplace(n,'7º1º','7-1',[rfReplaceAll]);
     n := StringReplace(n,'7º2º','7-2',[rfReplaceAll]);
     n := StringReplace(n,'7º3º','7-3',[rfReplaceAll]);
     n := StringReplace(n,'7º4º','7-4',[rfReplaceAll]);
     n := StringReplace(n,'7º5º','7-5',[rfReplaceAll]);
     n := StringReplace(n,'7º6º','7-6',[rfReplaceAll]);
     n := StringReplace(n,'7º7º','7-7',[rfReplaceAll]);
     n := StringReplace(n,'7º8º','7-8',[rfReplaceAll]);
     n := StringReplace(n,'7º9º','7-9',[rfReplaceAll]);

     n := StringReplace(n,'8º1º','8-1',[rfReplaceAll]);
     n := StringReplace(n,'8º2º','8-2',[rfReplaceAll]);
     n := StringReplace(n,'8º3º','8-3',[rfReplaceAll]);
     n := StringReplace(n,'8º4º','8-4',[rfReplaceAll]);
     n := StringReplace(n,'8º5º','8-5',[rfReplaceAll]);
     n := StringReplace(n,'8º6º','8-6',[rfReplaceAll]);
     n := StringReplace(n,'8º7º','8-7',[rfReplaceAll]);
     n := StringReplace(n,'8º8º','8-8',[rfReplaceAll]);
     n := StringReplace(n,'8º9º','8-9',[rfReplaceAll]);

     n := StringReplace(n,'9º1º','9-1',[rfReplaceAll]);
     n := StringReplace(n,'9º2º','9-2',[rfReplaceAll]);
     n := StringReplace(n,'9º3º','9-3',[rfReplaceAll]);
     n := StringReplace(n,'9º4º','9-4',[rfReplaceAll]);
     n := StringReplace(n,'9º5º','9-5',[rfReplaceAll]);
     n := StringReplace(n,'9º6º','9-6',[rfReplaceAll]);
     n := StringReplace(n,'9º7º','9-7',[rfReplaceAll]);
     n := StringReplace(n,'9º8º','9-8',[rfReplaceAll]);
     n := StringReplace(n,'9º9º','9-9',[rfReplaceAll]);

     n := StringReplace(n,'º','',[rfReplaceAll]);

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

     n := StringReplace(n,'ESTC.','ESTACIÓ',[rfReplaceAll]);
     n := StringReplace(n,'GUILLERIAS','GUILLERIES',[rfReplaceAll]);
     n := StringReplace(n,'CATALUÑA','CATALUNYA',[rfReplaceAll]);
     n := StringReplace(n,' DEN ',' D''EN ',[rfReplaceAll]);
     n := StringReplace(n,' DÉN ',' D''EN ',[rfReplaceAll]);
     n := StringReplace(n,' S.N.',' s/n',[rfReplaceAll]);
     n := StringReplace(n,'ISLAS BALEARES','ILLES BALEARS',[rfReplaceAll]);
     n := StringReplace(n,'EIVIZA','EIVÏSSA',[rfReplaceAll]);
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
     n := StringReplace(n,'MAESTRANZA','MAESTRANÇA',[rfReplaceAll]);
     n := StringReplace(n,'MARESMA','MARESME',[rfReplaceAll]);
     n := StringReplace(n,'MERÇE','MERCÉ',[rfReplaceAll]);
     n := StringReplace(n,'CORDOVA','CORDOBA',[rfReplaceAll]);
     n := StringReplace(n,'MILGUEL','MIGUEL',[rfReplaceAll]);
     n := StringReplace(n,'MNTFERRANT','MONTFERRANT',[rfReplaceAll]);
     n := StringReplace(n,'MONTSARRAT','MONTSERRAT',[rfReplaceAll]);
     n := StringReplace(n,'MOSEN ','MOSSÉN ',[rfReplaceAll]);
     n := StringReplace(n,'MOSSEN ','MOSSÉN ',[rfReplaceAll]);
     n := StringReplace(n,'MAÇIA','MACIÀ',[rfReplaceAll]);
     n := StringReplace(n,'MACIA','MACIÀ',[rfReplaceAll]);
     n := StringReplace(n,'NARCIS ','NARCÍS ',[rfReplaceAll]);
     n := StringReplace(n,'NERVION','NERVIÓN',[rfReplaceAll]);
     n := StringReplace(n,' SRA ',' SRA. ',[rfReplaceAll]);
     n := StringReplace(n,'PAISOS CATALANS','PAÏSSOS CATALANS',[rfReplaceAll]);
     n := StringReplace(n,'PALAMOS ','PALAMÓS ',[rfReplaceAll]);
     n := StringReplace(n,'PARADIS ','PARADÍS ',[rfReplaceAll]);
     n := StringReplace(n,'PASAGE ','PASAJE ',[rfReplaceAll]);
     n := StringReplace(n,'PSTGE ','PASSATGE ',[rfReplaceAll]);
     n := StringReplace(n,'PASSAJE ','PASSATGE ',[rfReplaceAll]);
     n := Stringreplace(n,'PASST.','PASSATGE ',[rfReplaceAll]);
     n := StringReplace(n,'PASSTGE','PASSATGE ',[rfReplaceAll]);
     n := StringReplace(n,'BENTURA ','VENTURA ',[rfReplaceAll]);
     n := StringReplace(n,'VENTUAR ','VENTURA ',[rfReplaceAll]);
     n := StringReplace(n,'SIRCOMBALACIÓ ','CIRCUNVALACIÓ ',[rfReplaceAll]);

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
