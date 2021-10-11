unit UOptions;

interface
uses Windows, SysUtils, Classes, Dialogs, forms, graphics, Messages, Types, JvJCLUtils,
  Variants, pngimage, JvJVCLUtils, math;

type
  TRGBArray = array[0..0] of TRGBTriple;
  pRGBArray = ^TRGBArray;

const
  CRLF              = #10#13;

  asX11ColorValues  : array[0..139] of TColor =
    ($FFF8F0, $D7EBFA, $FFFF00, $D4FF7F, $FFFFF0, $DCF5F5, $C4E4FF, $000000,
    $CDEBFF, $FF0000, $E22B8A, $2A2AA5, $87B8DE, $A09E5F, $00FF7F, $1E69D2,
    $507FFF, $ED9564, $DCF8FF, $3C14DC, $FFFF00, $8B0000, $8B8B00, $0B86B8,
    $A9A9A9, $006400, $6BB7BD, $8B008B, $2F6B55, $008CFF, $CC3299, $00008B,
    $7A96E9, $8FBC8F, $8B3D48, $4F4F2F, $D1CE00, $D30094, $9314FF, $FFBF00,
    $696969, $FF901E, $2222B2, $F0FAFF, $228B22, $FF00FF, $DCDCDC, $FFF8F8,
    $00D7FF, $20A5DA, $808080, $008000, $2FFFAD, $F0FFF0, $B469FF, $5C5CCD,
    $82004B, $F0FFFF, $8CE6F0, $FAE6E6, $F5F0FF, $00FC7C, $CDFAFF, $E6D8AD,
    $8080F0, $FFFFE0, $D2FAFA, $90EE90, $D3D3D3, $C1B6FF, $7AA0FF, $AAB220,
    $FACE87, $998877, $DEC4B0, $E0FFFF, $00FF00, $32CD32, $E6F0FA, $FF00FF,
    $000080, $AACD66, $CD0000, $D355BA, $DB7093, $71B33C, $EE687B, $9AFA00,
    $CCD148, $8515C7, $701919, $FAFFF5, $E1E4FF, $B5E4FF, $ADDEFF, $800000,
    $E6F5FD, $008080, $238E6B, $00A5FF, $0045FF, $D670DA, $AAE8EE, $98FB98,
    $EEEEAF, $9370DB, $D5EFFF, $B9DAFF, $3F85CD, $CBC0FF, $DDA0DD, $E6E0B0,
    $800080, $0000FF, $8F8FBC, $E16941, $13458B, $7280FA, $60A4F4, $578B2E,
    $EEF5FF, $2D52A0, $C0C0C0, $EBCE87, $CD5A6A, $908070, $FAFAFF, $7FFF00,
    $B48246, $8CB4D2, $808000, $D8BFD8, $4763FF, $D0E040, $EE82EE, $B3DEF5,
    $FFFFFF, $F5F5F5, $00FFFF, $32CD9A);

  asX11ColorNames   : array[0..139] of string =
    ('AliceBlue', 'AntiqueWhite', 'Aqua', 'Aquamarine', 'Azure', 'Beige',
    'Bisque', 'Black', 'BlanchedAlmond', 'Blue', 'BlueViolet', 'Brown',
    'BurlyWood', 'CadetBlue', 'Chartreuse', 'Chocolate', 'Coral',
    'CornflowerBlue', 'Cornsilk', 'Crimson', 'Cyan', 'DarkBlue', 'DarkCyan',
    'DarkGoldenrod', 'DarkGray', 'DarkGreen', 'DarkKhaki', 'DarkMagenta',
    'DarkOliveGreen', 'DarkOrange', 'DarkOrchid', 'DarkRed', 'DarkSalmon',
    'DarkSeaGreen', 'DarkSlateBlue', 'DarkSlateGray', 'DarkTurquoise',
    'DarkViolet', 'DeepPink', 'DeepSkyBlue', 'DimGray', 'DodgerBlue',
    'FireBrick', 'FloralWhite', 'ForestGreen', 'Fuchsia', 'Gainsboro',
    'GhostWhite', 'Gold', 'Goldenrod', 'Gray', 'Green', 'GreenYellow',
    'Honeydew', 'HotPink', 'IndianRed', 'Indigo', 'Ivory', 'Khaki',
    'Lavender', 'LavenderBlush', 'LawnGreen', 'LemonChiffon', 'LightBlue',
    'LightCoral', 'LightCyan', 'LightGoldenrodYellow', 'LightGreen',
    'LightGrey', 'LightPink', 'LightSalmon', 'LightSeaGreen', 'LightSkyBlue',
    'LightSlateGray', 'LightSteelBlue', 'LightYellow', 'Lime', 'LimeGreen',
    'Linen', 'Magenta', 'Maroon', 'MediumAquamarine', 'MediumBlue',
    'MediumOrchid', 'MediumPurple', 'MediumSeaGreen', 'MediumSlateBlue',
    'MediumSpringGreen', 'MediumTurquoise', 'MediumVioletRed', 'MidnightBlue',
    'MintCream', 'MistyRose', 'Moccasin', 'NavajoWhite', 'Navy', 'OldLace',
    'Olive', 'OliveDrab', 'Orange', 'OrangeRed', 'Orchid', 'PaleGoldenrod',
    'PaleGreen', 'PaleTurquoise', 'PaleVioletRed', 'PapayaWhip', 'PeachPuff',
    'Peru', 'Pink', 'Plum', 'PowderBlue', 'Purple', 'Red', 'RosyBrown',
    'RoyalBlue', 'SaddleBrown', 'Salmon', 'SandyBrown', 'SeaGreen', 'Seashell',
    'Sienna', 'Silver', 'SkyBlue', 'SlateBlue', 'SlateGray', 'Snow',
    'SpringGreen', 'SteelBlue', 'Tan', 'Teal', 'Thistle', 'Tomato', 'Turquoise',
    'Violet', 'Wheat', 'White', 'WhiteSmoke', 'Yellow', 'YellowGreen');

