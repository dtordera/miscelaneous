unit econcepteaux;

interface

uses UDBVAux, classes, db;

var
     cENTRADA,
     cAVERIES,
     cpressupost : TColumnsInfo;

     vENTRADA,
     vAVERIES,
     vpressupost : string;

implementation

procedure PreparaEntrada;
begin
     setlength(centrada,7+1);

     ventrada := 'id,DESCR,PCost,STOCK,FAMILIA,MARCA,id_lin';

     cENTRADA[0].Title:='';
     cENTRADA[0].Width:=20;
     cENTRADA[0].Format:='';
     cENTRADA[0].Alignment:=TAlignment(0);
     cENTRADA[0].FieldType:=TFieldType(0);

     cENTRADA[1].Title:='ref.';
     cENTRADA[1].Width:=80;
     cENTRADA[1].Format:='';
     cENTRADA[1].Alignment:=TAlignment(1);
     cENTRADA[1].FieldType:=TFieldType(3);

     cENTRADA[2].Title:='descripció';
     cENTRADA[2].Width:=350;
     cENTRADA[2].Format:='';
     cENTRADA[2].Alignment:=TAlignment(0);
     cENTRADA[2].FieldType:=TFieldType(24);

     cENTRADA[3].Title:='P.Cost';
     cENTRADA[3].Width:=80;
     cENTRADA[3].Format:='0.00';
     cENTRADA[3].Alignment:=TAlignment(1);
     cENTRADA[3].FieldType:=TFieldType(6);

     cENTRADA[4].Title:='en stock';
     cENTRADA[4].Width:=60;
     cENTRADA[4].Format:='';
     cENTRADA[4].Alignment:=TAlignment(2);
     cENTRADA[4].FieldType:=TFieldType(5);

     cENTRADA[5].Title:='família';
     cENTRADA[5].Width:=280;
     cENTRADA[5].Format:='';
     cENTRADA[5].Alignment:=TAlignment(0);
     cENTRADA[5].FieldType:=TFieldType(24);

     cENTRADA[6].Title:='marca';
     cENTRADA[6].Width:=200;
     cENTRADA[6].Format:='';
     cENTRADA[6].Alignment:=TAlignment(0);
     cENTRADA[6].FieldType:=TFieldType(24);

     cENTRADA[7].Title:='ref.línia';
     cENTRADA[7].Width:=80;
     cENTRADA[7].Format:='';
     cENTRADA[7].Alignment:=TAlignment(0);
     cENTRADA[7].FieldType:=TFieldType(24);
end;

procedure PreparaAveries;
begin
     setlength(caveries,4+1);

     vAveries := 'id,DESCR,PVP,id_lin';

     caveries[0].Title:='';
     caveries[0].Width:=20;
     caveries[0].Format:='';
     caveries[0].Alignment:=TAlignment(0);
     caveries[0].FieldType:=TFieldType(0);

     caveries[1].Title:='ref.';
     caveries[1].Width:=40;
     caveries[1].Format:='';
     caveries[1].Alignment:=TAlignment(2);
     caveries[1].FieldType:=TFieldType(3);

     caveries[2].Title:='descripció';
     caveries[2].Width:=350;
     caveries[2].Format:='';
     caveries[2].Alignment:=TAlignment(0);
     caveries[2].FieldType:=TFieldType(24);

     caveries[3].Title:='P.V.P.';
     caveries[3].Width:=0;
     caveries[3].Format:='0.00';
     caveries[3].Alignment:=TAlignment(1);
     caveries[3].FieldType:=TFieldType(6);

     caveries[4].Title:='ref. línia';
     caveries[4].Width:=60;
     caveries[4].Format:='';
     caveries[4].Alignment:=TAlignment(1);
     caveries[4].FieldType:=TFieldType(5);
end;

procedure Preparapressupost;
begin
     setlength(cpressupost,7+1);

     vpressupost := 'id,DESCR,PVP,STOCK,FAMILIA,MARCA,id_lin';

     cpressupost[0].Title:='';
     cpressupost[0].Width:=20;
     cpressupost[0].Format:='';
     cpressupost[0].Alignment:=TAlignment(0);
     cpressupost[0].FieldType:=TFieldType(0);

     cpressupost[1].Title:='ref.';
     cpressupost[1].Width:=80;
     cpressupost[1].Format:='';
     cpressupost[1].Alignment:=TAlignment(1);
     cpressupost[1].FieldType:=TFieldType(3);

     cpressupost[2].Title:='descripció';
     cpressupost[2].Width:=350;
     cpressupost[2].Format:='';
     cpressupost[2].Alignment:=TAlignment(0);
     cpressupost[2].FieldType:=TFieldType(24);

     cpressupost[3].Title:='P.V.P.';
     cpressupost[3].Width:=80;
     cpressupost[3].Format:='0.00';
     cpressupost[3].Alignment:=TAlignment(1);
     cpressupost[3].FieldType:=TFieldType(6);

     cpressupost[4].Title:='en stock';
     cpressupost[4].Width:=60;
     cpressupost[4].Format:='';
     cpressupost[4].Alignment:=TAlignment(2);
     cpressupost[4].FieldType:=TFieldType(5);

     cpressupost[5].Title:='família';
     cpressupost[5].Width:=280;
     cpressupost[5].Format:='';
     cpressupost[5].Alignment:=TAlignment(0);
     cpressupost[5].FieldType:=TFieldType(24);

     cpressupost[6].Title:='marca';
     cpressupost[6].Width:=200;
     cpressupost[6].Format:='';
     cpressupost[6].Alignment:=TAlignment(0);
     cpressupost[6].FieldType:=TFieldType(24);

     cpressupost[7].Title:='ref.línia';
     cpressupost[7].Width:=80;
     cpressupost[7].Format:='';
     cpressupost[7].Alignment:=TAlignment(0);
     cpressupost[7].FieldType:=TFieldType(24);
end;

initialization
     PreparaEntrada;
     Preparapressupost;
     PreparaAveries;

finalization
     setlength(caveries,0);
     setlength(cpressupost,0);
     setlength(centrada,0);
end.
