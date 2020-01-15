CLASS zcl_vendacab_v4_data DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_data_provider
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_vendacab_v4.

    METHODS /iwbep/if_v4_dp_basic~read_entity REDEFINITION .
    METHODS /iwbep/if_v4_dp_basic~read_entity_list REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES gcs_entity_set_names
       FOR zif_vendacab_v4~gcs_entity_set_names .
    ALIASES gcs_entity_type_names
      FOR zif_vendacab_v4~gcs_entity_type_names .
    ALIASES gty_cds_views
      FOR zif_vendacab_v4~gty_cds_views.
    METHODS read_entity_cabecalho
      IMPORTING
        io_request  TYPE REF TO /iwbep/if_v4_requ_basic_read
        io_response TYPE REF TO /iwbep/if_v4_resp_basic_read
      RAISING
        /iwbep/cx_gateway.

    METHODS read_list_cabecalho
      IMPORTING
        io_request        TYPE REF TO /iwbep/if_v4_requ_basic_list
        io_response       TYPE REF TO /iwbep/if_v4_resp_basic_list
        iv_orderby_string TYPE string
        iv_where_clause   TYPE string
        iv_select_string  TYPE string
        iv_skip           TYPE i
        iv_top            TYPE i
        is_done_list      TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list
      RAISING
        /iwbep/cx_gateway.


ENDCLASS.



