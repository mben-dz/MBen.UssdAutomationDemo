unit API.Android.Permissions;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  System.Generics.Collections,
  System.Permissions,
  FMX.DialogService,
//
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI,
  Androidapi.JNI.Os,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
//
  API.Android.Permissions.Interfaces;

type
  /// <summary>
  ///   Clean Implementation with Manifest Verification and Detailed Logging.
  /// </summary>
  TAndroidPermissions = class(TInterfacedObject, iAndroidPermissions)
  strict private
    FPermissionList: TList<string>;
    FLogger: TLoggerProc;
    FOnDetailedResult: TPermissionResultProc;
    FAlreadyGranted: TList<string>;
    FToRequest: TList<string>;
    FDeniedWithReason: TDictionary<string, string>;
    FNotInManifest: TList<string>;
    FManifestPermissions: TStringDynArray;

    const PERMISSION_PREFIX = 'android.permission.';

    // Internal Helper to add permissions
    function Add(const aPermission: string): iAndroidPermissions;
    procedure Log(const aMsg: string);
    function GetPermissionName(const aFullPermissionName: string): string;

    // Manifest verification
    function GetPermissionsFromManifest: TStringDynArray;
    function IsPermissionInManifest(const aPermission: string): Boolean;
    function IsGranted(const aPermission: string): Boolean; inline;

    // Callbacks for PermissionsService
    procedure DoPermissionRequestResult(
      Sender: TObject;
      const APermissions: TClassicStringDynArray;
      const AGrantResults: TClassicPermissionStatusDynArray);

    procedure DoDisplayRationale(
      Sender: TObject;
      const APermissions: TClassicStringDynArray;
      const APostRationaleProc: TProc);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    class function New: iAndroidPermissions;

    function SetLogger(const aLogger: TLoggerProc): iAndroidPermissions;

    {$REGION 'Permission Methods'}
    function ACCEPT_HANDOVER: iAndroidPermissions;
    function ACCESS_BACKGROUND_LOCATION: iAndroidPermissions;
    function ACCESS_BLOBS_ACROSS_USERS: iAndroidPermissions;
    function ACCESS_CHECKIN_PROPERTIES: iAndroidPermissions;
    function ACCESS_COARSE_LOCATION: iAndroidPermissions;
    function ACCESS_FINE_LOCATION: iAndroidPermissions;
    function ACCESS_LOCATION_EXTRA_COMMANDS: iAndroidPermissions;
    function ACCESS_MEDIA_LOCATION: iAndroidPermissions;
    function ACCESS_NETWORK_STATE: iAndroidPermissions;
    function ACCESS_NOTIFICATION_POLICY: iAndroidPermissions;
    function ACCESS_WIFI_STATE: iAndroidPermissions;
    function ACCOUNT_MANAGER: iAndroidPermissions;
    function ACTIVITY_RECOGNITION: iAndroidPermissions;
    function ADD_VOICEMAIL: iAndroidPermissions;
    function ANSWER_PHONE_CALLS: iAndroidPermissions;
    function BATTERY_STATS: iAndroidPermissions;
    function BIND_ACCESSIBILITY_SERVICE: iAndroidPermissions;
    function BIND_APPWIDGET: iAndroidPermissions;
    function BIND_AUTOFILL_SERVICE: iAndroidPermissions;
    function BIND_CALL_REDIRECTION_SERVICE: iAndroidPermissions;
    function BIND_CARRIER_MESSAGING_CLIENT_SERVICE: iAndroidPermissions;
    function BIND_CARRIER_MESSAGING_SERVICE: iAndroidPermissions;
    function BIND_CARRIER_SERVICES: iAndroidPermissions;
    function BIND_CHOOSER_TARGET_SERVICE: iAndroidPermissions;
    function BIND_COMPANION_DEVICE_SERVICE: iAndroidPermissions;
    function BIND_CONDITION_PROVIDER_SERVICE: iAndroidPermissions;
    function BIND_CONTROLS: iAndroidPermissions;
    function BIND_DEVICE_ADMIN: iAndroidPermissions;
    function BIND_DREAM_SERVICE: iAndroidPermissions;
    function BIND_INCALL_SERVICE: iAndroidPermissions;
    function BIND_INPUT_METHOD: iAndroidPermissions;
    function BIND_MIDI_DEVICE_SERVICE: iAndroidPermissions;
    function BIND_NFC_SERVICE: iAndroidPermissions;
    function BIND_NOTIFICATION_LISTENER_SERVICE: iAndroidPermissions;
    function BIND_PRINT_SERVICE: iAndroidPermissions;
    function BIND_QUICK_ACCESS_WALLET_SERVICE: iAndroidPermissions;
    function BIND_QUICK_SETTINGS_TILE: iAndroidPermissions;
    function BIND_REMOTEVIEWS: iAndroidPermissions;
    function BIND_SCREENING_SERVICE: iAndroidPermissions;
    function BIND_TELECOM_CONNECTION_SERVICE: iAndroidPermissions;
    function BIND_TEXT_SERVICE: iAndroidPermissions;
    function BIND_TV_INPUT: iAndroidPermissions;
    function BIND_TV_INTERACTIVE_APP: iAndroidPermissions;
    function BIND_VISUAL_VOICEMAIL_SERVICE: iAndroidPermissions;
    function BIND_VOICE_INTERACTION: iAndroidPermissions;
    function BIND_VPN_SERVICE: iAndroidPermissions;
    function BIND_VR_LISTENER_SERVICE: iAndroidPermissions;
    function BIND_WALLPAPER: iAndroidPermissions;
    function BLUETOOTH: iAndroidPermissions;
    function BLUETOOTH_ADMIN: iAndroidPermissions;
    function BLUETOOTH_ADVERTISE: iAndroidPermissions;
    function BLUETOOTH_CONNECT: iAndroidPermissions;
    function BLUETOOTH_PRIVILEGED: iAndroidPermissions;
    function BLUETOOTH_SCAN: iAndroidPermissions;
    function BODY_SENSORS: iAndroidPermissions;
    function BODY_SENSORS_BACKGROUND: iAndroidPermissions;
    function BROADCAST_PACKAGE_REMOVED: iAndroidPermissions;
    function BROADCAST_SMS: iAndroidPermissions;
    function BROADCAST_STICKY: iAndroidPermissions;
    function BROADCAST_WAP_PUSH: iAndroidPermissions;
    function CALL_COMPANION_APP: iAndroidPermissions;
    function CALL_PHONE: iAndroidPermissions;
    function CALL_PRIVILEGED: iAndroidPermissions;
    function CAMERA: iAndroidPermissions;
    function CAPTURE_AUDIO_OUTPUT: iAndroidPermissions;
    function CHANGE_COMPONENT_ENABLED_STATE: iAndroidPermissions;
    function CHANGE_CONFIGURATION: iAndroidPermissions;
    function CHANGE_NETWORK_STATE: iAndroidPermissions;
    function CHANGE_WIFI_MULTICAST_STATE: iAndroidPermissions;
    function CHANGE_WIFI_STATE: iAndroidPermissions;
    function CLEAR_APP_CACHE: iAndroidPermissions;
    function CONTROL_LOCATION_UPDATES: iAndroidPermissions;
    function DELETE_CACHE_FILES: iAndroidPermissions;
    function DELETE_PACKAGES: iAndroidPermissions;
    function DELIVER_COMPANION_MESSAGES: iAndroidPermissions;
    function DIAGNOSTIC: iAndroidPermissions;
    function DISABLE_KEYGUARD: iAndroidPermissions;
    function DUMP: iAndroidPermissions;
    function EXPAND_STATUS_BAR: iAndroidPermissions;
    function FACTORY_TEST: iAndroidPermissions;
    function FOREGROUND_SERVICE: iAndroidPermissions;
    function GET_ACCOUNTS: iAndroidPermissions;
    function GET_ACCOUNTS_PRIVILEGED: iAndroidPermissions;
    function GET_PACKAGE_SIZE: iAndroidPermissions;
    function GET_TASKS: iAndroidPermissions;
    function GLOBAL_SEARCH: iAndroidPermissions;
    function HIDE_OVERLAY_WINDOWS: iAndroidPermissions;
    function HIGH_SAMPLING_RATE_SENSORS: iAndroidPermissions;
    function INSTALL_LOCATION_PROVIDER: iAndroidPermissions;
    function INSTALL_PACKAGES: iAndroidPermissions;
    function INSTALL_SHORTCUT: iAndroidPermissions;
    function INSTANT_APP_FOREGROUND_SERVICE: iAndroidPermissions;
    function INTERACT_ACROSS_PROFILES: iAndroidPermissions;
    function INTERNET: iAndroidPermissions;
    function KILL_BACKGROUND_PROCESSES: iAndroidPermissions;
    function LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK: iAndroidPermissions;
    function LOADER_USAGE_STATS: iAndroidPermissions;
    function LOCATION_HARDWARE: iAndroidPermissions;
    function MANAGE_DOCUMENTS: iAndroidPermissions;
    function MANAGE_EXTERNAL_STORAGE: iAndroidPermissions;
    function MANAGE_MEDIA: iAndroidPermissions;
    function MANAGE_ONGOING_CALLS: iAndroidPermissions;
    function MANAGE_OWN_CALLS: iAndroidPermissions;
    function MANAGE_WIFI_INTERFACES: iAndroidPermissions;
    function MANAGE_WIFI_NETWORK_SELECTION: iAndroidPermissions;
    function MASTER_CLEAR: iAndroidPermissions;
    function MEDIA_CONTENT_CONTROL: iAndroidPermissions;
    function MODIFY_AUDIO_SETTINGS: iAndroidPermissions;
    function MODIFY_PHONE_STATE: iAndroidPermissions;
    function MOUNT_FORMAT_FILESYSTEMS: iAndroidPermissions;
    function MOUNT_UNMOUNT_FILESYSTEMS: iAndroidPermissions;
    function NEARBY_WIFI_DEVICES: iAndroidPermissions;
    function NFC: iAndroidPermissions;
    function NFC_PREFERRED_PAYMENT_INFO: iAndroidPermissions;
    function NFC_TRANSACTION_EVENT: iAndroidPermissions;
    function OVERRIDE_WIFI_CONFIG: iAndroidPermissions;
    function PACKAGE_USAGE_STATS: iAndroidPermissions;
    function PERSISTENT_ACTIVITY: iAndroidPermissions;
    function POST_NOTIFICATIONS: iAndroidPermissions;
    function PROCESS_OUTGOING_CALLS: iAndroidPermissions;
    function QUERY_ALL_PACKAGES: iAndroidPermissions;
    function READ_ASSISTANT_APP_SEARCH_DATA: iAndroidPermissions;
    function READ_BASIC_PHONE_STATE: iAndroidPermissions;
    function READ_CALENDAR: iAndroidPermissions;
    function READ_CALL_LOG: iAndroidPermissions;
    function READ_CONTACTS: iAndroidPermissions;
    function READ_EXTERNAL_STORAGE: iAndroidPermissions;
    function READ_HOME_APP_SEARCH_DATA: iAndroidPermissions;
    function READ_INPUT_STATE: iAndroidPermissions;
    function READ_LOGS: iAndroidPermissions;
    function READ_MEDIA_AUDIO: iAndroidPermissions;
    function READ_MEDIA_IMAGES: iAndroidPermissions;
    function READ_MEDIA_VIDEO: iAndroidPermissions;
    function READ_NEARBY_STREAMING_POLICY: iAndroidPermissions;
    function READ_PHONE_NUMBERS: iAndroidPermissions;
    function READ_PHONE_STATE: iAndroidPermissions;
    function READ_PRECISE_PHONE_STATE: iAndroidPermissions;
    function READ_SMS: iAndroidPermissions;
    function READ_SYNC_SETTINGS: iAndroidPermissions;
    function READ_SYNC_STATS: iAndroidPermissions;
    function READ_VOICEMAIL: iAndroidPermissions;
    function REBOOT: iAndroidPermissions;
    function RECEIVE_BOOT_COMPLETED: iAndroidPermissions;
    function RECEIVE_MMS: iAndroidPermissions;
    function RECEIVE_SMS: iAndroidPermissions;
    function RECEIVE_WAP_PUSH: iAndroidPermissions;
    function RECORD_AUDIO: iAndroidPermissions;
    function REORDER_TASKS: iAndroidPermissions;
    function REQUEST_COMPANION_PROFILE_APP_STREAMING: iAndroidPermissions;
    function REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION: iAndroidPermissions;
    function REQUEST_COMPANION_PROFILE_COMPUTER: iAndroidPermissions;
    function REQUEST_COMPANION_PROFILE_WATCH: iAndroidPermissions;
    function REQUEST_COMPANION_RUN_IN_BACKGROUND: iAndroidPermissions;
    function REQUEST_COMPANION_SELF_MANAGED: iAndroidPermissions;
    function REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND: iAndroidPermissions;
    function REQUEST_COMPANION_USE_DATA_IN_BACKGROUND: iAndroidPermissions;
    function REQUEST_DELETE_PACKAGES: iAndroidPermissions;
    function REQUEST_IGNORE_BATTERY_OPTIMIZATIONS: iAndroidPermissions;
    function REQUEST_INSTALL_PACKAGES: iAndroidPermissions;
    function REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE: iAndroidPermissions;
    function REQUEST_PASSWORD_COMPLEXITY: iAndroidPermissions;
    function RESTART_PACKAGES: iAndroidPermissions;
    function SCHEDULE_EXACT_ALARM: iAndroidPermissions;
    function SEND_RESPOND_VIA_MESSAGE: iAndroidPermissions;
    function SEND_SMS: iAndroidPermissions;
    function SET_ALARM: iAndroidPermissions;
    function SET_ALWAYS_FINISH: iAndroidPermissions;
    function SET_ALWAYS_FINISH_HINTS: iAndroidPermissions;
    function SET_ANIMATION_SCALE: iAndroidPermissions;
    function SET_DEBUG_APP: iAndroidPermissions;
    function SET_PREFERRED_APPLICATIONS: iAndroidPermissions;
    function SET_PROCESS_LIMIT: iAndroidPermissions;
    function SET_TIME: iAndroidPermissions;
    function SET_TIME_ZONE: iAndroidPermissions;
    function SET_WALLPAPER: iAndroidPermissions;
    function SET_WALLPAPER_HINTS: iAndroidPermissions;
    function SIGNAL_PERSISTENT_PROCESSES: iAndroidPermissions;
    function SMS_FINANCIAL_TRANSACTIONS: iAndroidPermissions;
    function START_FOREGROUND_SERVICES_FROM_BACKGROUND: iAndroidPermissions;
    function START_VIEW_APP_FEATURES: iAndroidPermissions;
    function START_VIEW_PERMISSION_USAGE: iAndroidPermissions;
    function STATUS_BAR: iAndroidPermissions;
    function SUBSCRIBE_TO_KEYGUARD_LOCKED_STATE: iAndroidPermissions;
    function SYSTEM_ALERT_WINDOW: iAndroidPermissions;
    function TRANSMIT_IR: iAndroidPermissions;
    function UNINSTALL_SHORTCUT: iAndroidPermissions;
    function UPDATE_DEVICE_STATS: iAndroidPermissions;
    function UPDATE_PACKAGES_WITHOUT_USER_ACTION: iAndroidPermissions;
    function USE_BIOMETRIC: iAndroidPermissions;
    function USE_EXACT_ALARM: iAndroidPermissions;
    function USE_FINGERPRINT: iAndroidPermissions;
    function USE_FULL_SCREEN_INTENT: iAndroidPermissions;
    function USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER: iAndroidPermissions;
    function USE_SIP: iAndroidPermissions;
    function UWB_RANGING: iAndroidPermissions;
    function VIBRATE: iAndroidPermissions;
    function WAKE_LOCK: iAndroidPermissions;
    function WRITE_APN_SETTINGS: iAndroidPermissions;
    function WRITE_CALENDAR: iAndroidPermissions;
    function WRITE_CALL_LOG: iAndroidPermissions;
    function WRITE_CONTACTS: iAndroidPermissions;
    function WRITE_EXTERNAL_STORAGE: iAndroidPermissions;
    function WRITE_GSERVICES: iAndroidPermissions;
    function WRITE_SECURE_SETTINGS: iAndroidPermissions;
    function WRITE_SETTINGS: iAndroidPermissions;
    function WRITE_SYNC_SETTINGS: iAndroidPermissions;
    function WRITE_VOICEMAIL: iAndroidPermissions;
    {$ENDREGION}

    function AddPermission(const aPermission: string): iAndroidPermissions;
    function AddPermissions(const aPermissions: TArray<string>): iAndroidPermissions;

    function ToArray: TArray<string>;

    function GetGrantedPermissions: TArray<string>;
    function GetDeniedPermissions: TArray<string>;
    function GetNotInManifestPermissions: TArray<string>;

    function CheckAndRequest(const aOnResult: TPermissionResultProc = nil): iAndroidPermissions;
  end;

  /// <summary>
  ///   Check if a Android permission is already granted.
  /// </summary>
  function IsPermGranted(const aPermission: string): Boolean;

  function GetLogPermissions(const aPerms: TArray<string>): string;

