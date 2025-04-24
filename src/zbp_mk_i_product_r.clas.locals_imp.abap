CLASS lhc_ZMK_I_PRODUCT_R DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmk_i_product_r RESULT result.

ENDCLASS.

CLASS lhc_ZMK_I_PRODUCT_R IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
