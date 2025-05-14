@EndUserText.label: 'Custom Entity'
@ObjectModel.query.implementedBy:  'ABAP:ZCL__MK_CUSTOM_ENTITY_'
define custom entity ZMK_I_PROD_CUSTOM 
{
  key prod_uuid      : sysuuid_x16;
      prodid         : abap.char(15);
      pgid           : zdel_mk_pg_id;
      phaseid        : zdel_mk_phase_id;
      pgname         : zdel_mk_pg_name;
      height         : abap.int4;
      depth          : abap.int4;
      width          : abap.int4;
      size_uom       : msehi;
      @Semantics.amount.currencyCode : 'price_currency'
      price          : abap.curr(15,2);
      price_currency : waers_curc;
      taxrate        : abap.dec(5,2);
      created_by     : abap.char(12);
      creation_time  : abap.tims;
      changed_by     : abap.char(12);
      change_time    : abap.tims;

}
