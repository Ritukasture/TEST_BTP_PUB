CLASS zcl_generate_data_booking DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS fill_booking.
ENDCLASS.



CLASS zcl_generate_data_booking IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    me->fill_booking(  ).
  ENDMETHOD.

  METHOD fill_booking.

    DATA: lt_data TYPE TABLE OF zmk_d_booking_a.

     lt_data  = VALUE #(
     ( booking_id = '1' book_id = '1' person_id = '1' booking_beg_date = '20210601' booking_beg_time = '090000'
       booking_end_date = '20210801' booking_end_time = '090000' booking_status = '1' )
     ( booking_id = '2' book_id = '2' person_id = '2' booking_beg_date = '20210602'
       booking_beg_time = '100000' booking_status = '2' )
     ( booking_id = '3' book_id = '3' person_id = '3' booking_beg_date = '20210603'
       booking_beg_time = '110000' booking_status = '1' )
     ( booking_id = '4' book_id = '4' person_id = '4' booking_beg_date = '20210604'
       booking_beg_time = '120000' booking_status = '1' )
     ( booking_id = '5' book_id = '5' person_id = '5' booking_beg_date = '20210605'
       booking_beg_time = '130000' booking_status = '1' )
     ( booking_id = '6' book_id = '6' person_id = '1' booking_beg_date = '20210606'
       booking_beg_time = '140000' booking_status = '2' ) ).

    LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      TRY.
          CALL METHOD cl_system_uuid=>if_system_uuid_static~create_uuid_x16
            RECEIVING
              uuid = DATA(lv_id).
        CATCH cx_uuid_error .
      ENDTRY.
      <ls_data>-booking_uuid = lv_id.
    ENDLOOP.

    DELETE FROM zmk_d_booking_a.
    INSERT zmk_d_booking_a FROM TABLE @lt_data.
  ENDMETHOD.

ENDCLASS.
