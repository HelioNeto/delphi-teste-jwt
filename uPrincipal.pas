unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  REST.Client, REST.JSON, REST.Types, System.JSON, IpPeerClient, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdCookieManager, IdURI, IdZLibCompressorBase, IdCompressorZLib, System.NetEncoding,
  Vcl.Imaging.jpeg;

type
  TfrmPrincipal = class(TForm)
    editUrlToken: TEdit;
    lblUrl: TLabel;
    btnToken: TBitBtn;
    mmResultado: TMemo;
    editToken: TEdit;
    Label1: TLabel;
    btnLogin: TBitBtn;
    Label2: TLabel;
    editUrlLogin: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnTokenClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    FHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FURLConsulta, FUserAgent, FAccept, FAcceptCharSet, FContentType: String;
    FBasicAuthentication: Boolean;
    procedure preparaconexao;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Api.Classes;

{$R *.dfm}

procedure TfrmPrincipal.btnLoginClick(Sender: TObject);
var
  strResult: String;
  tsBody : TStringStream;
begin
  mmResultado.Lines.Clear;
  preparaconexao;
  tsBody := TStringStream.Create;
  FHTTP.Request.CustomHeaders.Add('Authorization: Bearer '+editToken.Text);
  FURLConsulta := editUrlLogin.Text;

  try
    strResult := FHTTP.post(FURLConsulta, tsBody);
    mmResultado.lines.add(strResult);
  except
    on E: EIdHTTPProtocolException do
    begin
      mmResultado.Lines.add(E.ErrorMessage);
    end;
  end;
end;

procedure TfrmPrincipal.btnTokenClick(Sender: TObject);
var
  strResult: String;
  tsBody : TStringStream;
  objRespApi: TRespApi;
  objJson: TJSONObject;
begin
  preparaconexao;
  objRespApi := TRespApi.create;
  tsBody := TStringStream.Create('{"email" : "email@teste.com","senha" : "123456"}');

  FURLConsulta := editUrlToken.Text;

  try
    strResult := FHTTP.post(FURLConsulta, tsBody);
    objJson := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(strResult), 0) as TJSONObject;
    TJson.JsonToObject(objRespApi, objJson);
    if Assigned(objRespApi) then
      editToken.Text := objRespApi.token;
    mmResultado.lines.add(strResult);
  except
    on E: EIdHTTPProtocolException do
    begin
      mmResultado.Lines.add(E.ErrorMessage);
    end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FHTTP                         := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL  := TIdSSLIOHandlerSocketOpenSSL.Create(FHTTP);
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
  FHTTP.IOHandler               := FIdSSLIOHandlerSocketOpenSSL;
  FHTTP.CookieManager           := TIdCookieManager.Create(FHTTP);
  FHTTP.ConnectTimeout          := 30000;
  FHTTP.HandleRedirects         := True;
  FHTTP.AllowCookies            := True;
  FHTTP.RedirectMaximum         := 10;
  FHTTP.HTTPOptions             := [hoForceEncodeParams];
end;

procedure TfrmPrincipal.preparaconexao;
begin
  FUserAgent := 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; Acoo Browser; GTB5; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) ; Maxthon; InfoPath.1; .NET CLR 3.5.30729; .NET CLR 3.0.30618)';
  FAccept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FAcceptCharSet := 'UTF-8, *;q=0.8';
  FContentType := 'application/x-www-form-urlencoded';
  FBasicAuthentication := False;

  FHTTP.Request.Clear;
  FHTTP.Request.UserAgent           := FUserAgent;
  FHTTP.Request.AcceptCharSet       := FAcceptCharSet;
  FHTTP.Request.ContentType         := FContentType;
  FHTTP.Request.BasicAuthentication := FBasicAuthentication;
  FHTTP.Request.CustomHeaders.Clear;
end;

end.
