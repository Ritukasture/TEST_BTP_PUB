CLASS lhc_ZMK_I_PRODUCT_R DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmk_i_product_r RESULT result.
    METHODS copyproduct FOR MODIFY
      IMPORTING keys FOR ACTION zmk_i_product_r~copyproduct.
*    METHODS set_first_phase FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR zmk_i_product_r~set_first_phase.
    METHODS first_phase_set FOR DETERMINE ON SAVE
      IMPORTING keys FOR zmk_i_product_r~first_phase_set.
*    METHODS onsave FOR VALIDATE ON SAVE
*      IMPORTING keys FOR zmk_i_product_r~onsave.

ENDCLASS.

CLASS lhc_ZMK_I_PRODUCT_R IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD copyproduct.

    DATA: lt_product TYPE TABLE FOR CREATE zmk_i_product_r,
          lt_market  TYPE TABLE FOR CREATE zmk_i_product_r\_market,
          lt_order   TYPE TABLE FOR CREATE zmk_i_product_r\_order.

    READ TABLE keys ASSIGNING FIELD-SYMBOL(<ls_without_cid>) WITH KEY %cid = ' '.
    ASSERT <ls_without_cid> IS NOT ASSIGNED.

    READ ENTITIES OF zmk_i_product_r  IN LOCAL MODE
          ENTITY zmk_i_product_r
          ALL FIELDS WITH CORRESPONDING #(  keys  )
          RESULT DATA(lt_product_read)
          FAILED DATA(lt_failed).

    READ ENTITIES OF zmk_i_product_r  IN LOCAL MODE
        ENTITY zmk_i_product_r BY \_market
        ALL FIELDS WITH CORRESPONDING #(  keys  )
        RESULT DATA(lt_market_read).

*    READ ENTITIES OF zmk_i_product_r  IN LOCAL MODE
*      ENTITY zmk_i_product_r BY \_order
*      ALL FIELDS WITH CORRESPONDING #(  keys  )
*      RESULT DATA(lt_order_read).

    LOOP AT lt_product_read ASSIGNING FIELD-SYMBOL(<ls_product>).

*      APPEND INITIAL LINE TO lt_product ASSIGNING FIELD-SYMBOL(<ls_travel_copy>).
*       <ls_travel_copy>-%CID  = keys[ key entity produuid = <ls_product>-produuid ]-%CID.
*       <ls_travel_copy>-%data = CORRESPONDING #( <ls_product> EXCEPT produuid ).

* Inline declaration of line 45 46 47
      APPEND VALUE #( %cid  = keys[ KEY entity produuid = <ls_product>-produuid ]-%cid
                      %data = CORRESPONDING #( <ls_product> EXCEPT produuid prodid ) )
                  TO lt_product ASSIGNING FIELD-SYMBOL(<ls_product_copy>).

      <ls_product_copy>-Prodid = keys[ 1 ]-%param-prodid.
      APPEND VALUE #(  %cid_ref = <ls_product_copy>-%cid )
                 TO lt_market ASSIGNING FIELD-SYMBOL(<ls_market_copy>).

      LOOP AT lt_market_read ASSIGNING FIELD-SYMBOL(<ls_market>)
                                             USING KEY entity
                                             WHERE ProdUuid = <ls_product>-ProdUuid.

        APPEND VALUE #(  %cid = <ls_product_copy>-%cid && <ls_market>-Mrktid
                        %data = CORRESPONDING #( <ls_market> EXCEPT produuid mrktuuid  )  )
                     TO  <ls_market_copy>-%target ASSIGNING FIELD-SYMBOL(<ls_market_new>).

        <ls_market_new>-Startdate = cl_abap_context_info=>get_system_date(  ).
        <ls_market_new>-Enddate   = cl_abap_context_info=>get_system_date(  ) + 30.

      ENDLOOP.

      MODIFY ENTITIES OF zmk_i_product_r IN LOCAL MODE
          ENTITY zmk_i_product_r
          CREATE FIELDS ( Prodid
                          Pgid
                          Phaseid
                          Pgname
                          Height
                          Depth
                          Width
                          SizeUom
                          Price
                          PriceCurrency
                          Taxrate
                          CreatedBy
                          CreationTime
                          ChangedBy
                          ChangeTime )
          WITH lt_product
          ENTITY zmk_i_product_r
          CREATE BY \_market
          FIELDS (     mrktid
                       status
                       startdate
                       Enddate
                       CreatedBy
                       CreationTime
                       ChangedBy
                       ChangeTime )
          WITH lt_market
          MAPPED DATA(lt_mapped).

      mapped-zmk_i_product_r = lt_mapped-zmk_i_product_r.


    ENDLOOP.

  ENDMETHOD.

*  METHOD set_first_phase.
*
**    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
**    ENTITY zmk_i_product_r
**    FIELDS ( Phaseid )
**    WITH CORRESPONDING #( keys )
**    RESULT DATA(LT_Res).
**
**    MODIFY ENTITIES OF zmk_i_product_r IN LOCAL MODE
**           ENTITY zmk_i_product_r
**           UPDATE FIELDS ( Phaseid ) WITH VALUE #( FOR ls1_res IN lt_res
***                                    (  %key = ls1_res-%key
**                                     ( %tky = ls1_res-%tky
***                                       %is_draft = ls1_res-%is_draft
**                                       %data-phaseid = '1'
**                                       %control-phaseid = if_abap_behv=>mk-on  )  )
**                           REPORTED DATA(date_reported)
**                           FAILED DATA(date_failed)
**                           MAPPED DATA(date_mapped).
*
*  ENDMETHOD.

  METHOD first_phase_Set.

*    DATA: lt_product TYPE TABLE FOR CREATE zmk_i_product_r.
*
*    lt_product = VALUE #( ( Phaseid = '1' )  ).
*
*    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
*    ENTITY zmk_i_product_r
*    FIELDS ( Phaseid )
*    WITH CORRESPONDING #( keys )
*    RESULT DATA(LT_Res).
*
*    MODIFY ENTITIES OF zmk_i_product_r IN LOCAL MODE
*           ENTITY zmk_i_product_r
*           UPDATE FIELDS ( Phaseid ) WITH VALUE #( FOR ls1_res IN lt_res
**                                    (  %key = ls1_res-%key
*                                     ( %tky = ls1_res-%tky
**                                       %is_draft = ls1_res-%is_draft
*                                       %data-phaseid = '1'
*                                       %control-phaseid = if_abap_behv=>mk-on  )  )
*                           REPORTED DATA(date_reported)
*                           FAILED DATA(date_failed)
*                           MAPPED DATA(date_mapped).

    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
         ENTITY zmk_i_product_r
         FIELDS (  Phaseid )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_phase)
         FAILED DATA(ls_failed).

    IF sy-subrc EQ 0.

      DELETE lt_phase WHERE Phaseid IS NOT INITIAL.
      IF lt_phase IS INITIAL.
        RETURN.
      ENDIF.

      READ TABLE lt_phase ASSIGNING FIELD-SYMBOL(<ls_phase>) INDEX 1.
      IF sy-subrc EQ 0.
        <ls_phase>-Phaseid = '1'.
      ENDIF.

      MODIFY ENTITIES OF zmk_i_product_r IN LOCAL MODE
         ENTITY zmk_i_product_r
         UPDATE FIELDS ( Phaseid )
         WITH CORRESPONDING #( lt_phase )
         REPORTED DATA(ls_update_reported).
      IF sy-subrc EQ 0.
        reported = CORRESPONDING #( DEEP ls_update_reported ).
      ENDIF.


    ENDIF.

  ENDMETHOD.

ENDCLASS.
