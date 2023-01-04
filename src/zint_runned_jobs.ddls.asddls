@AbapCatalog.sqlViewName: 'ZINTRNDJOBS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Runned Jobs'
define root view ZINT_RUNNED_JOBS
  as select from ztint_runned
  association [1] to ZINT_MONITOR_CDS as _Monitor on $projection.collector_job_id = _Monitor.collector_job_id
  association [1] to ZINT_COLLECTOR as _Collector on $projection.collector_name = _Collector.collector_name
{

  key collector_job_id,
      int_job_name,
      int_job_count,
      collector_name,
      runned_date,
      sended,

      _Monitor,
      _Collector

}
