unit Model.Database;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Data.DB,
  Androidapi.Log,
  System.IOUtils, FireDAC.Phys.SQLiteWrapper.Stat;

type
  TdmDatabase = class(TDataModule)
    FDConnection: TFDConnection;
    QryLog: TFDQuery;
    DriverSqlite: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure SetupDatabase;
  public
    function LogTransaction(const aCode, aResponse: string; aStatus: string): Boolean;
  end;

var
  dmDatabase: TdmDatabase;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmDatabase }

procedure TdmDatabase.DataModuleCreate(Sender: TObject);
begin
  SetupDatabase
end;

function TdmDatabase.LogTransaction(const aCode, aResponse: string;
  aStatus: string): Boolean;
begin
  Result := False;
  if not FDConnection.Connected then Exit;

  FDConnection.StartTransaction;
  try
    QryLog.SQL.Text := 'INSERT INTO USSD_LOGS (CODE, RESPONSE, STATUS) VALUES (:Code, :Resp, :Stat)';
    QryLog.ParamByName('Code').AsString := aCode;
    QryLog.ParamByName('Resp').AsString := aResponse;
    QryLog.ParamByName('Stat').AsString := aStatus;
    QryLog.ExecSQL;

    FDConnection.Commit;
    Result := True;
  except
    FDConnection.Rollback;
    raise;
  end;
end;

procedure TdmDatabase.SetupDatabase;
var
  LDBPath: string;
begin
  {$IFDEF ANDROID}
  LDBPath := TPath.Combine(TPath.GetDocumentsPath, 'ussd_logs.db');
  {$ELSE}
  LDBPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'ussd_logs.db');
  {$ENDIF}

  FDConnection.Params.Values['Database'] := LDBPath;
  FDConnection.Params.Values['DriverID'] := 'SQLite';
  FDConnection.Params.Values['LockingMode'] := 'Normal';

  try
    FDConnection.Connected := True;

    // Create Table if not exists
    FDConnection.ExecSQL(
      'CREATE TABLE IF NOT EXISTS USSD_LOGS (' +
      'ID INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'TIMESTAMP DATETIME DEFAULT CURRENT_TIMESTAMP, ' +
      'CODE TEXT, ' +
      'RESPONSE TEXT, ' +
      'STATUS TEXT)');
  except
    on E: Exception do
      // Handle connection error
      LOGE(MarshaledAString(AnsiString('DB Error: ' + E.Message)));
  end;
end;

end.