implementation

function IsPermGranted(const aPermission: string): Boolean;
begin
  Result := PermissionsService.IsPermissionGranted(aPermission);
end;

function GetLogPermissions(const aPerms: TArray<string>): string;
//var
//  LPerm: string;
begin
  if Length(aPerms) = 0 then
  begin
    Result := '';
    Exit;
  end;

//  Result := sLineBreak;
//
//  for LPerm in aPerms do
//    Result := Result + LPerm + sLineBreak;

  Result := sLineBreak + string.Join(sLineBreak, aPerms);
end;

{ TAndroidPermissions }

constructor TAndroidPermissions.Create;
begin inherited Create;

  FPermissionList   := TList<string>.Create;
  FAlreadyGranted   := TList<string>.Create;
  FToRequest        := TList<string>.Create;
  FDeniedWithReason := TDictionary<string, string>.Create;
  FNotInManifest    := TList<string>.Create;

  FManifestPermissions := GetPermissionsFromManifest;
end;

destructor TAndroidPermissions.Destroy;
begin
  FPermissionList.Free;
  FAlreadyGranted.Free;
  FToRequest.Free;
  FDeniedWithReason.Free;
  FNotInManifest.Free;
  inherited Destroy;
end;

class function TAndroidPermissions.New: iAndroidPermissions;
begin
  Result := TAndroidPermissions.Create;
