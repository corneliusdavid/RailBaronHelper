program RailBaron;

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\system.drawing.dll'}

uses
  Forms,
  ufmRBMain in 'ufmRBMain.pas' {frmRBMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Rail Baron converted to .NET';
  Application.CreateForm(TfrmRBMain, frmRBMain);
  Application.Run;
end.
