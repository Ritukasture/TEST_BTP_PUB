@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_I_PRODUCT as select from ztb_mk_product
{
    key prod_uuid as ProdUuid,
    prodid as Prodid,
    pgid as Pgid,
    phaseid as Phaseid,
    pgname as Pgname,
    height as Height,
    depth as Depth,
    width as Width,
    size_uom as SizeUom,
    @Semantics.amount.currencyCode: 'priceCurrency'
    price as Price,
    price_currency as PriceCurrency,
    taxrate as Taxrate,
    created_by as CreatedBy,
    creation_time as CreationTime,
    changed_by as ChangedBy,
    change_time as ChangeTime,
    last_changed_at
}
