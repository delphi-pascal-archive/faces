unit UAddrBook;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, sPanel, sSkinProvider, MPCommonObjects, EasyListview,
  DB,   ADODB, Buttons, sSpeedButton, StdCtrls, sLabel, sCheckBox;

type
    TLVAvtorInfo = class
    public
    FID,FIconNum:Integer;
    FName,FMail,FPhone:WideString;
    FPColor:string;
    end;


  TFrmAddrBook = class(TForm)
    sSkinProvider1: TsSkinProvider;
    spnl1: TsPanel;
    elv: TEasyListview;
    qry1: TADOQuery;
    qry2: TADOQuery;
    btn4: TsSpeedButton;
    btn1: TsSpeedButton;
    btn2: TsSpeedButton;
    spnl2: TsPanel;
    chk1: TsCheckBox;
    img1: TImage;
    lbl1: TsLabelFX;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure elvItemPaintText(Sender: TCustomEasyListview;
      Item: TEasyItem; Position: Integer; ACanvas: TCanvas);
    procedure elvItemImageGetSize(Sender: TCustomEasyListview;
      Item: TEasyItem; Column: TEasyColumn; var ImageWidth,
      ImageHeight: Integer);
    procedure elvItemImageDrawIsCustom(Sender: TCustomEasyListview;
      Item: TEasyItem; Column: TEasyColumn; var IsCustom: Boolean);
    procedure elvItemImageDraw(Sender: TCustomEasyListview;
      Item: TEasyItem; Column: TEasyColumn; ACanvas: TCanvas;
      const RectArray: TEasyRectArrayObject;
      AlphaBlender: TEasyAlphaBlender);
    procedure btn4Click(Sender: TObject);
    procedure elvResize(Sender: TObject);
    procedure elvHintCustomInfo(Sender: TCustomEasyListview;
      TargetObj: TEasyCollectionItem; Info: TEasyHintInfo);
    procedure elvHintPopup(Sender: TCustomEasyListview;
      TargetObj: TEasyCollectionItem; HintType: TEasyHintType;
      MousePos: TPoint; var AText: WideString; var HideTimeout,
      ReShowTimeout: Integer; var Allow: Boolean);
    procedure elvHintPauseTime(Sender: TCustomEasyListview;
      HintWindowShown: Boolean; var PauseDelay: Integer);
    procedure elvHintCustomDraw(Sender: TCustomEasyListview;
      TargetObj: TEasyCollectionItem; const Info: TEasyHintInfo);
    procedure elvGroupPaintText(Sender: TCustomEasyListview;
      Group: TEasyGroup; ACanvas: TCanvas);
    procedure chk1Click(Sender: TObject);
    procedure elvItemFocusChanging(Sender: TCustomEasyListview;
      Item: TEasyItem; var Allow: Boolean);
  private
    { Private declarations }
     procedure MapImageCustomImageSize(var ImageHeight, ImageWidth: Integer);
  public
    { Public declarations }
    procedure ShowAddrBookDlg;
    procedure LoadAddrBookData;
  end;

var
  FrmAddrBook: TFrmAddrBook;



implementation

uses
  UMain,
  ASStrUtils,
  JvJVCLUtils,
  JvDBUtils,
  jclStrings,
  JvgUtils,
  JvgTypes,
  sGraphUtils,
  sSkinProps,
  pngimage,
  UOptions,
  Clipbrd,
  MPCommonUtilities, sSkinManager;

{$R *.dfm}

{ TFrmAddrBook }

procedure TFrmAddrBook.ShowAddrBookDlg;
begin
 with TFrmAddrBook.Create(Application) do
 begin
   try

     ShowModal;
   finally
     Free;
   end;

 end;

end;

procedure TFrmAddrBook.FormShow(Sender: TObject);
begin
qry1.Open;
qry2.Open;
LoadAddrBookData;
lbl1.Caption := '';
end;

