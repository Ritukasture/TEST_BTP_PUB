@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Market'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED }
define view entity ZMK_C_MARKET 
as projection on ZMK_I_MARKET
{
    key ProdUuid,
    key MrktUuid,
    Mrktid,
    Status,
    Startdate,
    Enddate,
    CreatedBy,
    CreationTime,
    ChangedBy,
    ChangeTime,
    last_changed_at,
    /* Associations */
    _product: redirected to parent ZMK_C_PRODUCT_R
}