end;

function TAndroidPermissions.SetLogger(const aLogger: TLoggerProc): iAndroidPermissions;
begin
  FLogger := aLogger;
  Result := Self;
end;

procedure TAndroidPermissions.Log(const aMsg: string);
begin
  if Assigned(FLogger) then
    FLogger(aMsg);
end;

function TAndroidPermissions.Add(const aPermission: string): iAndroidPermissions;
begin
  if not FPermissionList.Contains(aPermission) then
    FPermissionList.Add(aPermission);

  Result := Self;
end;

function TAndroidPermissions.AddPermission(
  const aPermission: string): iAndroidPermissions;
begin
  Result := Add(aPermission);
end;

function TAndroidPermissions.AddPermissions(
  const aPermissions: TArray<string>): iAndroidPermissions;
var
  LPerm: string;
begin
  for LPerm in aPermissions do
    Add(LPerm);

  Result := Self;
end;

function TAndroidPermissions.ToArray: TArray<string>;
begin
  Result := FPermissionList.ToArray;
end;

function TAndroidPermissions.GetDeniedPermissions: TArray<string>;
var
  LDenied: TList<string>;
  LPerm: string;
begin
  LDenied := TList<string>.Create;
  try
    for LPerm in FPermissionList do
    begin
      if not FAlreadyGranted.Contains(LPerm) and not FNotInManifest.Contains(LPerm) then
        LDenied.Add(LPerm);
    end;
    Result := LDenied.ToArray;
  finally
    LDenied.Free;
  end;
end;

function TAndroidPermissions.GetGrantedPermissions: TArray<string>;
begin
  Result := FAlreadyGranted.ToArray;
end;

function TAndroidPermissions.GetNotInManifestPermissions: TArray<string>;
begin
  Result := FNotInManifest.ToArray;
end;

function TAndroidPermissions.IsGranted(const aPermission: string): Boolean;
begin
  Result := PermissionsService.IsPermissionGranted(aPermission);
end;

function TAndroidPermissions.GetPermissionName(
  const aFullPermissionName: string): string;
begin
  // Remove 'android.permission.' prefix for cleaner logging
  if aFullPermissionName.StartsWith(PERMISSION_PREFIX) then
    Result := aFullPermissionName.Substring(Length(PERMISSION_PREFIX))
  else
    Result := aFullPermissionName;
end;

function TAndroidPermissions.GetPermissionsFromManifest: TStringDynArray;
var
  LPackageManager: JPackageManager;
  LPackageInfo: JPackageInfo;
  LPermissions: TList<string>;
  I: Integer;
begin
  try
    LPackageManager := TAndroidHelper.Context.getPackageManager;
    LPackageInfo    := LPackageManager.getPackageInfo(
      TAndroidHelper.Context.getPackageName, TJPackageManager.JavaClass.GET_PERMISSIONS);

    LPermissions := TList<string>.Create;
    try
      if Assigned(LPackageInfo.requestedPermissions) then
      begin
        for I := 0 to LPackageInfo.requestedPermissions.Length - 1 do
          LPermissions.Add(JStringToString(LPackageInfo.requestedPermissions.Items[I]));
      end;
      Result := LPermissions.ToArray;
    finally
      LPermissions.Free;
    end;
  except
    SetLength(Result, 0);
  end;
end;


function TAndroidPermissions.IsPermissionInManifest(const aPermission: string): Boolean;
var
  I: Integer;
begin
  Result := False;

  for I := 0 to High(FManifestPermissions) do
  begin
    if FManifestPermissions[I] = aPermission then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TAndroidPermissions.DoPermissionRequestResult(Sender: TObject;
  const APermissions: TClassicStringDynArray;
  const AGrantResults: TClassicPermissionStatusDynArray);
var
  LIndex: Integer;
  LResult: TPermissionStatus;
  LPerm, LPermName: string;
  LDeniedList: TList<string>;
  LAllGranted: Boolean;
begin
  LDeniedList := TList<string>.Create;
  try
    Log('');
    Log('╔══════════════════════════════════════════════╗');
    Log('║    PERMISSION REQUEST RESULT FROM SYSTEM     ║');
    Log('╚══════════════════════════════════════════════╝');

    LAllGranted := True;
    FDeniedWithReason.Clear;

    for LIndex := 0 to Length(APermissions) - 1 do
    begin
      LPerm     := APermissions[LIndex];
      LPermName := GetPermissionName(LPerm);
      LResult   := AGrantResults[LIndex];

      case LResult of
        TPermissionStatus.Granted:
          begin
            Log('  ✓ GRANTED: ' + LPermName);
            if not FAlreadyGranted.Contains(LPerm) then
              FAlreadyGranted.Add(LPerm);
          end;
        TPermissionStatus.Denied:
          begin
            Log('  ✗ DENIED: ' + LPermName);
            Log('     └─ Reason: User rejected permission');
            LDeniedList.Add(LPerm);
            FDeniedWithReason.AddOrSetValue(LPerm, 'USER_REJECTED');
            LAllGranted := False;
          end;
      end;
    end;

    Log('');
    Log('─────────────────────────────────────────────────────────────');
    Log('Summary: ' + IntToStr(FAlreadyGranted.Count) + ' granted, ' +
      IntToStr(LDeniedList.Count) + ' denied');
    Log('─────────────────────────────────────────────────────────────');
    Log('');

    TThread.Queue(nil, procedure begin
      if Assigned(FOnDetailedResult) then begin
        FOnDetailedResult(LAllGranted, FAlreadyGranted.ToArray, LDeniedList.ToArray);
      end;
    end);


  finally
    LDeniedList.Free;
  end;
