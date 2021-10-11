object FrmAddrBook: TFrmAddrBook
  Left = 553
  Top = 269
  Width = 614
  Height = 497
  Caption = #1040#1076#1088#1077#1089#1085#1072#1103' '#1082#1085#1080#1075#1072
  Color = 11038803
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spnl1: TsPanel
    Left = 0
    Top = 0
    Width = 598
    Height = 53
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'TOOLBAR'
    object btn4: TsSpeedButton
      Tag = 1
      Left = 4
      Top = 6
      Width = 49
      Height = 43
      Cursor = crHandPoint
      AllowAllUp = True
      GroupIndex = 1
      Down = True
      Layout = blGlyphRight
      OnClick = btn4Click
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'BUTTON_BIG'
      ImageIndex = 11
      Images = FrmMain.MediumIcons
      ShowCaption = False
    end
    object btn1: TsSpeedButton
      Tag = 2
      Left = 54
      Top = 6
      Width = 49
      Height = 43
      Cursor = crHandPoint
      AllowAllUp = True
      GroupIndex = 1
      Layout = blGlyphRight
      OnClick = btn4Click
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'BUTTON_BIG'
      ImageIndex = 14
      Images = FrmMain.MediumIcons
      ShowCaption = False
    end
    object btn2: TsSpeedButton
      Tag = 3
      Left = 106
      Top = 6
      Width = 49
      Height = 43
      Cursor = crHandPoint
      AllowAllUp = True
      GroupIndex = 1
      Layout = blGlyphRight
      OnClick = btn4Click
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'BUTTON_BIG'
      ImageIndex = 15
      Images = FrmMain.MediumIcons
      ShowCaption = False
    end
    object chk1: TsCheckBox
      Left = 180
      Top = 20
      Width = 98
      Height = 19
      Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = chk1Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object elv: TEasyListview
    Left = 0
    Top = 53
    Width = 598
    Height = 339
    Hint = 'Default Window Hint'
    Align = alClient
    BackGround.Enabled = True
    CellSizes.Icon.Height = 80
    CellSizes.Icon.Width = 80
    CellSizes.ReportThumb.Height = 40
    CellSizes.Thumbnail.Height = 147
    CellSizes.Thumbnail.Width = 130
    CellSizes.Tile.Height = 62
    CellSizes.Tile.Width = 180
    CellSizes.Report.Height = 40
    CellSizes.Report.Width = 40
    Color = clWhite
    EditManager.Font.Charset = RUSSIAN_CHARSET
    EditManager.Font.Color = clWindowText
    EditManager.Font.Height = -11
    EditManager.Font.Name = 'Tahoma'
    EditManager.Font.Style = []
    UseDockManager = False
    DragManager.DragMode = dmAutomatic
    DragManager.DragType = edtVCL
    DragManager.Enabled = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GroupCollapseButton.Data = {
      7A010000424D7A01000000000000360000002800000009000000090000000100
      2000000000004401000000000000000000000000000000000000D3C2B000B598
      7800B5987800B5987800B5987800B5987800B5987800B5987800D3C2B000B598
      7800BFCCD200AEBEC600A8B8C200A7B8C100A7B8C100A6B7C000AABAC300B598
      7800B5987800D9E1E400CFD8DC00C9D3D800C7D2D700C6D1D600C0CCD200BBC8
      CF00B5987800B5987800EEF2F200ECF0F000E7EDED00E6EBEC00E3E9EA00D9E0
      E300CCD6DB00B5987800B5987800F1F5F5000000000000000000000000000000
      000000000000D2DBDF00B5987800B5987800F5F7F700F5F7F700F4F7F700F4F7
      F700F4F6F600EBF0F100DAE1E500B5987800B5987800FBFCFC00FBFDFD00FBFD
      FD00FBFDFD00FBFCFC00FAFCFC00F3F6F700B5987800B5987800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5987800D3C2B000B598
      7800B5987800B5987800B5987800B5987800B5987800B5987800D3C2B000}
    GroupExpandButton.Data = {
      7A010000424D7A01000000000000360000002800000009000000090000000100
      2000000000004401000000000000000000000000000000000000D3C2B000B598
      7800B5987800B5987800B5987800B5987800B5987800B5987800D3C2B000B598
      7800BFCCD200AEBEC600A8B8C200A7B8C100A7B8C100A6B7C000AABAC300B598
      7800B5987800D9E1E400CFD8DC00C9D3D80000000000C6D1D600C0CCD200BBC8
      CF00B5987800B5987800EEF2F200ECF0F000E7EDED0000000000E3E9EA00D9E0
      E300CCD6DB00B5987800B5987800F1F5F5000000000000000000000000000000
      000000000000D2DBDF00B5987800B5987800F5F7F700F5F7F700F4F7F7000000
      0000F4F6F600EBF0F100DAE1E500B5987800B5987800FBFCFC00FBFDFD00FBFD
      FD0000000000FBFCFC00FAFCFC00F3F6F700B5987800B5987800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5987800D3C2B000B598
      7800B5987800B5987800B5987800B5987800B5987800B5987800D3C2B000}
    GroupFont.Charset = RUSSIAN_CHARSET
    GroupFont.Color = clWindowText
    GroupFont.Height = -11
    GroupFont.Name = 'Tahoma'
    GroupFont.Style = [fsBold]
    HintType = ehtCustomDraw
    Header.Columns.Items = {
      0600000003000000110000005445617379436F6C756D6E53746F726564FFFECE
      00060000000008000100000100000000000001C8000000FFFFFF1F0001000000
      01000000050000001004320442043E0440040000000000000000000000001100
      00005445617379436F6C756D6E53746F726564FFFECE00060000000008000100
      00010100000000000178000000FFFFFF1F000100000001000000030000002204
      3B044404000000000000000000000000110000005445617379436F6C756D6E53
      746F726564FFFECE00060000000008000100000102000000000001B4000000FF
      FFFF1F000100000001000000040000004D00610069006C000000000000000000
      00000000}
    Header.Draggable = False
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Visible = True
    HotTrack.Enabled = True
    HotTrack.Underline = False
    ImagesSmall = FrmMain.sImgList1
    PaintInfoColumn.CaptionLines = 2
    PaintInfoGroup.BandColor = 10485760
    PaintInfoGroup.BandFullWidth = True
    PaintInfoGroup.BandThickness = 1
    PaintInfoGroup.CaptionIndent = 5
    PaintInfoGroup.MarginBottom.CaptionIndent = 4
    PaintInfoItem.Border = 2
    PaintInfoItem.BorderColor = clSilver
    PaintInfoItem.CaptionIndent = 1
    PaintInfoItem.CaptionLines = 2
    PaintInfoItem.ImageIndent = 3
    PaintInfoItem.TileDetailCount = 3
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Selection.AlphaBlend = True
    Selection.AlphaBlendSelRect = True
    Selection.BlendAlphaImage = 120
    Selection.BlendAlphaTextRect = 160
    Selection.BlendIcon = False
    Selection.BorderColor = clGray
    Selection.FullCellPaint = True
    Selection.FullItemPaint = True
    Selection.FullRowSelect = True
    Selection.InactiveBorderColor = 16744576
    Selection.InactiveColor = clGray
    Selection.MouseButton = [cmbLeft, cmbRight]
    Selection.RectSelect = True
    Selection.UseFocusRect = False
    TabOrder = 1
    Themed = False
    OnGroupPaintText = elvGroupPaintText
    OnHintCustomInfo = elvHintCustomInfo
    OnHintCustomDraw = elvHintCustomDraw
    OnHintPauseTime = elvHintPauseTime
    OnHintPopup = elvHintPopup
    OnItemFocusChanging = elvItemFocusChanging
    OnItemImageDraw = elvItemImageDraw
    OnItemImageGetSize = elvItemImageGetSize
    OnItemImageDrawIsCustom = elvItemImageDrawIsCustom
    OnItemPaintText = elvItemPaintText
    OnResize = elvResize
  end
  object spnl2: TsPanel
    Left = 0
    Top = 392
    Width = 598
    Height = 69
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object img1: TImage
      Left = 4
      Top = 8
      Width = 44
      Height = 53
      Center = True
      Proportional = True
    end
    object lbl1: TsLabelFX
      Left = 56
      Top = 24
      Width = 18
      Height = 18
      Caption = 'lbl'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15523270
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    MakeSkinMenu = True
    ScreenSnap = True
    TitleButtons = <>
    Left = 104
    Top = 364
  end
  object qry1: TADOQuery
    Connection = FrmMain.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from TContact Order By LastName,FirstName')
    Left = 312
    Top = 201
  end
  object qry2: TADOQuery
    Connection = FrmMain.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'Select * from TFaces')
    Left = 312
    Top = 229
  end
end
