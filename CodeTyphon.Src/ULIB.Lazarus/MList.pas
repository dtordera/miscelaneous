unit MList;

interface

uses classes, stdctrls;

type TMList = class(TCustomListBox)
     private
     protected
     public
          constructor Create(AOwner : TComponent); override;
          destructor Destroy; override;
     published
end;

constructor TMList.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);
end;

destructor TMList.Destroy;
begin
     inherited Destroy;
end;

procedure Register;
begin
     RegisterComponents('pkULIB',[TMList]);
end;

end.