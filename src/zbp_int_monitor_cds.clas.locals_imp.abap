CLASS lhc_ZINT_MONITOR_CDS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zint_monitor_cds RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zint_monitor_cds RESULT result.

    METHODS runJob FOR MODIFY
      IMPORTING keys FOR ACTION zint_monitor_cds~runJob RESULT result.

ENDCLASS.

CLASS lhc_ZINT_MONITOR_CDS IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD runJob.

    SELECT collector_name, collector_descr, periodic_granularity, start_immediately, timestamp
        FROM ztint_collector
        INTO TABLE @DATA(lt_collector).

    loop at lt_collector ASSIGNING FIELD-SYMBOL(<ls_collector>).

    endloop.


  ENDMETHOD.

ENDCLASS.
