object DmRelatorioPedido: TDmRelatorioPedido
  OnCreate = DataModuleCreate
  Height = 243
  Width = 448
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Database=C:\3LM\BancoDeDados\PDV.FDB'
      'Password=masterkey'
      'User_Name=sysdba')
    Connected = True
    LoginPrompt = False
    Left = 120
    Top = 48
  end
  object FDQueryPedidos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT PEDIDO.ID_PEDIDO,'
      '        PEDIDO.CLIENTE_NOME,'
      '        PEDIDO.ENDERECO_ENTREGA,'
      '        PEDIDO.DATA_PEDIDO,'
      '        PEDIDO.TOTAL'
      '   FROM PEDIDO')
    Left = 80
    Top = 128
  end
  object FDQueryItens: TFDQuery
    MasterSource = DsPedidos
    MasterFields = 'ID_PEDIDO'
    Connection = FDConnection1
    SQL.Strings = (
      ' SELECT PEDIDO_PRODUTOS.NOME_PRODUTO,'
      '        PEDIDO_PRODUTOS.QUANTIDADE,'
      '        PEDIDO_PRODUTOS.VLR_UNITARIO'
      '   FROM PEDIDO_PRODUTOS'
      '  WHERE PEDIDO_PRODUTOS.ID_PEDIDO = :ID_PEDIDO')
    Left = 192
    Top = 128
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DsPedidos: TDataSource
    DataSet = FDQueryPedidos
    Left = 272
    Top = 48
  end
  object FDQueryPagamentos: TFDQuery
    MasterSource = DsPedidos
    MasterFields = 'ID_PEDIDO'
    Connection = FDConnection1
    SQL.Strings = (
      '  SELECT PEDIDO_PAGAMENTO.FORMA_PAGAMENTO,'
      '         PEDIDO_PAGAMENTO.VALOR'
      '    FROM PEDIDO_PAGAMENTO'
      '   WHERE PEDIDO_PAGAMENTO.ID_PEDIDO = :ID_PEDIDO')
    Left = 280
    Top = 128
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        ParamType = ptInput
      end>
  end
end
