program RailBaron;

uses
  Forms,
  ufmRBMain in 'ufmRBMain.pas' {frmRBMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Rail Baron Helper';
  Application.CreateForm(TfrmRBMain, frmRBMain);
  Application.Run;
end.
