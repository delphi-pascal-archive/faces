unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExForms, JvCustomItemViewer, JvOwnerDrawViewer, StdCtrls,
  sRadioButton, Buttons, sSpeedButton, ExtCtrls, JvExExtCtrls, JvShape,
  sPanel, sDialogs, sSkinManager, DB, PngImageList, ImgList, jpeg, GifImage,
  acAlphaImageList, ComCtrls, sPageControl,
  sSkinProvider, sStatusBar, Menus, ExtDlgs, sCheckBox, sLabel, ADODB, VirtualTrees;

type
  TFrmMain = class(TForm)
    sImgList2: TsAlphaImageList;
    FImgCol: TPngImageCollection;
    MImgCol: TPngImageCollection;
    ds1: TDataSource;
    sSkinManager1: TsSkinManager;
    dlg1: TsColorDialog;
    sSkinProvider1: TsSkinProvider;
    mm1: TMainMenu;
    N1: TMenuItem;
    spnl2: TsPanel;
    btn4: TsSpeedButton;
    btn5: TsSpeedButton;
    btn6: TsSpeedButton;
    btn7: TsSpeedButton;
    btn8: TsSpeedButton;
    rb1: TsRadioButton;
    rb12: TsRadioButton;
    chk1: TsCheckBox;
    spnl1: TsPanel;
    JvDrawViewer2: TJvOwnerDrawViewer;
    spnl3: TsPanel;
    sStatusBar1: TsStatusBar;
    N2: TMenuItem;
    pm1: TPopupMenu;
    Copy1: TMenuItem;
    dlg3: TsSavePictureDialog;
    dlg2: TsSaveDialog;
    SavetoFile1: TMenuItem;
    sImgList1: TsAlphaImageList;
    spnl4: TsPanel;
    JvrDrawViewer: TJvOwnerDrawViewer;
    spnl5: TsPanel;
    img1: TImage;
    btn1: TsSpeedButton;
    btn2: TsSpeedButton;
    JvShape1: TJvShape;
    lbl1: TsLabel;
    pm2: TPopupMenu;
    Copy2: TMenuItem;
    N3: TMenuItem;
    ADOConnection1: TADOConnection;
    qry1: TADOQuery;
    qry2: TADOQuery;
    MediumIcons: TPngImageList;
    procedure JvDrawViewer2DrawItem(Sender: TObject; Index: Integer;
      State: TCustomDrawState; Canvas: TCanvas; ItemRect, TextRect: TRect);
    procedure FormShow(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure JvrDrawViewerDrawItem(Sender: TObject; Index: Integer;
      State: TCustomDrawState; Canvas: TCanvas; ItemRect, TextRect: TRect);
    procedure JvDrawViewer2ItemChanged(Sender: TObject;
      Item: TJvViewerItem);
    procedure JvrDrawViewerItemChanged(Sender: TObject;
      Item: TJvViewerItem);
    procedure Copy1Click(Sender: TObject);
    procedure SavetoFile1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FSex: string;
    FColor: string;
    procedure ColorasX11;
    procedure ImgFaces(DataSet: TDataSet; aID: Integer; var OutBmp: TBitmap;
      Select, PColor: Tcolor; aGradient: Boolean);
    procedure CopyToClipboard;
  end;

var
  FrmMain           : TFrmMain;

implementation

uses
  JvJVCLUtils,
  JvDBUtils,
  jclStrings,
  JvgUtils,
  JvgTypes,
  sGraphUtils,
  sSkinProps,
  pngimage,
  UOptions,
  Clipbrd, UAddrBook;

{$R *.dfm}

{ TFrmMain }

procedure TFrmMain.ColorasX11;
var
  I                 : Integer;
begin
  JvDrawViewer2.Count := 140;
  for I := 0 to 139 do
  begin
    JvDrawViewer2.Items[i].Data := Pointer(asX11ColorValues[I]);
  end;

end;

procedure TFrmMain.JvDrawViewer2DrawItem(Sender: TObject; Index: Integer;
  State: TCustomDrawState; Canvas: TCanvas; ItemRect, TextRect: TRect);
var
  AColor            : TColor;
  R                 : TRect;
begin
  AColor := TColor(JvDrawViewer2.Items[Index].Data);
  Canvas.Brush.Color := AColor;
  Canvas.FillRect(ItemRect);
  Canvas.Pen.Style := psSolid;
  if [cdsSelected, cdsHot] * State <> [] then
  begin
    Canvas.Pen.Color := clHighlight;
    Canvas.Pen.Width := 2;
    Inc(ItemRect.Left);
    Inc(ItemRect.Top);
    Canvas.Rectangle(ItemRect);
    Dec(ItemRect.Left);
    Dec(ItemRect.Top);
  end
  else
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 1;
    Canvas.Rectangle(ItemRect);
    R := Rect(ItemRect.Left + 5, ItemRect.Top + 5, ItemRect.Right - 5,ItemRect.Bottom - 5);

  end;

end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  ColorasX11;
  FSex := 'M';
  
end;

procedure TFrmMain.btn4Click(Sender: TObject);
var
  i                 : Integer;
begin
  JvrDrawViewer.Clear;
  with qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(Format('Select * from TFaces where %s and %s',
      [FormatSQLCondition('Sex', '=', FSex, ftString, True),
      FormatSQLCondition('NUM', '=', IntToStr(TsSpeedButton(Sender).Tag),
        ftInteger, False)]));
    Open;
    i := 0;
    JvrDrawViewer.Count := RecordCount;
    First;
    while not Eof do
    begin
      JvrDrawViewer.Items[i].Data := Pointer(FieldByName('ID').AsInteger);
      Inc(i);
      Next;
    end;
    //Close;
  end;

end;

procedure TFrmMain.rb1Click(Sender: TObject);
begin
  case TsRadioButton(Sender).Tag of
    1:
      begin
        btn4.ImageIndex := 0;
        btn5.ImageIndex := 1;
        btn6.ImageIndex := 2;
        btn7.ImageIndex := 3;
        btn8.ImageIndex := 4;
        FSex := 'M';
        btn4Click(Self);
      end;
    2:
      begin
        btn4.ImageIndex := 5;
        btn5.ImageIndex := 6;
        btn6.ImageIndex := 7;
        btn7.ImageIndex := 8;
        btn8.ImageIndex := 9;
        FSex := 'F';
        btn4Click(Self);
      end;
  end;
end;

procedure TFrmMain.ImgFaces(DataSet: TDataSet; aID: Integer; var OutBmp:
  TBitmap; Select, PColor: Tcolor; aGradient: Boolean);
var
  bmp               : TBitmap;
  png               : TPNGObject;
   j              : Integer;
  oTmp              : TStringList;
begin
  bmp := CreateBmp32(40, 40);
  png := TPNGObject.Create;
  oTmp := TStringList.Create;
  with DataSet do
  begin
    try
      if Locate('ID', aID, []) then
      begin
        bmp.Canvas.Brush.Color := Select;
        bmp.Canvas.FillRect(Bounds(0, 0, 64, 64));
        if aGradient then
          GradientFillRect(bmp.Canvas,
            bmp.Canvas.ClipRect,
            $FEFDFC,
            $F3C8BD,
            fdTopToBottom,
            255);

        if FieldByName('SEX').Value = 'M' then
        begin

          j := FieldByName('TULOV').AsInteger;
          //туловище
          png.Assign(MImgCol.Items[j].PngImage);
          colorizer(ColorDarkenMultiplier(PColor, 0.5), png);
          png.Draw(bmp.Canvas, Rect(0, 0, 64, 64));
          //Галстук
          j := FieldByName('GALST').AsInteger;
          MImgCol.Items[j].PngImage.Draw(bmp.Canvas, Rect(0, 0, 64, 64));
          //голова
          MImgCol.Items[FieldByName('GOLOVA').AsInteger].PngImage.Draw(bmp.Canvas,
            Rect(0, 0, 64, 32));

          if FieldByName('KEP').AsInteger <> -1 then
          begin
            png.Assign(MImgCol.Items.Items[0].PngImage);
            colorizer(ColorDarkenMultiplier(PColor, 0.5), png);
            png.Draw(bmp.Canvas, Rect(0, 0, 64, 32));
          end;

          DrawTransparentBitmap(OutBmp.Canvas, 0, 0, 0, 0, Rect(4, 0, 40, 40), bmp, clNone);

        end
        else if FieldByName('SEX').Value = 'F' then
        begin
          j := FieldByName('TULOV').AsInteger;
          //туловище
          png.Assign(FImgCol.Items[j].PngImage);
          colorizer(ColorDarkenMultiplier(PColor, 0.4), png);
          png.Draw(bmp.Canvas, Rect(0, 0, 64, 64));
          //Галстук
          j := FieldByName('GALST').AsInteger;
          FImgCol.Items[j].PngImage.Draw(bmp.Canvas, Rect(0, 0, 64, 64));
          //голова
          FImgCol.Items[FieldByName('GOLOVA').AsInteger].PngImage.Draw(bmp.Canvas,
            Rect(0, 0, 64, 32));

          if FieldByName('KEP').AsInteger <> -1 then
          begin
            png.Assign(FImgCol.Items.Items[0].PngImage);
            colorizer(ColorDarkenMultiplier(PColor, 0.4), png);
            png.Draw(bmp.Canvas, Rect(0, 0, 64, 32));
          end;

          DrawTransparentBitmap(OutBmp.Canvas, 0, 0, 0, 0, Rect(4, 0, 40, 40), bmp, clNone);
          
        end;
      end;

    finally
      FreeAndNil(bmp);
      FreeAndNil(png);
      FreeAndNil(oTmp);
    end;
  end;

end;

procedure TFrmMain.JvrDrawViewerDrawItem(Sender: TObject; Index: Integer;
  State: TCustomDrawState; Canvas: TCanvas; ItemRect, TextRect: TRect);
var
  gg                : Integer;
  OutBmp            : TBitmap;
  R                 : TRect;
begin
  gg := Integer(JvrDrawViewer.Items[Index].Data);
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(ItemRect);
  OutBmp := CreateBmp32(35, 35);
  try

    if [cdsSelected, cdsHot] * State <> [] then
    begin
      Canvas.Pen.Color := clHighlight;
      Canvas.Pen.Width := 2;
      Inc(ItemRect.Left);
      Inc(ItemRect.Top);
      ImgFaces(qry1, gg, OutBmp, clHighlight, JvShape1.Brush.Color, true);
      Canvas.Rectangle(ItemRect);

      DrawBitmapInRect(Canvas, ItemRect, OutBmp);
      Canvas.Brush.Color := JvrDrawViewer.Color;

      Dec(ItemRect.Left);
      Dec(ItemRect.Top);
    end
    else
    begin

      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := clBlack;
      Canvas.Pen.Width := 1;
      ImgFaces(qry1, gg, OutBmp, clWhite, JvShape1.Brush.Color, true);
      Canvas.Rectangle(ItemRect);
      R := Rect(ItemRect.Left + 5, ItemRect.Top, ItemRect.Right,  ItemRect.Bottom);
      DrawBitmapInRect(Canvas, ItemRect, OutBmp);
      Canvas.Brush.Color := JvrDrawViewer.Color;

    end;
  finally
    FreeAndNil(OutBmp);
  end;

end;

procedure TFrmMain.JvDrawViewer2ItemChanged(Sender: TObject;
  Item: TJvViewerItem);
begin
  if (JvDrawViewer2.SelectedIndex >= 0) and (JvDrawViewer2.SelectedIndex < JvDrawViewer2.Count) then
  begin
    JvShape1.Brush.Color :=  TColor(JvDrawViewer2.Items[JvDrawViewer2.SelectedIndex].Data);
    FColor := ColorToString(JvShape1.Brush.Color);
    lbl1.Caption := FColor;
    JvrDrawViewer.Repaint;
  end;
end;

procedure TFrmMain.JvrDrawViewerItemChanged(Sender: TObject;
  Item: TJvViewerItem);
const
  AMirror           : Integer = 15;
var
  OutBmp,  ARefBitmap: TBitmap;
  
begin
  if (JvrDrawViewer.SelectedIndex >= 0) and
    (JvrDrawViewer.SelectedIndex < JvrDrawViewer.Count) then
  begin
    OutBmp := CreateBmp32(36, 33);

    ARefBitmap := TBitmap.Create;
    qry2.Close;
    qry2.SQL.Assign(qry1.SQL);
    qry2.Open;
    sStatusBar1.Panels[0].Text := 'ID: '+
      IntToStr(Integer(JvrDrawViewer.Items[JvrDrawViewer.SelectedIndex].Data));
    ImgFaces(qry2, Integer(JvrDrawViewer.Items[JvrDrawViewer.SelectedIndex].Data),
      OutBmp,  clWhite, JvShape1.Brush.Color, true);
    if chk1.Checked then
    begin
      MakeReflected(ARefBitmap, OutBmp, AMirror, true);

      img1.Picture.Assign(ARefBitmap); //
    end
    else
    begin
       img1.Picture.Assign(OutBmp);

    end;
    FreeAndNil(OutBmp);
    FreeAndNil(ARefBitmap);

  end;
end;

procedure TFrmMain.CopyToClipboard;
begin
  if img1.Picture.Graphic <> nil then
    Clipboard.Assign(img1.Picture);
end;

procedure TFrmMain.Copy1Click(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TFrmMain.SavetoFile1Click(Sender: TObject);
var
  GifBmp            : TGIFImage;
  PngBmp            : TPNGObject;
  JpgBmp            : TJPEGImage;
begin
  with dlg2 do
  begin
    FileName := '';
    if not Execute then
      Exit;
    try
      GifBmp := TGIFImage.Create;
      PngBmp := TPNGObject.Create;
      JpgBmp := TJPEGImage.Create;
      if AnsiUpperCase(ExtractFileExt(FileName)) = '.GIF' then
      begin
        GifBmp.Assign(Img1.Picture.Bitmap);
        GifBmp.SaveToFile(FileName);
      end                     //End Gif
      else if AnsiUpperCase(ExtractFileExt(FileName)) = '.PNG' then
      begin
        PngBmp.Assign(Img1.Picture.Bitmap);
        PngBmp.SaveToFile(FileName);
      end                     //End Png
      else if AnsiUpperCase(ExtractFileExt(FileName)) = '.JPG' then
      begin
        JpgBmp.Assign(Img1.Picture.Bitmap);
        JpgBmp.SaveToFile(FileName);
      end;                    //End JPG

    finally
      GifBmp.Free;
      PngBmp.Free;
      JpgBmp.Free;
    end;                      //End Try Finally
  end;                        //End With

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ADOConnection1.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
    ExtractFileDir(Application.ExeName) + '\Data\db.Mdb';
  ADOConnection1.Connected := True;
end;

procedure TFrmMain.Copy2Click(Sender: TObject);
begin
  Clipboard.AsText := lbl1.Caption;
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
  FrmAddrBook.ShowAddrBookDlg;
end;

procedure TFrmMain.N2Click(Sender: TObject);
begin
Close;
end;

end.

