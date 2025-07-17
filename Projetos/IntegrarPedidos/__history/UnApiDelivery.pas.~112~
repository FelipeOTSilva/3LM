unit UnApiDelivery;

interface

uses
  System.JSON, idhttp, UnIntegracaoPedidosDm;

type
  TAPIDelivery = class
  private
    FHTTP: TIdHTTP;
    FToken: string;
    FClientID: String;
    FClientSecret: String;
    FDmIntegracaoPedidos: TDmIntegracaoPedidos;

    Procedure Autenticar;
    procedure VerificarPedidosAConfirmar(const AJsonStr: string);
    Function EhPedidoNovo(AJson: TJSONArray; AOrderId: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    Procedure AbrirLoja;
    Procedure ConfirmarPedido(AID: string);
    function BuscarPedido(AIdPedido: string): TJSONObject;
  end;

implementation

uses
  IdSSLOpenSSL, IdGlobal, System.SysUtils, System.Classes;

{ TDeliveryAPI }

Procedure TAPIDelivery.AbrirLoja;
Const
  CUrlAbrirLoja =
    'https://merchant-api.ifood.com.br/events/v1.0/events:polling';
Var
  LHttp: TIdHTTP;
  LResp: String;
  LSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  LHttp := TIdHTTP.Create;
  Try
    LSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    Lssl.SSLOptions.Method := sslvTLSv1_2;
    Lssl.SSLOptions.SSLVersions := [sslvTLSv1_2];
    LHTTP.IOHandler := LSSL;

    LHttp.Request.CustomHeaders.Clear;
    LHttp.Request.CustomHeaders.AddValue('Authorization', FToken);

    LResp := LHttp.Get(CUrlAbrirLoja);

    If LHttp.ResponseCode = 200 Then
    Begin
      VerificarPedidosAConfirmar(LResp);

    End;
  Finally
    FreeAndNil(LHttp);
  End;

end;

procedure TAPIDelivery.Autenticar;
Const
  CUrl = 'https://merchant-api.ifood.com.br/authentication/v1.0/oauth/token';
Var
  LParams: TStringList;
  LResp: string;
  LSSL: TIdSSLIOHandlerSocketOpenSSL;
  LJSONResp: TJSONObject;
begin
  LSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Lssl.SSLOptions.Method := sslvTLSv1_2;
  Lssl.SSLOptions.SSLVersions := [sslvTLSv1_2];
  FHTTP.IOHandler := LSSL;

  LParams := TStringList.Create;
  Try
    LParams.Add('grantType=client_credentials');
    LParams.Add('clientId=' + FClientID);
    LParams.Add('clientSecret=' + FClientSecret);

    FHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
    LResp := FHTTP.Post(CUrl, LParams);
    LJSONResp := TJSONObject.ParseJSONValue(LResp) as TJSONObject;
    FToken := 'Bearer ' + LJSONResp.GetValue<string>('accessToken');

  Finally
    FreeAndNil(LSSL);
    FreeAndNil(LParams);
  End;
end;

function TAPIDelivery.BuscarPedido(AIdPedido: string): TJSONObject;
Const
  CUrlBuscaPedido = 'https://merchant-api.ifood.com.br/order/v1.0/orders/%0:s';
var
  LResp: string;
Begin
  Result := Nil;
  FHTTP.Request.CustomHeaders.Clear;
  FHTTP.Request.CustomHeaders.AddValue('Authorization', FToken);
  FHTTP.Request.ContentType := 'application/json';
  LResp := FHTTP.Get(Format(CUrlBuscaPedido,[AIdPedido]));

  If FHTTP.ResponseCode = 200 Then
    Result := TJSONObject.ParseJSONValue(LResp) as TJSONObject;
end;

Procedure TAPIDelivery.ConfirmarPedido(AID: string);
Const
  CUrlConfirmarPedido =
    'https://merchant-api.ifood.com.br/order/v1.0/orders/';
Var
  LUrl: string;
  LStream: TStringStream;
  LSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  LStream := Nil;

  LSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Lssl.SSLOptions.Method := sslvTLSv1_2;
  Lssl.SSLOptions.SSLVersions := [sslvTLSv1_2];

  FHTTP.Request.CustomHeaders.Clear;
  FHTTP.Request.CustomHeaders.AddValue('Authorization', FToken);
//  FHTTP.Request.ContentType := 'application/json';
  FHTTP.IOHandler := LSSL;

  LUrl := CUrlConfirmarPedido + AID+'/confirm';
  FHTTP.Post(LUrl, LStream);

  If FHTTP.ResponseCode = 202 Then
     FDmIntegracaoPedidos.InserirPedidoBD(BuscarPedido(AID));


end;

constructor TAPIDelivery.Create;
begin
  FDmIntegracaoPedidos := TDmIntegracaoPedidos.Create(Nil);
  FHTTP := TIdHTTP.Create;
  FHTTP.Request.ContentType := 'application/json';
  FClientID := 'd3081bb1-9ef9-42c1-b5d5-36ece53ae9de';
  FClientSecret :=
    'r44qpt752p37rve8sfau44bgvogg3l6cox7k067s9p8e5zmz793jktv5wogkf3v8u0o4zblfg5eyjc25uu7shbmszaoyaygwetq';
  Autenticar;

end;

destructor TAPIDelivery.Destroy;
begin
  FreeAndNil(FDmIntegracaoPedidos);
  FreeAndNil(FHTTP);
  inherited;
end;

function TAPIDelivery.EhPedidoNovo(AJson: TJSONArray; AOrderId: string): Boolean;
Var
  LJsonValue: TJSONValue;
  LJsonObj: TJSONObject;
  LCodeList: TStringList;
  LCode: string;
begin
  Result := False;
  LCodeList := TStringList.Create;
  try
    for LJsonValue in AJson do
    begin
      LJsonObj := LJsonValue as TJSONObject;
      if LJsonObj.GetValue<string>('orderId') = AOrderId then
      begin
        LCode := LJsonObj.GetValue<string>('code');
        if LCodeList.IndexOf(LCode) = -1 then
          LCodeList.Add(LCode);
      end;
    end;

     Result := (LCodeList.Count = 1) and (LCodeList[0] = 'PLC');
  finally
    FreeAndNil(LCodeList);
  end;
end;

procedure TAPIDelivery.VerificarPedidosAConfirmar(const AJsonStr: string);
var
  LJSONArray: TJSONArray;
  LItem: TJSONValue;
  LPedidoObj: TJSONObject;
  LCodigo, LOrderID: string;
Begin
  LJSONArray := TJSONObject.ParseJSONValue(AJsonStr) as TJSONArray;
  try
    for LItem in LJSONArray do
    begin
      LPedidoObj := LItem as TJSONObject;

      LCodigo := LPedidoObj.GetValue<string>('code');

      if SameText(LCodigo, 'PLC') then
      begin
        LOrderID := LPedidoObj.GetValue<string>('orderId');

        If EhPedidoNovo(LJSonArray, LOrderID) Then
          ConfirmarPedido(LOrderID);
      end;
    end;
  finally
    FreeAndNil(LJSONArray);
  end;

end;

end.
