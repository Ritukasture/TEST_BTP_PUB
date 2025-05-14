@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZMK_C_PRODUCT_R
  provider contract transactional_query
  as projection on ZMK_I_PRODUCT_R
{
  key ProdUuid,
      Prodid,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZMK_PROD_GRP_VH', element: 'Pgid'  } } ]
      Pgid,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZMK_PHASE_VH', element: 'Phaseid' } } ]
      Phaseid,
      PhaseCriticality,
      phase,
      Pgname,
      Height,
      Depth,
      Width,
      measures,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZMK_UOM_VH', element: 'Msehi' } }]
      SizeUom,
      @Semantics.amount.currencyCode: 'priceCurrency'
      Price,
      PriceCurrency,
      Taxrate,
      CreatedBy,
      CreationTime,
      ChangedBy,
      ChangeTime,
      last_changed_at,
      /* Associations */
      _market : redirected to composition child ZMK_C_MARKET,
      _order  : redirected to composition child ZMK_C_ORDER
}
