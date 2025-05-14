@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMK_I_EMPHISTORY as select from zmk_t_emphistory
{
    key name as Name,
    startdate as Startdate,
    enddate as Enddate, 
    cast( ' ' as abap.char(2)) as numdays,
     last_changed_at
}
