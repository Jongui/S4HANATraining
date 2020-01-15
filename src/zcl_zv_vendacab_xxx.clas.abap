class ZCL_ZV_VENDACAB_XXX definition
  public
  inheriting from CL_SADL_GTK_EXPOSURE_MPC
  final
  create public .

public section.
protected section.

  methods GET_PATHS
    redefinition .
  methods GET_TIMESTAMP
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZV_VENDACAB_XXX IMPLEMENTATION.


  method GET_PATHS.
et_paths = VALUE #(
( |CDS~ZV_VENDACAB_XXX| )
).
  endmethod.


  method GET_TIMESTAMP.
RV_TIMESTAMP = 20191216122641.
  endmethod.
ENDCLASS.
