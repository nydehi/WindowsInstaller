library ysflFMCA;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Windows,
  routines_msi in '..\CustomAction\routines_msi.pas',
  Msi in '..\CustomAction\Msi.pas',
  MsiDefs in '..\CustomAction\MsiDefs.pas',
  MsiQuery in '..\CustomAction\MsiQuery.pas',
  CustomAction.FileMaker in 'CustomAction.FileMaker.pas',
  CustomAction.Launch in 'CustomAction.Launch.pas',
  Youseful.System.Shell.Process.Component in 'Youseful.System.Shell.Process.Component.pas',
  Youseful.exceptions in 'Youseful.exceptions.pas',
  CustomAction.Logging in 'CustomAction.Logging.pas',
  CustomAction.LaunchDOS in 'CustomAction.LaunchDOS.pas',
  CustomAction.FileMaker.FM8AdvPath in 'CustomAction.FileMaker.FM8AdvPath.pas',
  CustomAction.FileMaker.FM8Path in 'CustomAction.FileMaker.FM8Path.pas',
  CustomAction.FileMaker.FM6Path in 'CustomAction.FileMaker.FM6Path.pas',
  CustomAction.FileMaker.FM7Path in 'CustomAction.FileMaker.FM7Path.pas',
  CustomAction.FileMaker.FM7DevPath in 'CustomAction.FileMaker.FM7DevPath.pas',
  CustomAction.FileMaker.FM85AdvPath in 'CustomAction.FileMaker.FM85AdvPath.pas',
  CustomAction.FileMaker.FM85Path in 'CustomAction.FileMaker.FM85Path.pas',
  CustomAction.FileMaker.FM9Path in 'CustomAction.FileMaker.FM9Path.pas',
  CustomAction.FileMaker.FM9AdvPath in 'CustomAction.FileMaker.FM9AdvPath.pas';

{$R *.res}

procedure DLLEntryPoint(dwReason :DWORD);
begin


end;

exports
   DLLEntryPoint,
   ParsePath index 1,
   Launch index 2,
   LaunchDOS index 3,
   FM8AdvPath index 4,
   FM6Path index 5,
   FM8Path index 6,
   FM7Path index 7,
   FM7DevPath index 8,
   FM85AdvPath index 9,
   FM9Path index 10,
   FM85Path index 11,
   FM9AdvPath index 12,
   FM8AdvBinPath index 13,
   FM6BinPath index 14,
   FM8BinPath index 15,
   FM7BinPath index 16,
   FM7DevBinPath index 17,
   FM85AdvBinPath index 18,
   FM9BinPath index 19,
   FM9AdvBinPath index 20;

begin
DllProc := @DLLEntryPoint;
DLLEntryPoint(DLL_PROCESS_ATTACH);
end.
{Notes:
   1) 12-8-07 fix fm85 pro path
















}
