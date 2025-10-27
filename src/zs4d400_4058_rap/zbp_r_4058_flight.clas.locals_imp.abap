CLASS lhc_zr_4058_flight DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Zr4058Flight
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
        IMPORTING keys FOR Zr4058Flight~validatePrice.


ENDCLASS.

CLASS lhc_zr_4058_flight IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatePrice.

    DATA failed_record   LIKE LINE OF failed-Zr4058Flight.
    DATA reported_record LIKE LINE OF reported-Zr4058Flight.

    READ ENTITIES OF ZR_4058_Flight IN LOCAL MODE
    ENTITY Zr4058Flight
      FIELDS ( Price )
      WITH CORRESPONDING #(  keys )
      RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).
      IF flight-price <= 0.

        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-Zr4058Flight.

        reported_record-%tky = flight-%tky.
        reported_record-%msg = new_message(
                          id       = '/LRN/S4D400'
                          number   = '101'
                          severity = ms-error ).
        APPEND reported_record TO reported-Zr4058Flight.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
