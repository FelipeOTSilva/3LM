unit UnIntegracaoPedidosFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient, SimpleDS, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, UnApiDelivery, Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    TimerAbrirLoja: TTimer;
    LblMensagem: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerAbrirLojaTimer(Sender: TObject);
  private
    { Private declarations }
    FDelivery: TAPIDelivery;
    FContagemSeg: Integer;

    Procedure DeixarImageVisivel(AImg: TImage; AFicarVisivel: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDelivery := TAPIDelivery.Create;
  FContagemSeg := 30;
  // TGIFImage(ImgGif.Picture.Graphic).Animate := True;
  // DeixarImageVisivel(ImgGif, False);
  // DeixarImageVisivel(ImgChecked, True);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDelivery);
end;

procedure TForm1.DeixarImageVisivel(AImg: TImage; AFicarVisivel: Boolean);
begin
  AImg.Visible := AFicarVisivel;
end;

procedure TForm1.TimerAbrirLojaTimer(Sender: TObject);
Const
  CMsgVerificação =
    'Próxima verificação de novos pedidos em: %0:d segundo(s)...';
  CMsgVerificandoNovosPedidos = 'Verificando se há novos pedidos...';

begin
  Dec(FContagemSeg);

  If FContagemSeg = 0 Then
  Begin
    TimerAbrirLoja.Enabled := False;
    LblMensagem.Caption := CMsgVerificandoNovosPedidos;
    Application.ProcessMessages;
    Sleep(5000);
    Try
      FDelivery.AbrirLoja;
    Finally
      FContagemseg := 30;
      LblMensagem.Caption := Format(CMsgVerificação, [FContagemSeg]);
      TimerAbrirLoja.Enabled := True;
    End;


  End
  Else
    LblMensagem.Caption := Format(CMsgVerificação, [FContagemSeg]);

end;

end.
