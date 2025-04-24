@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for Order'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZMK_C_ORDER
  as projection on ZMK_I_ORDER
{
  key ProdUuid,
  key MrktUuid,
  key OrderUuid,
      Orderid,
      Quantity,
      CalendarYear,
      @Semantics.amount.currencyCode: 'CukyField'
      Netamount,
      CukyField,
      @Semantics.amount.currencyCode: 'CukyField'
      Amountcurr,
      CreatedBy,
      CreationTime,
      ChangedBy,
      ChangeTime,
      last_changed_at,
      /* Associations */
      _product: redirected to parent ZMK_C_PRODUCT_R
}
