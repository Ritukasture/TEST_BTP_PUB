@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Interface'
@Metadata.ignorePropagatedAnnotations: true
//@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMK_I_ORDER as select from ztb_mk_order
association to parent ZMK_I_PRODUCT_R as _product on $projection.ProdUuid = _product.ProdUuid
{
    key prod_uuid as ProdUuid,
    key mrkt_uuid as MrktUuid,
    key order_uuid as OrderUuid,
    orderid as Orderid,
    quantity as Quantity,
    calendar_year as CalendarYear,
    @Semantics.amount.currencyCode: 'CukyField'
    netamount as Netamount,
    cuky_field as CukyField,
    @Semantics.amount.currencyCode: 'CukyField'
    amountcurr as Amountcurr,
    created_by as CreatedBy,
    creation_time as CreationTime,
    changed_by as ChangedBy,
    change_time as ChangeTime,
    last_changed_at,
    _product
}
