unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  DCPtiger, DCPsha512, DCPsha256, DCPsha1, DCPripemd160,
  DCPripemd128, DCPmd5, DCPmd4, DCPcrypt2, DCPhaval, DCPtwofish, DCPtea,
  DCPserpent, DCPblockciphers, DCPrijndael, DCPrc4, DCPrc2, DCPice, DCPdes,
  DCPcast128, DCPblowfish,
  ExtCtrls,
  XPMan,
  Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    grp1: TGroupBox;
    grp3: TGroupBox;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    edt9: TEdit;
    edt10: TEdit;
    edt11: TEdit;
    edt12: TEdit;
    edt13: TEdit;
    edt14: TEdit;
    edt15: TEdit;
    edt16: TEdit;
    edt17: TEdit;
    edt18: TEdit;
    edt19: TEdit;
    edt20: TEdit;
    edt21: TEdit;
    edt22: TEdit;
    edt23: TEdit;
    edt24: TEdit;
    edt25: TEdit;
    edt26: TEdit;
    edt27: TEdit;
    edt28: TEdit;
    edt29: TEdit;
    edt30: TEdit;
    edt31: TEdit;
    edt32: TEdit;
    edt33: TEdit;
    edt34: TEdit;
    edt35: TEdit;
    edt36: TEdit;
    edt37: TEdit;
    edt38: TEdit;
    edt39: TEdit;
    edt40: TEdit;
    edt41: TEdit;
    edt42: TEdit;
    edt43: TEdit;
    edt44: TEdit;
    edt45: TEdit;
    edt46: TEdit;
    edt47: TEdit;
    edt48: TEdit;
    edt49: TEdit;
    edt50: TEdit;
    edt51: TEdit;
    edt52: TEdit;
    edt53: TEdit;
    edt54: TEdit;
    edt55: TEdit;
    edt56: TEdit;
    edt57: TEdit;
    edt58: TEdit;
    edt59: TEdit;
    edt60: TEdit;
    btn1: TButton;
    tmr1: TTimer;
    lbl1: TLabel;
    Edit1: TEdit;
    grpOptions: TGroupBox;
    lblCipher: TLabel;
    lblHash: TLabel;
    lblPassphrase: TLabel;
    lblConfirmPassphrase: TLabel;
    cbxCipher: TComboBox;
    cbxHash: TComboBox;
    boxPassphrase: TEdit;
    boxConfirmPassphrase: TEdit;
    DCP_haval1: TDCP_haval;
    DCP_rc21: TDCP_rc2;
    DCP_rc41: TDCP_rc4;
    DCP_rijndael1: TDCP_rijndael;
    DCP_serpent1: TDCP_serpent;
    DCP_tea1: TDCP_tea;
    DCP_twofish1: TDCP_twofish;
    DCP_ice21: TDCP_ice2;
    DCP_thinice1: TDCP_thinice;
    DCP_ice1: TDCP_ice;
    DCP_3des1: TDCP_3des;
    DCP_des1: TDCP_des;
    DCP_cast1281: TDCP_cast128;
    DCP_blowfish1: TDCP_blowfish;
    DCP_md41: TDCP_md4;
    DCP_md51: TDCP_md5;
    DCP_ripemd1281: TDCP_ripemd128;
    DCP_ripemd1601: TDCP_ripemd160;
    DCP_sha11: TDCP_sha1;
    DCP_sha2561: TDCP_sha256;
    DCP_tiger1: TDCP_tiger;
    DCP_sha5121: TDCP_sha512;
    DCP_sha3841: TDCP_sha384;
    btn2: TButton;
    stat1: TStatusBar;
    btn3: TButton;
    lbl2: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mmo1: TMemo;
    function GenCod: string;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure cbxCipherChange(Sender: TObject);
    procedure cbxHashChange(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure lst1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lst1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,y,g: Integer;
  z,x: Integer;
  s,key,chip,hsh: string;
  Cipher: TDCP_cipher;
  Hash: TDCP_hash;

implementation

{$R *.dfm}

function TForm1.GenCod: string;
var
  m: string;
  r: Integer;
begin
  Result:='';
  m:=Copy(TimeToStr(Now),7,2);
  r:=StrToInt(m);
  if m <> '59' then r := 59;
  if r = 59 then begin
     i:=Random(10);
     lbl1.Caption:=IntToStr(i);
  if i = 0 then i:=Random(10);     
  if z <= 0 then z:=cbxCipher.Items.Count;
  if x <= 0 then x:=cbxHash.Items.Count;
     s:=Copy(TimeToStr(Now),4,2);
     cbxCipher.ItemIndex:=z;
     cbxHash.ItemIndex:=x;
     Result:=IntToStr(i*StrToInt(s));
     cbxCipherChange(Self);
     cbxHashChange(Self);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  g:=6;
  Randomize;
  // iterate through all the components and find the ciphers/hashes
  for i := 0 to (ComponentCount - 1) do
  begin
    if (Components[i] is TDCP_cipher) then
      cbxCipher.Items.AddObject(TDCP_cipher(Components[i]).Algorithm,Components[i])
    else if (Components[i] is TDCP_hash) then
      cbxHash.Items.AddObject(TDCP_hash(Components[i]).Algorithm,Components[i]);
  end;
  if (cbxCipher.Items.Count = 0) then
  begin
    MessageDlg('No ciphers were found',mtError,[mbOK],0);
    exit;
  end
  else
  begin
    cbxCipher.ItemIndex := 0;
    if (cbxHash.Items.Count = 0) then
    begin
      MessageDlg('No hashes were found',mtError,[mbOK],0);
      exit;
    end
    else
    begin
      cbxHash.ItemIndex := x;
      cbxCipher.OnChange(cbxCipher);
    end;
  end;
  Cipher := TDCP_cipher(cbxCipher.Items.Objects[cbxCipher.ItemIndex]);
  Hash := TDCP_hash(cbxHash.Items.Objects[cbxHash.ItemIndex]);  
  z:=cbxCipher.Items.Count;
  x:=cbxHash.Items.Count;
  y:=10;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  btn2.Tag := 0;
  if btn1.Caption = 'Генератор шифра' then begin
     btn1.Caption := 'Выключить таймер';
     tmr1.Enabled:=True;
  end else begin
     btn1.Caption := 'Генератор шифра';
     tmr1.Enabled:=False;
  end;
end;

procedure TForm1.cbxCipherChange(Sender: TObject);
begin
  {if (Cipher.MaxKeySize < Hash.HashSize) then
    dblKeySize.Caption := IntToStr(Cipher.MaxKeySize) + ' bits'
  else dblKeySize.Caption := IntToStr(Hash.HashSize) + ' bits';}
  lbl2.Caption:=IntToStr(cbxCipher.ItemIndex);
  chip:=IntToStr(cbxCipher.ItemIndex);
end;

function tictac(i: Integer; tc: Integer) : string;
const
  s = '. ';
  s1 = '.. ';
  s2 = '... ';
  s3 = '.... ';
  s4 = '..... ';
  s5 = '...... ';
begin
  if i = 5 then Result := s;
  if i = 4 then Result := s1;
  if i = 3 then Result := s2;
  if i = 2 then Result := s3;
  if i = 1 then Result := s4;
  if i = 0 then Result := s5;
  sleep(tc);
  Application.ProcessMessages;
end;

//Проверка строки на цыфры
function digitX(sx : string): string;
var
 i : integer;
begin
 result:='';
for i := 1 to length(sx) do begin
if not (sx[i] in ['0'..'9']) then begin
  result:='Not Digits';
  break;
end;
if result='' then result:='Only Digits';
end;
end;

procedure TForm1.cbxHashChange(Sender: TObject);
begin
  {if (Cipher.MaxKeySize < Hash.HashSize) then
    dblKeySize.Caption := IntToStr(Cipher.MaxKeySize) + ' bits'
  else dblKeySize.Caption := IntToStr(Hash.HashSize) + ' bits';}
  lbl3.Caption:=IntToStr(cbxHash.ItemIndex);
  hsh:=IntToStr(cbxHash.ItemIndex);
end;

//CryptStr
function EncS(Source, Passw: string): string;
var
  Cipher: TDCP_cipher;
begin
  Cipher := TDCP_cipher(Form1.cbxCipher.Items.Objects[Form1.cbxCipher.ItemIndex]);
  Cipher := Cipher.Create(nil);   // создаём объект
  Cipher.InitStr(Passw, TDCP_sha512);    // инициализируем
  Result := Cipher.EncryptString(Source); // шифруем
  Cipher.Burn;                            // стираем инфо о ключе
  //Cipher.Free;                            // уничтожаем объект
end;

function DecS(Source, Passw: string): string;
var
  Cipher: TDCP_cipher;
begin
  Cipher := TDCP_cipher(Form1.cbxCipher.Items.Objects[Form1.cbxCipher.ItemIndex]);
  Cipher := Cipher.Create(nil);   // создаём объект
  Cipher.InitStr(Passw, TDCP_sha512);    // инициализируем
  Result := Cipher.DecryptString(Source); // дешифруем
  Cipher.Burn;                            // стираем инфо о ключе
  //Cipher.Free;                           // уничтожаем объект
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
  s: string;
  ch1,ch2: integer;
begin
  g:=g-1;
  Label2.Caption:='5 / '+IntToStr(g);
if g <= 0 then begin
   g:=6;
   Label1.Caption:=' ';
if y <= 0 then y:=10;
if (Copy(TimeToStr(Now),7,2) = '30') or (lbl1.Caption = '0') or (Copy(TimeToStr(Now),7,2) = '59') or (g = 6) then begin
  if Edit1.Text <> '0' then begin
  if (boxPassphrase.Text <> '') and (boxConfirmPassphrase.Text <> '') then begin
     Edit1.Text:=DecS(Edit1.Text,boxConfirmPassphrase.Text);
     s:=digitX(Edit1.Text);
  if s = 'Not Digits' then
    mmo1.lines.Add('===========Not Digits===========')
  else begin
    mmo1.lines.Add('===========Digits OK===========');
    mmo1.lines.Add('['+DateToStr(Now)+' | '+TimeToStr(Now)+'] '+Edit1.Text+' Cipher: '+s);
  end;
  end else begin
  if boxConfirmPassphrase.Text = '' then boxConfirmPassphrase.Text:=edt10.Text+IntToStr(x)+edt60.Text;
     Edit1.Text:=DecS(Edit1.Text,boxConfirmPassphrase.Text);
     s:=digitX(Edit1.Text);
  if s = 'Not Digits' then
    mmo1.lines.Add('===========Not Digits===========')
  else begin
    mmo1.lines.Add('===========Digits OK===========');
    mmo1.lines.Add('['+DateToStr(Now)+' | '+TimeToStr(Now)+'] '+Edit1.Text+' Cipher: '+s);
  end;
  end;
     Edit1.Text := '0';
  end;
  Randomize;
  z:=Random(cbxCipher.Items.Count);
  x:=Random(cbxHash.Items.Count);
  s:=cbxCipher.Text+cbxHash.Text;
  cbxCipher.ItemIndex := z;
  cbxHash.ItemIndex := x;
  lbl3.Caption:=IntToStr(8);
  cbxHash.Enabled:=False;
  hsh:=IntToStr(x);
  lbl2.Caption:=IntToStr(z);
  chip:=IntToStr(z);
  edt1.Text:=GenCod;
  edt2.Text:=GenCod;
  edt3.Text:=GenCod;
  edt4.Text:=GenCod;
  edt5.Text:=GenCod;
  edt6.Text:=GenCod;
  edt7.Text:=GenCod;
  edt8.Text:=GenCod;
  edt9.Text:=GenCod;
  edt10.Text:=GenCod;
  edt11.Text:=GenCod;
  edt12.Text:=GenCod;
  edt13.Text:=GenCod;
  edt14.Text:=GenCod;
  edt15.Text:=GenCod;
  edt16.Text:=GenCod;
  edt17.Text:=GenCod;
  edt18.Text:=GenCod;
  edt19.Text:=GenCod;
  edt20.Text:=GenCod;
  edt21.Text:=GenCod;
  edt22.Text:=GenCod;
  edt23.Text:=GenCod;
  edt24.Text:=GenCod;
  edt25.Text:=GenCod;
  edt26.Text:=GenCod;
  edt27.Text:=GenCod;
  edt28.Text:=GenCod;
  edt29.Text:=GenCod;
  edt30.Text:=GenCod;
  edt31.Text:=GenCod;
  edt32.Text:=GenCod;
  edt33.Text:=GenCod;
  edt34.Text:=GenCod;
  edt35.Text:=GenCod;
  edt36.Text:=GenCod;
  edt37.Text:=GenCod;
  edt38.Text:=GenCod;
  edt39.Text:=GenCod;
  edt40.Text:=GenCod;
  edt41.Text:=GenCod;
  edt42.Text:=GenCod;
  edt43.Text:=GenCod;
  edt44.Text:=GenCod;
  edt45.Text:=GenCod;
  edt46.Text:=GenCod;
  edt47.Text:=GenCod;
  edt48.Text:=GenCod;
  edt49.Text:=GenCod;
  edt50.Text:=GenCod;
  edt51.Text:=GenCod;
  edt52.Text:=GenCod;
  edt53.Text:=GenCod;
  edt54.Text:=GenCod;
  edt55.Text:=GenCod;
  edt56.Text:=GenCod;
  edt57.Text:=GenCod;
  edt58.Text:=GenCod;
  edt59.Text:=GenCod;
  edt60.Text:=GenCod;
  ////////////////////
  Application.ProcessMessages;
  ////////////////////
  btn2.Tag := 0;
  if edt10.Text = '0' then edt10.Text := GenCod;
  if edt60.Text = '0' then edt60.Text := GenCod;
  ch1:=StrToInt(edt10.Text);
  ch2:=StrToInt(edt60.Text);
  ch1:=ch1*3;
  ch2:=ch2*3;
  ch1:=ch1+ch2;
  boxPassphrase.Text:=edt10.Text+IntToStr(ch1)+edt60.Text;
  boxConfirmPassphrase.Text:=edt10.Text+IntToStr(ch1)+edt60.Text;
  boxPassphrase.Enabled:=False;
  boxConfirmPassphrase.Enabled:=False;
  if Edit1.Text = '0' then begin
     key:=edt1.Text+edt2.Text+edt3.Text+edt4.Text+edt5.Text+edt6.Text+edt7.Text+edt8.Text+edt9.Text+edt10.Text+edt11.Text+edt12.Text+edt13.Text+edt14.Text+edt15.Text+edt16.Text+edt17.Text+edt18.Text+edt19.Text+edt20.Text+edt21.Text+edt22.Text+edt23.Text+edt24.Text+edt25.Text+edt26.Text+edt27.Text+edt28.Text+edt29.Text+edt30.Text+edt31.Text+edt32.Text+edt33.Text+edt34.Text+edt35.Text+edt36.Text+edt37.Text+edt38.Text+edt39.Text+edt40.Text+edt41.Text+edt42.Text+edt42.Text+edt44.Text+edt45.Text+edt46.Text+edt47.Text+edt48.Text+edt49.Text+edt50.Text+edt51.Text+edt52.Text+edt53.Text+edt54.Text+edt55.Text+edt56.Text+edt57.Text+edt58.Text+edt59.Text+edt60.Text;
  if (boxPassphrase.Text <> '') and (boxConfirmPassphrase.Text <> '') then begin
     Edit1.Text:=EncS(key,boxConfirmPassphrase.Text);
  end else begin
     Edit1.Text:=EncS(key,edt10.Text+IntToStr(ch1)+edt60.Text);
  end;
     mmo1.lines.Add('['+DateToStr(Now)+' | '+TimeToStr(Now)+'] '+chip+'@'+hsh+'@'+edt10.Text+'@'+IntToStr(ch1)+'@'+edt60.Text+'@'+Edit1.Text+' Cipher: '+s);
     mmo1.lines.Add('['+DateToStr(Now)+' | '+TimeToStr(Now)+'] '+chip+'@'+hsh+'@'+edt10.Text+'@'+IntToStr(ch1)+'@'+edt60.Text+'@'+key+' Cipher: '+s);
     mmo1.lines.SaveToFile('key.log');
  end;
end;
end else Label1.Caption:=tictac(g,100);
  grp1.Caption:='Генератор шифра: '+IntToStr(y)+' -> '+Copy(TimeToStr(Now),7,2)+' <- '+Copy(TimeToStr(Now),4,2);
  y:=y-1;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  if btn2.Tag <> 1 then begin
     btn2.Tag := 1;
     Edit1.Text:=DecS(Edit1.Text,boxConfirmPassphrase.Text);
     boxPassphrase.Enabled:=True;
     boxConfirmPassphrase.Enabled:=True;
  end;
end;

procedure TForm1.lst1Click(Sender: TObject);
begin
  if mmo1.Lines.Count >= 0 then
     stat1.Panels[0].Text:=mmo1.lines.Strings[mmo1.Lines.Count];
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  btn2.Tag := 0;
  Edit1.Text:=EncS(key,boxConfirmPassphrase.Text);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  mmo1.lines.Clear;
  edt1.Text:=GenCod;
  edt2.Text:=GenCod;
  edt3.Text:=GenCod;
  edt4.Text:=GenCod;
  edt5.Text:=GenCod;
  edt6.Text:=GenCod;
  edt7.Text:=GenCod;
  edt8.Text:=GenCod;
  edt9.Text:=GenCod;
  edt10.Text:=GenCod;
  edt11.Text:=GenCod;
  edt12.Text:=GenCod;
  edt13.Text:=GenCod;
  edt14.Text:=GenCod;
  edt15.Text:=GenCod;
  edt16.Text:=GenCod;
  edt17.Text:=GenCod;
  edt18.Text:=GenCod;
  edt19.Text:=GenCod;
  edt20.Text:=GenCod;
  edt21.Text:=GenCod;
  edt22.Text:=GenCod;
  edt23.Text:=GenCod;
  edt24.Text:=GenCod;
  edt25.Text:=GenCod;
  edt26.Text:=GenCod;
  edt27.Text:=GenCod;
  edt28.Text:=GenCod;
  edt29.Text:=GenCod;
  edt30.Text:=GenCod;
  edt31.Text:=GenCod;
  edt32.Text:=GenCod;
  edt33.Text:=GenCod;
  edt34.Text:=GenCod;
  edt35.Text:=GenCod;
  edt36.Text:=GenCod;
  edt37.Text:=GenCod;
  edt38.Text:=GenCod;
  edt39.Text:=GenCod;
  edt40.Text:=GenCod;
  edt41.Text:=GenCod;
  edt42.Text:=GenCod;
  edt43.Text:=GenCod;
  edt44.Text:=GenCod;
  edt45.Text:=GenCod;
  edt46.Text:=GenCod;
  edt47.Text:=GenCod;
  edt48.Text:=GenCod;
  edt49.Text:=GenCod;
  edt50.Text:=GenCod;
  edt51.Text:=GenCod;
  edt52.Text:=GenCod;
  edt53.Text:=GenCod;
  edt54.Text:=GenCod;
  edt55.Text:=GenCod;
  edt56.Text:=GenCod;
  edt57.Text:=GenCod;
  edt58.Text:=GenCod;
  edt59.Text:=GenCod;
  edt60.Text:=GenCod;
  key:=edt1.Text+edt2.Text+edt3.Text+edt4.Text+edt5.Text+edt6.Text+edt7.Text+edt8.Text+edt9.Text+edt10.Text+edt11.Text+edt12.Text+edt13.Text+edt14.Text+edt15.Text+edt16.Text+edt17.Text+edt18.Text+edt19.Text+edt20.Text+edt21.Text+edt22.Text+edt23.Text+edt24.Text+edt25.Text+edt26.Text+edt27.Text+edt28.Text+edt29.Text+edt30.Text+edt31.Text+edt32.Text+edt33.Text+edt34.Text+edt35.Text+edt36.Text+edt37.Text+edt38.Text+edt39.Text+edt40.Text+edt41.Text+edt42.Text+edt42.Text+edt44.Text+edt45.Text+edt46.Text+edt47.Text+edt48.Text+edt49.Text+edt50.Text+edt51.Text+edt52.Text+edt53.Text+edt54.Text+edt55.Text+edt56.Text+edt57.Text+edt58.Text+edt59.Text+edt60.Text;
  Edit1.Text:=EncS(key,key);
  btn1.Click;
end;

procedure TForm1.lst1DblClick(Sender: TObject);
begin
  mmo1.lines.Clear;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Cipher.Free;
  Hash.Free;
end;

end.
