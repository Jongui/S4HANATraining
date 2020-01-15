*&---------------------------------------------------------------------*
*& Report z_salvar_dados
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_salvar_dados.

CLASS lcl_main DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO lcl_main.
    METHODS: run.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create.

    DATA(lv) = cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>amdp_table_function ) ) ).
    CREATE OBJECT r_result.

  ENDMETHOD.

  METHOD run.
    DATA: lt_cab  TYPE STANDARD TABLE OF zvendacabxxx,
          lt_item TYPE STANDARD TABLE OF zvendaitemxxx,
          lw_cab  LIKE LINE OF lt_cab,
          lw_item LIKE LINE OF lt_item.

    DELETE FROM zvendacabxxx.
    DELETE FROM zvendaitemxxx.

    CLEAR lw_cab.
    lw_cab-id      = '0000000001'.
    lw_cab-datacriacao  = '20191231'.
    lw_cab-cliente = 'Cliente 1'.
    APPEND lw_cab TO lt_cab.
    CLEAR lw_item.
    lw_item-id          = lw_cab-id.
    lw_item-material    = 'Material 1'.
    lw_item-quantidade  = '10.1'.
    lw_item-unid_medida = 'KG'.
    lw_item-valor       = '10.00'.
    lw_item-curr        = 'EUR'.
    APPEND lw_item TO lt_item.
    CLEAR lw_item.
    lw_item-id          = lw_cab-id.
    lw_item-material    = 'Material 2'.
    lw_item-quantidade  = '20.0'.
    lw_item-unid_medida = 'KG'.
    lw_item-valor       = '20.00'.
    lw_item-curr        = 'GBP'.
    APPEND lw_item TO lt_item.

    CLEAR lw_cab.
    lw_cab-id      = '0000000002'.
    lw_cab-datacriacao    = '20191210'.
    lw_cab-cliente = 'Cliente 2'.
    APPEND lw_cab TO lt_cab.
    CLEAR lw_item.
    lw_item-id          = lw_cab-id.
    lw_item-material    = 'Material 1'.
    lw_item-quantidade  = '1.01'.
    lw_item-unid_medida = 'KG'.
    lw_item-valor       = '10.00'.
    lw_item-curr        = 'JPY'.
    APPEND lw_item TO lt_item.
    CLEAR lw_item.
    lw_item-id          = lw_cab-id.
    lw_item-material    = 'Material 3'.
    lw_item-quantidade  = '30.0'.
    lw_item-unid_medida = 'KG'.
    lw_item-valor       = '30.00'.
    lw_item-curr        = 'USD'.
    APPEND lw_item TO lt_item.

    CLEAR lw_item.
    lw_item-id          = lw_cab-id.
    lw_item-material    = 'Material 4'.
    lw_item-quantidade  = '30.0'.
    lw_item-unid_medida = 'L'.
    lw_item-valor       = '30.00'.
    lw_item-curr        = 'EUR'.
    APPEND lw_item TO lt_item.

    MODIFY: zvendacabxxx FROM TABLE lt_cab,
            zvendaitemxxx FROM TABLE lt_item.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).
