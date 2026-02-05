unit API.Android.Permissions.Interfaces;

interface

uses
  System.SysUtils, System.Types;

type
  /// <summary>
  ///   Procedure for detailed permission results.
  /// </summary>
  TPermissionResultProc = TProc<Boolean, TArray<string>, TArray<string>>;

  TcProc<T> = reference to procedure (const aArg: T);

  /// <summary>
  ///   Procedure for internal logging.
  /// </summary>
  TLoggerProc = TcProc<string>;

  /// <summary>
  ///   Defines the contract for building Android permissions fluently.
  /// </summary>
  iAndroidPermissions = interface ['{02A3C260-8637-4698-8666-845B860E20EB}']

    /// <summary>
    ///   Sets a logger to receive internal status updates.
    /// </summary>
    function SetLogger(const aLogger: TLoggerProc): iAndroidPermissions;

    {$REGION ' Permission Methods from Delphi-12.3.3 .. '}
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
    function SET_ALWAYS_FINISH_HINTS: iAndroidPermissions; // Placeholder logic
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

    /// <summary>
    ///   Dynamically add a permission by its full Android permission name.
    ///   This method provides flexibility to add runtime-determined permissions
    ///   or support for newer Android permissions not yet hardcoded in the library.
    ///   Example: AddPermission('android.permission.READ_MEDIA_IMAGES')
    /// </summary>
    function AddPermission(const aPermission: string): iAndroidPermissions;

    /// <summary>
    ///   Add multiple permissions at once.
    /// </summary>
    function AddPermissions(const aPermissions: TArray<string>): iAndroidPermissions;

    /// <summary>
    ///   Get array of all added permissions.
    /// </summary>
    function ToArray: TArray<string>;

    /// <summary>
    ///   Get all currently granted permissions.
    /// </summary>
    function GetGrantedPermissions: TArray<string>;

    /// <summary>
    ///   Get all currently denied permissions.
    /// </summary>
    function GetDeniedPermissions: TArray<string>;

    /// <summary>
    ///   Get permissions not declared in manifest.
    /// </summary>
    function GetNotInManifestPermissions: TArray<string>;

    /// <summary>
    ///   Checks which permissions are already granted or
    ///   are not exist in THE ANDROID RUN-TIME MANIFEST
    ///   , logs them, and only requests the rest.
    /// </summary>
    function CheckAndRequest(const aOnResult: TPermissionResultProc = nil): iAndroidPermissions;

  end;

