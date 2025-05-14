CLASS lhc_ZMK_I_EMPLOYEE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmk_i_employee RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zmk_i_employee.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zmk_i_employee.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zmk_i_employee.

    METHODS read FOR READ
      IMPORTING keys FOR READ zmk_i_employee RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zmk_i_employee.

ENDCLASS.

CLASS lhc_ZMK_I_EMPLOYEE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA: ls_employee TYPE zmk_tab_employee,
          lt_employee TYPE TABLE OF zmk_tab_employee.

    SELECT MAX( num )
    FROM zmk_tab_employee
    INTO @DATA(lv_num).

    IF sy-subrc NE 0.
    ENDIF.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).

*      DATA(lo_instance) = zcl_mk_buffer_unmng=>get_instance(  ).
      lv_num = lv_num + 1.
      ls_employee-num = <lfs_entity>-num.
      ls_employee-name  = <lfs_entity>-name.
      ls_employee-age = <lfs_entity>-age.

      APPEND ls_employee TO lt_employee.

*  INSERT Value #(
*         %cid = <lfs_entity>-%cid
*         num = ls_employee-num )
*         INTO table mapped-zmk_i_employee.

    ENDLOOP.

*    APPEND lt_employee TO zcl_mk_buffer_unmng=>gt_employee.

    MOVE-CORRESPONDING lt_employee TO zcl_mk_buffer_unmng=>gt_employee.
*    INSERT zmk_tab_employee FROM TABLE @lt_employee.

  ENDMETHOD.

  METHOD update.

    DATA: ls_employee TYPE zmk_tab_employee,
          lt_employee TYPE TABLE OF zmk_tab_employee.


    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).

      DATA(ls_control)  = <lfs_entity>-%control.
      IF ls_control-name IS NOT INITIAL.
        ls_employee-name  = <lfs_entity>-name.
      ENDIF.
*      IF ls_control-age IS NOT INITIAL.
      ls_employee-age = <lfs_entity>-age.
*      ENDIF.

*      IF ls_employee IS NOT INITIAL.
      APPEND ls_employee TO lt_employee.
*     ENDIF.

    ENDLOOP.

    MOVE-CORRESPONDING lt_employee TO zcl_mk_buffer_unmng=>gt_employee_upd.

  ENDMETHOD.

  METHOD delete.

    DATA: ls_employee TYPE zmk_tab_employee,
          lt_employee TYPE TABLE OF zmk_tab_employee.


    LOOP AT keys ASSIGNING FIELD-SYMBOL(<lfs_entity>).

*      DATA(lo_instance) = zcl_mk_buffer_unmng=>get_instance(  ).

      ls_employee-num = <lfs_entity>-num.

      APPEND ls_employee TO lt_employee.

    ENDLOOP.

    MOVE-CORRESPONDING lt_employee TO zcl_mk_buffer_unmng=>gt_employee_del.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMK_I_EMPLOYEE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMK_I_EMPLOYEE IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.

    IF zcl_mk_buffer_unmng=>gt_employee IS NOT INITIAL.
      SELECT MAX( num )
    FROM zmk_tab_employee
    INTO @DATA(lv_num).

      LOOP AT zcl_mk_buffer_unmng=>gt_employee  ASSIGNING FIELD-SYMBOL(<ls_create>).

        <ls_create>-num = lv_num + 1.

      ENDLOOP.


    ENDIF.
  ENDMETHOD.

  METHOD save.

    IF zcl_mk_buffer_unmng=>gt_employee IS NOT INITIAL.
      INSERT zmk_tab_employee FROM TABLE @zcl_mk_buffer_unmng=>gt_employee.

    ELSEIF zcl_mk_buffer_unmng=>gt_employee_upd IS NOT INITIAL.

      UPDATE zmk_tab_employee FROM TABLE @zcl_mk_buffer_unmng=>gt_employee_upd.

    ELSEIF zcl_mk_buffer_unmng=>gt_employee_del IS NOT INITIAL.

      DELETE zmk_tab_employee FROM TABLE @zcl_mk_buffer_unmng=>gt_employee_del.

    ENDIF.

  ENDMETHOD.

  METHOD cleanup.
*    CLEAR: zcl_mk_buffer_unmng=>gt_employee, zcl_mk_buffer_unmng=>gt_employee_upd,
*           zcl_mk_buffer_unmng=>gt_employee_del.


  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_buffer DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    CLASS-METHODS get_instance

      RETURNING VALUE(ro_instance) TYPE REF TO lcl_buffer.



  PRIVATE SECTION.

    CLASS-DATA: go_instance TYPE REF TO lcl_buffer.

ENDCLASS.



CLASS lcl_buffer IMPLEMENTATION.

  METHOD get_instance.

    IF go_instance IS NOT BOUND.

      go_instance = NEW #( ).

    ENDIF.

    ro_instance = go_instance.

  ENDMETHOD.

ENDCLASS.