procedure TFrmAddrBook.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
qry1.Close;
qry2.Close;
end;

procedure TFrmAddrBook.LoadAddrBookData;
var
  Item :TEasyItem ;
  LVAvtorInfo :TLVAvtorInfo;
begin
   with elv,qry1 do
    begin
     BeginUpdate;
      try
        Items.Clear;
         if not Active then Open;
         if RecordCount <= 0  then Exit;
          First;
           while not Eof do
            begin
             LVAvtorInfo := TLVAvtorInfo.Create;
             LVAvtorInfo.FID := FieldByName('ID').AsInteger;
             LVAvtorInfo.FName := FieldByName('LastName').AsString + ' '+
              FieldByName('FirstName').AsString;
             LVAvtorInfo.FPhone := FieldByName('Phone').AsString;
             LVAvtorInfo.FMail :=  FieldByName('Mail').AsString;
             LVAvtorInfo.FIconNum := FieldByName('IconNum').AsInteger;
             LVAvtorInfo.FPColor := FieldByName('IconColor').AsString;

             if Application.Terminated then Exit;
             Item := Items.Add;
             Item.Caption := LVAvtorInfo.FName;
             Item.Captions[1]:= LVAvtorInfo.FPhone;
             Item.Captions[2]:= AsConvertURLToFilename(LVAvtorInfo.FMail);
             Item.Details[0] := 0;
             Item.Details[1] := 1;
             Item.Details[2] := 2;
             Item.ImageIndex := 1;
             Item.Data := LVAvtorInfo;

             Next;

            end;

      finally
       //elv.Sort.AutoRegroup := true;
       elv.Sort.ReGroup(elv.Header.Columns[0]);
       EndUpdate;
      end;

    end;

end;

procedure TFrmAddrBook.elvItemPaintText(Sender: TCustomEasyListview;
  Item: TEasyItem; Position: Integer; ACanvas: TCanvas);
begin
 case Position of
   0 : begin
        if elv.View in [ elsTile] then
        ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

       end;
   1 : ACanvas.Font.Color := clRed;
   2:  begin ;
       ACanvas.Font.Color :=
       FrmMain.sSkinManager1.gd[FrmMain.sSkinManager1.ConstData.IndexGLobalInfo].FontColor[5]; //clBlue;
       ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];
       end;
  end;
end;

procedure TFrmAddrBook.MapImageCustomImageSize(var ImageHeight,
  ImageWidth: Integer);
begin
case elv.View of
    elsIcon,
    elsReport:
      begin
        ImageWidth := 40;
        ImageHeight := 40;
      end;
    elsSmallIcon,
    elsList,
    elsGrid:
      begin
        ImageWidth := 16;
        ImageHeight := 16;
      end;
    elsThumbnail,
    elsFilmStrip,
    elsTile:
      begin
        ImageWidth := 40;
        ImageHeight := 48;
      end;
  end;
end;

procedure TFrmAddrBook.elvItemImageGetSize(Sender: TCustomEasyListview;
  Item: TEasyItem; Column: TEasyColumn; var ImageWidth,
  ImageHeight: Integer);
begin
MapImageCustomImageSize(ImageWidth, ImageHeight);
end;

procedure TFrmAddrBook.elvItemImageDrawIsCustom(
  Sender: TCustomEasyListview; Item: TEasyItem; Column: TEasyColumn;
  var IsCustom: Boolean);
begin
 if elv.View in [elsTile,elsIcon,elsThumbnail,elsReport] then
  IsCustom := True
  else
  IsCustom := False;
end;

procedure TFrmAddrBook.elvItemImageDraw(Sender: TCustomEasyListview;
  Item: TEasyItem; Column: TEasyColumn; ACanvas: TCanvas;
  const RectArray: TEasyRectArrayObject; AlphaBlender: TEasyAlphaBlender);
const
  AMirror           : Integer = 15;
var
  OutBmp,  ARefBitmap: TBitmap;
