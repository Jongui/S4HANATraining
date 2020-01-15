@AbapCatalog.sqlViewName: 'ZVVENDACABITMXXX'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Associcacao cabecalho-item'
@Search.searchable: true

@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.writeActivePersistence: 'ZVENDACABXXX'
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true

@UI.headerInfo: { typeName: 'Ver ordem de venda', typeNamePlural: 'Ver ordens de venda' }
@OData.publish: true
define view ZV_VENDACABITEM_XXX
  as select from ZV_VENDACAB_XXX as cab
  association [1..*] to ZV_VENDAITEM_XXX as _item on _item.id = $projection.id
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
      },
      {
      id:'items',
      type: #FIELDGROUP_REFERENCE,
      targetQualifier: 'two',
      label: 'Itens'
      }]

      @UI.fieldGroup: [{
        qualifier: 'one',
        position: 10
      }]
      @UI.selectionField.position: 10
      @UI.lineItem: { label: 'Venda', position: 10, importance: #HIGH }
      @UI.identification: { label: 'Venda', position: 10, importance: #HIGH }
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
  key cab.id,
      @UI.fieldGroup: [{
      qualifier: 'one',
      position: 20
      }]
      @UI.selectionField.position: 20
      @UI.lineItem: { label: 'Cliente', position: 20, importance: #HIGH }
      @UI.identification: { label: 'Cliente', position: 20, importance: #HIGH }
      cab.cliente,
      @UI.fieldGroup: [{
      qualifier: 'one',
      position: 30
      }]
      @UI.selectionField.position: 30
      @UI.lineItem: { label: 'Data de criacao', position: 30, importance: #HIGH }
      @UI.identification: { label: 'Data de criacao', position: 30, importance: #HIGH }
      cab.datacriacao,
      @UI.fieldGroup: [{
      qualifier: 'two'
      }]
      _item
}
