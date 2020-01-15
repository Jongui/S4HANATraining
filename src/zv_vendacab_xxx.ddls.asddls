@AbapCatalog.sqlViewName: 'ZVVENDACABXXX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View Venda Cabecalho'

@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.writeActivePersistence: 'ZVENDACABXXX'
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true
@OData.publish: true

@UI.headerInfo: { typeName: 'Cabecalho ordem de venda', typeNamePlural: 'Cabecalhos ordem de venda' }
@Search.searchable: true
define view ZV_VENDACAB_XXX
  as select from zvendacabxxx
{
      @UI.facet: [
      {
      id: 'GeneralInformation',
      type: #COLLECTION,
      label: 'Info Ordem'
      },
      {
      parentId: 'GeneralInformation',
      id:'infoOrdem',
      type: #FIELDGROUP_REFERENCE,
      targetQualifier: 'one',
      label: 'Info Ordem'
      }]

      @UI.fieldGroup: [{
        qualifier: 'one',
        position: 10
      }]
      @UI.selectionField.position: 10
      @UI.lineItem: { label: 'Venda', position: 10, importance: #HIGH }
      @UI.identification: { label: 'Venda', position: 10, importance: #HIGH }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
  key id,
      @UI.fieldGroup: [{
      qualifier: 'one',
      position: 20
      }]
      @UI.selectionField.position: 20
      @UI.lineItem: { label: 'Data de criacao', position: 20, importance: #HIGH }
      @UI.identification: { label: 'Data de criacao', position: 20, importance: #HIGH }
      datacriacao,
      @UI.fieldGroup: [{
      qualifier: 'one',
      position: 30
      }]
      @UI.selectionField.position: 30
      @UI.lineItem: { label: 'Cliente', position: 30, importance: #HIGH }
      @UI.identification: { label: 'Cliente', position: 30, importance: #HIGH }
      cliente
}