procedure BmpColorize(R0, G0, B0: integer; var png, png2: tpngobject);
procedure colorizer(acolor: tcolor; var png: tpngobject);
function ColorDarkenMultiplier(AColor: TColor; AMultiplier: Double): TColor;
procedure DrawTransparentBitmap(Dest: TCanvas; X, Y, W, H: Integer;
  Rect: TRect; Bitmap: TBitmap; TransparentColor: TColor);
procedure DrawBitmapInRect(Canvas: TCanvas; Rect: TRect; Bitmap: TBitmap);
procedure MakeReflected(ADest, ASource: TBitmap; AMirrorSize: Integer; aGradient: Boolean);
procedure ItemHTDrawEx(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; var Width: Integer;
  CalcWidth: Boolean; MouseX, MouseY: Integer; var MouseOnLink: Boolean;
  var LinkName: string);
{ example for Text parameter : 'Item 1 <b>bold</b> <i>italic ITALIC <br><FONT COLOR="clRed">red <FONT COLOR="clgreen">green <FONT COLOR="clblue">blue </i>' }
function ItemHTDraw(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string): string;
function ItemHTWidth(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string): Integer;
function ItemHTPlain(const Text: string): string;
function ItemHTHeight(Canvas: TCanvas; const Text: string): Integer;
function PrepareText(const A: string): string;

implementation

const
  cBR               = '<BR>';
  cHR               = '<HR>';
  cTagBegin         = '<';
  cTagEnd           = '>';
  cLT               = '<';
  cGT               = '>';
  cQuote            = '"';
  cCENTER           = 'CENTER';
  cRIGHT            = 'RIGHT';
  cHREF             = 'HREF';
  cIND              = 'IND';
  cCOLOR            = 'COLOR';
  cSIZE             = 'SIZE';
  cBGCOLOR          = 'BGCOLOR';
  cMAILTO           = 'MAILTO:';
  cURLTYPE          = '://';

  (******************************************************************************)

procedure BmpColorize(R0, G0, B0: integer; var png, png2: tpngobject);
var
  x, y              : integer;
  Rowa              : Prgbarray;
  Rowb              : Prgbarray;
  R, G, B           : integer;
  // H0       : integer;
  // H,S,V    : integer;
begin
  for y := 0 to png.height - 1 do
  begin
    rowa := png2.Scanline[y];
    rowb := png.Scanline[y];
    for x := 0 to png.width - 1 do
    begin
      R := (rowa[x].RgbtRed div 4) + (R0 {div 1});
      G := (rowa[x].Rgbtgreen div 4) + (G0 {div 2});
      B := (rowa[x].Rgbtblue div 4) + (B0 {div 3});

      if R > 255 then
        R := 255
      else if R < 0 then
        R := 0;
      if G > 255 then
        G := 255
      else if G < 0 then
        G := 0;
      if B > 255 then
        B := 255
      else if B < 0 then
        B := 0;

      rowb[x].Rgbtred := R;
      rowb[x].Rgbtgreen := G;
      rowb[x].Rgbtblue := B;
    end;
  end;
