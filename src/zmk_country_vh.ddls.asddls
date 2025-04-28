@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH for country'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_COUNTRY_VH
  as select from ztb_mk_country
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @Semantics.text: true
      @EndUserText.label: 'Market_ID'
  key mrktid   as Mrktid,
      mrktname as Mrktname,
      code     as Code,
      imageurl as Imageurl
}
