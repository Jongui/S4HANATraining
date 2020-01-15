CLASS zcl_amdp_vendas DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS valor_total FOR TABLE FUNCTION zf_vendasum_xxx.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_vendas IMPLEMENTATION.
  METHOD valor_total BY DATABASE FUNCTION FOR HDB
                     LANGUAGE SQLSCRIPT
                     OPTIONS READ-ONLY
                     USING zvendacabxxx zvendaitemxxx.
    RETURN SELECT cab.client as client,
                  cab.id as id,
                  cab.cliente as cliente,
                  SUM ( item.valor),
                  item.curr as curr
                  FROM zvendacabxxx AS cab
                    INNER JOIN zvendaitemxxx AS item
                    ON cab.client = item.client AND
                       cab.id = item.id
                    WHERE cab.client = :clnt
                    GROUP BY cab.id, cab.cliente
                    ORDER BY cab.id;

  ENDMETHOD.
ENDCLASS.
