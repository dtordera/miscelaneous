object dm: Tdm
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 720
  Top = 402
  Height = 187
  Width = 189
  object CG: TADOConnection
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object CR: TConfigRecord
    DefaultNames.Strings = (
      'DATABASE'
      'ULTIM_FITXER'
      'ULTIMA_DATA'
      'IVA_ARTICLES'
      'U_LLEGENDA'
      'BAK_DIR'
      'ANT_DIR'
      'MARGE_DEFECTE'
      'IVA_A'
      'IVA_B'
      'TREBALLADORS'
      'UT_TREBALLADORS'
      'COPIES_INF'
      'COPIES_TCK'
      'NO_NORMALIT'
      'LEFT_MAIN'
      'TOP_MAIN'
      'WIDTH_MAIN'
      'HEIGHT_MAIN'
      'IMPRESORA_1'
      'IMPRESORA_2'
      'AMPLE_TICKET_C'
      'APLICAR_COLORS'
      'ESTIL_PREFIXAT'
      'MOSTRAR_A_COMPTE_PENDENT'
      'LLISTES_FIXES'
      'PANELL_ORDRES'
      'BASE_TMP'
      'ESCPOS'
      'SEQ_OPERTURA'
      'OBRIR_CAIXA_AUTO'
      'ORDRE_LLISTES'
      'C_REPETIT_2'
      'C_REPETIT_3'
      'C_REPETIT_4'
      'C_OBSOLET'
      'C_MESDOSANYS'
      'C_MARGEDEFECTE'
      'C_MARGEMARCA'
      'C_MARGENOVALID'
      'C_ENTRADADIRECTA'
      'C_ABONAMENT'
      'C_ABONADA'
      'C_REALITZATS'
      'C_VISITA_AVUI'
      'C_REP_FINALITZADA'
      'C_PENDENTS_PRESSUPOST'
      'C_ENTREGA_AVIAT'
      'C_TORN_OBERT'
      'C_UTS_CERO'
      'C_NORMALIT')
    OnLoad = CRLoad
    Left = 48
    Top = 80
  end
  object CT: TADOConnection
    LoginPrompt = False
    Left = 96
    Top = 24
  end
end
