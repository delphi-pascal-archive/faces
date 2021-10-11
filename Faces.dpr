program Faces;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  UAddrBook in 'UAddrBook.pas' {FrmAddrBook},
  UOptions in 'UOptions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Faces';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
