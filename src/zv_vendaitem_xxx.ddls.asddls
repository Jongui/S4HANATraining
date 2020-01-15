@AbapCatalog.sqlViewName: 'ZVVENDAITEMXXX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View Venda Items'

@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.writeActivePersistence: 'ZVENDAITEMXXX'
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true
@OData.publish: true

@UI.headerInfo: { typeName: 'Item ordem de venda', typeNamePlural: 'Items ordem de venda',
                  title.value: 'material' }
@Search.searchable: true
define view ZV_VENDAITEM_XXX
  as select from zvendaitemxxx
{

      @UI.facet: [
        {
          id: 'GeneralInformation',
          type: #COLLECTION,
          label: 'Info Material'
        },
        {
            parentId: 'GeneralInformation',
            id:'infoMaterial',
            type: #FIELDGROUP_REFERENCE,
            targetQualifier: 'one',
            label: 'Info Material'
        }]

  key id,
      @UI.fieldGroup: [{
        qualifier: 'one',
        position: 20
      }]
      @UI.selectionField.position: 20
      @UI.lineItem: { label: 'Material', position: 20, importance: #HIGH }
      @UI.identification: { label: 'Material', position: 20, importance: #HIGH }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Material'
  key material,
      @UI.fieldGroup: [{
        qualifier: 'one',
        position: 30
      }]
      @Semantics.quantity.unitOfMeasure : 'unid_medida'
      @UI.lineItem: { label: 'Quantidade', position: 30, importance: #HIGH }
      @UI.identification: { label: 'Quantidade', position: 30, importance: #HIGH }
      @EndUserText.label: 'Quantidade'
      quantidade,

      unid_medida,
      @UI.fieldGroup: [{
        qualifier: 'one',
        position: 40
      }]
      @Semantics.amount.currencyCode: 'curr'
      @UI.lineItem: { label: 'Valor', position: 40, importance: #HIGH }
      @UI.identification: { label: 'Valor', position: 40, importance: #HIGH }
      @EndUserText.label: 'Valor'
      valor,

      curr,
      @Semantics.currencyCode: true
      cast( 'EUR' as abap.cuky )             as targetCurr,
      @UI.fieldGroup: [{
        qualifier: 'one',
        position: 50
      }]
      @UI.lineItem: { label: 'Valor total em Euros', position: 50 }
      @EndUserText.label: 'Valor total em Euros'
      @Semantics.amount.currencyCode: 'targetCurr'
      CURRENCY_CONVERSION(
      amount             => valor,
      source_currency    => curr,
      target_currency    => cast( 'EUR' as abap.cuky ),
       exchange_rate_date => cast( '20200114' as abap.dats ),
       error_handling     => 'SET_TO_NULL' ) as ConvertedGrossAmount

}
