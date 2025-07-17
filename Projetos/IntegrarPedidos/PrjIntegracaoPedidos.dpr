program PrjIntegracaoPedidos;

uses
  Vcl.Forms,
  UnIntegracaoPedidosFrm in 'UnIntegracaoPedidosFrm.pas' {FrmIntegracao},
  UnApiDelivery in 'UnApiDelivery.pas',
  UnIntegracaoPedidosDm in 'UnIntegracaoPedidosDm.pas' {DmIntegracaoPedidos: TDataModule},
  UnIntegracaoPedidosMenu in 'UnIntegracaoPedidosMenu.pas' {FrmPedidos},
  UnRelatorioPedidoFrm in 'UnRelatorioPedidoFrm.pas' {FrmRelatorioPedido},
  UnRelatorioPedidoDm in 'UnRelatorioPedidoDm.pas' {DmRelatorioPedido: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  Application.Run;
end.
