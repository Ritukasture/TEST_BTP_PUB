CLASS lhc_zmk_i_order DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS getnetamount FOR DETERMINE ON SAVE
      IMPORTING keys FOR zmk_i_order~getnetamount.

ENDCLASS.

CLASS lhc_zmk_i_order IMPLEMENTATION.

  METHOD getnetamount.

    DATA(ls_order) = keys[ 1 ].


    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE ENTITY
     zmk_i_product_r FIELDS ( Price ) WITH CORRESPONDING #( keys ) RESULT DATA(lt_products)
     ENTITY zmk_i_product_r BY \_order ALL FIELDS WITH VALUE #( ( %key = VALUE #( ProdUuid = ls_order-ProdUuid ) ) )
       RESULT DATA(lt_order_read).

*    READ ENTITIES OF zmk_i_product_r IN LOCAL MODE
*     ENTITY zmk_i_product_r BY \_order
*     ALL FIELDS WITH CORRESPONDING #( keys )
*     RESULT DATA(lt_order_read).

    IF lt_order_read IS NOT INITIAL.

      READ TABLE lt_products ASSIGNING FIELD-SYMBOL(<lfs_product_read>) WITH KEY ProdUuid = ls_order-ProdUuid.

      IF sy-subrc EQ 0.

        READ TABLE lt_order_read ASSIGNING FIELD-SYMBOL(<lfs_order_read>) WITH KEY ProdUuid = ls_order-ProdUuid
                                                                                   MrktUuid = ls_order-MrktUuid
                                                                                   OrderUuid = ls_order-OrderUuid.
        IF sy-subrc NE 0.

          RETURN.

        ELSE.

*        LOOP AT lt_rbkp ASSIGNING FIELD-SYMBOL(<rbkp>).
          <lfs_order_read>-Netamount = <lfs_order_read>-Quantity * <lfs_product_read>-Price.
*    ENDLOOP.
          IF <lfs_order_read>-Netamount IS NOT INITIAL.
            MODIFY ENTITIES OF zmk_i_product_r
            IN LOCAL MODE
            ENTITY zmk_i_order
            UPDATE FIELDS ( Netamount  )
            with CORRESPONDING #( lt_order_read  ).
*            WITH VALUE #( FOR ls_data IN lt_order_read
*                         ( %key = ls_data-%key
*                           %tky = ls_data-%tky
*                           %is_draft = ls_data-%is_draft
*                           %data-Netamount = <lfs_order_read>-Netamount
*                           %control-Netamount = if_abap_behv=>mk-on )
*                        )
*                      REPORTED DATA(date_reported)
*                      FAILED DATA(date_failed)
*                      MAPPED DATA(date_mapped).
*            reported = CORRESPONDING #( DEEP date_reported ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
