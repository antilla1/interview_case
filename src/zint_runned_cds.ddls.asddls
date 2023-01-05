//@AbapCatalog.sqlViewName: 'ZINTRUNCDS'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Runned'

@UI:{
headerInfo:{

typeName: 'Job Monitor',
typeNamePlural: 'Job Monitor',
title:{type: #STANDARD,value: 'collector_job_id'}
}

}

@ObjectModel.semanticKey: ['collector_job_id']
@ObjectModel.representativeKey: 'collector_job_id'
define root view entity ZINT_RUNNED_CDS
  as select from  ZINT_RUNNED_JOBS // ztint_runned
{

      @UI.facet: [

      {   id: 'GeneralData',
          type: #COLLECTION,
          position: 10,
          label: 'Job Monitor'
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
              lineItem: [ { position: 10, importance: #HIGH , label: 'Collector job id'} ],
              selectionField: [{position: 10 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 10,importance: #HIGH }]
      }
      @EndUserText:{label: 'Collector job id'}
      @UI.hidden: true
  key collector_job_id,

      int_job_name,
      int_job_count,

      @UI: {
              lineItem: [ { position: 30, importance: #HIGH , label: 'Collector job name'} ],
              selectionField: [{position: 30 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 30,importance: #HIGH }]
      }
      @EndUserText:{label: 'Collector job name'}
      collector_name,

      @UI: {
              lineItem: [ { position: 30, importance: #HIGH , label: 'Collector Descr'} ],
              selectionField: [{position: 30 }],
              fieldGroup: [{qualifier: 'GeneralData1',position: 30,importance: #HIGH }]
      }
      @EndUserText:{label: 'Collector Descr'}
      _Collector.collector_descr,

      @UI: {
      lineItem: [ { position: 60, importance: #HIGH,label: 'Created Date' } ],
      fieldGroup: [{qualifier: 'GeneralData2',position: 30,importance: #HIGH }]
      }
      @EndUserText:{label: 'Runned Date'}
      runned_date,
      
      @UI: {
      lineItem: [ { position: 40, importance: #HIGH , label: 'Sended'} ],
      fieldGroup: [{qualifier: 'GeneralData2',position: 40,importance: #HIGH }]
      }
      @EndUserText:{label: 'Sended'}
      sended,
      
      @UI: {
      fieldGroup: [{qualifier: 'GeneralData2',position: 50,importance: #HIGH }]
      }
      @EndUserText:{label: 'Result'}
      _Monitor.job_result

}
