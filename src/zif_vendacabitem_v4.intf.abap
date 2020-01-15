INTERFACE zif_vendacabitem_v4
  PUBLIC .
  TYPES:
    BEGIN OF gty_cds_views,
      cabecalho TYPE zv_vendacab_xxx,
      items     TYPE zv_vendaitem_xxx,
    END OF gty_cds_views.

  TYPES: BEGIN OF gty_w_vendacab .
      INCLUDE TYPE gty_cds_views-cabecalho.
  TYPES:
    _item TYPE STANDARD TABLE OF gty_cds_views-items WITH DEFAULT KEY,
    END OF gty_w_vendacab.

  TYPES:
    BEGIN OF gt_key_range,
      id TYPE RANGE OF gty_cds_views-cabecalho-id,
      material TYPE RANGE OF gty_cds_views-items-material,
    END OF gt_key_range.

  CONSTANTS:

    BEGIN OF gcs_cds_view_names,
      cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'CABECALHO',
      items     TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'ITEMS',
    END OF gcs_cds_view_names,

    BEGIN OF gcs_entity_type_names,
      BEGIN OF internal,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'CABECALHO',
        items     TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'ITEMS',
      END OF internal,
      BEGIN OF edm,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE 'CabecalhoType',
        items     TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE 'ItemType',
      END OF edm,
    END OF gcs_entity_type_names,

    BEGIN OF gcs_entity_set_names,
      BEGIN OF internal,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'CABECALHO',
        items TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE 'ITEMS',
      END OF internal,
      BEGIN OF edm,
        cabecalho TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE 'Cabecalho',
        items TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE 'Items',
      END OF edm,
    END OF gcs_entity_set_names ,

    BEGIN OF gcs_nav_prop_names,
      BEGIN OF internal,
        cabecalho_to_items TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name VALUE '_ITEM',
      END OF internal,
      BEGIN OF edm,
        cabecalho_to_items TYPE /iwbep/if_v4_med_element=>ty_e_med_edm_name VALUE '_Item',
      END OF edm,
    END OF gcs_nav_prop_names,

    BEGIN OF gcs_expand_expressions,
      "BEGIN OF internal,
      cabecalho_with_items TYPE /iwbep/if_v4_runtime_types=>ty_expand_expression VALUE '_ITEM',
      "END OF internal,
      "BEGIN OF edm,
    END OF gcs_expand_expressions .

ENDINTERFACE.
