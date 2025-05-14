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
  association [0..1] to ztb_mk_phase as _Phases on $projection.Phaseid = _Phases.phaseid
  //association [1..*] to ZMK_I_ORDER  as _order  on product.ProdUuid = _order.ProdUuid
  // com [1..*] to ZMK_I_ORDER as _order on product.ProdUuid = _order.ProdUuid
{
  key ProdUuid,
      Prodid,
      Pgid,
      Phaseid,
      @Semantics.text: true
      case 
      when Phaseid = 1
      then 1
      when Phaseid = 2
      then 2
      when Phaseid = 3
      then 3
      when Phaseid = 4
      then 5
      else 0
      end           as PhaseCriticality,
      _Phases.phase as phase,
      Pgname,
      Height,
      Depth,
      Width,
      measures,
      SizeUom,
      @Semantics.amount.currencyCode: 'priceCurrency'
      Price,
      PriceCurrency,
      Taxrate,
      @Semantics.user.createdBy: true
      CreatedBy,
      //@Semantics.systemDateTime.createdAt: true
      CreationTime,
      @Semantics.user.lastChangedBy: true
      ChangedBy,
      //@Semantics.systemDateTime.createdAt: true
      ChangeTime,
      last_changed_at,
      _market,
      _order
}