begin
 if elv.View in [elsTile] then
   begin
    OutBmp := CreateBmp32(36, 33);
    ARefBitmap := TBitmap.Create;
     try
    FrmMain.ImgFaces(qry2,
      TLVAvtorInfo(Item.data).FIconNum,
      OutBmp,
      clWhite,StringToColor(TLVAvtorInfo(Item.data).FPColor),true);
      MakeReflected(ARefBitmap, OutBmp, 15,true);
      AlphaBlender.Blend(elv, Item, ACanvas, RectArray.IconRect, ARefBitmap);
     finally
     FreeAndNil(OutBmp);
     FreeAndNil(ARefBitmap);
     end;

   end
  else  if elv.View in [elsIcon] then
   begin
    OutBmp := CreateBmp32(36, 36);
    ARefBitmap := TBitmap.Create;
     try
    FrmMain.ImgFaces(qry2, TLVAvtorInfo(Item.data).FIconNum,
      OutBmp, clWhite,StringToColor(TLVAvtorInfo(Item.data).FPColor),true);
       AlphaBlender.Blend(elv, Item, ACanvas, RectArray.IconRect, OutBmp);
     finally
     FreeAndNil(OutBmp);

     FreeAndNil(ARefBitmap);
     end;
   end
   else  if elv.View in [elsReport] then
   begin
    OutBmp := CreateBmp32(36, 36);
    ARefBitmap := TBitmap.Create;
     try
    FrmMain.ImgFaces(qry2,
      TLVAvtorInfo(Item.data).FIconNum,
      OutBmp,
      clWhite,StringToColor(TLVAvtorInfo(Item.data).FPColor),true);
       AlphaBlender.Blend(elv, Item, ACanvas, RectArray.IconRect, OutBmp);
     finally
     FreeAndNil(OutBmp);
     FreeAndNil(ARefBitmap);
     end;
   end;
end;

procedure TFrmAddrBook.btn4Click(Sender: TObject);
begin
TsSpeedButton(Sender).Down := True;
 case TsSpeedButton(Sender).Tag of
   1: elv.View := elsIcon;
   2: elv.View := elsReport;
   3: elv.View := elsTile;
 end;

end;

procedure TFrmAddrBook.elvResize(Sender: TObject);
var
  hasScrollBar : boolean;
  offset : Integer;
begin
  hasScrollBar := (GetWindowLong (elv.Handle, GWL_STYLE) and WS_VSCROLL) <> 0;
  if not hasScrollBar then
    offset := GetSystemMetrics (SM_CXVSCROLL)
  else
    offset := 0;
 elv.Header.Columns[0].Width := elv.ClientWidth - elv.Header.Columns[1].Width -
                            elv.Header.Columns[2].Width -   2 - offset;

end;

procedure TFrmAddrBook.elvHintCustomInfo(Sender: TCustomEasyListview;
  TargetObj: TEasyCollectionItem; Info: TEasyHintInfo);
  var
  R: TRect;
begin
 if Info.HintType = ehtCustomDraw then
  begin
    Info.Text := TLVAvtorInfo(TEasyItem( TargetObj).data).FName;
    R := Rect(0, 0,140,50 );
    R.Right := R.Right + 72 + 4 + 4;
    if R.Bottom < 62 + 2 then  R.Bottom := 62 + 2;
    Info.Bounds := R;
  end
end;

procedure TFrmAddrBook.elvHintPopup(Sender: TCustomEasyListview;
  TargetObj: TEasyCollectionItem; HintType: TEasyHintType;
  MousePos: TPoint; var AText: WideString; var HideTimeout,
  ReShowTimeout: Integer; var Allow: Boolean);
begin
if HintType = ehtCustomDraw then
  begin
   Allow := TargetObj is TEasyItem;

  end
end;

procedure TFrmAddrBook.elvHintPauseTime(Sender: TCustomEasyListview;
  HintWindowShown: Boolean; var PauseDelay: Integer);
