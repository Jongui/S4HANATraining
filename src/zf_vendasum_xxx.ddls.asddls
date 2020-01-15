@EndUserText.label: 'Function Table soma Venda Cabecalho'
@ClientDependent: true
@AccessControl.authorizationCheck: #NOT_REQUIRED

define table function ZF_VENDASUM_XXX
with parameters @Environment.systemField: #CLIENT
                  clnt:abap.clnt
returns {
  client  : mandt;
  id      : z_id_xxx;
  cliente : z_cliente_xxx;
  @Semantics.amount.currencyCode : 'ZF_VENDASUM_XXX.curr'
  valor   : z_valor_total_xxx;
  curr    : z_curr_xxx;
}
implemented by method zcl_amdp_vendas=>valor_total;