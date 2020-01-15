INTERFACE zif_vendacab_v4
  PUBLIC .
  TYPES:
    BEGIN OF gty_cds_views,
      cabecalho  TYPE ZV_VENDACAB_XXX,
    END OF gty_cds_views.

  TYPES: BEGIN OF gty_w_vendacab .
      INCLUDE TYPE gty_cds_views-cabecalho.
  TYPES:
    END OF gty_w_vendacab.

  TYPES:
    BEGIN OF gt_key_range,
      id    TYPE RANGE OF gty_cds_views-cabecalho-id,
    END OF gt_key_range.

  CONSTANTS:

    BEGIN OF gcs_cds_view_names,
      cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'CABECALHO',
    END OF gcs_cds_view_names,

    BEGIN OF gcs_entity_type_names,
      BEGIN OF internal,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'CABECALHO',
      END OF internal,
      BEGIN OF edm,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE 'CabecalhoType',
      END OF edm,
    END OF gcs_entity_type_names,

    BEGIN OF gcs_entity_set_names,
      BEGIN OF internal,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'CABECALHO',
      END OF internal,
      BEGIN OF edm,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE 'Cabecalho',
      END OF edm,
    END OF gcs_entity_set_names .

*    BEGIN OF gcs_nav_prop_names,
*      BEGIN OF internal,
*        salesorder_to_items TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE '_ITEM',
*      END OF internal,
*      BEGIN OF edm,
*        salesorder_to_items TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE '_Item',
*      END OF edm,
*    END OF gcs_nav_prop_names,
*
*    BEGIN OF gcs_expand_expressions,
*      "BEGIN OF internal,
*      salesorder_with_items TYPE /iwbep/if_v4_runtime_types=>ty_expand_expression VALUE '_ITEM',
*      "END OF internal,
*      "BEGIN OF edm,
*    END OF gcs_expand_expressions .

ENDINTERFACE.
