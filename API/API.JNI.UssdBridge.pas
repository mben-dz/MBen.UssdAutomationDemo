unit API.JNI.UssdBridge;

interface

uses
  System.SysUtils,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JUssdBridge = interface;//com.MBenDelphi.UssdAutomationDemo.UssdBridge
  //JUssdBridge_1 = interface;//com.MBenDelphi.UssdAutomationDemo.UssdBridge$1
  JUssdBridge_DelphiLogger = interface;//com.MBenDelphi.UssdAutomationDemo.UssdBridge$DelphiLogger
  JUssdBridge_UssdListener = interface;//com.MBenDelphi.UssdAutomationDemo.UssdBridge$UssdListener

// ===== Interface declarations =====

  JUssdBridgeClass = interface(JObjectClass)
    ['{7B38E369-04A4-4982-9058-9888C1956644}']
    {class} function init(aContext: JContext): JUssdBridge; cdecl;
  end;

  [JavaSignature('com/MBenDelphi/UssdAutomationDemo/UssdBridge')]
  JUssdBridge = interface(JObject)
    ['{02E991CE-5D17-4DB8-A1DE-9D7AF904142A}']
    procedure sendUssdRequest(aUssdCode: JString; aSimSlot: Integer); cdecl;
    procedure setDelphiLogger(aDelphiLogger: JUssdBridge_DelphiLogger); cdecl;
    procedure setListener(aUssdListener: JUssdBridge_UssdListener); cdecl;
  end;
  TJUssdBridge = class(TJavaGenericImport<JUssdBridgeClass, JUssdBridge>) end;

  // com.MBenDelphi.UssdAutomationDemo.UssdBridge$1
  JUssdBridge_DelphiLoggerClass = interface(IJavaClass)
    ['{16F95CF6-61F5-47FD-8AC8-9975C681B3DF}']
  end;

  [JavaSignature('com/MBenDelphi/UssdAutomationDemo/UssdBridge$DelphiLogger')]
  JUssdBridge_DelphiLogger = interface(IJavaInstance)
    ['{E60D5558-61D2-4DFE-86DE-CB4241D2F15E}']
    procedure logMessage(const aLogMsg: JString); cdecl;
  end;
  TJUssdBridge_DelphiLogger = class(TJavaGenericImport<JUssdBridge_DelphiLoggerClass, JUssdBridge_DelphiLogger>) end;

  JUssdBridge_UssdListenerClass = interface(IJavaClass)
    ['{91496C33-8DDC-491F-8B12-3FB592CB84A3}']
  end;

  [JavaSignature('com/MBenDelphi/UssdAutomationDemo/UssdBridge$UssdListener')]
  JUssdBridge_UssdListener = interface(IJavaInstance)
    ['{8BE59F09-4EBD-4A12-9EA4-C1A6A58EFA18}']
    procedure onFailure(aError: JString); cdecl;
    procedure onResponse(aResponse: JString); cdecl;
  end;
  TJUssdBridge_UssdListener = class(TJavaGenericImport<JUssdBridge_UssdListenerClass, JUssdBridge_UssdListener>) end;

  TProcLogger = reference to procedure (const aLogMsg: string);

  // Delphi Implementation of the JUssdListener
  TUssdListenerImpl = class(TJavaLocal, JUssdBridge_UssdListener)
  private
    FOnResponse: TProcLogger;
    FOnFailure: TProcLogger;
  public
    constructor Create(aOnResponse, aOnFailure: TProcLogger);

    procedure onResponse(aResponse: JString); cdecl;
    procedure onFailure(aError: JString); cdecl;
  end;

  // Delphi Implementation of the JDelphiLogger
  TDelphiLoggerImpl = class(TJavaLocal, JUssdBridge_DelphiLogger)
  private
    FLogger: TProcLogger;
  public
    constructor Create(aLogger: TProcLogger);

    procedure logMessage(const aLogMsg: JString); cdecl;
  end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('API.JNI.UssdBridge.JUssdBridge', TypeInfo(API.JNI.UssdBridge.JUssdBridge));
  //TRegTypes.RegisterType('API.JNI.UssdBridge.JUssdBridge_1', TypeInfo(API.JNI.UssdBridge.JUssdBridge_1));
  TRegTypes.RegisterType('API.JNI.UssdBridge.JUssdBridge_DelphiLogger', TypeInfo(API.JNI.UssdBridge.JUssdBridge_DelphiLogger));
  TRegTypes.RegisterType('API.JNI.UssdBridge.JUssdBridge_UssdListener', TypeInfo(API.JNI.UssdBridge.JUssdBridge_UssdListener));
end;

{ TUssdListenerImpl }

{$REGION '  JUssdListener Impl .. '}

constructor TUssdListenerImpl.Create(aOnResponse, aOnFailure: TProcLogger);
begin inherited Create;

  FOnResponse := aOnResponse;
  FOnFailure  := aOnFailure;
end;

procedure TUssdListenerImpl.onFailure(aError: JString); cdecl;
var
  LMsg: string;
begin
  LMsg := JStringToString(aError);

  if Assigned(FOnFailure) then
    FOnFailure(LMsg);
end;

procedure TUssdListenerImpl.onResponse(aResponse: JString); cdecl;
var
  LMsg: string;
begin
  LMsg := JStringToString(aResponse);

  if Assigned(FOnResponse) then
    FOnResponse(LMsg);
end;
{$ENDREGION}

{ TDelphiLoggerImpl }

{$REGION '  JDelphiLogger Impl .. '}
constructor TDelphiLoggerImpl.Create(aLogger: TProcLogger);
begin inherited Create;

  FLogger := aLogger;
end;

procedure TDelphiLoggerImpl.logMessage(const aLogMsg: JString);
var
  LMsg: string;
begin
  LMsg := JStringToString(aLogMsg);

  if Assigned(FLogger) then
    FLogger(LMsg);
end;
{$ENDREGION}

initialization
  RegisterTypes;
end.