end;

procedure colorizer(acolor: tcolor; var png: tpngobject);
var
  R0, G0, B0        : integer;
  png2              : tpngobject;
begin
  aColor := ColorToRGB(aColor);
  png2 := TPNGObject.Create;
  png2.Assign(png);
  R0 := GetRValue((acolor));
  G0 := GetGValue((acolor));
  B0 := GetBValue((acolor));
  BmpColorize(R0, G0, B0, png2, png);
  png.assign(png2);
  png2.Free;
end;

function ColorDarkenMultiplier(AColor: TColor; AMultiplier: Double): TColor;
var
  ARed, AGreen, ABlue: Integer;
begin
  AColor := ColorToRGB(AColor);
  ARed := (AColor and $FF);
  AGreen := (AColor and $FF00) shr 8;
  ABlue := (AColor and $FF0000) shr 16;
  ARed := Trunc(ARed - ARed * AMultiplier);
  AGreen := Trunc(AGreen - AGreen * AMultiplier);
  ABlue := Trunc(ABlue - ABlue * AMultiplier);
  if ARed > 255 then
    ARed := 255;
  if AGreen > 255 then
    AGreen := 255;
  if ABlue > 255 then
    ABlue := 255;
  if ARed < 0 then
    ARed := 0;
  if AGreen < 0 then
    AGreen := 0;
  if ABlue < 0 then
    ABlue := 0;
  Result := ARed + (AGreen shl 8) + (ABlue shl 16);
end;

function WidthOf(R: TRect): Integer;
begin
  Result := R.Right - R.Left;
end;

function HeightOf(R: TRect): Integer;
begin
  Result := R.Bottom - R.Top;
end;

function MinL(A, B: LongInt): LongInt;
begin
  if (A < B) then
    Result := A
  else
    Result := B;
end;

function MaxL(A, B: LongInt): LongInt;
begin
  if (A < B) then
    Result := B
  else
    Result := A;
end;

procedure DrawTransparentBitmapPrim(DC: HDC; Bitmap: HBitmap;
  xStart, yStart, Width, Height: Integer; Rect: TRect;
  TransparentColor: TColorRef);
{-draw transparent bitmap}
var
  BM                : Windows.TBitmap;
  cColor            : TColorRef;
  bmAndBack         : hBitmap;
  bmAndObject       : hBitmap;
  bmAndMem          : hBitmap;
  bmSave            : hBitmap;
  bmBackOld         : hBitmap;
  bmObjectOld       : hBitmap;
  bmMemOld          : hBitmap;
  bmSaveOld         : hBitmap;
  hdcMem            : hDC;
  hdcBack           : hDC;
  hdcObject         : hDC;
  hdcTemp           : hDC;
  hdcSave           : hDC;
  ptSize            : TPoint;
  ptRealSize        : TPoint;
  ptBitSize         : TPoint;
  ptOrigin          : TPoint;