end;

procedure TAndroidPermissions.DoDisplayRationale(
  Sender: TObject;
  const APermissions: TClassicStringDynArray;
  const APostRationaleProc: TProc);
var
  I: Integer;
  LMsg: string;
begin
  Log('');
  Log('╔═══════════════════════════════════════════════════════════╗');
  Log('║        DISPLAYING RATIONALE TO USER                       ║');
  Log('╚═══════════════════════════════════════════════════════════╝');
  Log('');

  LMsg := 'This app requires the following permissions to function properly:'#13#10#13#10;
    for I := 0 to High(APermissions) do
    begin
      Log('  • ' + GetPermissionName(APermissions[I]));
      LMsg := LMsg + GetPermissionName(APermissions[I]) + #13#10;
    end;
  Log('');

  TDialogService.ShowMessage(LMsg,
    procedure(const AResult: TModalResult)
    begin
      Log('User acknowledged rationale dialog.');
      Log('Proceeding to system permission request...');
      if Assigned(APostRationaleProc) then
        APostRationaleProc;
    end);
end;

function TAndroidPermissions.CheckAndRequest(
  const aOnResult: TPermissionResultProc): iAndroidPermissions;
var
  LPerm, LPermName: string;
  I: Integer;
  LTempList: TList<string>;
begin
  Result := Self;
  FOnDetailedResult := aOnResult;

  FAlreadyGranted.Clear;
  FToRequest.Clear;
  FDeniedWithReason.Clear;
  FNotInManifest.Clear;

  if FPermissionList.Count = 0 then
  begin
    Log('  ⚠ No permissions in list to check.');

    TThread.Queue(nil, procedure begin
      if Assigned(FOnDetailedResult) then
        FOnDetailedResult(True, [], []);
    end);

    Exit;
  end;

  Log('');
  Log('╔═══════════════════════════════════════════════════════════╗');
  Log('║    ANDROID PERMISSIONS CHECK AND REQUEST PROCESS          ║');
  Log('╚═══════════════════════════════════════════════════════════╝');
  Log('');

  Log('This app uses the enhanced permissions system that:');
  Log('  1. Verifies permissions exist in AndroidManifest.xml');
  Log('  2. Checks current grant status');
  Log('  3. Requests only missing permissions');
  Log('  4. Logs detailed denial reasons');
  Log('  5. Shows OS-level denial information');
  Log('');

  Log(' Expected [Manifest.XML] Permissions At Runtime:');
    if Length(FManifestPermissions) > 0 then
    begin
      Log('');
      for I := 0 to High(FManifestPermissions) do
        Log('  • ' + GetPermissionName(FManifestPermissions[I]));
    end;
  Log('');

  Log('Application initialized. Ready to request permissions.');
  Log('');

  Log('  Checking ' + IntToStr(FPermissionList.Count) + ' permissions...');
  Log('');

  // Phase 1: Verify permissions exist in manifest
  Log('PHASE 1: MANIFEST VERIFICATION');
  Log('─────────────────────────────────────────────────────────────');
  Log('Total permissions in manifest: ' + IntToStr(Length(FManifestPermissions)));

  Log('');
  Log('─────────────────────────────────────────────────────────────');
  Log('');

  // Phase 2: Analyze each requested permission
  Log('PHASE 2: PERMISSION STATUS ANALYSIS');
  Log('─────────────────────────────────────────────────────────────');
  Log('Analyzing ' + IntToStr(FPermissionList.Count) + ' requested permissions:');
  Log('');

  for LPerm in FPermissionList do
  begin
    LPermName := GetPermissionName(LPerm);

    // Check if permission is in manifest
    if not IsPermissionInManifest(LPerm) then
    begin
      Log('  ⚠ NOT_IN_MANIFEST: ' + LPermName);
      Log('     └─ Action: Add to AndroidManifest.xml');
      FNotInManifest.Add(LPerm);
      FDeniedWithReason.AddOrSetValue(LPerm, 'NOT_DECLARED_IN_MANIFEST');
    end
    // Check if already granted
    else if IsGranted(LPerm) then
    begin
      Log('  ✓ GRANTED: ' + LPermName);
      FAlreadyGranted.Add(LPerm);
    end
    // Permission needs to be requested
    else
    begin
      Log('  ⏳ PENDING: ' + LPermName);
      Log('     └─ Status: Will request from system');
      FToRequest.Add(LPerm);
    end;
  end;

  Log('');
  Log('─────────────────────────────────────────────────────────────');
  Log('ANALYSIS SUMMARY:');
  Log('  Total Requested:    ' + IntToStr(FPermissionList.Count));
  Log('  Already Granted:    ' + IntToStr(FAlreadyGranted.Count));
  Log('  Pending Request:    ' + IntToStr(FToRequest.Count));
  Log('  Not in Manifest:    ' + IntToStr(FNotInManifest.Count));
  Log('─────────────────────────────────────────────────────────────');
  Log('');

  // If nothing to request, call callback immediately
  if FToRequest.Count = 0 then
  begin
    if FNotInManifest.Count > 0 then
    begin
      Log('⚠ INCOMPLETE: Some permissions missing from manifest.');
      Log('');
      Log('Required manifest declarations:');
      for LPerm in FNotInManifest do
        Log('  <uses-permission android:name="' + LPerm + '" />');
    end
    else
    begin
      Log('✓ SUCCESS: All permissions are either granted or not required.');
    end;
    Log('');

    TThread.Queue(nil, procedure begin
      if Assigned(FOnDetailedResult) then
        FOnDetailedResult(True, FAlreadyGranted.ToArray,
          FNotInManifest.ToArray);
    end);

    Exit;
  end;

  Log('PHASE 3: REQUESTING PERMISSIONS FROM SYSTEM');
  Log('─────────────────────────────────────────────────────────────');
  Log('Initiating system permission request dialog...');
  Log('Requesting ' + IntToStr(FToRequest.Count) + ' permission(s):');
  Log('');

  // Reorder FToRequest to match manifest order..
  LTempList := TList<string>.Create;
  try
    for LPerm in FManifestPermissions do
    begin
      for I := 0 to FToRequest.Count - 1 do
      begin
        if LPerm = FToRequest[I] then
        begin
          LTempList.Add(LPerm);
          Break;
        end;
      end;
    end;

    FToRequest.Clear;
    FToRequest.AddRange(LTempList);
  finally
    LTempList.Free;
  end;

  for LPerm in FToRequest do
    Log('  • ' + GetPermissionName(LPerm));

  Log('');

  PermissionsService.RequestPermissions(FToRequest.ToArray,
    DoPermissionRequestResult, DoDisplayRationale);
end;

{$REGION ' Permission Methods Implementation'}
// Simple mapping of adding string literals ...

function TAndroidPermissions.ACCEPT_HANDOVER: iAndroidPermissions;
begin Result := Add(cACCEPT_HANDOVER); end;

function TAndroidPermissions.ACCESS_BACKGROUND_LOCATION: iAndroidPermissions;
begin Result := Add(cACCESS_BACKGROUND_LOCATION); end;

function TAndroidPermissions.ACCESS_BLOBS_ACROSS_USERS: iAndroidPermissions;
begin Result := Add(cACCESS_BLOBS_ACROSS_USERS); end;

