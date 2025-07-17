unit UnRelatorioPedidoDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDmRelatorioPedido = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQueryPedidos: TFDQuery;
    FDQueryItens: TFDQuery;
    DsPedidos: TDataSource;
    FDQueryPagamentos: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmRelatorioPedido: TDmRelatorioPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmRelatorioPedido.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected := True;

  FDQueryPedidos.Open;
  FDQueryItens.Open;
  FDQueryPagamentos.Open;
end;

end.
