CLASS zcl_zs_vendacabitem_xx_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zs_vendacabitem_xx_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS /iwbep/if_mgw_appl_srv_runtime~create_deep_entity
        REDEFINITION.
  PROTECTED SECTION.

    METHODS cabecalhoset_get_entity
        REDEFINITION.
    METHODS cabecalhoset_get_entityset
        REDEFINITION .
    METHODS cabecalhoset_update_entity
        REDEFINITION.
    METHODS itemsset_get_entity
        REDEFINITION .
    METHODS itemsset_get_entityset
        REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zs_vendacabitem_xx_dpc_ext IMPLEMENTATION.

  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.
    DATA: BEGIN OF ls_order_item_data.
        INCLUDE TYPE zcl_zs_vendacabitem_xx_mpc=>ts_cabecalho.
    DATA: items TYPE zcl_zs_vendacabitem_xx_mpc=>tt_items,
          END OF ls_order_item_data.

* Get Entity Set Name
    DATA(lv_entity_set_name) = io_tech_request_context->get_entity_set_name( ).
*
    CASE lv_entity_set_name.
      WHEN 'CabecalhoSet'.

*   Get the Sales Order header and item data from the request to be created
        io_data_provider->read_entry_data( IMPORTING es_data = ls_order_item_data ).
    ENDCASE.
  ENDMETHOD.
  METHOD cabecalhoset_get_entity.
    DATA: lv_id       TYPE zvendaitemxxx-id.
    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<lf_key>)
                      WITH KEY name = 'Id'.
    IF <lf_key> IS ASSIGNED.
      lv_id = <lf_key>-value.
    ENDIF.

    SELECT  SINGLE *
      INTO  er_entity
      FROM  zvendacabxxx
      WHERE id  EQ lv_id.
  ENDMETHOD.

  METHOD cabecalhoset_get_entityset.
    DATA: lr_cliente     TYPE RANGE OF zvendacabxxx-cliente,
          lr_datacriacao TYPE RANGE OF zvendacabxxx-datacriacao,
          lr_id          TYPE RANGE OF zvendacabxxx-id,
          lw_cliente     LIKE LINE OF lr_cliente,
          lw_datacriacao LIKE LINE OF lr_datacriacao,
          lw_id          LIKE LINE OF lr_id,
          lw_so          TYPE /iwbep/s_cod_select_option.

    DATA(lt_filters) = io_tech_request_context->get_filter( )->get_filter_select_options( ).

    READ TABLE lt_filters ASSIGNING FIELD-SYMBOL(<lf_filters>)  WITH TABLE KEY property = 'ID'.
    IF <lf_filters> IS ASSIGNED.
      LOOP AT <lf_filters>-select_options INTO lw_so.
        MOVE-CORRESPONDING lw_so TO lw_id.
        APPEND lw_id TO lr_id.
      ENDLOOP.
    ENDIF.

    UNASSIGN <lf_filters>.
    READ TABLE lt_filters ASSIGNING <lf_filters>  WITH TABLE KEY property = 'DATACRIACAO'.
    IF <lf_filters> IS ASSIGNED.
      LOOP AT <lf_filters>-select_options INTO lw_so.
        MOVE-CORRESPONDING lw_so TO lw_datacriacao.
        APPEND lw_datacriacao TO lr_datacriacao.
      ENDLOOP.
    ENDIF.

    UNASSIGN <lf_filters>.
    READ TABLE lt_filters ASSIGNING <lf_filters>  WITH TABLE KEY property = 'CLIENTE'.
    IF <lf_filters> IS ASSIGNED.
      LOOP AT <lf_filters>-select_options INTO lw_so.
        MOVE-CORRESPONDING lw_so TO lw_cliente.
        APPEND lw_cliente TO lr_cliente.
      ENDLOOP.
    ENDIF.

    SELECT  *
      INTO  TABLE et_entityset
      FROM  zvendacabxxx
      WHERE id          IN lr_id
        AND datacriacao IN lr_datacriacao
        AND cliente     IN lr_cliente.

  ENDMETHOD.
  METHOD cabecalhoset_update_entity.
    DATA: BEGIN OF ls_order_item_data.
        INCLUDE TYPE zcl_zs_vendacabitem_xx_mpc=>ts_cabecalho.
    DATA: items TYPE zcl_zs_vendacabitem_xx_mpc=>tt_items,
          END OF ls_order_item_data.
    io_data_provider->read_entry_data( IMPORTING es_data = ls_order_item_data ).
  ENDMETHOD.
  METHOD itemsset_get_entity.
    DATA: lv_id       TYPE zvendaitemxxx-id,
          lv_material TYPE zvendaitemxxx-material.
    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<lf_key>)
                      WITH KEY name = 'Id'.
    IF <lf_key> IS ASSIGNED.
      lv_id = <lf_key>-value.
    ENDIF.

    UNASSIGN <lf_key>.
    READ TABLE it_key_tab ASSIGNING <lf_key>
                      WITH KEY name = 'Material'.
    IF <lf_key> IS ASSIGNED.
      lv_material = <lf_key>-value.
    ENDIF.

    CHECK NOT lv_id IS INITIAL.

    SELECT  SINGLE *
      INTO  er_entity
      FROM  zvendaitemxxx
      WHERE id EQ lv_id
        AND material EQ lv_material.
  ENDMETHOD.
  METHOD itemsset_get_entityset.
    DATA: lv_id       TYPE zvendaitemxxx-id.
    READ TABLE it_key_tab ASSIGNING FIELD-SYMBOL(<lf_key>)
                      WITH KEY name = 'Id'.
    IF <lf_key> IS ASSIGNED.
      lv_id = <lf_key>-value.
    ENDIF.

    SELECT  *
      INTO  TABLE et_entityset
      FROM  zvendaitemxxx
      WHERE id  EQ lv_id.
  ENDMETHOD.
ENDCLASS.
