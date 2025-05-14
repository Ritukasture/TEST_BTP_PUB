CLASS lhc_zmk_i_market DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validatestartdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmk_i_market~validatestartdate.
    METHODS confirm FOR MODIFY
      IMPORTING keys FOR ACTION zmk_i_market~confirm RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zmk_i_market RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmk_i_market RESULT result.
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR zmk_i_market RESULT result.
*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR zmk_i_market RESULT result.

ENDCLASS.

CLASS lhc_zmk_i_market IMPLEMENTATION.

  METHOD validatestartdate.
    DATA(lv_key) = keys[ 1 ]-ProdUuid.
    " Read Market field
    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
    ENTITY zmk_i_product_r
     FIELDS ( ProdUuid )
     WITH CORRESPONDING #(  keys )
     RESULT DATA(lt_prod)
     ENTITY zmk_i_product_r BY \_Market ALL FIELDS WITH VALUE #( (  %key = VALUE #( ProdUuid = lv_key )
                   ) )
                   RESULT DATA(lt_market).
    IF lt_market IS NOT INITIAL.
      READ TABLE lt_market ASSIGNING FIELD-SYMBOL(<ls_market>) INDEX 1.
      IF sy-subrc EQ 0.
        IF <ls_market>-Startdate IS INITIAL.
          APPEND VALUE #( %tky = <ls_market>-%tky ) TO failed-zmk_i_market.

          APPEND VALUE #( %tky        = <ls_market>-%tky
                      %state_area = 'VALIDATE_START_DATE_MANDATORY'
                      %msg        = new_message_with_text(
                             severity = if_abap_behv_message=>severity-error
                             text   = 'Start Date is Mandatory'
                               )

                     ) TO reported-zmk_i_market.

        ENDIF.

        IF <ls_market>-Startdate LT sy-datum.
          APPEND VALUE #( %tky = <ls_market>-%tky ) TO failed-zmk_i_market.
          APPEND VALUE #( %tky        = <ls_market>-%tky
*                      %state_area = 'VALIDATE_START_DATE'
*                      %msg        = new_message_with_text(
*                             severity = if_abap_behv_message=>severity-error
*                             text   = 'Start Date should be greater than or equal to todays date'
*                               )
                        %msg                = new_message( id       = '00'
                                                           number   =  001
                                                           v1       =  |Start Date should be greater than or equal to todays date|
                                                           severity = if_abap_behv_message=>severity-error )
                         %element-startdate      = if_abap_behv=>mk-on
                     ) TO reported-zmk_i_market.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD confirm.

    MODIFY ENTITIES OF zmk_i_product_r IN LOCAL MODE
         ENTITY zmk_i_market
         UPDATE FIELDS ( status ) WITH VALUE #( FOR ls_key IN keys
*                                    (  %key = ls1_res-%key
                                   ( %tky = ls_key-%tky
*                                       %is_draft = ls1_res-%is_draft
                                     %data-status = 'C' ) )
*                                       %control-phaseid = if_abap_behv=>mk-on  )  )
                         REPORTED DATA(date_reported).


  ENDMETHOD.

*  METHOD get_instance_authorizations.
*
*    DATA(lv_mart_uuid)  = keys[ 1 ]-MrktUuid.
*    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
*         ENTITY zmk_i_product_r BY \_Market
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         RESULT DATA(lt_market).
*
*    IF lt_market IS NOT INITIAL.
*
*      READ TABLE lt_market ASSIGNING FIELD-SYMBOL(<ls_market_tmp>) WITH KEY MrktUuid = lv_mart_uuid.
*      IF sy-subrc EQ 0.
*        IF sy-subrc EQ 0..
*
*            result = VALUE #( FOR ls_market IN lt_market
*                               (  %tky = ls_market-%tky
*                                  %action-Confirm = COND #( WHEN <ls_market_tmp>-Status EQ abap_true
*                                                                 THEN if_abap_behv=>fc-o-disabled
*
*                                                            WHEN <ls_market_tmp>-Status EQ abap_false
*                                                            THEN if_abap_behv=>fc-o-enabled
*                                                )
*
*                               )
*
*                            ).
*  ENDIF.
*
*ENDIF.
*ENDIF.
*
*ENDMETHOD.


  METHOD get_instance_features.

    DATA(lv_mart_uuid)  = keys[ 1 ]-MrktUuid.
    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
         ENTITY zmk_i_product_r BY \_Market
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(lt_market).

    IF lt_market IS NOT INITIAL.

      READ TABLE lt_market ASSIGNING FIELD-SYMBOL(<ls_market_tmp>) WITH KEY MrktUuid = lv_mart_uuid.
      IF sy-subrc EQ 0.
        IF sy-subrc EQ 0..

          result = VALUE #( FOR ls_market IN lt_market
                             (  %tky = ls_market-%tky
                                %action-Confirm = COND #( WHEN <ls_market_tmp>-Status EQ 'C'
                                                               THEN if_abap_behv=>fc-o-disabled

                                                          WHEN <ls_market_tmp>-Status NE 'C'
                                                          THEN if_abap_behv=>fc-o-enabled
                                              )

                             )

                          ).
        ENDIF.

      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
