@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for phase'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_PHASE_VH
  as select from ztb_mk_phase
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @Semantics.text: true
      @EndUserText.label: 'Phase_ID'
  key phaseid as Phaseid,
      phase   as Phase
}
