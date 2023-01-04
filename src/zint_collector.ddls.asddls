@AbapCatalog.sqlViewName: 'ZINTCOLCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Collector'


@UI:{
headerInfo:{

typeName: 'Collectors',
typeNamePlural: 'Collectors',
title:{type: #STANDARD,value: 'collector_name'}
}

}

@ObjectModel.semanticKey: ['collector_name']
@ObjectModel.representativeKey: 'collector_name'
define root view ZINT_COLLECTOR
  as select from ztint_collector
{

      @UI.facet: [

      {   id: 'GeneralData',
          type: #COLLECTION,
          position: 10,
          label: 'Collectors'
       },

      {
          type: #FIELDGROUP_REFERENCE,
          position: 10,
          targetQualifier: 'GeneralData1',
          parentId: 'GeneralData',
          isSummary: true,
          isPartOfPreview: true
       },

      {
          type: #FIELDGROUP_REFERENCE,
          position: 20,
          targetQualifier: 'GeneralData2',
          parentId: 'GeneralData',
          isSummary: true,
          isPartOfPreview: true
      }

      ]


      @UI: {
              lineItem: [ { position: 10, importance: #HIGH , label: 'Collector name'} ],
              selectionField: [{position: 10 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 10,importance: #HIGH }]
      }
      @EndUserText:{label: 'Collector name'}
  key collector_name,

      @UI: {
              lineItem: [ { position: 20, importance: #HIGH , label: 'Collector descr'} ],
              selectionField: [{position: 20 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 20,importance: #HIGH }]
      }
      @EndUserText:{label: 'Collector descr'}
      collector_descr,

      @UI: {
              lineItem: [ { position: 30, importance: #HIGH , label: 'Periodic granularity'} ],
              selectionField: [{position: 30 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 30,importance: #HIGH }]
      }
      @EndUserText:{label: 'Periodic granularity'}
      periodic_granularity,

      @UI: {
              lineItem: [ { position: 40, importance: #HIGH , label: 'Start immediately'} ],
              selectionField: [{position: 40 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 40,importance: #HIGH }]
      }
      @EndUserText:{label: 'Start immediately'}
      start_immediately,

      @UI: {
              lineItem: [ { position: 50, importance: #HIGH , label: 'Timestamp'} ],
              selectionField: [{position: 50 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 50,importance: #HIGH }]
      }
      @EndUserText:{label: 'Timestamp'}
      timestamp
}