begin
  hdcTemp := CreateCompatibleDC(DC);
  SelectObject(hdcTemp, Bitmap);
  GetObject(Bitmap, SizeOf(BM), @BM);
  ptRealSize.x := MinL(Rect.Right - Rect.Left, BM.bmWidth - Rect.Left);
  ptRealSize.y := MinL(Rect.Bottom - Rect.Top, BM.bmHeight - Rect.Top);
  DPtoLP(hdcTemp, ptRealSize, 1);
  ptOrigin.x := Rect.Left;
  ptOrigin.y := Rect.Top;
  {convert from device to logical points}
  DPtoLP(hdcTemp, ptOrigin, 1);
  {get width of bitmap}
  ptBitSize.x := BM.bmWidth;
  {get height of bitmap}
  ptBitSize.y := BM.bmHeight;
  DPtoLP(hdcTemp, ptBitSize, 1);
  if (ptRealSize.x = 0) or (ptRealSize.y = 0) then
  begin
    ptSize := ptBitSize;
    ptRealSize := ptSize;
  end
  else
    ptSize := ptRealSize;
  if (Width = 0) or (Height = 0) then
  begin
    Width := ptSize.x;
    Height := ptSize.y;
  end;
  {create DCs to hold temporary data}
  hdcBack := CreateCompatibleDC(DC);
  hdcObject := CreateCompatibleDC(DC);
  hdcMem := CreateCompatibleDC(DC);
  hdcSave := CreateCompatibleDC(DC);
  {create a bitmap for each DC}
  {monochrome DC}
  bmAndBack := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);
  bmAndObject := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);
  bmAndMem := CreateCompatibleBitmap(DC, MaxL(ptSize.x, Width), MaxL(ptSize.y,
    Height));
  bmSave := CreateCompatibleBitmap(DC, ptBitSize.x, ptBitSize.y);
  {select a bitmap object to store pixel data}
  bmBackOld := SelectObject(hdcBack, bmAndBack);
  bmObjectOld := SelectObject(hdcObject, bmAndObject);
  bmMemOld := SelectObject(hdcMem, bmAndMem);
  bmSaveOld := SelectObject(hdcSave, bmSave);
  SetMapMode(hdcTemp, GetMapMode(DC));
  {save the bitmap sent here, it will be overwritten}
  BitBlt(hdcSave, 0, 0, ptBitSize.x, ptBitSize.y, hdcTemp, 0, 0, SRCCOPY);
  {set the background color of the source DC to the color,}
  {contained in the parts of the bitmap that should be transparent}
  cColor := SetBkColor(hdcTemp, TransparentColor);
  {create the object mask for the bitmap by performing a BitBlt()}
  {from the source bitmap to a monochrome bitmap}
  BitBlt(hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, ptOrigin.x, ptOrigin.y,
    SRCCOPY);
  {set the background color of the source DC back to the original color}
  SetBkColor(hdcTemp, cColor);
  {create the inverse of the object mask}
  BitBlt(hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, NOTSRCCOPY);
  {copy the background of the main DC to the destination}
  BitBlt(hdcMem, 0, 0, Width, Height, DC, xStart, yStart, SRCCOPY);
  {mask out the places where the bitmap will be placed}
  StretchBlt(hdcMem, 0, 0, Width, Height, hdcObject, 0, 0, ptSize.x, ptSize.y,
    SRCAND);
  {mask out the transparent colored pixels on the bitmap}
  BitBlt(hdcTemp, ptOrigin.x, ptOrigin.y, ptSize.x, ptSize.y, hdcBack, 0, 0,
    SRCAND);
  {XOR the bitmap with the background on the destination DC}
  StretchBlt(hdcMem, 0, 0, Width, Height, hdcTemp, ptOrigin.x, ptOrigin.y,
    ptSize.x, ptSize.y, SRCPAINT);
  {copy the destination to the screen}
  BitBlt(DC, xStart, yStart, MaxL(ptRealSize.x, Width), MaxL(ptRealSize.y,
    Height), hdcMem, 0, 0, SRCCOPY);
  {place the original bitmap back into the bitmap sent}
  BitBlt(hdcTemp, 0, 0, ptBitSize.x, ptBitSize.y, hdcSave, 0, 0, SRCCOPY);
  {delete the memory bitmaps}
  DeleteObject(SelectObject(hdcBack, bmBackOld));
  DeleteObject(SelectObject(hdcObject, bmObjectOld));
  DeleteObject(SelectObject(hdcMem, bmMemOld));
  DeleteObject(SelectObject(hdcSave, bmSaveOld));
  {delete the memory DCs}
  DeleteDC(hdcMem);
  DeleteDC(hdcBack);
  DeleteDC(hdcObject);
  DeleteDC(hdcSave);
  DeleteDC(hdcTemp);
end;

procedure DrawTransparentBitmap(Dest: TCanvas; X, Y, W, H: Integer;
  Rect: TRect; Bitmap: TBitmap; TransparentColor: TColor);
var
  MemImage          : TBitmap;
  R                 : TRect;
