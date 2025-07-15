program PrjIntegracaoPedidos;

uses
  Vcl.Forms,
  UnIntegracaoPedidosFrm in 'UnIntegracaoPedidosFrm.pas' {Form1},
  UnApiDelivery in 'UnApiDelivery.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
