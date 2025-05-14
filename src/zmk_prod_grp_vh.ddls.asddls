@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH for Prod group'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_PROD_GRP_VH
  as select from ztb_mk_prod_grp
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @Semantics.text: true
      @EndUserText.label: 'Product_ID'
  key pgid     as Pgid,
      pgname   as Pgname,
      imageurl as Imageurl
}