begin
 if HintWindowShown then
    PauseDelay := 100;
end;

procedure TFrmAddrBook.elvHintCustomDraw(Sender: TCustomEasyListview;
  TargetObj: TEasyCollectionItem; const Info: TEasyHintInfo);
  var
  R: TRect;
  OutBmp,  ARefBitmap: TBitmap;

  const
 StrHtm= '<ALIGN=Left><Font Color="clBlack" Size="8"><b>%s</FONT></b><br>' + //Название <u> </u>
         '<ALIGN=Left><Font Color="clRed" Size="8">%s</FONT><br>'+ //Автор  </b>
         '<ALIGN=Left><Font Color="clBlue" Size="8">%s</FONT><br>';

begin
   if  (TargetObj is  TEasyItem) then
    begin
     OutBmp := CreateBmp32(36, 33);
     ARefBitmap := TBitmap.Create;
     try
      R := Info.Bounds;

     // GradientFillRect(Info.Canvas,
//          R,
//          $FEFDFC,
//          $F3C8BD,
//          fdTopToBottom,
//          255);


      FrmMain.ImgFaces(qry2,
      TLVAvtorInfo(TEasyItem( TargetObj).data).FIconNum,
      OutBmp,
      clWhite,StringToColor(TLVAvtorInfo(TEasyItem( TargetObj).data).FPColor),true);
      MakeReflected(ARefBitmap, OutBmp, 15,true);
      Info.Canvas.Draw(R.Left+6,R.Top+8, ARefBitmap);


      //R.Left := R.Left + 4 ;
      //Info.Canvas.Font.Name := 'Tahoma';
      //Info.Canvas.Font.Style := [fsBold];
      //Info.Canvas.Font.Size := 8;
      //Info.Canvas.Brush.Style := bsClear;
      //DrawTextWEx(Info.Canvas.Handle, Info.Text, R, [dtLeft,dtEndEllipsis], 2);


     R.Top := (RectHeight(R) - 46) div 2;
     R.Left := R.Left + 50 ;
     ItemHTDraw(Info.Canvas,R,[odDefault],
           Format(StrHtm,[Info.Text,
                          TLVAvtorInfo(TEasyItem( TargetObj).data).FPhone,
                          TLVAvtorInfo(TEasyItem( TargetObj).data).FMail]));

     
      finally
      FreeAndNil(OutBmp);
      FreeAndNil(ARefBitmap);
     end;


     

    end;
end;

procedure TFrmAddrBook.elvGroupPaintText(Sender: TCustomEasyListview;
  Group: TEasyGroup; ACanvas: TCanvas);
begin
    ACanvas.Font.Color := FrmMain.sSkinManager1.GetActiveEditFontColor;
end;

procedure TFrmAddrBook.chk1Click(Sender: TObject);
begin
//if chk1.Checked then
 elv.Sort.AutoRegroup := chk1.Checked;
end;

procedure TFrmAddrBook.elvItemFocusChanging(Sender: TCustomEasyListview;
  Item: TEasyItem; var Allow: Boolean);
var
LVAvtorInfo :TLVAvtorInfo;
OutBmp,  ARefBitmap: TBitmap;
begin
if (Assigned(item)) then
 begin
  LVAvtorInfo:= TLVAvtorInfo(Item.Data);
  OutBmp := CreateBmp32(36, 33);
     ARefBitmap := TBitmap.Create;
     try
      FrmMain.ImgFaces(qry2,
      LVAvtorInfo.FIconNum,
      OutBmp,
      clWhite,StringToColor(LVAvtorInfo.FPColor),true);
      MakeReflected(ARefBitmap, OutBmp, 20,true);
      img1.Picture.Assign(ARefBitmap);
      lbl1.Caption := LVAvtorInfo.FName;
     finally
      FreeAndNil(OutBmp);
      FreeAndNil(ARefBitmap);
     end;


  end;
end;

end.
