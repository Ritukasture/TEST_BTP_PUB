@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view employee'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMK_I_EMPLOYEE
  as select from zmk_tab_employee
{
  key num  as Num,
  key name as Name,
      age  as Age,
      last_changed_at
      //    _association_name // Make association public
}
