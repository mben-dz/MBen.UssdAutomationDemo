unit API.USSD.Service;

interface

uses
  System.SysUtils, System.Classes,
//
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
//
  Model.Database,
  API.JNI.UssdBridge;

type
  TUSSDService = class
  private
    FJUssdBridge: JUssdBridge;
    FJUssdListener: TUssdListenerImpl;
    FJLogger: TDelphiLoggerImpl;

    FOnLogUssdReply: TProcLogger;
    FOnLog: TProcLogger;
    procedure HandleSuccess(const aResponse: string);
    procedure HandleFailure(const aError: string);
    procedure HandleJLogger(const aLogMsg: string);
  public
    constructor Create;
    destructor Destroy; override;

    property OnLogUssdReply: TProcLogger read FOnLogUssdReply write FOnLogUssdReply;
    property OnLog: TProcLogger read FOnLog write FOnLog;

    procedure SendRequest(const aCode: string; aSimSlot: Integer);
  end;

implementation

{ TUSSDService }

constructor TUSSDService.Create;
begin
  inherited;

  // Initialize the Java UssdListener Interface..
  FJUssdListener := TUssdListenerImpl.Create(
    HandleSuccess,
    HandleFailure
  );

  // Initialize the Java DelphiLogger Interface..
  FJLogger := TDelphiLoggerImpl.Create(HandleJLogger);

  try
    FJUssdBridge := TJUssdBridge.JavaClass.init(TAndroidHelper.Context);
    FJUssdBridge.setListener(FJUssdListener);
    FJUssdBridge.setDelphiLogger(FJLogger);
  except
    on E: Exception do
      if Assigned(FOnLog) then FOnLog('Error initializing Java Bridge: ' + E.Message);
  end;

end;

destructor TUSSDService.Destroy;
begin
  // FJListener & FJLogger they are managed by Java GC usually, but we can nil references
  FJUssdBridge := nil;

  inherited;
end;

procedure TUSSDService.SendRequest(const aCode: string; aSimSlot: Integer);
begin
  if Assigned(FOnLogUssdReply) then FOnLogUssdReply('Sending: ' + aCode + ' (Slot ' + aSimSlot.ToString + ')');

  if FJUssdBridge <> nil then
  begin
    FJUssdBridge.sendUssdRequest(StringToJString(aCode), aSimSlot);
  end
  else
  begin
    if Assigned(FOnLog) then FOnLog('Java UssdBridge not initialized !!');
  end;
end;

procedure TUSSDService.HandleSuccess(const aResponse: string);
begin
  if Assigned(FOnLogUssdReply) then FOnLogUssdReply('SUCCESS: ' + aResponse);
  
  // Log to Database
  dmDatabase.LogTransaction('USSD', aResponse, 'SUCCESS');
end;

procedure TUSSDService.HandleFailure(const aError: string);
begin
  if Assigned(FOnLogUssdReply) then FOnLogUssdReply('FAILURE: ' + aError);
  
  // Log to Database
  dmDatabase.LogTransaction('USSD', aError, 'FAILURE');
end;

procedure TUSSDService.HandleJLogger(const aLogMsg: string);
begin
  if Assigned(FOnLog) then FOnLog('JavaLog: ' + aLogMsg);
end;

end.