function TAndroidPermissions.ACCESS_CHECKIN_PROPERTIES: iAndroidPermissions;
begin Result := Add(cACCESS_CHECKIN_PROPERTIES); end;

function TAndroidPermissions.ACCESS_COARSE_LOCATION: iAndroidPermissions;
begin Result := Add(cACCESS_COARSE_LOCATION); end;

function TAndroidPermissions.ACCESS_FINE_LOCATION: iAndroidPermissions;
begin Result := Add(cACCESS_FINE_LOCATION); end;

function TAndroidPermissions.ACCESS_LOCATION_EXTRA_COMMANDS: iAndroidPermissions;
begin Result := Add(cACCESS_LOCATION_EXTRA_COMMANDS); end;

function TAndroidPermissions.ACCESS_MEDIA_LOCATION: iAndroidPermissions;
begin Result := Add(cACCESS_MEDIA_LOCATION); end;

function TAndroidPermissions.ACCESS_NETWORK_STATE: iAndroidPermissions;
begin Result := Add(cACCESS_NETWORK_STATE); end;

function TAndroidPermissions.ACCESS_NOTIFICATION_POLICY: iAndroidPermissions;
begin Result := Add(cACCESS_NOTIFICATION_POLICY); end;

function TAndroidPermissions.ACCESS_WIFI_STATE: iAndroidPermissions;
begin Result := Add(cACCESS_WIFI_STATE); end;

function TAndroidPermissions.ACCOUNT_MANAGER: iAndroidPermissions;
begin Result := Add(cACCOUNT_MANAGER); end;

function TAndroidPermissions.ACTIVITY_RECOGNITION: iAndroidPermissions;
begin Result := Add(cACTIVITY_RECOGNITION); end;

function TAndroidPermissions.ADD_VOICEMAIL: iAndroidPermissions;
begin Result := Add(cADD_VOICEMAIL); end;

function TAndroidPermissions.ANSWER_PHONE_CALLS: iAndroidPermissions;
begin Result := Add(cANSWER_PHONE_CALLS); end;

function TAndroidPermissions.BATTERY_STATS: iAndroidPermissions;
begin Result := Add(cBATTERY_STATS); end;

function TAndroidPermissions.BIND_ACCESSIBILITY_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_ACCESSIBILITY_SERVICE); end;

function TAndroidPermissions.BIND_APPWIDGET: iAndroidPermissions;
begin Result := Add(cBIND_APPWIDGET); end;

function TAndroidPermissions.BIND_AUTOFILL_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_AUTOFILL_SERVICE); end;

function TAndroidPermissions.BIND_CALL_REDIRECTION_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_CALL_REDIRECTION_SERVICE); end;

function TAndroidPermissions.BIND_CARRIER_MESSAGING_CLIENT_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_CARRIER_MESSAGING_CLIENT_SERVICE); end;

function TAndroidPermissions.BIND_CARRIER_MESSAGING_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_CARRIER_MESSAGING_SERVICE); end;

function TAndroidPermissions.BIND_CARRIER_SERVICES: iAndroidPermissions;
begin Result := Add(cBIND_CARRIER_SERVICES); end;

function TAndroidPermissions.BIND_CHOOSER_TARGET_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_CHOOSER_TARGET_SERVICE); end;

function TAndroidPermissions.BIND_COMPANION_DEVICE_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_COMPANION_DEVICE_SERVICE); end;

function TAndroidPermissions.BIND_CONDITION_PROVIDER_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_CONDITION_PROVIDER_SERVICE); end;

function TAndroidPermissions.BIND_CONTROLS: iAndroidPermissions;
begin Result := Add(cBIND_CONTROLS); end;

function TAndroidPermissions.BIND_DEVICE_ADMIN: iAndroidPermissions;
begin Result := Add(cBIND_DEVICE_ADMIN); end;

function TAndroidPermissions.BIND_DREAM_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_DREAM_SERVICE); end;

function TAndroidPermissions.BIND_INCALL_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_INCALL_SERVICE); end;

function TAndroidPermissions.BIND_INPUT_METHOD: iAndroidPermissions;
begin Result := Add(cBIND_INPUT_METHOD); end;

function TAndroidPermissions.BIND_MIDI_DEVICE_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_MIDI_DEVICE_SERVICE); end;

function TAndroidPermissions.BIND_NFC_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_NFC_SERVICE); end;

function TAndroidPermissions.BIND_NOTIFICATION_LISTENER_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_NOTIFICATION_LISTENER_SERVICE); end;

function TAndroidPermissions.BIND_PRINT_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_PRINT_SERVICE); end;

function TAndroidPermissions.BIND_QUICK_ACCESS_WALLET_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_QUICK_ACCESS_WALLET_SERVICE); end;

function TAndroidPermissions.BIND_QUICK_SETTINGS_TILE: iAndroidPermissions;
begin Result := Add(cBIND_QUICK_SETTINGS_TILE); end;

function TAndroidPermissions.BIND_REMOTEVIEWS: iAndroidPermissions;
begin Result := Add(cBIND_REMOTEVIEWS); end;

function TAndroidPermissions.BIND_SCREENING_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_SCREENING_SERVICE); end;

function TAndroidPermissions.BIND_TELECOM_CONNECTION_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_TELECOM_CONNECTION_SERVICE); end;

function TAndroidPermissions.BIND_TEXT_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_TEXT_SERVICE); end;

function TAndroidPermissions.BIND_TV_INPUT: iAndroidPermissions;
begin Result := Add(cBIND_TV_INPUT); end;

function TAndroidPermissions.BIND_TV_INTERACTIVE_APP: iAndroidPermissions;
begin Result := Add(cBIND_TV_INTERACTIVE_APP); end;

function TAndroidPermissions.BIND_VISUAL_VOICEMAIL_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_VISUAL_VOICEMAIL_SERVICE); end;

function TAndroidPermissions.BIND_VOICE_INTERACTION: iAndroidPermissions;
begin Result := Add(cBIND_VOICE_INTERACTION); end;

function TAndroidPermissions.BIND_VPN_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_VPN_SERVICE); end;

function TAndroidPermissions.BIND_VR_LISTENER_SERVICE: iAndroidPermissions;
begin Result := Add(cBIND_VR_LISTENER_SERVICE); end;

function TAndroidPermissions.BIND_WALLPAPER: iAndroidPermissions;
begin Result := Add(cBIND_WALLPAPER); end;

function TAndroidPermissions.BLUETOOTH: iAndroidPermissions;
begin Result := Add(cBLUETOOTH); end;

function TAndroidPermissions.BLUETOOTH_ADMIN: iAndroidPermissions;
begin Result := Add(cBLUETOOTH_ADMIN); end;

function TAndroidPermissions.BLUETOOTH_ADVERTISE: iAndroidPermissions;
begin Result := Add(cBLUETOOTH_ADVERTISE); end;

function TAndroidPermissions.BLUETOOTH_CONNECT: iAndroidPermissions;
begin Result := Add(cBLUETOOTH_CONNECT); end;

function TAndroidPermissions.BLUETOOTH_PRIVILEGED: iAndroidPermissions;
begin Result := Add(cBLUETOOTH_PRIVILEGED); end;

function TAndroidPermissions.BLUETOOTH_SCAN: iAndroidPermissions;
begin Result := Add(cBLUETOOTH_SCAN); end;

function TAndroidPermissions.BODY_SENSORS: iAndroidPermissions;
begin Result := Add(cBODY_SENSORS); end;

function TAndroidPermissions.BODY_SENSORS_BACKGROUND: iAndroidPermissions;
begin Result := Add(cBODY_SENSORS_BACKGROUND); end;

function TAndroidPermissions.BROADCAST_PACKAGE_REMOVED: iAndroidPermissions;
begin Result := Add(cBROADCAST_PACKAGE_REMOVED); end;

