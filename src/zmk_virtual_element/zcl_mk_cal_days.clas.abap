CLASS zcl_mk_cal_days DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_sadl_exit,
      if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_mk_cal_days IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_data TYPE STANDARD TABLE OF zmk_c_emphistory.

    lt_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      <ls_data>-numdays = <ls_data>-Enddate  - <ls_data>-Startdate.
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #( lt_data ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.

ENDCLASS.