begin
  MemImage := TBitmap.Create;
  try
    R := Bounds(0, 0, Bitmap.Width, Bitmap.Height);
    if TransparentColor = clNone then
    begin
      if (WidthOf(Rect) <> 0) and (HeightOf(Rect) <> 0) then
        R := Rect;
      MemImage.Width := WidthOf(R);
      MemImage.Height := HeightOf(R);
      MemImage.Canvas.CopyRect(Bounds(0, 0, MemImage.Width, MemImage.Height),
        Bitmap.Canvas, R);
      if (W = 0) or (H = 0) then
        Dest.Draw(X, Y, MemImage)
      else
        Dest.StretchDraw(Bounds(X, Y, W, H), MemImage);
    end
    else
    begin
      MemImage.Width := WidthOf(R);
      MemImage.Height := HeightOf(R);
      MemImage.Canvas.CopyRect(R, Bitmap.Canvas, R);
      if TransparentColor = clDefault then
        TransparentColor := MemImage.Canvas.Pixels[0, MemImage.Height - 1];
      DrawTransparentBitmapPrim(Dest.Handle, MemImage.Handle, X, Y, W, H,
        Rect, ColorToRGB(TransparentColor and not $02000000));
    end;
  finally
    MemImage.Free;
  end;
end;

procedure DrawBitmapInRect(Canvas: TCanvas; Rect: TRect; Bitmap: TBitmap);
var
  X, Y              : Integer;
begin
  with Canvas do
  begin
    X := (Rect.Right - Rect.Left - Bitmap.Width) div 2 + Rect.Left;
    Y := (Rect.Bottom - Rect.Top - Bitmap.Height) div 2 + Rect.Top;
    BrushCopy(Classes.Rect(X, Y, X + Bitmap.Width, Y + Bitmap.Height), Bitmap,
      Classes.Rect(0, 0, Bitmap.Width, Bitmap.Height), clBlack);
  end;
end;

procedure PixelFilterAlphaBlend(var D, S: TRGBQuad;
  AAlpha: Integer = $FF; AProcessPerChannelAlpha: Boolean = True);
begin
  D.rgbBlue := (D.rgbBlue * ($FF - AAlpha) + S.rgbBlue * AAlpha) shr 8;
  D.rgbGreen := (D.rgbGreen * ($FF - AAlpha) + S.rgbGreen * AAlpha) shr 8;
  D.rgbRed := (D.rgbRed * ($FF - AAlpha) + S.rgbRed * AAlpha) shr 8;
end;

procedure MakeReflected(ADest, ASource: TBitmap; AMirrorSize: Integer; aGradient: Boolean);
var
  AAlpha            : Single;
  AAlphaDelta       : Single;
  DS, SS            : PRGBQuad;
  I, J, A           : Integer;
begin
  if ASource.PixelFormat <> pf32bit then
    Exit;

  AAlpha := $80;
  AAlphaDelta := AAlpha / AMirrorSize;

  ADest.PixelFormat := pf32bit;
  ADest.Width := ASource.Width;
  ADest.Height := ASource.Height + AMirrorSize;
  ADest.Canvas.Brush.Color := clWhite;
  if aGradient then
    GradientFillRect(ADest.Canvas,
      ADest.Canvas.ClipRect,
      $FEFDFC,
      $DAB3A9,
      fdTopToBottom,
      255);

  ADest.Canvas.Draw(0, 0, ASource);

  for I := 0 to AMirrorSize - 1 do
  begin
    DS := ADest.ScanLine[ASource.Height + I];
    SS := ASource.ScanLine[ASource.Height - I - 1];
    A := Round(AAlpha);
    for J := 0 to ASource.Width - 1 do
    begin
      PixelFilterAlphaBlend(DS^, SS^, A, False);
      Inc(DS);
      Inc(SS);
    end;
    AAlpha := AAlpha - AAlphaDelta;
  end;
end;

function BeforeTag(var Str: string; DeleteToTag: Boolean = False): string;
begin
  if Pos(cTagBegin, Str) > 0 then
  begin
    Result := Copy(Str, 1, Pos(cTagBegin, Str) - 1);
    if DeleteToTag then
      Delete(Str, 1, Pos(cTagBegin, Str) - 1);
  end
  else
  begin
    Result := Str;
    if DeleteToTag then
      Str := '';
  end;
end;

function GetChar(const Str: string; Pos: Word; Up: Boolean = False): Char;
begin
  if Length(Str) >= Pos then
    Result := Str[Pos]
  else
    Result := ' ';
  if Up then
    Result := UpCase(Result);
end;

function DeleteTag(const Str: string): string;
begin
  Result := Str;
  if (GetChar(Result, 1) = cTagBegin) and (Pos(cTagEnd, Result) > 1) then
    Delete(Result, 1, Pos(cTagEnd, Result));
end;

procedure ItemHTDrawEx(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string; var Width: Integer;
  CalcWidth: Boolean; MouseX, MouseY: Integer; var MouseOnLink: Boolean;
  var LinkName: string);
