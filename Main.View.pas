unit Main.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
//
  Layout.USSD,
  API.Android.Permissions.Interfaces;

type
  TMainView = class(TForm)
    LayoutContainer: TLayout;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FLytUSSD: TLytUSSD;
    FPermissions: iAndroidPermissions;
    function GetPermissions: iAndroidPermissions;
    property Permissions: iAndroidPermissions read GetPermissions;
  private
    procedure Log(const aMsg: string);
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation {$R *.fmx}

uses
  API.Android.Permissions;

procedure TMainView.FormCreate(Sender: TObject);
begin
  FLytUSSD := TLytUSSD.Create(Self);
  FLytUSSD.Parent := LayoutContainer;
  FLytUSSD.Align  := TAlignLayout.Client;

(*
    <uses-sdk
        android:minSdkVersion="21"
        android:targetSdkVersion="35" />

    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.CALL_PHONE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.READ_PHONE_NUMBERS" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />

*)

  Permissions
    .SetLogger(Log)
    .ACCESS_COARSE_LOCATION
    .ACCESS_FINE_LOCATION
    .CALL_PHONE
    .CAMERA
    .INTERNET
    .READ_EXTERNAL_STORAGE
    .READ_PHONE_STATE
    .READ_PHONE_NUMBERS
    .WRITE_EXTERNAL_STORAGE

    .CheckAndRequest(procedure(aAllGranted: Boolean; aGranted, aDenied: TArray<string>)
      begin
        if aAllGranted then begin
          FLytUSSD.MemoLog.Lines.Clear;
          Log('✓ All permissions granted - app is fully operational!');
        end;
//        // get only aDenied List ..
        if Length(aDenied) > 0 then begin
          Log('Denied list:');
          Log(GetLogPermissions(aDenied));
        end;


      end);
end;

function TMainView.GetPermissions: iAndroidPermissions;
begin
  if not Assigned(FPermissions) then
    FPermissions := TAndroidPermissions.New;
  Result := FPermissions;
end;

procedure TMainView.Log(const aMsg: string);
begin
  TThread.Queue(nil, procedure
  begin
    FLytUSSD.MemoLog.Lines.Add(Format('[%s] %s', [FormatDateTime('HH:mm:ss', Now), aMsg]));
    FLytUSSD.MemoLog.GoToTextEnd;
  end);
end;

end.
