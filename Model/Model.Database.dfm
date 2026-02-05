object dmDatabase: TdmDatabase
  OnCreate = DataModuleCreate
  Height = 288
  Width = 389
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 82
    Top = 22
  end
  object QryLog: TFDQuery
    Connection = FDConnection
    Left = 82
    Top = 114
  end
  object DriverSqlite: TFDPhysSQLiteDriverLink
    Left = 266
    Top = 80
  end
end
