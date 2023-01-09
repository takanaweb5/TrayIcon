unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, ComCtrls, ToolWin, Buttons, Clipbrd, ShellAPI,
  ActnList, StdActns, OleCtrls, SHDocVw, ActiveX, ComObj, StrUtils, Contnrs,
  System.Actions ;

  const
  TB_HISTORY  = 0;
  TB_HTML     = 1;
  TB_FILE     = 2;
  TB_DEBUG    = 3;
  TB_PICTURE  = 4;
  TB_SAVE     = 5;
  NO_HTML = '_NOT_HTML';
  TX_PICTURE = '_This is Picture';
  LIMIT_BYTE = 1024*1024;
  LIMIT_ALLSIZE = 1024*1024*50;
  MAX_LISTSIZE = 50;
  LIMIT_OVER = '1MBを超えたためデータは収集されませんでした';
  HS_OVER = '50件または合計が50MBを超えた時は、古い履歴から切り捨てられます。';
  HS_HISTORY = '[履歴]'#13+
            'クリップボードにコピーされた文字列データを保存します。'#13+
            HS_OVER+#13+
            '「保存」を選択するとアプリケーションが終了するまで内容を保持することが出来ます。';
  HS_HTML = '[HTML]'#13+
            'HTML形式のデータを格納します。'#13+
            '(「Excel」や｢Word｣や｢Internet Explorer｣からコピーした場合、書式を保持して保存出来ます)'#13+
            HS_OVER;
  HS_FILE = '[ファイル名]'#13+
            '「Explorer」でファイルをコピーした時、ファイル名を文字列形式で格納します。'#13+
            HS_OVER;
  HS_DEBUG = '[Debug]'#13+
            '例外の発生情報を格納します。開発者用です';
  HS_PICTURE = '[画像]'#13+
            '画像形式のデータを格納します。';
  HS_SAVE = '[保存]'#13+
            '「保存」を選択したデータが格納されています。'#13+
            'アプリケーションが終了するまで内容は保持されます。'#13+
            '保存出来る件数およびデータの大きさに上限はありません。';
  HS_CLIPSTR = 'クリップボードの中身を表示しています';
  HS_MEMO = '[メモ書き]'#13+
            'ご自由にメモとしてお使い下さい。'#13+
            'アプリケーションの起動中、内容は保持されます。'#13+
            'アプリケーションが勝手に内容を変更することはありません。';
  HelpStrs: array[0..TB_SAVE] of string = (HS_HISTORY, HS_HTML, HS_FILE, HS_DEBUG, HS_PICTURE, HS_SAVE);
  HelpStrs2:array[0..1] of string = (HS_CLIPSTR, HS_MEMO);

type
  TClipList = class(TStringList)
  private
    FType: Word;
    function GetSize(): Integer;
  public
    function GetMaxSizeIndex(AddSize: Integer; MaxSize: Integer): Integer;
    property Size: Integer read GetSize;
  end;