CLASS zcl_vendacab_v4_data IMPLEMENTATION.
  METHOD /iwbep/if_v4_dp_basic~read_entity.
    DATA: lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

    io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

    CASE lv_entityset_name.

      WHEN gcs_entity_set_names-internal-cabecalho.
        read_entity_cabecalho(
          EXPORTING
            io_request  = io_request
            io_response = io_response ).
      WHEN OTHERS.
        super->/iwbep/if_v4_dp_basic~read_entity(
          EXPORTING
            io_request  = io_request
            io_response = io_response ).

    ENDCASE.
  ENDMETHOD.

  METHOD /iwbep/if_v4_dp_basic~read_entity_list.
      DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

    DATA: ls_todo_list         TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list,
          ls_done_list         TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list,
          lv_where_clause      TYPE string,
          lv_select_string     TYPE string,
          lv_orderby_string    TYPE string,
          lt_selected_property TYPE /iwbep/if_v4_runtime_types=>ty_t_property_path,
          lv_skip              TYPE i VALUE 0,
          lv_top               TYPE i VALUE 0,
          lt_orderby_property  TYPE abap_sortorder_tab.


    io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

    IF ls_todo_list-process-orderby = abap_true.
      ls_done_list-orderby = abap_true.
      io_request->get_orderby( IMPORTING et_orderby_property = lt_orderby_property ).
      CLEAR lv_orderby_string.
      LOOP AT lt_orderby_property INTO DATA(ls_orderby_property).
        IF ls_orderby_property-descending = abap_true.
          CONCATENATE lv_orderby_string ls_orderby_property-name 'DESCENDING' INTO lv_orderby_string SEPARATED BY space.
        ELSE.
          CONCATENATE lv_orderby_string ls_orderby_property-name 'ASCENDING' INTO lv_orderby_string SEPARATED BY space.
        ENDIF.
      ENDLOOP.

    ELSE.
      lv_orderby_string = 'PRIMARY KEY'.
    ENDIF.


    IF ls_todo_list-process-skip = abap_true.
      ls_done_list-skip = abap_true.
      io_request->get_skip( IMPORTING ev_skip = lv_skip ).
    ENDIF.
    IF ls_todo_list-process-top = abap_true.
      ls_done_list-top = abap_true.
      io_request->get_top( IMPORTING ev_top = lv_top ).
    ENDIF.


    IF ls_todo_list-process-select = abap_true.
      ls_done_list-select = abap_true.
      io_request->get_selected_properties(  IMPORTING et_selected_property = lt_selected_property ).
      CONCATENATE LINES OF lt_selected_property INTO lv_select_string  SEPARATED BY ','.
    ELSE.
      lv_select_string = '*'.
    ENDIF.

    IF ls_todo_list-process-filter = abap_true.
      ls_done_list-filter = abap_true.
      io_request->get_filter_osql_where_clause( IMPORTING ev_osql_where_clause = lv_where_clause ).
    ENDIF.

    io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

    CASE lv_entityset_name.

      WHEN gcs_entity_set_names-internal-cabecalho.

        read_list_cabecalho(
          EXPORTING
            io_request        = io_request
            io_response       = io_response
            iv_orderby_string = lv_orderby_string
            iv_select_string  = lv_select_string
            iv_where_clause   = lv_where_clause
            iv_skip           = lv_skip
            iv_top            = lv_top
            is_done_list      = ls_done_list ).

      WHEN OTHERS.
        super->/iwbep/if_v4_dp_basic~read_entity_list( io_request  = io_request
                                                       io_response = io_response ).
    ENDCASE.

  ENDMETHOD.
  METHOD read_entity_cabecalho.

    DATA: lw_cabecalho         TYPE gty_cds_views-cabecalho,
          lw_key_cabecalho     TYPE gty_cds_views-cabecalho,
          lv_cabecalho_key_edm TYPE string,
          lv_helper_int        TYPE i.

    DATA: lw_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list,
          lw_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

    io_request->get_todos( IMPORTING es_todo_list = lw_todo_list ).

    io_request->get_key_data( IMPORTING es_key_data = lw_key_cabecalho ).
    lw_done_list-key_data = abap_true.

    SELECT SINGLE * FROM zv_vendacab_xxx
    INTO CORRESPONDING FIELDS OF @lw_cabecalho
    WHERE id = @lw_key_cabecalho-id.

    IF lw_cabecalho IS NOT INITIAL.
      io_response->set_busi_data( is_busi_data = lw_cabecalho ).
    ELSE.
      lv_cabecalho_key_edm = lv_helper_int = lw_key_cabecalho-id.

      RAISE EXCEPTION TYPE zcx_vendacab_v4
        EXPORTING
          textid              = zcx_vendacab_v4=>entity_not_found
          http_status_code    = zcx_vendacab_v4=>gcs_http_status_codes-not_found
          edm_entity_set_name = gcs_entity_set_names-edm-cabecalho
          entity_key          = lv_cabecalho_key_edm.

    ENDIF.

    io_response->set_is_done( lw_done_list ).

  ENDMETHOD.
  METHOD read_list_cabecalho.
    DATA : lt_key_range_cabecalho TYPE zif_e2e001_odata_v4_so_types=>gt_key_range-salesorder,
           lw_key_range_cabecalho TYPE LINE OF zif_e2e001_odata_v4_so_types=>gt_key_range-salesorder,
           lt_cabecalho           TYPE STANDARD TABLE OF gty_cds_views-cabecalho,
           lt_key_cabecalho       TYPE STANDARD TABLE OF gty_cds_views-cabecalho.

    DATA: lw_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list,
          lw_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list,
          lv_count     TYPE i,
          lv_max_index TYPE i.

    io_request->get_todos( IMPORTING es_todo_list = lw_todo_list ).

    lw_done_list = is_done_list.

    IF lw_todo_list-process-key_data = abap_true.
      io_request->get_key_data( IMPORTING et_key_data = lt_key_cabecalho ).
      LOOP AT lt_key_cabecalho INTO DATA(ls_key_entity).
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_key_entity-id ) TO lt_key_range_cabecalho.
      ENDLOOP.
      lw_done_list-key_data = abap_true.
    ENDIF.

    IF  lw_todo_list-process-filter = abap_false
    AND lw_todo_list-process-key_data = abap_false
    AND iv_top = 0.
      RAISE EXCEPTION TYPE zcx_vendacab_v4
        EXPORTING
          textid              = zcx_vendacab_v4=>use_filter_top_or_nav
          http_status_code    = zcx_vendacab_v4=>gcs_http_status_codes-bad_request
          edm_entity_set_name = gcs_entity_set_names-edm-cabecalho.
    ENDIF.

    IF lw_todo_list-return-busi_data = abap_true.
      IF iv_top IS NOT INITIAL.
        lv_max_index = iv_top + iv_skip.
      ELSE.
        lv_max_index = 0.
      ENDIF.

      SELECT (iv_select_string) UP TO @lv_max_index ROWS
        INTO CORRESPONDING FIELDS OF TABLE @lt_cabecalho
        FROM zv_vendacab_xxx
        WHERE (iv_where_clause)
          AND   id IN @lt_key_range_cabecalho
        ORDER BY (iv_orderby_string).

      IF iv_skip IS NOT INITIAL.
        DELETE lt_cabecalho TO iv_skip.
      ENDIF.

      io_response->set_busi_data( it_busi_data = lt_cabecalho ).

    ELSE.
      IF lw_todo_list-return-count = abap_true.

        SELECT COUNT( * )
          INTO @lv_count
          FROM zv_vendacab_xxx
          WHERE (iv_where_clause)
            AND id IN @lt_key_range_cabecalho.

        io_response->set_count( lv_count ).
      ENDIF.
    ENDIF.

    io_response->set_is_done( lw_done_list ).

  ENDMETHOD.
ENDCLASS.
