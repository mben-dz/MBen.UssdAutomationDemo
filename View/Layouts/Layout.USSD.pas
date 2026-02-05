unit Layout.USSD;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Layouts,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.ListBox,
//
  API.USSD.Service;

type
  TLytUSSD = class(TFrame)
    VertScrollBox: TVertScrollBox;
    LytHeader: TLayout;
    LblTitle: TLabel;
    LytControls: TLayout;
    EdtUSSDCode: TEdit;
    BtnExecuteUSSD: TButton;
    CmbSimSlot: TComboBox;
    LytLog: TLayout;
    LblLog: TLabel;
    MemoUssdReply: TMemo;
    MemoLog: TMemo;
    procedure BtnExecuteUSSDClick(Sender: TObject);
  private
    { Private declarations }
    FService: TUSSDService;
    procedure LogUssdReply(const aMsg: string);
    procedure Log(const aMsg: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

constructor TLytUSSD.Create(AOwner: TComponent);
begin inherited Create(AOwner);

  FService := TUSSDService.Create;
  FService.OnLogUssdReply := LogUssdReply;
  FService.OnLog := Log;

  CmbSimSlot.Items.Add('SIM 1');
  CmbSimSlot.Items.Add('SIM 2');
  CmbSimSlot.ItemIndex := 0;
end;

destructor TLytUSSD.Destroy;
begin
  FService.Free;
  inherited;
end;

procedure TLytUSSD.Log(const aMsg: string);
begin
  TThread.Queue(nil, procedure
  begin
    MemoLog.Lines.Add(Format('[%s] %s', [FormatDateTime('HH:mm:ss', Now), aMsg]));
    MemoLog.GoToTextEnd;
  end);
end;

procedure TLytUSSD.LogUssdReply(const aMsg: string);
begin
  TThread.Queue(nil, procedure
  begin
    MemoUssdReply.Lines.Add(Format('[%s] %s', [FormatDateTime('HH:mm:ss', Now), aMsg]));
    MemoUssdReply.GoToTextEnd;
  end);
end;

procedure TLytUSSD.BtnExecuteUSSDClick(Sender: TObject);
begin
//  if EdtUSSDCode.Text.IsEmpty then
//  begin
//    ShowMessage('Please enter a USSD code.');
//    Exit;
//  end;

  FService.SendRequest(EdtUSSDCode.Text, CmbSimSlot.ItemIndex);
end;

end.