//  TWebBrow = class(TThread)
//  private
//    FWebBrowser: TWebBrowser;
//    FHTMLText: string;
//  protected
//    procedure Execute; override;
//  public
//    constructor Create(WebBrowser: TWebBrowser; HTMLText: string);
//    destructor Destroy; override;
//  end;

  TMainForm = class(TForm)
    trayIcon: TTrayIcon;
    popTrayMenu: TPopupMenu;
    menShowForm: TMenuItem;
    N4: TMenuItem;
    menExit: TMenuItem;
    ToolBar1: TToolBar;
    btnAllClear: TSpeedButton;
    btnGet: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    Splitter1: TSplitter;
    popListMenu: TPopupMenu;
    menSave: TMenuItem;
    menDelData: TMenuItem;
    N3: TMenuItem;
    menHelp: TMenuItem;
    PageControl1: TPageControl;
    tabHistory: TTabSheet;
    tabHTML: TTabSheet;
    tabFile: TTabSheet;
    tabSave: TTabSheet;
    tabDebug: TTabSheet;
    tabPicture: TTabSheet;
    lstHistory: TListBox;
    lstHTML: TListBox;
    lstFile: TListBox;
    lstSave: TListBox;
    lstDebug: TListBox;
    PageControl2: TPageControl;
    tabClipboard: TTabSheet;
    tabMemo: TTabSheet;
    memDisplay: TMemo;
    memMemo: TMemo;
    popMemoMenu: TPopupMenu;
    menCut: TMenuItem;
    menCopy: TMenuItem;
    menPaste: TMenuItem;
    menDel: TMenuItem;
    N1: TMenuItem;
    menUndo: TMenuItem;
    menSelectAll: TMenuItem;
    N2: TMenuItem;
    menLowerCase: TMenuItem;
    menUpperCase: TMenuItem;
    menTopUpperCase: TMenuItem;
    menToMultiByte: TMenuItem;
    menToSingleByte: TMenuItem;
    N7: TMenuItem;
    menHelp2: TMenuItem;
    ActionList: TActionList;
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    EditSelectAll: TEditSelectAll;
    EditUndo: TEditUndo;
    EditDelete: TEditDelete;
    ActGetData: TAction;
    ActSaveData: TAction;
    ActDelData: TAction;
    ActAllClear: TAction;
    ActFormShow: TAction;
    ActLowerCase: TAction;
    ActUpperCase: TAction;
    ActTopUpperCase: TAction;
    ActToMultiByte: TAction;
    ActToSingleByte: TAction;
    pnlHTML: TPanel;
    WebBrowser: TWebBrowser;
    popWebMenu: TPopupMenu;
    menWebCopy: TMenuItem;
    menWebAllSelect: TMenuItem;
    MenuItem8: TMenuItem;
    menJumpURL: TMenuItem;
    menShowSource: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    scrImage: TScrollBox;
    imgImage: TImage;
    tmTimer: TTimer;
    procedure tmTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure menExitClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure ActGetDataExecute(Sender: TObject);
    procedure ActSaveDataExecute(Sender: TObject);
    procedure ActDelDataExecute(Sender: TObject);
    procedure ActAllClearExecute(Sender: TObject);
    procedure ActionUpdate(Sender: TObject);
    procedure ActAllClearUpdate(Sender: TObject);
    procedure ActFormShowExecute(Sender: TObject);
    procedure menHelpClick(Sender: TObject);
    procedure ActConvertExecute(Sender: TObject);
    procedure ActConvertUpdate(Sender: TObject);
    procedure WebBrowserBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
    procedure WebBrowserNewWindow2(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
    procedure menWebCopyClick(Sender: TObject);
    procedure menWebAllSelectClick(Sender: TObject);
    procedure menJumpURLClick(Sender: TObject);
    procedure menShowSourceClick(Sender: TObject);
    procedure trayIconMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    FNavigate: Boolean;
    FhMap: THandle;
    FNextWnd: HWND;
    FTextList: array[0..TB_SAVE] of TClipList;
    FHtmlList: array[0..TB_SAVE] of TClipList;
    FListBox:  array[0..TB_SAVE] of TListBox;
    FMemo:     array[0..1] of TMemo;
    FClipSet: Boolean; //自アプリ内でクリップボードに取り出している時
    procedure WMUser1(var msg: TMessage); message WM_USER + 1;
    procedure WMSysCommand(var msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMDrawClipboard(var msg: TMessage); message WM_DRAWCLIPBOARD;
    procedure WMChangeChain(var msg: TWMChangeCBChain); message WM_CHANGECBCHAIN;
    procedure HookWndProc(var Msg: TMsg; var Handled: Boolean);
    procedure SetBuffer(Format: Word; var Buffer; Size: Integer);
    function GetHtmlText(Format: Word): string;
    function GetUnicodeText(Format: Word): WideString;
    function SetHwndToFileMap(hWnd: THandle): THandle;
    function SaveClipData(): Boolean;
    procedure SetClipboardFromHistory();
    function GetCopyFileName(): string;
    procedure SaveData(Tab: Integer; TextString: string; HTMLString: string);
    function GetListBoxString(TextString: string): string;
    procedure ReSetListBox(Tab: Integer);
    procedure SetmemDisplay();
    function DeleteTag(HTMLSource, TagName: string): string;
    function DeleteTags(HTMLSource: string): string;
    function GetHTMLSource(HTMLSource: string): string;
    function ConvertString(const ConvertStr: String; CommandName: string): String;
    function GetClipboardFormatID(FormatName: string): Word;
    procedure ShowHTMLClipSource(HTMLString: string);
    procedure ShowURL(HTMLString: string);
    procedure ReSetClipboardViewer();
  public
    { Public 宣言 }
  end;

  function Utf8Decode(const S: UTF8String): WideString;

var
  CF_HTML: Word;
  MainForm: TMainForm;

implementation

{$R *.dfm}

//*****************************************************************************
//[ 概  要 ]　フォーム作成時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FhMap := SetHwndToFileMap(Self.Handle);

  for i := Low(FTextList) to High(FTextList) do begin
    FTextList[i] := TClipList.Create;
    //大文字と小文字を区別する
    FTextList[i].CaseSensitive := true;
  end;

  for i := Low(FHtmlList) to High(FHtmlList) do begin
    FHtmlList[i] := TClipList.Create;
    //大文字と小文字を区別する
    FHtmlList[i].CaseSensitive := true;
  end;

  for i := 0 to PageControl1.PageCount - 1 do begin
    FListBox[i] := TListBox(PageControl1.Pages[i].Controls[0]);
  end;

  for i := 0 to PageControl2.PageCount - 1 do begin
    FMemo[i] := TMemo(PageControl2.Pages[i].Controls[0]);
  end;

  //最前面をキープするフォームを作成する
    //Delphi2005ではバグっぽいのでオブジェクトインスペクタであらかじめ設定しておく
//  Self.FormStyle := fsStayOnTop;　

  tabHTML.TabVisible  := false;
  tabFile.TabVisible  := false;
  tabSave.TabVisible  := false;
  tabDebug.TabVisible := false;
  tabPicture.TabVisible := false;
  lstHistory.Clear;
  memDisplay.Clear;
  memMemo.Clear;
  pnlHTML.Visible := false;
  scrImage.Visible := false;
  WebBrowser.Navigate('about:blank');
  WebBrowser.Silent := true;

  //クリップボードにデータがあれば保存する
  SaveClipData();

  //WebBrowserでコピーが出来るようにするおまじない
  OleInitialize(nil);

  //クリップボードビューアとして登録
  FClipSet := true;   //WM_DRAWCLIPBOARDが発生するため
  FNextWnd := SetClipboardViewer(Self.Handle);
  FClipSet := false;

  //WebBrowserで右クリックを出来るようにする
  Application.OnMessage := HookWndProc;
end;

//*****************************************************************************
//[ 概  要 ]　WebBrowserで右クリックを出来るようにする
////            サイズボックスのドラッグでフォームのサイズを変更可能にする
//[ 引  数 ]　Sender
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.HookWndProc(var Msg: TMsg; var Handled: Boolean);
var
  Pos: TPoint;
begin
  //WebBrowserで右クリックを出来るようにする
  with msg do
  begin
    if (message = WM_CONTEXTMENU) or (message = WM_RBUTTONUP) then
    begin
      if GetParent(GetParent(hwnd)) = WebBrowser.Handle then
      begin
        GetCursorPos(Pos);
        popWebMenu.Popup(Pos.x, Pos.y);
        Handled := true;
        Exit;
      end;
    end;
  end;

//  with msg do
//  begin
//    if wParam = HTSIZE then
//    begin
//      SetCursor(LoadCursor(0, IDC_SIZENWSE));
//      if message = WM_NCMOUSEMOVE then
//      begin
//        Handled := True;
//      end;
//      if message = WM_NCLBUTTONDOWN then
//      begin
//        ReleaseCapture();
//        Self.Perform(WM_SYSCOMMAND, SC_SIZE or WMSZ_BOTTOMRIGHT,0);
//      end;
//      Exit;
//    end
//    else
//    begin
//      Screen.Cursor := crDefault;
//    end;
//  end;
end;

//*****************************************************************************
//[ 概  要 ]　共有メモリにWindowハンドルを登録する
//[ 引  数 ]　Windowハンドル
//[ 戻り値 ]　共有メモリのハンドル
//*****************************************************************************
function TMainForm.SetHwndToFileMap(hWnd: THandle): THandle;
var
  FileMapName: string;
  P: Pointer;
begin
  FileMapName := ExtractFileName(Application.ExeName);
  Result := CreateFileMapping(THandle(-1), nil, PAGE_READWRITE, 0,
                              sizeof(THandle), PChar(FileMapName));
  P := MapViewOfFile(Result, FILE_MAP_WRITE, 0, 0, 0);
  if P <> nil then
  begin
    PHandle(P)^ := self.Handle;
    UnmapViewOfFile(P);
  end;
end;

//*****************************************************************************
//[ 概  要 ]　フォーム破棄時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  CloseHandle(FhMap);

  for i := Low(FTextList) to High(FTextList) do begin
    FTextList[i].Free;
  end;

  for i := Low(FHtmlList) to High(FHtmlList) do begin
    FHtmlList[i].Free;
  end;

  //クリップボードビューアから削除
  ChangeClipboardChain(Self.Handle,FNextWnd);

  //WebBrowserでコピーが出来るようにするおまじない
  OleUninitialize;
end;

//*****************************************************************************
//[イベント]　FormResize
//[ 概  要 ]　フォームのサイズの変更時にボタンの幅を自動調整
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormResize(Sender: TObject);
begin
  btnGet.Width      := ToolBar1.Width div 4;
  btnSave.Width     := ToolBar1.Width div 4;
  btnAllClear.Width := ToolBar1.Width div 4;
  btnClose.Width    := ToolBar1.Width - (ToolBar1.Width div 4) * 3;
end;

//*****************************************************************************
//[ 概  要 ]　フォーム表示時にタイマーを無効にする
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormShow(Sender: TObject);
begin
  tmTimer.Enabled := False;
end;

//*****************************************************************************
//[ 概  要 ]　フォームを閉じる時にタイマーを有効にする
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormHide(Sender: TObject);
begin
  tmTimer.Enabled := True;
end;

////*****************************************************************************
////[ 概  要 ]　新しいタブを作成する
////[ 引  数 ]　TObject
////[ 戻り値 ]　なし
////*****************************************************************************
//procedure TMainForm.CreateNewTab();
//var
//  TabSheet: TTabSheet;
//  ListBox: TListBox;
//begin
//  TabSheet := TTabSheet.Create(self);
//  TabSheet.Caption := 'テスト';
//  TabSheet.PageControl := PageControl1;
//
//  ListBox := TListBox.Create(self);
//  ListBox.Parent := TabSheet;
//  ListBox.Align := alClient;
//  ListBox.OnClick := ListBoxClick;
//  ListBox.OnDblClick := GetTextClick;
//  ListBox.PopupMenu := popListMenu;
//end;
//
//*****************************************************************************
//[ 概  要 ]　クリップボードに選択したデータを貼付ける
//[ 引  数 ]　なし
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SetClipboardFromHistory();
var
  s,k: Integer;
  HTMLString: string;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;

  //クリップボード変更中
  FClipSet := True;
  Clipboard.Open;
  try
    Clipboard.Clear;
    Clipboard.AsText := FTextList[s][k];

    HTMLString := FHTMLList[s][k];
    if (HTMLString <> NO_HTML) and (HTMLString <> LIMIT_OVER) then
    begin
      SetBuffer(CF_HTML, HTMLString[1], Length(HTMLString) + 1);
    end;
  finally
    Clipboard.Close;
    FClipSet := false;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　「閉じる」ボタン押下時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.CloseClick(Sender: TObject);
begin
  Self.Visible := false;
end;

//*****************************************************************************
//[ 概  要 ]　フォームを表示するメッセージを受信した時
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WMUser1(var msg: TMessage);
begin
  ActFormShowExecute(Self);
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードビュアーに変更があった時通知される
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WMChangeChain(var msg: TWMChangeCBChain);
begin
  //自分の次のクリップボードビュアーが削除された時、次のクリップボードビュアーを置換える
  if msg.Remove = FNextWnd then begin
    FNextWnd := msg.Next;
  end
  else begin
    if FNextWnd <> 0 then begin
      //自分の次のクリップボードビュアーにメッセージを送信する
      SendMessage(FNextWnd,msg.Msg,msg.Remove,msg.Next);
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードに変更があった時通知される
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WMDrawClipboard(var msg: TMessage);
begin
  //自アプリ内でクリップボードの「取り出し」時は対象外にする
  if FClipSet then Exit;
  if FListBox[PageControl1.ActivePageIndex].Focused then Exit;

  //クリップボード変更中
  FClipSet := True;

  try
    SaveClipData();
  except on E: Exception do begin
    //例外情報の出力
    FTextList[TB_DEBUG].Insert(0, Format('WMDrawClipboard:%s %s', [E.Message, FormatDateTime('hh:mm:ss',Now())]));
    FHTMLList[TB_DEBUG].Insert(0, NO_HTML);
    if Self.Visible then ReSetListBox(TB_DEBUG);
    tabDebug.TabVisible := true;
    end;
  end;

  SendMessage(FNextWnd,msg.Msg,msg.WParam,msg.LParam);

  FClipSet := false;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードのデータを履歴に収集する
//[ 引  数 ]　なし
//[ 戻り値 ]　True:データを保存した時
//*****************************************************************************
function TMainForm.SaveClipData(): Boolean;
var
  TextString: Widestring;
  HTMLString: string;
  TabType: Integer;
  Picture: TPicture;
begin
  //クリップボードに文字列データがあるか判定
  if Clipboard.HasFormat(CF_UNICODETEXT) then begin
    TabType := TB_HISTORY;
    TextString := GetUnicodeText(CF_UNICODETEXT);
  end
  else if Clipboard.HasFormat(CF_TEXT) then begin
    TabType := TB_HISTORY;
    TextString := Clipboard.AsText;
  end
  //クリップボードにExplorerからのコピー形式があるかチェック
  else if Clipboard.HasFormat(CF_HDROP) then  begin
    TabType := TB_FILE;
    TextString := GetCopyFileName();
  end
//  else if Clipboard.HasFormat(CF_PICTURE) then begin
//    TabType := TB_PICTURE;
//    TextString := TX_PICTURE;
//  end
  else begin
    Result := false;
    Exit;
  end;

  Result := true;
  btnAllClear.Enabled := true;

  //クリップボードに'HTML Format'が存在するかチェック
  if CF_HTML = 0 then CF_HTML := GetClipboardFormatID('HTML Format');
  if CF_HTML <> 0 then begin
    if Clipboard.HasFormat(CF_HTML) then begin
      TabType := TB_HTML;
      HTMLString := Trim(GetHtmlText(CF_HTML));
    end;
  end;

  //データを保存する
  if TabType = TB_HTML then begin
    //クリップボードの中身が1MBを超えたら対象外とする
    if (Length(TextString) > LIMIT_BYTE) and (Length(HTMLString) > LIMIT_BYTE) then begin
      SaveData(TB_HTML, LIMIT_OVER, LIMIT_OVER);
    end
    else if (Length(HTMLString) > LIMIT_BYTE) then begin
      SaveData(TB_HTML, LIMIT_OVER, LIMIT_OVER);
      SaveData(TB_HISTORY, TextString, NO_HTML);
    end
    else begin
      SaveData(TB_HTML, TextString, HTMLString);
      SaveData(TB_HISTORY, TextString, NO_HTML);
    end;
  end else begin
//    if TabType = TB_PICTURE then begin
//      Picture := TPicture.Create;
//      Picture.Assign(Clipboard);
//      FTextList[TB_PICTURE].Insert(0, TextString);
//      FTextList[TB_PICTURE].Objects[0] := Picture;
//      FHTMLList[TB_PICTURE].Insert(0, NO_HTML);
//      ReSetListBox(TB_PICTURE);
//    end;
    //クリップボードの中身が1MBを超えたら対象外とする
    if (Length(TextString) > LIMIT_BYTE) then begin
      SaveData(TabType, LIMIT_OVER, NO_HTML);
    end
    else begin
      SaveData(TabType, TextString, NO_HTML);
    end;
  end;

  //非表示のタブを表示
  PageControl1.Pages[TabType].TabVisible := true;

  //保存したページの保存した項目を選択
  if TabType = TB_HTML then begin
    PageControl1.ActivePageIndex := TB_HISTORY;
    FListBox[TB_HISTORY].ItemIndex := 0;
  end
  else begin
    PageControl1.ActivePageIndex := TabType;
    FListBox[TabType].ItemIndex := 0;
  end;

  //クリップボードの中身を表示
  if Self.Visible then begin
    if not memDisplay.Focused then begin
      memDisplay.Lines.Text := TextString;
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボード形式の番号を取得
//[ 引  数 ]　Format名
//[ 戻り値 ]　クリップボード形式
//*****************************************************************************
function TMainForm.GetClipboardFormatID(FormatName: string): Word;
begin
  Result := RegisterClipboardFormat(PChar(FormatName));
end;

//*****************************************************************************
//[ 概  要 ]　CF_HDROPのコピー形式からファイル名を取得する
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
function TMainForm.GetCopyFileName(): string;
var
  i: Integer;
  iCount: Integer;
  szFileName: array[0..MAX_PATH + 1] of Char;
  Data: THandle;
  DataPtr: Pointer;
begin
  Clipboard.Open;
  Data := GetClipboardData(CF_HDROP);
  try
    if Data = 0 then
      raise Exception.Create('CF_HDROPのハンドルが取得出来ません');

    DataPtr := GlobalLock(Data);
    if DataPtr = nil then
      raise Exception.Create('CF_HDROPのハンドルが取得出来ません');

    iCount := DragQueryFile(THandle(DataPtr), Cardinal(-1), nil, 0);
    for i := 0 to iCount - 1 do
    begin
      DragQueryFile(THandle(DataPtr), i, szFileName, Length(szFileName));
      Result := Result + szFileName + sLineBreak;
    end;
  finally
    if Data <> 0 then GlobalUnlock(Data);
    Clipboard.Close;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードのデータを該当のタブに保存する
//[ 引  数 ]　Tab:ページ番号、クリップボードに保存するデータ(文字列形式)
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SaveData(Tab: Integer; TextString: string; HTMLString: string);
var
  FindIndex, NewIndex: Integer;
  i,Size,Count: Integer;
begin
  //２重登録のチェック
  if Tab = TB_HTML then
    FindIndex := FHTMLList[Tab].IndexOf(HTMLString)
  else
    FindIndex := FTextList[Tab].IndexOf(TextString);

  if FindIndex >= 0 then begin
    //登録済みを１番目に移動
    FTextList[Tab].Move(FindIndex, 0);
    FHTMLList[Tab].Move(FindIndex, 0);
  end
  else begin
    //50件を超えた時
    Count := FTextList[Tab].Count;
    if Count = MAX_LISTSIZE then begin
      //１番古いデータを削除
      FTextList[Tab].Delete(Count - 1);
      FHTMLList[Tab].Delete(Count - 1);
    end
    else begin
      //サイズののチェック
      if Tab = TB_HTML then
        Size := Length(HTMLString) + FHTMLList[Tab].Size
      else
        Size := Length(TextString) + FTextList[Tab].Size;

      //1MBを超えた時
      if Size > LIMIT_ALLSIZE then begin
        if Tab = TB_HTML then
          NewIndex := FHTMLList[Tab].GetMaxSizeIndex(Length(HTMLString), LIMIT_ALLSIZE)
        else
          NewIndex := FTextList[Tab].GetMaxSizeIndex(Length(TextString), LIMIT_ALLSIZE);

        //1MBを超える部分を削除
        for i := Count -1 downto NewIndex do begin
          FTextList[Tab].Delete(i);
          FHTMLList[Tab].Delete(i);
        end;
      end;
    end;
    //１番目に保存
    FTextList[Tab].Insert(0, TextString);
    FHTMLList[Tab].Insert(0, HTMLString);
  end;

  //リストボックスを再設定する
  if Self.Visible then ReSetListBox(Tab);
end;

//*****************************************************************************
//[ 概  要 ]　ListBoxのデータを再設定し直す
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ReSetListBox(Tab: Integer);
var
  i: Integer;
  TextString: string;
begin
  FListBox[Tab].Clear;
  for i := 1 to FTextList[Tab].Count do
  begin
    //例：「1: クリップボードの中身」
    TextString := FTextList[Tab][i - 1];
    FListBox[Tab].Items.Add(Format('%d: %s', [i, GetListBoxString(TextString)]));
//    FListBox[Tab].Items.Add(Format('%d:Size:%d-%d: %s', [i, Length(TextString),FTextList[Tab].Size,GetListBoxString(TextString)]));
  end;
end;

//*****************************************************************************
//[ 概  要 ]　ListBoxに表示する文字列を取得する
//[ 引  数 ]　クリップボードの文字列
//[ 戻り値 ]　ListBoxに表示する文字列
//*****************************************************************************
function TMainForm.GetListBoxString(TextString: string): string;
var
  StringList: TStringList;
  i: Integer;
begin
  StringList := TStringList.Create;
  try try
    //空白以外の文字のある最初の行のTrim後の値を取り出す
    StringList.Text := TextString;
    for i := 0 to StringList.Count - 1 do begin
      Result := Trim(StringList[i]);
      if Result <> '' then Exit; //finallyは実行される
    end;
  finally
    StringList.Free;
  end;
  except on E: Exception do begin
    //例外情報の出力
    FTextList[TB_DEBUG].Insert(0, Format('WMDrawClipboard:%s %s', [E.Message, FormatDateTime('hh:mm:ss',Now())]));
    FHTMLList[TB_DEBUG].Insert(0, NO_HTML);
    ReSetListBox(TB_DEBUG);
    tabDebug.TabVisible := true;
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　フォームの最小化および閉じるを実行された時
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WMSysCommand(var msg: TWMSysCommand);
begin
  case msg.CmdType of
  SC_MINIMIZE,SC_CLOSE:
    begin
      self.Visible := false;
      msg.Result := 0;
    end;
  else
    inherited;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　ListBoxがクリックされた時
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ListBoxClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  //クリップボードの中身を表示
  SetmemDisplay();

  //WebBrowserにフォーカスがあるとListBoxにフォーカスが移らない事象の対応
  PageControl1.SetFocus;
  TWinControl(Sender).SetFocus;
  Screen.Cursor := crDefault;
end;

//*****************************************************************************
//[ 概  要 ]　Ctrl+Sで、HTMLテキストを表示する(裏技)
//[ 引  数 ]　HTMLString
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ShowHTMLClipSource(HTMLString: string);
begin
  pnlHTML.Visible := false;
  memDisplay.Visible := True;
  memDisplay.SelectAll;
  memDisplay.Lines.Text := Trim(UTF8Decode(HTMLString));
  PageControl2.ActivePageIndex := 0;
end;

//*****************************************************************************
//[ 概  要 ]　Ctrl+Jで、URLを開く(裏技)
//[ 引  数 ]　HTMLString
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ShowURL(HTMLString: string);
var
  i,j: Integer;
  S: string;
begin
  i := Pos('SourceURL', HTMLString);
  j := PosEx(#13,HTMLString,i);
  if i > 0 then begin
    if j > i then begin
      S := Copy(HTMLString, i + Length('SourceURL') + 1, j - i- Length('SourceURL'));
      ShellExecuteW(Self.Handle,'', PWideChar(Trim(UTF8Decode(S))), '', '', 0);
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードの中身を表示する
//[ 引  数 ]　なし
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SetmemDisplay();
  procedure WebBrow(HTMLText: string);
  var
    S: string;
    Stream: IStream;
  begin
    S := GetHTMLSource(HTMLText);
    S := '<META CHARSET=UTF-8>' + DeleteTags(S);
    //インターフェースはFreeしなくて良い
    //soOwned指定により、TStringStreamはTStreamAdapterの中で解放される
    Stream := TStreamAdapter.Create(TStringStream.Create(S), soOwned);
    (WebBrowser.Document as IPersistStreamInit).Load(Stream);
  end;
var
  s,k: Integer;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;

  if k >= 0 then begin
    if (FHtmlList[s][k] <> NO_HTML) and (FHtmlList[s][k] <> LIMIT_OVER) then begin
      //HTML形式を表示
      FNavigate := false;
      WebBrow(FHtmlList[s][k]);
      FNavigate := true;
      memDisplay.Visible := false;
      pnlHTML.Visible    := true;
      scrImage.Visible   := false;
    end
//    else if FTextList[s][k] = TX_PICTURE then begin
//      //PICTURE形式を表示
//      imgImage.Picture := FTextList[s].GetObject(k) as TPicture;
//      memDisplay.Visible := false;
//      pnlHTML.Visible    := false;
//      scrImage.Visible   := true;
//      Clipboard.Clear;
//      Clipboard.Assign(FTextList[s].GetObject(k) as TPicture);
//    end
    else begin
      //TEXT形式を表示
      memDisplay.Lines.Text := FTextList[s][k];
      memDisplay.Visible := true;
      pnlHTML.Visible    := false;
      scrImage.Visible   := false;
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　<HTML>...</HTML>ではさまれた範囲を取得する
//[ 引  数 ]　元のHTMLソース
//[ 戻り値 ]　<HTML>...</HTML>ではさまれた範囲
//*****************************************************************************
function TMainForm.GetHTMLSource(HTMLSource: string): string;
var
  i,j: Integer;
  strHTML: string;
begin
  i := Pos('<HTML', UpperCase(HTMLSource));
  j := PosEx('/HTML>',UpperCase(HTMLSource),i);
  if i > 0 then begin
    if j > i then
      strHTML := Copy(HTMLSource, i, j - i + Length('HTML') + 2)
    else
      strHTML := Copy(HTMLSource, i, Length(HTMLSource));
  end
  else begin
    strHTML := HTMLSource;
  end;
  Result := strHTML;
end;

//*****************************************************************************
//[ 概  要 ]　<SCRIPT>...</SCRIPT>ではさまれた範囲などを削除する
//[ 引  数 ]　元のHTMLソース
//[ 戻り値 ]　削除されたHTMLソース
//*****************************************************************************
function TMainForm.DeleteTags(HTMLSource: string): string;
var
  strHTML: string;
begin
  strHTML := HTMLSource;
  strHTML := DeleteTag(strHTML, 'SCRIPT');
  strHTML := DeleteTag(strHTML, 'APPLET');
  strHTML := DeleteTag(strHTML, 'OBJECT');
//  strHTML := DeleteTag(strHTML, 'LINK');
  Result := strHTML;
end;

//*****************************************************************************
//[ 概  要 ]　<タグ名>...</タグ名>ではさまれた範囲を削除する
//[ 引  数 ]　元のHTMLソース、タグ名
//[ 戻り値 ]　削除されたHTMLソース
//*****************************************************************************
function TMainForm.DeleteTag(HTMLSource, TagName: string): string;
var
  i,j: Integer;
  strHTML: Ansistring;
begin
  strHTML := HTMLSource;
  while True do begin
    i := Pos(UpperCase(Format('<%s',[TagName])), UpperCase(strHTML));
    j := PosEx(UpperCase(Format('/%s>',[TagName])),UpperCase(strHTML), i);
    if (i > 0) and (j > i) then begin
      Delete(strHTML, i, j - i + Length(TagName) + 2);
    end else begin
      Result := strHTML;
      Exit;
    end;
  end;
end;

//*****************************************************************************
//UTF-8のソースでは一部文字化けしてしまう
//*****************************************************************************
//var
//  RegExp: OleVariant;
//  strHTML: string;
//begin
//  strHTML := Utf8Decode(HTMLSource);
//  try
//    RegExp := CreateOleObject('VBScript.RegExp');
//    RegExp.IgnoreCase := True;
//    RegExp.Global := True;
//
//    //<SCRIPT>...</SCRIPT>ではさまれた範囲を削除する
//    RegExp.Pattern := '<SCRIPT(.|\n)*?>(.|\n)*?</SCRIPT>';
//    strHTML := RegExp.Replace(strHTML, '');
//
//    //<APPLET>...</APPLET>ではさまれた範囲を削除する
//    RegExp.Pattern := '<APPLET(.|\n)*?>(.|\n)*?</APPLET>';
//    strHTML := RegExp.Replace(strHTML, '');
//
//    //<OBJECT>...</OBJECT>ではさまれた範囲を削除する
//    RegExp.Pattern := '<OBJECT(.|\n)*?>(.|\n)*?</OBJECT>';
//    strHTML := RegExp.Replace(strHTML, '');
//  finally
//    VarClear(RegExp);
//    Result := UTF8Encode(strHTML);
//  end;
//end;

//*****************************************************************************
//[ 概  要 ]　WebBrowserのリンクをクリックした時、ページを変更しない
//[ 引  数 ]　TObject等
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WebBrowserBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,Headers: OleVariant; var Cancel: WordBool);
begin
  if FNavigate then Cancel := true;
end;

//*****************************************************************************
//[ 概  要 ]　WebBrowserのリンクをクリックした時、ページを変更しない
//[ 引  数 ]　TObject等
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WebBrowserNewWindow2(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool);
begin
  if FNavigate then Cancel := true;
end;

//*****************************************************************************
//[ 概  要 ]　WebBrowserのリンク先をすべて削除
//[ 引  数 ]　TObject等
//[ 戻り値 ]　なし
//*****************************************************************************
//procedure TMainForm.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
//begin
//  for i := WebBrowser.OleObject.document.links.Length -1  downto 0 do begin
////    V := WebBrowser.OleObject.document.links[i];
//    V := WebBrowser.document;
//    V.links[i].href := '#';
//  end;
//end;

//*****************************************************************************
//[ 概  要 ]　クリップボードから文字列データを取得する
//[ 引  数 ]　Format:CF_HTML 等
//[ 戻り値 ]　なし
//*****************************************************************************
function TMainForm.GetHtmlText(Format: Word): string;
var
  Data: THandle;
begin
  Clipboard.Open;
  Data := GetClipboardData(Format);
  try
    if Data <> 0 then
      Result := PChar(GlobalLock(Data))
    else
      Result := '';
  finally
    if Data <> 0 then GlobalUnlock(Data);
    Clipboard.Close;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードからUnicode文字列データを取得する
//[ 引  数 ]　Format:CF_UNICODETEXT 等
//[ 戻り値 ]　なし
//*****************************************************************************
function TMainForm.GetUnicodeText(Format: Word): WideString;
var
  Data: THandle;
begin
  Clipboard.Open;
  Data := GetClipboardData(Format);
  try
    if Data <> 0 then
      Result := PWideChar(GlobalLock(Data))
    else
      Result := '';
  finally
    if Data <> 0 then GlobalUnlock(Data);
    Clipboard.Close;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードにデータを設定する
//[ 引  数 ]　Format:CF_TEXT 等、Buffer:データを取得する変数、Size:変数のサイズ
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SetBuffer(Format: Word; var Buffer; Size: Integer);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
  try
    DataPtr := GlobalLock(Data);
    try
      Move(Buffer, DataPtr^, Size);
      SetClipboardData(Format, Data);
    finally
      GlobalUnlock(Data);
    end;
  except
    GlobalFree(Data);
    raise;
  end;
end;

//*****************************************************************************
//アクションの実行
//*****************************************************************************
//[ 概  要 ]　「取り出し」「保存」「削除」アクションのEnabledの設定
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActionUpdate(Sender: TObject);
var
  s: Integer;
begin
  //最前面をキープするフォームを作成する(時たま原因不明で最前面を失うため)
  Self.FormStyle := fsStayOnTop;

  s := PageControl1.ActivePageIndex;
  if s = TB_SAVE then begin
    if TAction(Sender).Name = ActSaveData.Name then begin
      ActSaveData.Enabled := false;
      Exit;
    end;
  end;

  if FListBox[s].ItemIndex < 0 then
    TAction(Sender).Enabled := false
  else
    TAction(Sender).Enabled := true;
end;

//*****************************************************************************
//[ 概  要 ]　「すべて消去」アクションのEnabledの設定
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActAllClearUpdate(Sender: TObject);
var
  s,Count: Integer;
begin
  s := PageControl1.ActivePageIndex;
  Count := FListBox[s].Items.Count;

  if Count > 0 then
    btnAllClear.Enabled := true
  else
    btnAllClear.Enabled := false;
end;

//*****************************************************************************
//[ 概  要 ]　「取り出し」アクション実行時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActGetDataExecute(Sender: TObject);
var
  s,k: Integer;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;

  if k < 0 then Exit;

  Screen.Cursor := crHourGlass;
  try
    SetClipboardFromHistory();
  except on E: Exception do begin
    //例外情報の出力
    FTextList[TB_DEBUG].Insert(0, Format('WMDrawClipboard:%s %s', [E.Message, FormatDateTime('hh:mm:ss',Now())]));
    FHTMLList[TB_DEBUG].Insert(0, NO_HTML);
    ReSetListBox(TB_DEBUG);
    tabDebug.TabVisible := true;
    end;
  end;

  //選択したデータを１番目に移動する
  FTextList[s].Move(k,0);
  FHtmlList[s].Move(k,0);

  //リストボックスを再設定する
  ReSetListBox(s);
  FListBox[s].ItemIndex := 0;
  Screen.Cursor := crDefault;
end;

//*****************************************************************************
//[ 概  要 ]　「保存」アクション実行時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActSaveDataExecute(Sender: TObject);
var
  s,k: Integer;
  TextString: string;
  HTMLString: string;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;

  if k < 0 then Exit;

  //保存タブを選択出来るようにする
  tabSave.TabVisible := true;

  TextString := FTextList[s][k];
  if s = TB_HTML then //HTML形式の時
    HTMLString := FHTMLList[s][k]
  else
    HTMLString := NO_HTML;

  SaveData(TB_SAVE, TextString, HTMLString);

  //保存ページの保存した項目を選択
  PageControl1.ActivePageIndex := TB_SAVE;
  lstSave.ItemIndex := 0;
end;

//*****************************************************************************
//[ 概  要 ]　「削除」アクション実行時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActDelDataExecute(Sender: TObject);
var
  s,k: Integer;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;

  FTextList[s].Delete(k);
  FHtmlList[s].Delete(k);
  FListBox[s].Items.Delete(k);

  if s > 0 then begin
    if FTextList[s].Count = 0 then begin
      PageControl1.Pages[s].TabVisible := false;
    end;
  end;
  memDisplay.Lines.Clear;
end;

//*****************************************************************************
//[ 概  要 ]　「すべて消去」アクション実行時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActAllClearExecute(Sender: TObject);
var
  s: Integer;
begin
  s := PageControl1.ActivePageIndex;
  FTextList[s].Clear;
  FHtmlList[s].Clear;
  FListBox[s].Clear;

  if s > 0 then PageControl1.Pages[s].TabVisible := false;
  memDisplay.Lines.Clear;
end;

//*****************************************************************************
//[ 概  要 ]　「変換」アクションのEnabledの設定
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActConvertUpdate(Sender: TObject);
var
  s: Integer;
begin
  s := PageControl2.ActivePageIndex;
  if FMemo[s].SelLength > 0 then
    TAction(Sender).Enabled := true
  else
    TAction(Sender).Enabled := false;
end;

//*****************************************************************************
//[ 概  要 ]　「変換」アクション実行時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActConvertExecute(Sender: TObject);
var
  s: Integer;
  SelStart: Integer;
  ConvertStr: string;
begin
  s := PageControl2.ActivePageIndex;
  ConvertStr := ConvertString(FMemo[s].SelText, TAction(Sender).Name);
  SelStart  := FMemo[s].SelStart;
//  FMemo[s].SelText := ConvertStr;  //Undo出来ないので
  FMemo[s].Perform(EM_REPLACESEL, 1, Longint(PChar(ConvertStr)));
  FMemo[s].SelStart  := SelStart;
  FMemo[s].SelLength := Length(ConvertStr);
end;

//*****************************************************************************
//[ 概  要 ]　文字列の変換
//[ 引  数 ]　変換前の文字列、変換種別
//[ 戻り値 ]　変換された文字列
//*****************************************************************************
function TMainForm.ConvertString(const ConvertStr: String; CommandName: string): String;
  function ConvertWideString(const S: WideString; dwMapFlags: DWORD): WideString;
  var
    ConvertStr: array of WideChar;
    StrLen: Integer;
  begin
    StrLen := LCMapStringW(GetUserDefaultLCID(), dwMapFlags,
                                          PWideChar(S), -1, nil, 0);
    SetLength(ConvertStr, StrLen);
    LCMapStringW(GetUserDefaultLCID(), dwMapFlags, PWideChar(S), -1,
                              PWideChar(ConvertStr), Length(ConvertStr));
    Result := PWideChar(ConvertStr);
  end;
var
  WideStr: WideString;
begin
  if CommandName = ActLowerCase.Name then
    //大文字->小文字
    WideStr := ConvertWideString(ConvertStr, LCMAP_LOWERCASE)
  else if CommandName = ActUpperCase.Name then
    //小文字->大文字
    WideStr := ConvertWideString(ConvertStr, LCMAP_UPPERCASE)
  else if CommandName = ActTopUpperCase.Name then
  begin
    //先頭のみ大文字
    WideStr := ConvertWideString(ConvertStr, LCMAP_LOWERCASE);
    WideStr[1] := ConvertWideString(WideStr[1], LCMAP_UPPERCASE)[1];
  end
  else if CommandName = ActToMultiByte.Name then
    //半角->全角
    WideStr := ConvertWideString(ConvertStr, LCMAP_FULLWIDTH)
  else if CommandName = ActToSingleByte.Name then
    //全角->半角
    WideStr := ConvertWideString(ConvertStr, LCMAP_HALFWIDTH);

  Result := WideStr;
end;

//*****************************************************************************
//[ 概  要 ]　右クリックメニューの｢説明｣選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.menHelpClick(Sender: TObject);
var
  s: Integer;
begin
  if TMenuItem(Sender).Name = 'menHelp' then begin
    s := PageControl1.ActivePageIndex;
    MessageDlg(HelpStrs[s], mtInformation, [mbOK], 0);
  end
  else begin //'menHelp2'
    s := PageControl2.ActivePageIndex;
    MessageDlg(HelpStrs2[s], mtInformation, [mbOK], 0);
  end;
end;

//*****************************************************************************
//[ 概  要 ]　WEB画面の右クリックメニューの｢URLを開く｣選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.menJumpURLClick(Sender: TObject);
var
  s,k: Integer;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;
  if k >= 0 then begin
    if (FHtmlList[s][k] <> NO_HTML) and (FHtmlList[s][k] <> LIMIT_OVER) then begin
      ShowURL(FHtmlList[s][k]);
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　WEB画面の右クリックメニューの｢ソースを表示｣選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.menShowSourceClick(Sender: TObject);
var
  s,k: Integer;
begin
  s := PageControl1.ActivePageIndex;
  k := FListBox[s].ItemIndex;
  if k >= 0 then begin
    if (FHtmlList[s][k] <> NO_HTML) and (FHtmlList[s][k] <> LIMIT_OVER) then begin
      ShowHTMLClipSource(FHtmlList[s][k]);
    end;
  end;
end;

//*****************************************************************************
//[ 概  要 ]　WEB画面の右クリックメニューの｢すべてを選択｣選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.menWebAllSelectClick(Sender: TObject);
begin
  WebBrowser.ExecWB(OLECMDID_SELECTALL,0);
end;

//*****************************************************************************
//[ 概  要 ]　WEB画面の右クリックメニューの｢コピー｣選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.menWebCopyClick(Sender: TObject);
begin
  WebBrowser.ExecWB(OLECMDID_COPY,0);
end;

//*****************************************************************************
//タスクトレイのイベント
//*****************************************************************************
//[ 概  要 ]　「フォームの表示」アクション実行時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ActFormShowExecute(Sender: TObject);
var
  i: Integer;
begin
  Self.Visible := true;
  Sleep(100);
  SetForegroundWindow(Self.Handle);

  for i := 0 to PageControl1.PageCount - 1 do begin
    ReSetListBox(i)
  end;

  //クリップボードの中身を表示
  SetmemDisplay();

  if (PageControl2.ActivePageIndex = 1) and (Trim(memMemo.Lines.Text)='') then
    PageControl2.ActivePageIndex := 0;
end;

////*****************************************************************************
////[ 概  要 ]　メモで「CapsLock」「半角/全角」「無変換」を押した時
////            「CapsLock」：小文字 -> 大文字 -> 先頭のみ大文字 -> 小文字
////            「半角/全角」「無変換」：半角<->全角
////[ 引  数 ]　TObject他
////[ 戻り値 ]　なし
////*****************************************************************************
//procedure TMainForm.MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//var
//  s: Integer;
//  SelStart: Integer;
//  ConvertStr: string;
//begin
//  s := PageControl2.ActivePageIndex;
//
//  if Shift <> [] then Exit;
//  if FMemo[s].SelLength = 0 then Exit;
//
//  case key of
//  //「CapsLock」
//  240:begin
//    FMemo[s].Tag := FMemo[s].Tag + 1;
//    case FMemo[s].Tag mod 3 of
//      0:ConvertStr := ConvertString(FMemo[s].SelText, ActLowerCase.Name);
//      1:ConvertStr := ConvertString(FMemo[s].SelText, ActUpperCase.Name);
//      2:ConvertStr := ConvertString(FMemo[s].SelText, ActTopUpperCase.Name);
//    end;
//  end;
//  //「半角/全角」「無変換」
//  29,243,244:begin
//    FMemo[s].Tag := FMemo[s].Tag + 1;
//    case FMemo[s].Tag mod 2 of
//      0:ConvertStr := ConvertString(FMemo[s].SelText, ActToMultiByte.Name);
//      1:ConvertStr := ConvertString(FMemo[s].SelText, ActToSingleByte.Name);
//    end;
//  end;
//  else
//    Exit;
//  end;
//
//  SelStart  := FMemo[s].SelStart;
//  //Undo出来るようにするため、EM_REPLACESELメッセージをwParam=1でSendする
//  FMemo[s].Perform(EM_REPLACESEL, 1, Longint(PChar(ConvertStr)));
//  FMemo[s].SelStart  := SelStart;
//  FMemo[s].SelLength := Length(ConvertStr);
//end;

//*****************************************************************************
//[ 概  要 ]　トレイのアイコンの右クリックメニューの｢終了｣選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.menExitClick(Sender: TObject);
begin
  Close;
end;

//*****************************************************************************
{ TClipList }
//*****************************************************************************
//[ 概  要 ]　全体のサイズを取得する
//[ 引  数 ]　TObject
//[ 戻り値 ]　サイズ
//*****************************************************************************
function TClipList.GetSize(): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Self.Count - 1 do begin
    Inc(Result, Length(Self[i]));
  end;
end;

//*****************************************************************************
//[ 概  要 ]　MaxサイズになるIndexを取得する
//[ 引  数 ]　今回追加するサイズ、Maxサイズ
//[ 戻り値 ]　MaxサイズになるIndex
//*****************************************************************************
function TClipList.GetMaxSizeIndex(AddSize: Integer; MaxSize: Integer): Integer;
var
  i,NewSize: Integer;
begin
  NewSize := AddSize;
  for i := 0 to Self.Count -1 do begin
    Inc(NewSize, Length(Self[i]));
    if NewSize > MaxSize then begin
      Result := i;
      Exit;
    end;
  end;
  Result := Self.Count;
end;

//*****************************************************************************
//[ 概  要 ]　UTF8の文字列をWideStringに変換する
//[ 引  数 ]　UTF8の文字列
//[ 戻り値 ]　WideString
//*****************************************************************************
function Utf8Decode(const S: UTF8String): WideString;
var
  InSize, RtnLen: Integer;
  Buf: array of WideChar;
begin
  InSize := Length(S);
  SetLength(Buf,InSize);
  RtnLen := MultiByteToWideChar(CP_UTF8, 0, PAnsiChar(S), InSize, PWideChar(Buf), InSize * 2);
  if RtnLen > 0 then begin
    Result := PWideChar(Buf);
  end;
end;

//*****************************************************************************
//[ 概  要 ]　トレイアイコンクリック時
//            クリップボードチェーンがいつのまにか切れてしまう不具合対応
//[ 引  数 ]　TObjectなど
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.trayIconMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReSetClipboardViewer();
end;

//*****************************************************************************
//[ 概  要 ]　タイマー実行時(300秒間隔)
//            クリップボードチェーンがいつのまにか切れてしまう不具合対応
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.tmTimerTimer(Sender: TObject);
begin
  ReSetClipboardViewer();
end;

//*****************************************************************************
//[ 概  要 ]　クリップボードビューアを再登録
//            クリップボードチェーンがいつのまにか切れてしまう不具合対応
//[ 引  数 ]　なし
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ReSetClipboardViewer();
begin
  //クリップボードビューアから一旦削除
  ChangeClipboardChain(Self.Handle, FNextWnd);
  //クリップボードビューアを再登録
  FClipSet := true;   //WM_DRAWCLIPBOARDが発生するため
  FNextWnd := SetClipboardViewer(Self.Handle);
  FClipSet := false;
end;

end.
