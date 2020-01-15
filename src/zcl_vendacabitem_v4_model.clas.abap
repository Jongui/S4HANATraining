CLASS zcl_vendacabitem_v4_model DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_model_prov
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_vendacabitem_v4.
    METHODS /iwbep/if_v4_mp_basic~define REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    ALIASES gty_cds_views
      FOR zif_vendacabitem_v4~gty_cds_views.
    ALIASES gcs_entity_set_names
      FOR zif_vendacabitem_v4~gcs_entity_set_names .
    ALIASES gcs_entity_type_names
      FOR zif_vendacabitem_v4~gcs_entity_type_names .
    ALIASES gcs_nav_prop_names
      FOR zif_vendacabitem_v4~gcs_nav_prop_names.

    METHODS define_vendacab
      IMPORTING
        io_model TYPE REF TO /iwbep/if_v4_med_model
      RAISING
        /iwbep/cx_gateway .
    METHODS define_vendaitem
      IMPORTING
        io_model TYPE REF TO /iwbep/if_v4_med_model
      RAISING
        /iwbep/cx_gateway .
ENDCLASS.



CLASS zcl_vendacabitem_v4_model IMPLEMENTATION.
  METHOD /iwbep/if_v4_mp_basic~define.
    define_vendacab( io_model ).
    define_vendaitem( io_model ).
  ENDMETHOD.
  METHOD define_vendacab.
    DATA: lt_primitive_properties TYPE /iwbep/if_v4_med_element=>ty_t_med_prim_property,
          lo_entity_set           TYPE REF TO /iwbep/if_v4_med_entity_set,
          lo_nav_prop             TYPE REF TO /iwbep/if_v4_med_nav_prop,
          lo_entity_type          TYPE REF TO /iwbep/if_v4_med_entity_type,
          lv_referenced_cds_view  TYPE gty_cds_views-cabecalho.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "   Criar entidade
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_entity_type = io_model->create_entity_type_by_struct(
                      EXPORTING
                        iv_entity_type_name          = gcs_entity_type_names-internal-cabecalho
                        is_structure                 = lv_referenced_cds_view
                        iv_add_conv_to_prim_props    = abap_true
                        iv_add_f4_help_to_prim_props = abap_true
                        iv_gen_prim_props            = abap_true ).

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Definir EDM externo como nome da entidade
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    lo_entity_type->set_edm_name( gcs_entity_type_names-edm-cabecalho ).

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Renomear EDM externa das propriedades
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_entity_type->get_primitive_properties( IMPORTING et_property = lt_primitive_properties ).

    LOOP AT lt_primitive_properties INTO DATA(lo_primitive_property).
      lo_primitive_property->set_edm_name( to_mixed( val = lo_primitive_property->get_internal_name( ) ) ).
    ENDLOOP.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Definir campos chave
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_primitive_property = lo_entity_type->get_primitive_property( 'ID' ).
    lo_primitive_property->set_is_key( ).

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "   Navegacao
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_nav_prop = lo_entity_type->create_navigation_property( gcs_nav_prop_names-internal-cabecalho_to_items ).
    lo_nav_prop->set_edm_name( gcs_nav_prop_names-edm-cabecalho_to_items ).

    lo_nav_prop->set_target_entity_type_name( gcs_entity_type_names-internal-items ).
    lo_nav_prop->set_target_multiplicity( /iwbep/if_v4_med_element=>gcs_med_nav_multiplicity-to_many_optional ).
    lo_nav_prop->set_on_delete_action( /iwbep/if_v4_med_element=>gcs_med_on_delete_action-none ).

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "   ENTITY SETS
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_entity_set = lo_entity_type->create_entity_set( gcs_entity_set_names-internal-cabecalho ).
    lo_entity_set->set_edm_name( gcs_entity_set_names-edm-cabecalho ).

  ENDMETHOD.
  METHOD define_vendaitem.
    DATA: lo_entity_type          TYPE REF TO /iwbep/if_v4_med_entity_type,
          lo_entity_set           TYPE REF TO /iwbep/if_v4_med_entity_set,
          lt_primitive_properties TYPE /iwbep/if_v4_med_element=>ty_t_med_prim_property,
          lv_referenced_cds_view  TYPE gty_cds_views-items  . " As internal ABAP name we use the name of the CDS view


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Create entity type
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_entity_type = io_model->create_entity_type_by_struct(
                      EXPORTING
                        iv_entity_type_name          = gcs_entity_type_names-internal-items
                        is_structure                 = lv_referenced_cds_view
                        iv_add_conv_to_prim_props    = abap_true
                        iv_add_f4_help_to_prim_props = abap_true
                        iv_gen_prim_props            = abap_true ).

    lo_entity_type->set_edm_name( gcs_entity_type_names-edm-items ).


    lo_entity_type->get_primitive_properties( IMPORTING et_property = lt_primitive_properties ).

    LOOP AT lt_primitive_properties INTO DATA(lo_primitive_property).
      lo_primitive_property->set_edm_name( to_mixed( val = lo_primitive_property->get_internal_name( ) ) ).
    ENDLOOP.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Set key field(s)
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_primitive_property = lo_entity_type->get_primitive_property( 'ID' ).
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MATERIAL'  ).
    lo_primitive_property->set_is_key( ).


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "   Create entity set
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_entity_set = lo_entity_type->create_entity_set( gcs_entity_set_names-internal-items ).
    lo_entity_set->set_edm_name( gcs_entity_set_names-edm-items ).

  ENDMETHOD.
ENDCLASS.
