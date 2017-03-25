unit MCEdit;

interface

uses classes, extctrls, mask, maskutils, comctrls, stdctrls, forms;

type TMCEdit = class(TCustomPanel)
     private
          VMaskEdit : TMaskEdit;
          VCalendar : TMonthCalendar;
          VOkBtn    : TButton;
          VAutoSize : boolean;
          FOnChange : TNotifyEvent;          
          procedure VMaskOnChange(sender : TObject);
          procedure VCalendarClick(sender : TObject);
     protected
     public
          constructor Create(AOwner : TComponent); override;
          destructor Destroy; override;
          procedure AfterConstruction; override;
          procedure SetVMask(m : string);
          procedure SetVAutoSize(a : boolean);
          function  GetVMask : string;
          procedure SetVDate(d : TDateTime);
          function  GetVDate : TDateTime;
     published
          property Mask : string read GetVMask write SetVMask;
          property Align;
          property AutoSize : boolean read VAutoSize write SetVAutoSize;
          property Date : TDateTime read GetVDate write SetVDate;
          property OnChange : TNotifyEvent read FOnChange write FOnChange;
end;

procedure Register;

implementation

uses controls, sysutils;

procedure Register;
begin
     RegisterComponents('pkULIB',[TMCEdit]);
end;

constructor TMCEdit.Create(AOwner : TComponent);
begin
     inherited Create(AOwner);

     VMaskEdit := TMaskEdit.Create(self);
     VMaskEdit.EditMask := '!99/99/\2\000;1;_';
     VMaskEdit.OnChange := VMaskOnChange;
     VCalendar := TMonthCalendar.Create(self);
     VCalendar.OnClick := VCalendarClick;
     VOkBtn    := TButton.Create((Owner as TCustomForm));
end;

function TMCEdit.GetVDate : TDateTime;
begin
     result := VCalendar.Date;
end;

procedure TMCEdit.SetVDate(d : TDateTime);
begin
     VCalendar.Date := d;
     VMaskEdit.Text :=  FormatMaskText(VMaskEdit.EditMask,datetostr(d));

     if Assigned(OnChange) then OnChange(self);
end;

procedure TMCEdit.VCalendarClick(sender : TObject);
begin
     Date := VCalendar.Date;
end;

procedure TMCEdit.SetVAutoSize(a : boolean);
begin
     if a then
     begin
          VCalendar.Align := alNone;
          VCalendar.AutoSize := false;
          ClientWidth := VCalendar.Width;
          ClientHeight := VMaskEdit.Height + VCalendar.Height;
          VCalendar.Align := alClient;
          VCalendar.AutoSize := true;
     end;

     VAutoSize := a;
end;

procedure TMCEdit.VMaskOnChange(sender : TObject);
begin
     try
     VCalendar.Date := strtodate(VMaskEdit.Text);
     except
     end;
end;

procedure TMCEdit.SetVMask(m : string);
begin
     VMaskEdit.EditMask := m;
end;

function TMCEdit.GetVMask : string;
begin
     result := VMaskEdit.EditMask;
end;

procedure TMCEdit.AfterConstruction;
begin
     Ctl3D := false;
     VMaskEdit.Parent := self;
     VMaskEdit.Align  := alTop;
     VMaskEdit.ParentCtl3D := false;
     VMaskEdit.Ctl3D  := false;

     VCalendar.Parent := self;
     VCalendar.Align  := alClient;

     VOkBtn.Parent    := self;
     VOkBtn.Height := 30;
     VOkBtn.Width  := 50;
     VOkBtn.Left   := (Owner as TCustomForm).ClientWidth - VOkBtn.Width - 2;
     VOkBtn.Top    := (Owner as TCustomForm).ClientHeight - VOkBtn.Height - 2;
     VOkBtn.Default := true;
     VOkBtn.ModalResult := mrOk;
     VOkBtn.Align := alBottom;
     VOkBtn.Caption := '&Ok';
end;

destructor TMCEdit.Destroy;
begin
     if Assigned(VOkBtn)    then VOkBtn.Free;
     if Assigned(VCalendar) then VCalendar.Free;
     if Assigned(VMaskEdit) then VMaskEdit.Free;
     inherited;
end;

end.