function TAndroidPermissions.BROADCAST_SMS: iAndroidPermissions;
begin Result := Add(cBROADCAST_SMS); end;

function TAndroidPermissions.BROADCAST_STICKY: iAndroidPermissions;
begin Result := Add(cBROADCAST_STICKY); end;

function TAndroidPermissions.BROADCAST_WAP_PUSH: iAndroidPermissions;
begin Result := Add(cBROADCAST_WAP_PUSH); end;

function TAndroidPermissions.CALL_COMPANION_APP: iAndroidPermissions;
begin Result := Add(cCALL_COMPANION_APP); end;

function TAndroidPermissions.CALL_PHONE: iAndroidPermissions;
begin Result := Add(cCALL_PHONE); end;

function TAndroidPermissions.CALL_PRIVILEGED: iAndroidPermissions;
begin Result := Add(cCALL_PRIVILEGED); end;

function TAndroidPermissions.CAMERA: iAndroidPermissions;
begin Result := Add(cCAMERA); end;

function TAndroidPermissions.CAPTURE_AUDIO_OUTPUT: iAndroidPermissions;
begin Result := Add(cCAPTURE_AUDIO_OUTPUT); end;

function TAndroidPermissions.CHANGE_COMPONENT_ENABLED_STATE: iAndroidPermissions;
begin Result := Add(cCHANGE_COMPONENT_ENABLED_STATE); end;

function TAndroidPermissions.CHANGE_CONFIGURATION: iAndroidPermissions;
begin Result := Add(cCHANGE_CONFIGURATION); end;

function TAndroidPermissions.CHANGE_NETWORK_STATE: iAndroidPermissions;
begin Result := Add(cCHANGE_NETWORK_STATE); end;

function TAndroidPermissions.CHANGE_WIFI_MULTICAST_STATE: iAndroidPermissions;
begin Result := Add(cCHANGE_WIFI_MULTICAST_STATE); end;

function TAndroidPermissions.CHANGE_WIFI_STATE: iAndroidPermissions;
begin Result := Add(cCHANGE_WIFI_STATE); end;

function TAndroidPermissions.CLEAR_APP_CACHE: iAndroidPermissions;
begin Result := Add(cCLEAR_APP_CACHE); end;

function TAndroidPermissions.CONTROL_LOCATION_UPDATES: iAndroidPermissions;
begin Result := Add(cCONTROL_LOCATION_UPDATES); end;

function TAndroidPermissions.DELETE_CACHE_FILES: iAndroidPermissions;
begin Result := Add(cDELETE_CACHE_FILES); end;

function TAndroidPermissions.DELETE_PACKAGES: iAndroidPermissions;
begin Result := Add(cDELETE_PACKAGES); end;

function TAndroidPermissions.DELIVER_COMPANION_MESSAGES: iAndroidPermissions;
begin Result := Add(cDELIVER_COMPANION_MESSAGES); end;

function TAndroidPermissions.DIAGNOSTIC: iAndroidPermissions;
begin Result := Add(cDIAGNOSTIC); end;

function TAndroidPermissions.DISABLE_KEYGUARD: iAndroidPermissions;
begin Result := Add(cDISABLE_KEYGUARD); end;

function TAndroidPermissions.DUMP: iAndroidPermissions;
begin Result := Add(cDUMP); end;

function TAndroidPermissions.EXPAND_STATUS_BAR: iAndroidPermissions;
begin Result := Add(cEXPAND_STATUS_BAR); end;

function TAndroidPermissions.FACTORY_TEST: iAndroidPermissions;
begin Result := Add(cFACTORY_TEST); end;

function TAndroidPermissions.FOREGROUND_SERVICE: iAndroidPermissions;
begin Result := Add(cFOREGROUND_SERVICE); end;

function TAndroidPermissions.GET_ACCOUNTS: iAndroidPermissions;
begin Result := Add(cGET_ACCOUNTS); end;

function TAndroidPermissions.GET_ACCOUNTS_PRIVILEGED: iAndroidPermissions;
begin Result := Add(cGET_ACCOUNTS_PRIVILEGED); end;

function TAndroidPermissions.GET_PACKAGE_SIZE: iAndroidPermissions;
begin Result := Add(cGET_PACKAGE_SIZE); end;

function TAndroidPermissions.GET_TASKS: iAndroidPermissions;
begin Result := Add(cGET_TASKS); end;

function TAndroidPermissions.GLOBAL_SEARCH: iAndroidPermissions;
begin Result := Add(cGLOBAL_SEARCH); end;

function TAndroidPermissions.HIDE_OVERLAY_WINDOWS: iAndroidPermissions;
begin Result := Add(cHIDE_OVERLAY_WINDOWS); end;

function TAndroidPermissions.HIGH_SAMPLING_RATE_SENSORS: iAndroidPermissions;
begin Result := Add(cHIGH_SAMPLING_RATE_SENSORS); end;

function TAndroidPermissions.INSTALL_LOCATION_PROVIDER: iAndroidPermissions;
begin Result := Add(cINSTALL_LOCATION_PROVIDER); end;

function TAndroidPermissions.INSTALL_PACKAGES: iAndroidPermissions;
begin Result := Add(cINSTALL_PACKAGES); end;

function TAndroidPermissions.INSTALL_SHORTCUT: iAndroidPermissions;
begin Result := Add(cINSTALL_SHORTCUT); end;

function TAndroidPermissions.INSTANT_APP_FOREGROUND_SERVICE: iAndroidPermissions;
begin Result := Add(cINSTANT_APP_FOREGROUND_SERVICE); end;

function TAndroidPermissions.INTERACT_ACROSS_PROFILES: iAndroidPermissions;
begin Result := Add(cINTERACT_ACROSS_PROFILES); end;

function TAndroidPermissions.INTERNET: iAndroidPermissions;
begin Result := Add(cINTERNET); end;

function TAndroidPermissions.KILL_BACKGROUND_PROCESSES: iAndroidPermissions;
begin Result := Add(cKILL_BACKGROUND_PROCESSES); end;

function TAndroidPermissions.LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK: iAndroidPermissions;
begin Result := Add(cLAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK); end;

function TAndroidPermissions.LOADER_USAGE_STATS: iAndroidPermissions;
begin Result := Add(cLOADER_USAGE_STATS); end;

function TAndroidPermissions.LOCATION_HARDWARE: iAndroidPermissions;
begin Result := Add(cLOCATION_HARDWARE); end;

function TAndroidPermissions.MANAGE_DOCUMENTS: iAndroidPermissions;
begin Result := Add(cMANAGE_DOCUMENTS); end;

function TAndroidPermissions.MANAGE_EXTERNAL_STORAGE: iAndroidPermissions;
begin Result := Add(cMANAGE_EXTERNAL_STORAGE); end;

function TAndroidPermissions.MANAGE_MEDIA: iAndroidPermissions;
begin Result := Add(cMANAGE_MEDIA); end;

function TAndroidPermissions.MANAGE_ONGOING_CALLS: iAndroidPermissions;
begin Result := Add(cMANAGE_ONGOING_CALLS); end;

function TAndroidPermissions.MANAGE_OWN_CALLS: iAndroidPermissions;
begin Result := Add(cMANAGE_OWN_CALLS); end;

function TAndroidPermissions.MANAGE_WIFI_INTERFACES: iAndroidPermissions;
begin Result := Add(cMANAGE_WIFI_INTERFACES); end;

function TAndroidPermissions.MANAGE_WIFI_NETWORK_SELECTION: iAndroidPermissions;
begin Result := Add(cMANAGE_WIFI_NETWORK_SELECTION); end;

function TAndroidPermissions.MASTER_CLEAR: iAndroidPermissions;
begin Result := Add(cMASTER_CLEAR); end;

function TAndroidPermissions.MEDIA_CONTENT_CONTROL: iAndroidPermissions;
begin Result := Add(cMEDIA_CONTENT_CONTROL); end;

