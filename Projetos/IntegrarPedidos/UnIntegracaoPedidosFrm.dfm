object FrmIntegracao: TFrmIntegracao
  Left = 0
  Top = 0
  Caption = 'Integra'#231#227'o Novos Pedidos'
  ClientHeight = 472
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object LblMensagem: TLabel
    Left = 24
    Top = 184
    Width = 570
    Height = 28
    Caption = 'Pr'#243'xima verifica'#231#227'o de novos pedidos em: %0:d segundo(s)..'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TimerAbrirLoja: TTimer
    OnTimer = TimerAbrirLojaTimer
    Left = 488
    Top = 96
  end
end
