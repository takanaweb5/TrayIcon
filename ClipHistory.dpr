program ClipHistory;

uses
  Forms,
  SysUtils,
  Windows,
  Messages,
  Main in 'Main.pas' {MainForm};

{$R *.res}
//*****************************************************************************
//[ 関　数 ]　GetHwndFromFileMap
//[ 概  要 ]　共有メモリから起動中のソフトのWindowハンドルを取得する
//[ 引  数 ]　なし
//[ 戻り値 ]　Windowハンドル
//*****************************************************************************
function GetHwndFromFileMap(): THandle;
var
  FileMapName: string;
  hMap: THandle;
  P: Pointer;
begin
  Result := 0;
  FileMapName := ExtractFileName(Application.ExeName);
  hMap := OpenFileMapping(FILE_MAP_READ,FALSE,PChar(FileMapName));
  if hMap <> 0 then begin
    P := MapViewOfFile(hMap,FILE_MAP_READ,0,0,0);
    if P <> nil then
    begin
      Result := PHandle(P)^;
      UnmapViewOfFile(P);
    end;
    CloseHandle(hMap);
  end;
end;

//*****************************************************************************
//　メインプログラム開始
//*****************************************************************************
var
  hForm: THandle;
begin
  //二重起動の防止
  hForm := GetHwndFromFileMap();
  if hForm <> 0 then begin
    //起動中のアプリをアクティブにするようにメッセージを送信する
    PostMessage(hForm,WM_USER+1,0,0);
    Exit;
  end;

  //タスクバーには表示させない
  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);

  Application.Initialize;
  Application.ShowMainForm := false;
//  Application.HintPause := 100;
//  Application.HintShortPause := 5000;
  Application.Title := 'クリップボード履歴';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
