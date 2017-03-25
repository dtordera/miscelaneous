unit BringToFront;

interface

uses classes, controls;

type TBringToFront = class(TComponent)
     private
     VControlName : string;
     protected
     public
          procedure SetVControlName(s : string);
     published
     property ControlName : string read VControlName write SetVControlName;

end;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('pkULIB',[TBringToFront]);
end;

procedure TBringToFront.SetVControlName(s : string);
begin
     (Owner.FindComponent(s) as TControl).BringToFront;

     VControlName := s;
end;

end.