const
  DefaultLeft       = 0;      // (ahuser) was 2
var
  vText, vM, TagPrp, Prp, TempLink, PSize: string;
  vCount            : Integer;
  vStr              : TStringList;
  Selected          : Boolean;
  Alignment         : TAlignment;
  Trans, IsLink     : Boolean;
  CurLeft           : Integer;
  // for begin and end
  OldFontStyles     : TFontStyles;
  OldFontColor      : TColor;
  OldBrushColor     : TColor;
  OldAlignment      : TAlignment;
  OldFont           : TFont;
  // for font style
  RemFontColor,
    RemBrushColor   : TColor;

  function ExtractPropertyValue(const Tag: string; PropName: string): string;
  begin
    Result := '';
    PropName := UpperCase(PropName);
    if Pos(PropName, UpperCase(Tag)) > 0 then
    begin
      Result := Copy(Tag, Pos(PropName, UpperCase(Tag)) + Length(PropName), Length(Tag));
      Result := Copy(Result, Pos(cQuote, Result) + 1, Length(Result));
      Result := Copy(Result, 1, Pos(cQuote, Result) - 1);
    end;
  end;

  procedure Style(const Style: TFontStyle; const Include: Boolean);
  begin
    if Assigned(Canvas) then
      if Include then
        Canvas.Font.Style := Canvas.Font.Style + [Style]
      else
        Canvas.Font.Style := Canvas.Font.Style - [Style];
  end;

  function CalcPos(const Str: string): Integer;
  begin
    case Alignment of
      taRightJustify:
        Result := (Rect.Right - Rect.Left) - ItemHTWidth(Canvas, Rect, State, Str);
      taCenter:
        Result := (Rect.Right - Rect.Left - ItemHTWidth(Canvas, Rect, State, Str)) div 2;
    else
      Result := DefaultLeft;
    end;
    if Result <= 0 then
      Result := DefaultLeft;
  end;

  procedure Draw(const M: string);
  var
    Width, Height   : Integer;
    R               : TRect;
  begin
    R := Rect;
    Inc(R.Left, CurLeft);
    if Assigned(Canvas) then
    begin
      Width := Canvas.TextWidth(M);
      Height := CanvasMaxTextHeight(Canvas);
      if IsLink and not MouseOnLink then
        if (MouseY in [R.Top..R.Top + Height]) and
          (MouseX in [R.Left..R.Left + Width]) then
        begin
          MouseOnLink := True;
          Canvas.Font.Color := clRed; // hover link
          LinkName := TempLink;
        end;
      if not CalcWidth then
      begin
{$IFDEF VCL}
        if Trans then
          Canvas.Brush.Style := bsClear; // for transparent
{$ENDIF VCL}
{$IFDEF VisualCLX}
        if not Trans then
          Canvas.FillRect(R); // for opaque ( transparent = False )
{$ENDIF VisualCLX}
        Canvas.TextOut(R.Left, R.Top, M);
      end;
      CurLeft := CurLeft + Width;
    end;
  end;

  procedure NewLine;
  begin
    if Assigned(Canvas) then
      if vCount < vStr.Count - 1 then
      begin
        Width := Max(Width, CurLeft);
        CurLeft := DefaultLeft;
        Rect.Top := Rect.Top + CanvasMaxTextHeight(Canvas);
      end;
  end;

