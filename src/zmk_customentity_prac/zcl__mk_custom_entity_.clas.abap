CLASS zcl__mk_custom_entity_ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl__mk_custom_entity_ IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA(lv_top)  = io_request->get_paging(  )->get_page_size(  ).
    IF lv_top < 0.
      lv_top = 1.
    ENDIF.

    DATA(lv_skip) = io_request->get_paging(  )->get_offset(  ).

    DATA(lt_sort) = io_request->get_sort_elements(  ).

    DATA: lv_orderby TYPE string.

    LOOP AT lt_sort INTO DATA(ls_sort).

      IF ls_sort-descending = abap_true.
        lv_orderby = |' {  lv_orderby } { ls_sort-element_name } DESCENDING' |.
      ELSE.
        lv_orderby = |' {  lv_orderby } { ls_sort-element_name } ASCENDING' |.
      ENDIF.
    ENDLOOP.

    IF lv_orderby IS INITIAL.
      lv_orderby = 'prod_uuid'.
    ENDIF.

    DATA(lv_condition) = io_request->get_filter(  )->get_as_sql_string(  ).

    SELECT FROM ztb_mk_product
      FIELDS prod_uuid, Prodid, Pgid, Phaseid, Pgname, Height, Depth, Width,  size_uom, Price,
              price_currency, Taxrate, Created_By, Creation_Time, Changed_By, Change_Time
      WHERE (lv_condition)
      ORDER BY (lv_orderby)
      INTO TABLE @DATA(lt_product)
      UP TO @lv_top ROWS OFFSET @lv_skip.

    IF lines( lt_product ) > 0.
      io_response->set_total_number_of_records( lines( lt_product ) ).
    ELSE.
      io_response->set_total_number_of_records( 0 ).
    ENDIF.

    io_response->set_data( lt_product ).

  ENDMETHOD.

ENDCLASS.