function TAndroidPermissions.MODIFY_AUDIO_SETTINGS: iAndroidPermissions;
begin Result := Add(cMODIFY_AUDIO_SETTINGS); end;

function TAndroidPermissions.MODIFY_PHONE_STATE: iAndroidPermissions;
begin Result := Add(cMODIFY_PHONE_STATE); end;

function TAndroidPermissions.MOUNT_FORMAT_FILESYSTEMS: iAndroidPermissions;
begin Result := Add(cMOUNT_FORMAT_FILESYSTEMS); end;

function TAndroidPermissions.MOUNT_UNMOUNT_FILESYSTEMS: iAndroidPermissions;
begin Result := Add(cMOUNT_UNMOUNT_FILESYSTEMS); end;

function TAndroidPermissions.NEARBY_WIFI_DEVICES: iAndroidPermissions;
begin Result := Add(cNEARBY_WIFI_DEVICES); end;

function TAndroidPermissions.NFC: iAndroidPermissions;
begin Result := Add(cNFC); end;

function TAndroidPermissions.NFC_PREFERRED_PAYMENT_INFO: iAndroidPermissions;
begin Result := Add(cNFC_PREFERRED_PAYMENT_INFO); end;

function TAndroidPermissions.NFC_TRANSACTION_EVENT: iAndroidPermissions;
begin Result := Add(cNFC_TRANSACTION_EVENT); end;

function TAndroidPermissions.OVERRIDE_WIFI_CONFIG: iAndroidPermissions;
begin Result := Add(cOVERRIDE_WIFI_CONFIG); end;

function TAndroidPermissions.PACKAGE_USAGE_STATS: iAndroidPermissions;
begin Result := Add(cPACKAGE_USAGE_STATS); end;

function TAndroidPermissions.PERSISTENT_ACTIVITY: iAndroidPermissions;
begin Result := Add(cPERSISTENT_ACTIVITY); end;

function TAndroidPermissions.POST_NOTIFICATIONS: iAndroidPermissions;
begin Result := Add(cPOST_NOTIFICATIONS); end;

function TAndroidPermissions.PROCESS_OUTGOING_CALLS: iAndroidPermissions;
begin Result := Add(cPROCESS_OUTGOING_CALLS); end;

function TAndroidPermissions.QUERY_ALL_PACKAGES: iAndroidPermissions;
begin Result := Add(cQUERY_ALL_PACKAGES); end;

function TAndroidPermissions.READ_ASSISTANT_APP_SEARCH_DATA: iAndroidPermissions;
begin Result := Add(cREAD_ASSISTANT_APP_SEARCH_DATA); end;

function TAndroidPermissions.READ_BASIC_PHONE_STATE: iAndroidPermissions;
begin Result := Add(cREAD_BASIC_PHONE_STATE); end;

function TAndroidPermissions.READ_CALENDAR: iAndroidPermissions;
begin Result := Add(cREAD_CALENDAR); end;

function TAndroidPermissions.READ_CALL_LOG: iAndroidPermissions;
begin Result := Add(cREAD_CALL_LOG); end;

function TAndroidPermissions.READ_CONTACTS: iAndroidPermissions;
begin Result := Add(cREAD_CONTACTS); end;

function TAndroidPermissions.READ_EXTERNAL_STORAGE: iAndroidPermissions;
begin Result := Add(cREAD_EXTERNAL_STORAGE); end;

function TAndroidPermissions.READ_HOME_APP_SEARCH_DATA: iAndroidPermissions;
begin Result := Add(cREAD_HOME_APP_SEARCH_DATA); end;

function TAndroidPermissions.READ_INPUT_STATE: iAndroidPermissions;
begin Result := Add(cREAD_INPUT_STATE); end;

function TAndroidPermissions.READ_LOGS: iAndroidPermissions;
begin Result := Add(cREAD_LOGS); end;

function TAndroidPermissions.READ_MEDIA_AUDIO: iAndroidPermissions;
begin Result := Add(cREAD_MEDIA_AUDIO); end;

function TAndroidPermissions.READ_MEDIA_IMAGES: iAndroidPermissions;
begin Result := Add(cREAD_MEDIA_IMAGES); end;

function TAndroidPermissions.READ_MEDIA_VIDEO: iAndroidPermissions;
begin Result := Add(cREAD_MEDIA_VIDEO); end;

function TAndroidPermissions.READ_NEARBY_STREAMING_POLICY: iAndroidPermissions;
begin Result := Add(cREAD_NEARBY_STREAMING_POLICY); end;

function TAndroidPermissions.READ_PHONE_NUMBERS: iAndroidPermissions;
begin Result := Add(cREAD_PHONE_NUMBERS); end;

function TAndroidPermissions.READ_PHONE_STATE: iAndroidPermissions;
begin Result := Add(cREAD_PHONE_STATE); end;

function TAndroidPermissions.READ_PRECISE_PHONE_STATE: iAndroidPermissions;
begin Result := Add(cREAD_PRECISE_PHONE_STATE); end;

function TAndroidPermissions.READ_SMS: iAndroidPermissions;
begin Result := Add(cREAD_SMS); end;

function TAndroidPermissions.READ_SYNC_SETTINGS: iAndroidPermissions;
begin Result := Add(cREAD_SYNC_SETTINGS); end;

function TAndroidPermissions.READ_SYNC_STATS: iAndroidPermissions;
begin Result := Add(cREAD_SYNC_STATS); end;

function TAndroidPermissions.READ_VOICEMAIL: iAndroidPermissions;
begin Result := Add(cREAD_VOICEMAIL); end;

function TAndroidPermissions.REBOOT: iAndroidPermissions;
begin Result := Add(cREBOOT); end;

function TAndroidPermissions.RECEIVE_BOOT_COMPLETED: iAndroidPermissions;
begin Result := Add(cRECEIVE_BOOT_COMPLETED); end;

function TAndroidPermissions.RECEIVE_MMS: iAndroidPermissions;
begin Result := Add(cRECEIVE_MMS); end;

function TAndroidPermissions.RECEIVE_SMS: iAndroidPermissions;
begin Result := Add(cRECEIVE_SMS); end;

function TAndroidPermissions.RECEIVE_WAP_PUSH: iAndroidPermissions;
begin Result := Add(cRECEIVE_WAP_PUSH); end;

function TAndroidPermissions.RECORD_AUDIO: iAndroidPermissions;
begin Result := Add(cRECORD_AUDIO); end;

function TAndroidPermissions.REORDER_TASKS: iAndroidPermissions;
begin Result := Add(cREORDER_TASKS); end;

function TAndroidPermissions.REQUEST_COMPANION_PROFILE_APP_STREAMING: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_PROFILE_APP_STREAMING); end;

function TAndroidPermissions.REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION); end;

function TAndroidPermissions.REQUEST_COMPANION_PROFILE_COMPUTER: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_PROFILE_COMPUTER); end;

function TAndroidPermissions.REQUEST_COMPANION_PROFILE_WATCH: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_PROFILE_WATCH); end;

function TAndroidPermissions.REQUEST_COMPANION_RUN_IN_BACKGROUND: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_RUN_IN_BACKGROUND); end;

function TAndroidPermissions.REQUEST_COMPANION_SELF_MANAGED: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_SELF_MANAGED); end;

function TAndroidPermissions.REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND); end;

function TAndroidPermissions.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND: iAndroidPermissions;
begin Result := Add(cREQUEST_COMPANION_USE_DATA_IN_BACKGROUND); end;

function TAndroidPermissions.REQUEST_DELETE_PACKAGES: iAndroidPermissions;
begin Result := Add(cREQUEST_DELETE_PACKAGES); end;

function TAndroidPermissions.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS: iAndroidPermissions;
begin Result := Add(cREQUEST_IGNORE_BATTERY_OPTIMIZATIONS); end;

