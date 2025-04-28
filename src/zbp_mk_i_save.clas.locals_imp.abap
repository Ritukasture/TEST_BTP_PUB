CLASS lsc_ZMK_I_PRODUCT_R DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMK_I_PRODUCT_R IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_market_log   TYPE STANDARD TABLE OF zlog_market_tab,
          lt_market_log_c TYPE STANDARD TABLE OF zlog_market_tab,
          lt_market_log_u TYPE STANDARD TABLE OF zlog_market_tab.


* Create entry log
    IF create-zmk_i_market IS NOT INITIAL.
      lt_market_log = CORRESPONDING #( create-zmk_i_market ).

      LOOP AT lt_market_log ASSIGNING FIELD-SYMBOL(<ls_market_create>).
        <ls_market_create>-changing_oper = 'Create'.
        READ TABLE create-zmk_i_market ASSIGNING FIELD-SYMBOL(<ls_market>)
                                       WITH TABLE KEY entity
                                       COMPONENTS  ProdUuid = <ls_market_create>-produuid
                                                   MrktUuid = <ls_market_create>-mrktuuid.
        IF sy-subrc IS INITIAL.
          IF <ls_market>-%control-Mrktid = cl_abap_behv=>flag_changed.
            <ls_market_create>-changed_field = 'Mrktid'.
            <ls_market_create>-changed_value = <ls_market>-Mrktid.
            TRY.
                <ls_market_create>-change_id = cl_system_uuid=>create_uuid_x16_static( ).
              CATCH cx_uuid_error.
                "handle exception
            ENDTRY.

            APPEND <ls_market_create> TO lt_market_log_c.
          ENDIF.

        ENDIF.

      ENDLOOP.

      INSERT zlog_market_tab FROM TABLE @lt_market_log_c.

    ENDIF.

* Update entry log
    IF update-zmk_i_market IS NOT INITIAL.
      lt_market_log = CORRESPONDING #( update-zmk_i_market ).
      LOOP AT update-zmk_i_market ASSIGNING FIELD-SYMBOL(<ls_market_update>).
        ASSIGN lt_market_log[ produuid = <ls_market_update>-produuid
                              mrktuuid = <ls_market_update>-mrktuuid ] TO FIELD-SYMBOL(<ls_log_u>).
        <ls_log_u>-changing_oper = 'Update'.

        IF <ls_market_update>-%control-Mrktid = if_abap_behv=>mk-on.
          <ls_log_u>-changed_field = 'Mrktid'.
          <ls_log_u>-changed_value = <ls_market_update>-Mrktid.
          TRY.
              <ls_log_u>-change_id = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error.
              "handle exception
          ENDTRY.

          APPEND <ls_log_u> TO lt_market_log_u.
        ENDIF.

      ENDLOOP.

      INSERT zlog_market_tab FROM TABLE @lt_market_log_u.
    ENDIF.



* Delete entry log
    IF delete-zmk_i_market IS NOT INITIAL.

    ENDIF.

**********************************************************************************
*                                Unmanaged save
**********************************************************************************
    TYPES: ltt_order TYPE ztb_mk_order.
    DATA: lt_order_crt TYPE STANDARD TABLE OF ztb_mk_order,
          lt_order_del TYPE STANDARD TABLE OF ztb_mk_order,
          lt_order_upd TYPE STANDARD TABLE OF ztb_mk_order.
*---Create
    IF create-zmk_i_order IS NOT INITIAL.
      lt_order_crt = VALUE #( FOR <ls_data> IN create-zmk_i_order
                                  ( prod_uuid = <ls_data>-ProdUuid
                                    mrkt_uuid = <ls_data>-MrktUuid
                                    order_uuid = <ls_data>-OrderUuid
                                    orderid    = <ls_data>-Orderid
                                    quantity = <ls_data>-Quantity
                                    calendar_year = <ls_data>-CalendarYear
                                    netamount     = <ls_data>-Netamount
                                    cuky_field    = <ls_data>-CukyField
                                    amountcurr    = <ls_data>-Amountcurr
                                    created_by    = <ls_data>-CreatedBy
                                    creation_time = <ls_data>-CreationTime
                                    changed_by    = <ls_data>-ChangedBy
                                    change_time   = <ls_data>-ChangeTime
                                    last_changed_at = <ls_data>-last_changed_at ) ).

      INSERT ztb_mk_order FROM TABLE @lt_order_crt.

    ENDIF.

*---Update
    IF update-zmk_i_order IS NOT INITIAL.
      lt_order_upd = VALUE #( FOR <ls_data> IN update-zmk_i_order
                                  ( prod_uuid = <ls_data>-ProdUuid
                                    mrkt_uuid = <ls_data>-MrktUuid
                                    order_uuid = <ls_data>-OrderUuid
                                    orderid    = <ls_data>-Orderid
                                    quantity = <ls_data>-Quantity
                                    calendar_year = <ls_data>-CalendarYear
                                    netamount     = <ls_data>-Netamount
                                    cuky_field    = <ls_data>-CukyField
                                    amountcurr    = <ls_data>-Amountcurr
                                    created_by    = <ls_data>-CreatedBy
                                    creation_time = <ls_data>-CreationTime
                                    changed_by    = <ls_data>-ChangedBy
                                    change_time   = <ls_data>-ChangeTime
                                    last_changed_at = <ls_data>-last_changed_at ) ).

      UPDATE ztb_mk_order FROM TABLE @lt_order_upd.
    ENDIF.

*---Delete
    IF delete-zmk_i_order IS NOT INITIAL.
      lt_order_del = VALUE #( FOR <ls_data1> IN delete-zmk_i_order
                                  ( prod_uuid = <ls_data1>-ProdUuid
                                    mrkt_uuid = <ls_data1>-MrktUuid
                                    order_uuid = <ls_data1>-OrderUuid ) ).

      DELETE ztb_mk_order FROM TABLE @lt_order_crt.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