begin
  // (p3) remove warnings
  OldFontColor := 0;
  OldBrushColor := 0;
  RemFontColor := 0;
  RemBrushColor := 0;
  OldAlignment := taLeftJustify;
  OldFont := TFont.Create;

  if Canvas <> nil then
  begin
    OldFontStyles := Canvas.Font.Style;
    OldFontColor := Canvas.Font.Color;
    OldBrushColor := Canvas.Brush.Color;
    OldAlignment := Alignment;
    RemFontColor := Canvas.Font.Color;
    RemBrushColor := Canvas.Brush.Color;
  end;
  try
    Alignment := taLeftJustify;
    IsLink := False;
    MouseOnLink := False;
    vText := Text;
    vStr := TStringList.Create;
    vStr.Text := PrepareText(vText);
    Trans := True;
    LinkName := '';
    TempLink := '';

    Selected := (odSelected in State) or (odDisabled in State);

    Width := DefaultLeft;
    CurLeft := DefaultLeft;

    vM := '';
    for vCount := 0 to vStr.Count - 1 do
    begin
      vText := vStr[vCount];
      CurLeft := CalcPos(vText);
      while Length(vText) > 0 do
      begin
        vM := BeforeTag(vText, True);
        vM := StringReplace(vM, '&lt;', cLT, [rfReplaceAll, rfIgnoreCase]);  // <--+ this must be here
        vM := StringReplace(vM, '&gt;', cGT, [rfReplaceAll, rfIgnoreCase]); // <--/
        if GetChar(vText, 1) = cTagBegin then
        begin
          Draw(vM);
          if Pos(cTagEnd, vText) = 0 then
            Insert(cTagEnd, vText, 2);
          if GetChar(vText, 2) = '/' then
          begin
            case GetChar(vText, 3, True) of
              'A':
                begin
                  IsLink := False;
                  Canvas.Font.Assign(OldFont);
                end;
              'B':
                Style(fsBold, False);
              'I':
                Style(fsItalic, False);
              'U':
                Style(fsUnderline, False);
              'S':
                Style(fsStrikeOut, False);
              'F':
                begin
                  if not Selected then // restore old colors
                  begin
                    Canvas.Font.Color := RemFontColor;
                    Canvas.Brush.Color := RemBrushColor;
                    Trans := True;
                  end;
                end;
            end
          end
          else
          begin
            case GetChar(vText, 2, True) of
              'A':
                begin
                  if GetChar(vText, 3, True) = 'L' then // ALIGN
                  begin
                    TagPrp := UpperCase(Copy(vText, 2, Pos(cTagEnd, vText) - 2));
                    if Pos(cCENTER, TagPrp) > 0 then
                      Alignment := taCenter
                    else if Pos(cRIGHT, TagPrp) > 0 then
                      Alignment := taRightJustify
                    else
                      Alignment := taLeftJustify;
                    CurLeft := DefaultLeft;
                    if not CalcWidth then
                      CurLeft := CalcPos(vText);
                  end
                  else
                  begin       // A HREF
                    TagPrp := Copy(vText, 2, Pos(cTagEnd, vText) - 2);
                    if Pos(cHREF, UpperCase(TagPrp)) > 0 then
                    begin
                      IsLink := True;
                      OldFont.Assign(Canvas.Font);
                      if not Selected then
                        Canvas.Font.Color := clBlue;
                      TempLink := ExtractPropertyValue(TagPrp, cHREF);
                    end;
                  end;
                end;
              'B':
                Style(fsBold, True);
              'I':
                if GetChar(vText, 3, True) = 'N' then //IND="%d"
                begin
                  TagPrp := Copy(vText, 2, Pos(cTagEnd, vText) - 2);
                  CurLeft := StrToInt(ExtractPropertyValue(TagPrp, cIND)); // ex IND="10"
                end
                else
                  Style(fsItalic, True); // ITALIC
              'U':
                Style(fsUnderline, True);
              'S':
                Style(fsStrikeOut, True);
              'H':
                if (GetChar(vText, 3, True) = 'R') and (not CalcWidth) and Assigned(Canvas) then  // HR
                begin
                  if odDisabled in State then // only when disabled
                    Canvas.Pen.Color := Canvas.Font.Color;
                  Canvas.Pen.Color := Canvas.Font.Color;
                  Canvas.MoveTo(0, Rect.Top + CanvasMaxTextHeight(Canvas));
                  Canvas.LineTo(Rect.Right, Rect.Top + CanvasMaxTextHeight(Canvas));
                end;
              'F':
                if (Pos(cTagEnd, vText) > 0) and (not Selected) and Assigned(Canvas) and not
                  CalcWidth then // F from FONT
                begin
                  TagPrp := UpperCase(Copy(vText, 2, Pos(cTagEnd, vText) - 2));
                  RemFontColor := Canvas.Font.Color;
                  RemBrushColor := Canvas.Brush.Color;
                  if Pos(cCOLOR, TagPrp) > 0 then
                  begin
                    Prp := ExtractPropertyValue(TagPrp, cCOLOR);
                    Canvas.Font.Color := StringToColor(Prp);
                  end;
                  if Pos(cSIZE, TagPrp) > 0 then
                  begin
                    PSize := ExtractPropertyValue(TagPrp, cSIZE);
                    Canvas.Font.Size := StrToInt(PSize);
                  end;
                  if Pos(cBGCOLOR, TagPrp) > 0 then
                  begin
                    Prp := ExtractPropertyValue(TagPrp, cBGCOLOR);
                    Canvas.Brush.Color := StringToColor(Prp);
                    Trans := False;
                  end;
                end;
            end;
          end;
          vText := DeleteTag(vText);
          vM := '';
        end;
      end;
      Draw(vM);
      NewLine;
      vM := '';
    end;
  finally
    if Canvas <> nil then
    begin
      Canvas.Font.Style := OldFontStyles;
      Canvas.Font.Color := OldFontColor;
      Canvas.Brush.Color := OldBrushColor;
      Alignment := OldAlignment;
      {    Canvas.Font.Color := RemFontColor;
          Canvas.Brush.Color:= RemBrushColor;}
    end;
    FreeAndNil(vStr);
    FreeAndNil(OldFont);
  end;
  Width := Max(Width, CurLeft - DefaultLeft);