function TAndroidPermissions.REQUEST_INSTALL_PACKAGES: iAndroidPermissions;
begin Result := Add(cREQUEST_INSTALL_PACKAGES); end;

function TAndroidPermissions.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE: iAndroidPermissions;
begin Result := Add(cREQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE); end;

function TAndroidPermissions.REQUEST_PASSWORD_COMPLEXITY: iAndroidPermissions;
begin Result := Add(cREQUEST_PASSWORD_COMPLEXITY); end;

function TAndroidPermissions.RESTART_PACKAGES: iAndroidPermissions;
begin Result := Add(cRESTART_PACKAGES); end;

function TAndroidPermissions.SCHEDULE_EXACT_ALARM: iAndroidPermissions;
begin Result := Add(cSCHEDULE_EXACT_ALARM); end;

function TAndroidPermissions.SEND_RESPOND_VIA_MESSAGE: iAndroidPermissions;
begin Result := Add(cSEND_RESPOND_VIA_MESSAGE); end;

function TAndroidPermissions.SEND_SMS: iAndroidPermissions;
begin Result := Add(cSEND_SMS); end;

function TAndroidPermissions.SET_ALARM: iAndroidPermissions;
begin Result := Add(cSET_ALARM); end;

function TAndroidPermissions.SET_ALWAYS_FINISH: iAndroidPermissions;
begin Result := Add(cSET_ALWAYS_FINISH); end;

function TAndroidPermissions.SET_ALWAYS_FINISH_HINTS: iAndroidPermissions;
begin Result := Add(cSET_ALWAYS_FINISH_HINTS); end; // Duplicate safety

function TAndroidPermissions.SET_ANIMATION_SCALE: iAndroidPermissions;
begin Result := Add(cSET_ANIMATION_SCALE); end;

function TAndroidPermissions.SET_DEBUG_APP: iAndroidPermissions;
begin Result := Add(cSET_DEBUG_APP); end;

function TAndroidPermissions.SET_PREFERRED_APPLICATIONS: iAndroidPermissions;
begin Result := Add(cSET_PREFERRED_APPLICATIONS); end;

function TAndroidPermissions.SET_PROCESS_LIMIT: iAndroidPermissions;
begin Result := Add(cSET_PROCESS_LIMIT); end;

function TAndroidPermissions.SET_TIME: iAndroidPermissions;
begin Result := Add(cSET_TIME); end;

function TAndroidPermissions.SET_TIME_ZONE: iAndroidPermissions;
begin Result := Add(cSET_TIME_ZONE); end;

function TAndroidPermissions.SET_WALLPAPER: iAndroidPermissions;
begin Result := Add(cSET_WALLPAPER); end;

function TAndroidPermissions.SET_WALLPAPER_HINTS: iAndroidPermissions;
begin Result := Add(cSET_WALLPAPER_HINTS); end;

function TAndroidPermissions.SIGNAL_PERSISTENT_PROCESSES: iAndroidPermissions;
begin Result := Add(cSIGNAL_PERSISTENT_PROCESSES); end;

function TAndroidPermissions.SMS_FINANCIAL_TRANSACTIONS: iAndroidPermissions;
begin Result := Add(cSMS_FINANCIAL_TRANSACTIONS); end;

function TAndroidPermissions.START_FOREGROUND_SERVICES_FROM_BACKGROUND: iAndroidPermissions;
begin Result := Add(cSTART_FOREGROUND_SERVICES_FROM_BACKGROUND); end;

function TAndroidPermissions.START_VIEW_APP_FEATURES: iAndroidPermissions;
begin Result := Add(cSTART_VIEW_APP_FEATURES); end;

function TAndroidPermissions.START_VIEW_PERMISSION_USAGE: iAndroidPermissions;
begin Result := Add(cSTART_VIEW_PERMISSION_USAGE); end;

function TAndroidPermissions.STATUS_BAR: iAndroidPermissions;
begin Result := Add(cSTATUS_BAR); end;

function TAndroidPermissions.SUBSCRIBE_TO_KEYGUARD_LOCKED_STATE: iAndroidPermissions;
begin Result := Add(cSUBSCRIBE_TO_KEYGUARD_LOCKED_STATE); end;

function TAndroidPermissions.SYSTEM_ALERT_WINDOW: iAndroidPermissions;
begin Result := Add(cSYSTEM_ALERT_WINDOW); end;

function TAndroidPermissions.TRANSMIT_IR: iAndroidPermissions;
begin Result := Add(cTRANSMIT_IR); end;

function TAndroidPermissions.UNINSTALL_SHORTCUT: iAndroidPermissions;
begin Result := Add(cUNINSTALL_SHORTCUT); end;

function TAndroidPermissions.UPDATE_DEVICE_STATS: iAndroidPermissions;
begin Result := Add(cUPDATE_DEVICE_STATS); end;

function TAndroidPermissions.UPDATE_PACKAGES_WITHOUT_USER_ACTION: iAndroidPermissions;
begin Result := Add(cUPDATE_PACKAGES_WITHOUT_USER_ACTION); end;

function TAndroidPermissions.USE_BIOMETRIC: iAndroidPermissions;
begin Result := Add(cUSE_BIOMETRIC); end;

function TAndroidPermissions.USE_EXACT_ALARM: iAndroidPermissions;
begin Result := Add(cUSE_EXACT_ALARM); end;

function TAndroidPermissions.USE_FINGERPRINT: iAndroidPermissions;
begin Result := Add(cUSE_FINGERPRINT); end;

function TAndroidPermissions.USE_FULL_SCREEN_INTENT: iAndroidPermissions;
begin Result := Add(cUSE_FULL_SCREEN_INTENT); end;

function TAndroidPermissions.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER: iAndroidPermissions;
begin Result := Add(cUSE_ICC_AUTH_WITH_DEVICE_IDENTIFIER); end;

function TAndroidPermissions.USE_SIP: iAndroidPermissions;
begin Result := Add(cUSE_SIP); end;

function TAndroidPermissions.UWB_RANGING: iAndroidPermissions;
begin Result := Add(cUWB_RANGING); end;

function TAndroidPermissions.VIBRATE: iAndroidPermissions;
begin Result := Add(cVIBRATE); end;

function TAndroidPermissions.WAKE_LOCK: iAndroidPermissions;
begin Result := Add(cWAKE_LOCK); end;

function TAndroidPermissions.WRITE_APN_SETTINGS: iAndroidPermissions;
begin Result := Add(cWRITE_APN_SETTINGS); end;

function TAndroidPermissions.WRITE_CALENDAR: iAndroidPermissions;
begin Result := Add(cWRITE_CALENDAR); end;

function TAndroidPermissions.WRITE_CALL_LOG: iAndroidPermissions;
begin Result := Add(cWRITE_CALL_LOG); end;

function TAndroidPermissions.WRITE_CONTACTS: iAndroidPermissions;
begin Result := Add(cWRITE_CONTACTS); end;

function TAndroidPermissions.WRITE_EXTERNAL_STORAGE: iAndroidPermissions;
begin Result := Add(cWRITE_EXTERNAL_STORAGE); end;

function TAndroidPermissions.WRITE_GSERVICES: iAndroidPermissions;
begin Result := Add(cWRITE_GSERVICES); end;

function TAndroidPermissions.WRITE_SECURE_SETTINGS: iAndroidPermissions;
begin Result := Add(cWRITE_SECURE_SETTINGS); end;

function TAndroidPermissions.WRITE_SETTINGS: iAndroidPermissions;
begin Result := Add(cWRITE_SETTINGS); end;

function TAndroidPermissions.WRITE_SYNC_SETTINGS: iAndroidPermissions;
begin Result := Add(cWRITE_SYNC_SETTINGS); end;

function TAndroidPermissions.WRITE_VOICEMAIL: iAndroidPermissions;
begin Result := Add(cWRITE_VOICEMAIL); end;
{$ENDREGION}

end.
