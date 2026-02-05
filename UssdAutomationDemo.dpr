program UssdAutomationDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  API.JNI.UssdBridge in 'API\API.JNI.UssdBridge.pas',
  Model.Database in 'Model\Model.Database.pas' {dmDatabase: TDataModule},
  API.USSD.Service in 'API\API.USSD.Service.pas',
  Main.View in 'Main.View.pas' {MainView},
  Layout.USSD in 'View\Layouts\Layout.USSD.pas' {LytUSSD: TFrame},
  API.Android.Permissions.Interfaces in 'API\Permissions\API.Android.Permissions.Interfaces.pas',
  API.Android.Permissions in 'API\Permissions\API.Android.Permissions.pas';

{$R *.res}

begin
  Application.Initialize;
  // Create DataModule before Main Form
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
