object MainForm: TMainForm
  Left = 350
  Top = 200
  BorderIcons = [biSystemMenu]
  Caption = #12463#12522#12483#12503#12508#12540#12489#23653#27508
  ClientHeight = 336
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 175
    Width = 292
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 179
    ExplicitWidth = 300
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 292
    Height = 22
    AutoSize = True
    ButtonWidth = 100
    Caption = 'ToolBar1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS UI Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object btnGet: TSpeedButton
      Left = 0
      Top = 0
      Width = 75
      Height = 22
      Action = ActGetData
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object btnSave: TSpeedButton
      Left = 75
      Top = 0
      Width = 75
      Height = 22
      Hint = #36984#25246#12373#12428#12383#12487#12540#12479#12434#20445#23384#12375#12414#12377
      Action = ActSaveData
      Caption = #20445#31649'(&S)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object btnAllClear: TSpeedButton
      Left = 150
      Top = 0
      Width = 75
      Height = 22
      Hint = #23653#27508#12434#12377#12409#12390#21066#38500#12375#12414#12377
      Action = ActAllClear
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object btnClose: TSpeedButton
      Left = 225
      Top = 0
      Width = 75
      Height = 22
      Hint = #12501#12457#12540#12512#12434#38281#12376#12390#12289#12479#12473#12463#12488#12524#12452#12395#25147#12426#12414#12377
      Caption = #38281#12376#12427'(&C)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS UI Gothic'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = CloseClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 22
    Width = 292
    Height = 153
    ActivePage = tabHistory
    Align = alTop
    PopupMenu = popListMenu
    TabOrder = 1
    object tabHistory: TTabSheet
      Caption = #23653#27508
      object lstHistory: TListBox
        Left = 0
        Top = 0
        Width = 284
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ItemHeight = 12
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11')
        ParentFont = False
        PopupMenu = popListMenu
        TabOrder = 0
        OnClick = ListBoxClick
        OnDblClick = ActGetDataExecute
      end
    end
    object tabHTML: TTabSheet
      Caption = 'HTML'
      object lstHTML: TListBox
        Left = 0
        Top = 0
        Width = 284
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ItemHeight = 12
        ParentFont = False
        PopupMenu = popListMenu
        TabOrder = 0
        OnClick = ListBoxClick
        OnDblClick = ActGetDataExecute
      end
    end
    object tabFile: TTabSheet
      Caption = #12501#12449#12452#12523#21517
      object lstFile: TListBox
        Left = 0
        Top = 0
        Width = 284
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ItemHeight = 12
        ParentFont = False
        PopupMenu = popListMenu
        TabOrder = 0
        OnClick = ListBoxClick
        OnDblClick = ActGetDataExecute
      end
    end
    object tabDebug: TTabSheet
      Caption = 'Debug'
      object lstDebug: TListBox
        Left = 0
        Top = 0
        Width = 284
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ItemHeight = 12
        ParentFont = False
        TabOrder = 0
      end
    end
    object tabPicture: TTabSheet
      Caption = #30011#20687
      object lstPicture: TListBox
        Left = 0
        Top = 0
        Width = 284
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ItemHeight = 12
        ParentFont = False
        PopupMenu = popListMenu
        TabOrder = 0
        OnClick = ListBoxClick
        OnDblClick = ActGetDataExecute
      end
    end
    object tabSave: TTabSheet
      Caption = #20445#31649
      object lstSave: TListBox
        Left = 0
        Top = 0
        Width = 284
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ItemHeight = 12
        ParentFont = False
        PopupMenu = popListMenu
        TabOrder = 0
        OnClick = ListBoxClick
        OnDblClick = ActGetDataExecute
      end
    end
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 178
    Width = 292
    Height = 158
    ActivePage = tabClipboard
    Align = alClient
    PopupMenu = popMemoMenu
    TabOrder = 2
    object tabClipboard: TTabSheet
      Caption = #12463#12522#12483#12503#12508#12540#12489#12398#20013#36523
      object memDisplay: TMemo
        Left = 0
        Top = 0
        Width = 284
        Height = 130
        Align = alClient
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        Lines.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11')
        ParentFont = False
        PopupMenu = popMemoMenu
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object pnlHTML: TPanel
        Left = 0
        Top = 0
        Width = 284
        Height = 130
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        object WebBrowser: TWebBrowser
          Left = 1
          Top = 1
          Width = 282
          Height = 128
          Align = alClient
          PopupMenu = popMemoMenu
          TabOrder = 0
          OnNewWindow2 = WebBrowserNewWindow2
          ControlData = {
            4C000000251D00003B0D00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object scrImage: TScrollBox
        Left = 0
        Top = 0
        Width = 284
        Height = 130
        Align = alClient
        Color = clWhite
        ParentColor = False
        TabOrder = 2
        object imgImage: TImage
          Left = 0
          Top = 0
          Width = 288
          Height = 138
          AutoSize = True
        end
      end
    end
    object tabMemo: TTabSheet
      Caption = #12513#12514#26360#12365
      object memMemo: TMemo
        Left = 0
        Top = 0
        Width = 284
        Height = 130
        Align = alClient
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS UI Gothic'
        Font.Style = []
        ParentFont = False
        PopupMenu = popMemoMenu
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object trayIcon: TTrayIcon
    Hint = #12463#12522#12483#12503#12508#12540#12489#23653#27508
    PopupMenu = popTrayMenu
    Visible = True
    OnClick = ActFormShowExecute
    Left = 224
    Top = 74
  end
  object popTrayMenu: TPopupMenu
    Left = 216
    Top = 120
    object menShowForm: TMenuItem
      Action = ActFormShow
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object menExit: TMenuItem
      Caption = #32066#20102'(&X)'
      OnClick = menExitClick
    end
  end
  object popMemoMenu: TPopupMenu
    Left = 24
    Top = 216
    object menCut: TMenuItem
      Action = EditCut
    end
    object menCopy: TMenuItem
      Action = EditCopy
    end
    object menPaste: TMenuItem
      Action = EditPaste
    end
    object menDel: TMenuItem
      Action = EditDelete
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menUndo: TMenuItem
      Action = EditUndo
    end
    object menSelectAll: TMenuItem
      Action = EditSelectAll
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menLowerCase: TMenuItem
      Action = ActLowerCase
    end
    object menUpperCase: TMenuItem
      Action = ActUpperCase
    end
    object menTopUpperCase: TMenuItem
      Action = ActTopUpperCase
    end
    object menToMultiByte: TMenuItem
      Action = ActToMultiByte
    end
    object menToSingleByte: TMenuItem
      Action = ActToSingleByte
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object menHelp2: TMenuItem
      Caption = #35500#26126'(&H)'
      OnClick = menHelpClick
    end
  end
  object popListMenu: TPopupMenu
    Left = 88
    Top = 96
    object menGetData: TMenuItem
      Action = ActGetData
      ShortCut = 13
    end
    object menSave: TMenuItem
      Action = ActSaveData
      Caption = #20445#31649'(&S)'
    end
    object menDelData: TMenuItem
      Action = ActDelData
      ShortCut = 46
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object menHelp: TMenuItem
      Caption = #35500#26126'(&H)'
      OnClick = menHelpClick
    end
  end
  object ActionList: TActionList
    Left = 120
    Top = 256
    object EditCut: TEditCut
      Category = #32232#38598
      Caption = #20999#12426#21462#12426'(&T)'
      Hint = #20999#12426#21462#12426'|'#36984#25246#37096#20998#12434#20999#12426#21462#12426#12289#12463#12522#12483#12503#12508#12540#12489#12395#36865#12427
      ShortCut = 16472
    end
    object EditCopy: TEditCopy
      Category = #32232#38598
      Caption = #12467#12500#12540'(&C)'
      Hint = #12467#12500#12540'|'#36984#25246#31684#22258#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540
      ShortCut = 16451
    end
    object EditPaste: TEditPaste
      Category = #32232#38598
      Caption = #36028#12426#20184#12369'(&P)'
      Hint = #36028#12426#20184#12369'|'#12463#12522#12483#12503#12508#12540#12489#12398#20869#23481#12434#36028#12426#20184#12369#12427
      ShortCut = 16470
    end
    object EditSelectAll: TEditSelectAll
      Category = #32232#38598
      Caption = #12377#12409#12390#36984#25246'(&A)'
      Hint = #12377#12409#12390#12434#36984#25246'|'#12489#12461#12517#12513#12531#12488#20840#20307#12434#36984#25246#12377#12427
      ShortCut = 16449
    end
    object EditUndo: TEditUndo
      Category = #32232#38598
      Caption = #20803#12395#25147#12377'(&U)'
      Hint = #20803#12395#25147#12377'|'#30452#21069#12398#22793#26356#12434#20803#12395#25147#12377
      ShortCut = 16474
    end
    object EditDelete: TEditDelete
      Category = #32232#38598
      Caption = #21066#38500'(&D)'
      Hint = #21066#38500'|'#36984#25246#37096#20998#12434#21066#38500#12377#12427
    end
    object ActGetData: TAction
      Category = #12450#12463#12471#12519#12531
      Caption = #21462#12426#20986#12375'(&G)'
      Hint = #12463#12522#12483#12503#12508#12540#12489#12395#12487#12540#12479#12434#21462#12426#20986#12375#12414#12377
      OnExecute = ActGetDataExecute
      OnUpdate = ActionUpdate
    end
    object ActSaveData: TAction
      Category = #12450#12463#12471#12519#12531
      Caption = #20445#23384'(&S)'
      OnExecute = ActSaveDataExecute
      OnUpdate = ActionUpdate
    end
    object ActDelData: TAction
      Category = #12450#12463#12471#12519#12531
      Caption = #21066#38500'(&D)'
      OnExecute = ActDelDataExecute
      OnUpdate = ActionUpdate
    end
    object ActAllClear: TAction
      Category = #12450#12463#12471#12519#12531
      Caption = #20840#28040#21435'(&A)'
      OnExecute = ActAllClearExecute
      OnUpdate = ActAllClearUpdate
    end
    object ActFormShow: TAction
      Category = #12450#12463#12471#12519#12531
      Caption = #12501#12457#12540#12512#12398#34920#31034'(&H)...'
      OnExecute = ActFormShowExecute
    end
    object ActLowerCase: TAction
      Category = #22793#25563
      Caption = #23567#25991#23383#12395#22793#25563
      OnExecute = ActConvertExecute
      OnUpdate = ActConvertUpdate
    end
    object ActUpperCase: TAction
      Category = #22793#25563
      Caption = #22823#25991#23383#12395#22793#25563
      OnExecute = ActConvertExecute
      OnUpdate = ActConvertUpdate
    end
    object ActTopUpperCase: TAction
      Category = #22793#25563
      Caption = #20808#38957#12398#12415#22823#25991#23383#12395#22793#25563
      OnExecute = ActConvertExecute
      OnUpdate = ActConvertUpdate
    end
    object ActToMultiByte: TAction
      Category = #22793#25563
      Caption = #20840#35282#12395#22793#25563
      OnExecute = ActConvertExecute
      OnUpdate = ActConvertUpdate
    end
    object ActToSingleByte: TAction
      Category = #22793#25563
      Caption = #21322#35282#12395#22793#25563
      OnExecute = ActConvertExecute
      OnUpdate = ActConvertUpdate
    end
  end
  object popWebMenu: TPopupMenu
    Left = 64
    Top = 224
    object menWebCopy: TMenuItem
      Caption = #12467#12500#12540'(&C)'
      Hint = #12467#12500#12540'|'#36984#25246#31684#22258#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540
      ShortCut = 16451
      OnClick = menWebCopyClick
    end
    object menWebAllSelect: TMenuItem
      Caption = #12377#12409#12390#36984#25246'(&A)'
      Hint = #12377#12409#12390#12434#36984#25246'|'#12489#12461#12517#12513#12531#12488#20840#20307#12434#36984#25246#12377#12427
      ShortCut = 16449
      OnClick = menWebAllSelectClick
    end
    object MenuItem8: TMenuItem
      Caption = '-'
    end
    object menJumpURL: TMenuItem
      Caption = 'URL'#12434#38283#12367'(&J)'
      OnClick = menJumpURLClick
    end
    object menShowSource: TMenuItem
      Caption = #12477#12540#12473#12434#34920#31034'(&V)'
      OnClick = menShowSourceClick
    end
    object MenuItem14: TMenuItem
      Caption = '-'
    end
    object MenuItem15: TMenuItem
      Caption = #35500#26126'(&H)'
      OnClick = menHelpClick
    end
  end
  object tmTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmTimerTimer
    Left = 152
    Top = 104
  end
end