end;
// Kaczkowski - end

function ItemHTDraw(Canvas: TCanvas; Rect: TRect; const State: TOwnerDrawState;
  const Text: string): string;
var
  W                 : Integer;
  S                 : Boolean;
  St                : string;
begin
  ItemHTDrawEx(Canvas, Rect, State, Text, {HideSelColor,} W, False, 0, 0, S, St);
end;

function ItemHTPlain(const Text: string): string; // Kaczkowski: optimised
var
  S                 : string;
begin
  Result := '';
  S := PrepareText(Text);
  while Pos(cTagBegin, S) > 0 do
  begin
    Result := Result + Copy(S, 1, Pos(cTagBegin, S) - 1);
    if Pos(cTagEnd, S) > 0 then
      Delete(S, 1, Pos(cTagEnd, S))
    else
      Delete(S, 1, Pos(cTagBegin, S));
  end;
  Result := Result + S;
end;

function ItemHTWidth(Canvas: TCanvas; Rect: TRect;
  const State: TOwnerDrawState; const Text: string): Integer;
var
  S                 : Boolean;
  St                : string;
begin
  ItemHTDrawEx(Canvas, Rect, State, Text, Result, True, 0, 0, S, St);
end;

// Kaczkowski - begin

function ItemHTHeight(Canvas: TCanvas; const Text: string): Integer;
var
  Str               : TStringList;
begin
  try
    Str := TStringList.Create;
    Str.Text := PrepareText(Text);
    Result := Str.Count * CanvasMaxTextHeight(Canvas);
  finally
    FreeAndNil(Str);
  end;
  if Result = 0 then
    Result := CanvasMaxTextHeight(Canvas); // if Str.count = 0;
  Inc(Result);
end;

function IsHyperLink(Canvas: TCanvas; Rect: TRect; const State: TOwnerDrawState;
  const Text: string; MouseX, MouseY: Integer; var HyperLink: string): Boolean; overload;
var
  W                 : Integer;
begin
  ItemHTDrawEx(Canvas, Rect, State, Text, W, False, MouseX, MouseY, Result, HyperLink);
end;

function IsHyperLink(Canvas: TCanvas; Rect: TRect; const Text: string;
  MouseX, MouseY: Integer; var HyperLink: string): Boolean; overload;
var
  W                 : Integer;
begin
  ItemHTDrawEx(Canvas, Rect, [], Text, W, False, MouseX, MouseY, Result, HyperLink);
end;

function PrepareText(const A: string): string;
type
  THtmlCode = packed record
    Html: PChar;
    Text: Char;
  end;
const
  Conversions       : array[0..6] of THtmlCode =
    (
    (Html: '&amp;'; Text: '&'),
    (Html: '&quot;'; Text: '"'),
    (Html: '&reg;'; Text: '®'),
    (Html: '&copy;'; Text: '©'),
    (Html: '&trade;'; Text: '™'),
    (Html: '&euro;'; Text: '€'),
    (Html: '&nbsp;'; Text: ' ')
    );
var
  I                 : Integer;
begin
  Result := A;
  for I := Low(Conversions) to High(Conversions) do
    with Conversions[I] do
      Result := StringReplace(Result, Html, Text, [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, sLineBreak, '', [rfReplaceAll, rfIgnoreCase]);  // only <BR> can be new line
  Result := StringReplace(Result, cBR, sLineBreak, [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, cHR, cHR + sLineBreak, [rfReplaceAll, rfIgnoreCase]);  // fixed <HR><BR>
end;

end.

