@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH for UOM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_UOM_VH
  as select from ztb_mk_uom
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @Semantics.text: true
      @EndUserText.label: 'UOM'
  key msehi   as Msehi,
      dimid   as Dimid,
      isocode as Isocode
}
