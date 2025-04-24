@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@VDM.viewType: #BASIC
define root view entity ZMK_I_PRODUCT_R
  as select from ZMK_I_PRODUCT as product
  //association [1..*] to ZMK_I_MARKET as _market on product.ProdUuid = _market.ProdUuid
  composition [1..*] of ZMK_I_MARKET as _market //on product.ProdUuid = _market.ProdUuid
  composition [1..*] of ZMK_I_ORDER  as _order 
  //association [1..*] to ZMK_I_ORDER  as _order  on product.ProdUuid = _order.ProdUuid
  // com [1..*] to ZMK_I_ORDER as _order on product.ProdUuid = _order.ProdUuid
{
  key ProdUuid,
      Prodid,
      Pgid,
      Phaseid,
      Pgname,
      Height,
      Depth,
      Width,
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
      _market,
      _order
}
