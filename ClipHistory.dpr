program ClipHistory;

uses
  Forms,
  SysUtils,
  Windows,
  Messages,
  Main in 'Main.pas' {MainForm};

{$R *.res}
//*****************************************************************************
//[ �ց@�� ]�@GetHwndFromFileMap
//[ �T  �v ]�@���L����������N�����̃\�t�g��Window�n���h�����擾����
//[ ��  �� ]�@�Ȃ�
//[ �߂�l ]�@Window�n���h��
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
//�@���C���v���O�����J�n
//*****************************************************************************
var
  hForm: THandle;
begin
  //��d�N���̖h�~
  hForm := GetHwndFromFileMap();
  if hForm <> 0 then begin
    //�N�����̃A�v�����A�N�e�B�u�ɂ���悤�Ƀ��b�Z�[�W�𑗐M����
    PostMessage(hForm,WM_USER+1,0,0);
    Exit;
  end;

  //�^�X�N�o�[�ɂ͕\�������Ȃ�
  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);

  Application.Initialize;
  Application.ShowMainForm := false;
//  Application.HintPause := 100;
//  Application.HintShortPause := 5000;
  Application.Title := '�N���b�v�{�[�h����';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
