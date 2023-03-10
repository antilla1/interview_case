@AbapCatalog.sqlViewName: 'ZINTMONCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Monitor'


@UI:{
headerInfo:{

typeName: 'Job Monitor',
typeNamePlural: 'Job Monitor',
title:{type: #STANDARD,value: 'collector_job_id'}
}

}

@ObjectModel.semanticKey: ['collector_job_id']
@ObjectModel.representativeKey: 'collector_job_id'
define root view ZINT_MONITOR_CDS as select from ztint_monitor {

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
  key collector_job_id,
  
//  int_job_name,
//  int_job_count,
//
//@UI: {
//        lineItem: [ { position: 30, importance: #HIGH , label: 'Collector job name'} ],
//        selectionField: [{position: 30 }],
//        fieldGroup: [{qualifier: 'GeneralData1',position: 30,importance: #HIGH }]
//}
//@EndUserText:{label: 'Collector job name'}    
//  collector_name,
//
//@UI: {
//lineItem: [ { position: 60, importance: #HIGH,label: 'Created Date' } ],
//fieldGroup: [{qualifier: 'GeneralData2',position: 30,importance: #HIGH }]
//}
//@EndUserText:{label: 'Created Date'}  
//  created_dt,
  job_result
}
