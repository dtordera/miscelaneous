unit oneinst;
{Source: DELPHI 1.0
 Author: Juergen Schlottke
         46, Schoenaich-C.-Str.
         25336 Elmshorn
         (Germany, so forgive me my English!)
         Compuserve-ID 100106,3034
         Your comments are welcome!

 Purpose: Allow only one instance of a Delphi program to execute

 Usage: Just ADD this UNIT to Your Delphi project.
        (recommended as first unit in Your uses list)

 Differences to other implementations:
 - This one won't rely on the window name, it is not needed!
 - No side effects while running other Delphi applications
 - The unit can be placed almost anywhere in Your uses statement
 - Your project code doesn't need any changes

 You are allowed to use this code in Your compiled applications.
 And You may distribute unmodified version of this source.
 No costs - no warranties!
 If You find this source useful and use it, so please send me
 a nice postcard from Your home city (or from Your holidays).
}
{$K+} {Smart Callbacks ON}
interface

implementation
uses wintypes,winprocs,toolhelp,sysutils,forms;

{dont't change the declaration of the enumeration function!}
function EnumWindowsProc(Hwindow:HWnd; lParam:Longint):boolean;export;
begin
  enumWindowsProc:=true; {Continue enumeration}
  {Exit if window does not belong to the previous instance}
  if GetWindowWord( hWindow, GWW_hINSTANCE )<>hPrevInst then exit;
  {Exit if window is not visible}
  if not iswindowvisible(hwindow) then exit;
  EnumWindowsProc := false;{Stop enumeration}
  {Show our window in front of all other apps}
  if isiconic(hwindow) then
    showwindow(hwindow,sw_restore)
  else
    bringwindowtotop(hwindow);
end;

function activateRunningTask:boolean;
var
  task:TTaskEntry;
  found:boolean;
begin
  if hprevinst=0 then   {there is no previous instance}
  begin                 {return false and exit}
    activateRunningtask:=false;
    exit;
  end
  else                  {we will do the job!}
    activateRunningtask:=true;
  {Initialize our TTaskEntry structure}
  fillchar(task,sizeof(task),#0);
  task.dwsize:=sizeof(task);
  found:=TaskFirst(@task); {Look through task entries}
  while found do
  begin
    if task.hinst=hPrevInst then
    begin {We have found the previous instance!}
      {Now Search for windows, EnumWindowsProc will do the rest}
      enumwindows(@enumwindowsProc,0);
      exit;
    end;
    found:=TaskNext(@task);
  end;
end;

begin
  {If another instance could be activated then terminate}
  if activaterunningTask then application.terminate;
end.
