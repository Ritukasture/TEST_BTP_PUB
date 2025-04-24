@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Market interface view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_I_MARKET as select from ztb_mk_market
association to parent ZMK_I_PRODUCT_R as _product on $projection.ProdUuid = _product.ProdUuid
{
    key prod_uuid as ProdUuid,
    key mrkt_uuid as MrktUuid,
    mrktid as Mrktid,
    status as Status,
    startdate as Startdate,
    enddate as Enddate,
    created_by as CreatedBy,
    creation_time as CreationTime,
    changed_by as ChangedBy,
    change_time as ChangeTime,
    last_changed_at,
    _product
}
