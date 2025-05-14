CLASS zcl_mk_buffer_unmng DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-DATA: gt_employee TYPE TABLE OF zmk_tab_employee.
    CLASS-DATA: gt_employee_upd TYPE TABLE OF zmk_tab_employee.
    CLASS-DATA: gt_employee_del type table of zmk_tab_employee.

    CLASS-METHODS get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_mk_buffer_unmng.

    CLASS-METHODS set_value IMPORTING it_data TYPE ztt_mk_employee.

    CLASS-METHODS set_upd_value IMPORTING it_data TYPE ztt_mk_employee.

    CLASS-METHODS set_del_value IMPORTING it_data Type ztt_mk_employee.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: go_instance TYPE REF TO zcl_mk_buffer_unmng.

ENDCLASS.

CLASS zcl_mk_buffer_unmng IMPLEMENTATION.
  METHOD get_instance.

    IF go_instance IS NOT BOUND.

      go_instance = NEW #( ).
    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.

  METHOD set_value.

    MOVE-CORRESPONDING it_data TO gt_employee.

  ENDMETHOD.

  METHOD set_upd_value.
   MOVE-CORRESPONDING it_data TO gt_employee_upd.
  ENDMETHOD.

  METHOD set_del_value.
   MOVE-CORRESPONDING it_data TO gt_employee_del.
  ENDMETHOD.

ENDCLASS.