{$REGION ' Permissions Consts from Delphi-12.3.3 Verssion .. '}
const
  cACCEPT_HANDOVER = 'android.permission.ACCEPT_HANDOVER';
  cACCESS_BACKGROUND_LOCATION = 'android.permission.ACCESS_BACKGROUND_LOCATION';
  cACCESS_BLOBS_ACROSS_USERS = 'android.permission.ACCESS_BLOBS_ACROSS_USERS';
  cACCESS_CHECKIN_PROPERTIES = 'android.permission.ACCESS_CHECKIN_PROPERTIES';
  cACCESS_COARSE_LOCATION = 'android.permission.ACCESS_COARSE_LOCATION';
  cACCESS_FINE_LOCATION = 'android.permission.ACCESS_FINE_LOCATION';
  cACCESS_LOCATION_EXTRA_COMMANDS = 'android.permission.ACCESS_LOCATION_EXTRA_COMMANDS';
  cACCESS_MEDIA_LOCATION = 'android.permission.ACCESS_MEDIA_LOCATION';
  cACCESS_NETWORK_STATE = 'android.permission.ACCESS_NETWORK_STATE';
  cACCESS_NOTIFICATION_POLICY = 'android.permission.ACCESS_NOTIFICATION_POLICY';
  cACCESS_WIFI_STATE = 'android.permission.ACCESS_WIFI_STATE';
  cACCOUNT_MANAGER = 'android.permission.ACCOUNT_MANAGER';
  cACTIVITY_RECOGNITION = 'android.permission.ACTIVITY_RECOGNITION';
  cADD_VOICEMAIL = 'android.permission.ADD_VOICEMAIL';
  cANSWER_PHONE_CALLS = 'android.permission.ANSWER_PHONE_CALLS';
  cBATTERY_STATS = 'android.permission.BATTERY_STATS';
  cBIND_ACCESSIBILITY_SERVICE = 'android.permission.BIND_ACCESSIBILITY_SERVICE';
  cBIND_APPWIDGET = 'android.permission.BIND_APPWIDGET';
  cBIND_AUTOFILL_SERVICE = 'android.permission.BIND_AUTOFILL_SERVICE';
  cBIND_CALL_REDIRECTION_SERVICE = 'android.permission.BIND_CALL_REDIRECTION_SERVICE';
  cBIND_CARRIER_MESSAGING_CLIENT_SERVICE = 'android.permission.BIND_CARRIER_MESSAGING_CLIENT_SERVICE';
  cBIND_CARRIER_MESSAGING_SERVICE = 'android.permission.BIND_CARRIER_MESSAGING_SERVICE';
  cBIND_CARRIER_SERVICES = 'android.permission.BIND_CARRIER_SERVICES';
  cBIND_CHOOSER_TARGET_SERVICE = 'android.permission.BIND_CHOOSER_TARGET_SERVICE';
  cBIND_COMPANION_DEVICE_SERVICE = 'android.permission.BIND_COMPANION_DEVICE_SERVICE';
  cBIND_CONDITION_PROVIDER_SERVICE = 'android.permission.BIND_CONDITION_PROVIDER_SERVICE';
  cBIND_CONTROLS = 'android.permission.BIND_CONTROLS';
  cBIND_DEVICE_ADMIN = 'android.permission.BIND_DEVICE_ADMIN';
  cBIND_DREAM_SERVICE = 'android.permission.BIND_DREAM_SERVICE';
  cBIND_INCALL_SERVICE = 'android.permission.BIND_INCALL_SERVICE';
  cBIND_INPUT_METHOD = 'android.permission.BIND_INPUT_METHOD';
  cBIND_MIDI_DEVICE_SERVICE = 'android.permission.BIND_MIDI_DEVICE_SERVICE';
  cBIND_NFC_SERVICE = 'android.permission.BIND_NFC_SERVICE';
  cBIND_NOTIFICATION_LISTENER_SERVICE = 'android.permission.BIND_NOTIFICATION_LISTENER_SERVICE';
  cBIND_PRINT_SERVICE = 'android.permission.BIND_PRINT_SERVICE';
  cBIND_QUICK_ACCESS_WALLET_SERVICE = 'android.permission.BIND_QUICK_ACCESS_WALLET_SERVICE';
  cBIND_QUICK_SETTINGS_TILE = 'android.permission.BIND_QUICK_SETTINGS_TILE';
  cBIND_REMOTEVIEWS = 'android.permission.BIND_REMOTEVIEWS';
  cBIND_SCREENING_SERVICE = 'android.permission.BIND_SCREENING_SERVICE';
  cBIND_TELECOM_CONNECTION_SERVICE = 'android.permission.BIND_TELECOM_CONNECTION_SERVICE';
  cBIND_TEXT_SERVICE = 'android.permission.BIND_TEXT_SERVICE';
  cBIND_TV_INPUT = 'android.permission.BIND_TV_INPUT';
  cBIND_TV_INTERACTIVE_APP = 'android.permission.BIND_TV_INTERACTIVE_APP';
  cBIND_VISUAL_VOICEMAIL_SERVICE = 'android.permission.BIND_VISUAL_VOICEMAIL_SERVICE';
  cBIND_VOICE_INTERACTION = 'android.permission.BIND_VOICE_INTERACTION';
  cBIND_VPN_SERVICE = 'android.permission.BIND_VPN_SERVICE';
  cBIND_VR_LISTENER_SERVICE = 'android.permission.BIND_VR_LISTENER_SERVICE';
  cBIND_WALLPAPER = 'android.permission.BIND_WALLPAPER';
  cBLUETOOTH = 'android.permission.BLUETOOTH';
  cBLUETOOTH_ADMIN = 'android.permission.BLUETOOTH_ADMIN';
  cBLUETOOTH_ADVERTISE = 'android.permission.BLUETOOTH_ADVERTISE';
  cBLUETOOTH_CONNECT = 'android.permission.BLUETOOTH_CONNECT';
  cBLUETOOTH_PRIVILEGED = 'android.permission.BLUETOOTH_PRIVILEGED';
  cBLUETOOTH_SCAN = 'android.permission.BLUETOOTH_SCAN';
  cBODY_SENSORS = 'android.permission.BODY_SENSORS';
  cBODY_SENSORS_BACKGROUND = 'android.permission.BODY_SENSORS_BACKGROUND';
  cBROADCAST_PACKAGE_REMOVED = 'android.permission.BROADCAST_PACKAGE_REMOVED';
  cBROADCAST_SMS = 'android.permission.BROADCAST_SMS';
  cBROADCAST_STICKY = 'android.permission.BROADCAST_STICKY';
  cBROADCAST_WAP_PUSH = 'android.permission.BROADCAST_WAP_PUSH';
  cCALL_COMPANION_APP = 'android.permission.CALL_COMPANION_APP';
  cCALL_PHONE = 'android.permission.CALL_PHONE';
  cCALL_PRIVILEGED = 'android.permission.CALL_PRIVILEGED';
  cCAMERA = 'android.permission.CAMERA';
  cCAPTURE_AUDIO_OUTPUT = 'android.permission.CAPTURE_AUDIO_OUTPUT';
  cCHANGE_COMPONENT_ENABLED_STATE = 'android.permission.CHANGE_COMPONENT_ENABLED_STATE';
  cCHANGE_CONFIGURATION = 'android.permission.CHANGE_CONFIGURATION';
  cCHANGE_NETWORK_STATE = 'android.permission.CHANGE_NETWORK_STATE';
  cCHANGE_WIFI_MULTICAST_STATE = 'android.permission.CHANGE_WIFI_MULTICAST_STATE';
  cCHANGE_WIFI_STATE = 'android.permission.CHANGE_WIFI_STATE';
  cCLEAR_APP_CACHE = 'android.permission.CLEAR_APP_CACHE';
  cCONTROL_LOCATION_UPDATES = 'android.permission.CONTROL_LOCATION_UPDATES';
  cDELETE_CACHE_FILES = 'android.permission.DELETE_CACHE_FILES';
  cDELETE_PACKAGES = 'android.permission.DELETE_PACKAGES';
  cDELIVER_COMPANION_MESSAGES = 'android.permission.DELIVER_COMPANION_MESSAGES';
  cDIAGNOSTIC = 'android.permission.DIAGNOSTIC';
  cDISABLE_KEYGUARD = 'android.permission.DISABLE_KEYGUARD';
  cDUMP = 'android.permission.DUMP';
  cEXPAND_STATUS_BAR = 'android.permission.EXPAND_STATUS_BAR';
  cFACTORY_TEST = 'android.permission.FACTORY_TEST';
  cFOREGROUND_SERVICE = 'android.permission.FOREGROUND_SERVICE';
  cGET_ACCOUNTS = 'android.permission.GET_ACCOUNTS';
  cGET_ACCOUNTS_PRIVILEGED = 'android.permission.GET_ACCOUNTS_PRIVILEGED';
  cGET_PACKAGE_SIZE = 'android.permission.GET_PACKAGE_SIZE';
  cGET_TASKS = 'android.permission.GET_TASKS';
  cGLOBAL_SEARCH = 'android.permission.GLOBAL_SEARCH';
  cHIDE_OVERLAY_WINDOWS = 'android.permission.HIDE_OVERLAY_WINDOWS';
  cHIGH_SAMPLING_RATE_SENSORS = 'android.permission.HIGH_SAMPLING_RATE_SENSORS';
  cINSTALL_LOCATION_PROVIDER = 'android.permission.INSTALL_LOCATION_PROVIDER';
  cINSTALL_PACKAGES = 'android.permission.INSTALL_PACKAGES';
  cINSTALL_SHORTCUT = 'android.permission.INSTALL_SHORTCUT';
  cINSTANT_APP_FOREGROUND_SERVICE = 'android.permission.INSTANT_APP_FOREGROUND_SERVICE';
  cINTERACT_ACROSS_PROFILES = 'android.permission.INTERACT_ACROSS_PROFILES';
  cINTERNET = 'android.permission.INTERNET';
  cKILL_BACKGROUND_PROCESSES = 'android.permission.KILL_BACKGROUND_PROCESSES';
  cLAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK = 'android.permission.LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK';
  cLOADER_USAGE_STATS = 'android.permission.LOADER_USAGE_STATS';
  cLOCATION_HARDWARE = 'android.permission.LOCATION_HARDWARE';
  cMANAGE_DOCUMENTS = 'android.permission.MANAGE_DOCUMENTS';
  cMANAGE_EXTERNAL_STORAGE = 'android.permission.MANAGE_EXTERNAL_STORAGE';
  cMANAGE_MEDIA = 'android.permission.MANAGE_MEDIA';
  cMANAGE_ONGOING_CALLS = 'android.permission.MANAGE_ONGOING_CALLS';
  cMANAGE_OWN_CALLS = 'android.permission.MANAGE_OWN_CALLS';
  cMANAGE_WIFI_INTERFACES = 'android.permission.MANAGE_WIFI_INTERFACES';
  cMANAGE_WIFI_NETWORK_SELECTION = 'android.permission.MANAGE_WIFI_NETWORK_SELECTION';
  cMASTER_CLEAR = 'android.permission.MASTER_CLEAR';
  cMEDIA_CONTENT_CONTROL = 'android.permission.MEDIA_CONTENT_CONTROL';
  cMODIFY_AUDIO_SETTINGS = 'android.permission.MODIFY_AUDIO_SETTINGS';
  cMODIFY_PHONE_STATE = 'android.permission.MODIFY_PHONE_STATE';
  cMOUNT_FORMAT_FILESYSTEMS = 'android.permission.MOUNT_FORMAT_FILESYSTEMS';
  cMOUNT_UNMOUNT_FILESYSTEMS = 'android.permission.MOUNT_UNMOUNT_FILESYSTEMS';
  cNEARBY_WIFI_DEVICES = 'android.permission.NEARBY_WIFI_DEVICES';
  cNFC = 'android.permission.NFC';
  cNFC_PREFERRED_PAYMENT_INFO = 'android.permission.NFC_PREFERRED_PAYMENT_INFO';
  cNFC_TRANSACTION_EVENT = 'android.permission.NFC_TRANSACTION_EVENT';
  cOVERRIDE_WIFI_CONFIG = 'android.permission.OVERRIDE_WIFI_CONFIG';
  cPACKAGE_USAGE_STATS = 'android.permission.PACKAGE_USAGE_STATS';
  cPERSISTENT_ACTIVITY = 'android.permission.PERSISTENT_ACTIVITY';
  cPOST_NOTIFICATIONS = 'android.permission.POST_NOTIFICATIONS';
  cPROCESS_OUTGOING_CALLS = 'android.permission.PROCESS_OUTGOING_CALLS';
  cQUERY_ALL_PACKAGES = 'android.permission.QUERY_ALL_PACKAGES';
  cREAD_ASSISTANT_APP_SEARCH_DATA = 'android.permission.READ_ASSISTANT_APP_SEARCH_DATA';
  cREAD_BASIC_PHONE_STATE = 'android.permission.READ_BASIC_PHONE_STATE';
  cREAD_CALENDAR = 'android.permission.READ_CALENDAR';
  cREAD_CALL_LOG = 'android.permission.READ_CALL_LOG';
  cREAD_CONTACTS = 'android.permission.READ_CONTACTS';
  cREAD_EXTERNAL_STORAGE = 'android.permission.READ_EXTERNAL_STORAGE';
  cREAD_HOME_APP_SEARCH_DATA = 'android.permission.READ_HOME_APP_SEARCH_DATA';
  cREAD_INPUT_STATE = 'android.permission.READ_INPUT_STATE';
  cREAD_LOGS = 'android.permission.READ_LOGS';
  cREAD_MEDIA_AUDIO = 'android.permission.READ_MEDIA_AUDIO';
  cREAD_MEDIA_IMAGES = 'android.permission.READ_MEDIA_IMAGES';
  cREAD_MEDIA_VIDEO = 'android.permission.READ_MEDIA_VIDEO';
  cREAD_NEARBY_STREAMING_POLICY = 'android.permission.READ_NEARBY_STREAMING_POLICY';
  cREAD_PHONE_NUMBERS = 'android.permission.READ_PHONE_NUMBERS';
  cREAD_PHONE_STATE = 'android.permission.READ_PHONE_STATE';
  cREAD_PRECISE_PHONE_STATE = 'android.permission.READ_PRECISE_PHONE_STATE';
  cREAD_SMS = 'android.permission.READ_SMS';
  cREAD_SYNC_SETTINGS = 'android.permission.READ_SYNC_SETTINGS';
  cREAD_SYNC_STATS = 'android.permission.READ_SYNC_STATS';
  cREAD_VOICEMAIL = 'android.permission.READ_VOICEMAIL';
  cREBOOT = 'android.permission.REBOOT';
  cRECEIVE_BOOT_COMPLETED = 'android.permission.RECEIVE_BOOT_COMPLETED';
  cRECEIVE_MMS = 'android.permission.RECEIVE_MMS';
  cRECEIVE_SMS = 'android.permission.RECEIVE_SMS';
  cRECEIVE_WAP_PUSH = 'android.permission.RECEIVE_WAP_PUSH';
  cRECORD_AUDIO = 'android.permission.RECORD_AUDIO';
  cREORDER_TASKS = 'android.permission.REORDER_TASKS';
  cREQUEST_COMPANION_PROFILE_APP_STREAMING = 'android.permission.REQUEST_COMPANION_PROFILE_APP_STREAMING';
  cREQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION = 'android.permission.REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION';
  cREQUEST_COMPANION_PROFILE_COMPUTER = 'android.permission.REQUEST_COMPANION_PROFILE_COMPUTER';
  cREQUEST_COMPANION_PROFILE_WATCH = 'android.permission.REQUEST_COMPANION_PROFILE_WATCH';
  cREQUEST_COMPANION_RUN_IN_BACKGROUND = 'android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND';
  cREQUEST_COMPANION_SELF_MANAGED = 'android.permission.REQUEST_COMPANION_SELF_MANAGED';
  cREQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND = 'android.permission.REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND';
  cREQUEST_COMPANION_USE_DATA_IN_BACKGROUND = 'android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND';
  cREQUEST_DELETE_PACKAGES = 'android.permission.REQUEST_DELETE_PACKAGES';
  cREQUEST_IGNORE_BATTERY_OPTIMIZATIONS = 'android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS';
  cREQUEST_INSTALL_PACKAGES = 'android.permission.REQUEST_INSTALL_PACKAGES';
  cREQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE = 'android.permission.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE';
  cREQUEST_PASSWORD_COMPLEXITY = 'android.permission.REQUEST_PASSWORD_COMPLEXITY';
  cRESTART_PACKAGES = 'android.permission.RESTART_PACKAGES';
  cSCHEDULE_EXACT_ALARM = 'android.permission.SCHEDULE_EXACT_ALARM';
  cSEND_RESPOND_VIA_MESSAGE = 'android.permission.SEND_RESPOND_VIA_MESSAGE';
  cSEND_SMS = 'android.permission.SEND_SMS';
  cSET_ALARM = 'android.permission.SET_ALARM';
  cSET_ALWAYS_FINISH = 'android.permission.SET_ALWAYS_FINISH';
  cSET_ALWAYS_FINISH_HINTS = 'android.permission.SET_ALWAYS_FINISH_HINTS';
  cSET_ANIMATION_SCALE = 'android.permission.SET_ANIMATION_SCALE';
  cSET_DEBUG_APP = 'android.permission.SET_DEBUG_APP';
  cSET_PREFERRED_APPLICATIONS = 'android.permission.SET_PREFERRED_APPLICATIONS';
  cSET_PROCESS_LIMIT = 'android.permission.SET_PROCESS_LIMIT';
  cSET_TIME = 'android.permission.SET_TIME';
  cSET_TIME_ZONE = 'android.permission.SET_TIME_ZONE';
  cSET_WALLPAPER = 'android.permission.SET_WALLPAPER';
  cSET_WALLPAPER_HINTS = 'android.permission.SET_WALLPAPER_HINTS';
  cSIGNAL_PERSISTENT_PROCESSES = 'android.permission.SIGNAL_PERSISTENT_PROCESSES';
  cSMS_FINANCIAL_TRANSACTIONS = 'android.permission.SMS_FINANCIAL_TRANSACTIONS';
  cSTART_FOREGROUND_SERVICES_FROM_BACKGROUND = 'android.permission.START_FOREGROUND_SERVICES_FROM_BACKGROUND';
  cSTART_VIEW_APP_FEATURES = 'android.permission.START_VIEW_APP_FEATURES';
  cSTART_VIEW_PERMISSION_USAGE = 'android.permission.START_VIEW_PERMISSION_USAGE';
  cSTATUS_BAR = 'android.permission.STATUS_BAR';
  cSUBSCRIBE_TO_KEYGUARD_LOCKED_STATE = 'android.permission.SUBSCRIBE_TO_KEYGUARD_LOCKED_STATE';
  cSYSTEM_ALERT_WINDOW = 'android.permission.SYSTEM_ALERT_WINDOW';
  cTRANSMIT_IR = 'android.permission.TRANSMIT_IR';
  cUNINSTALL_SHORTCUT = 'android.permission.UNINSTALL_SHORTCUT';
  cUPDATE_DEVICE_STATS = 'android.permission.UPDATE_DEVICE_STATS';
  cUPDATE_PACKAGES_WITHOUT_USER_ACTION = 'android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION';
  cUSE_BIOMETRIC = 'android.permission.USE_BIOMETRIC';
  cUSE_EXACT_ALARM = 'android.permission.USE_EXACT_ALARM';
  cUSE_FINGERPRINT = 'android.permission.USE_FINGERPRINT';
  cUSE_FULL_SCREEN_INTENT = 'android.permission.USE_FULL_SCREEN_INTENT';
  cUSE_ICC_AUTH_WITH_DEVICE_IDENTIFIER = 'android.permission.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER';
  cUSE_SIP = 'android.permission.USE_SIP';
  cUWB_RANGING = 'android.permission.UWB_RANGING';
  cVIBRATE = 'android.permission.VIBRATE';
  cWAKE_LOCK = 'android.permission.WAKE_LOCK';
  cWRITE_APN_SETTINGS = 'android.permission.WRITE_APN_SETTINGS';
  cWRITE_CALENDAR = 'android.permission.WRITE_CALENDAR';
  cWRITE_CALL_LOG = 'android.permission.WRITE_CALL_LOG';
  cWRITE_CONTACTS = 'android.permission.WRITE_CONTACTS';
  cWRITE_EXTERNAL_STORAGE = 'android.permission.WRITE_EXTERNAL_STORAGE';
  cWRITE_GSERVICES = 'android.permission.WRITE_GSERVICES';
  cWRITE_SECURE_SETTINGS = 'android.permission.WRITE_SECURE_SETTINGS';
  cWRITE_SETTINGS = 'android.permission.WRITE_SETTINGS';
  cWRITE_SYNC_SETTINGS = 'android.permission.WRITE_SYNC_SETTINGS';
  cWRITE_VOICEMAIL = 'android.permission.WRITE_VOICEMAIL';

{$ENDREGION}

implementation

end.
