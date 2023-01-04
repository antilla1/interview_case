INTERFACE zif_collector
  PUBLIC .
  METHODS:
    run
      IMPORTING
        it_parameters TYPE if_apj_dt_exec_object=>tt_templ_val
      RETURNING VALUE(rv_data)  TYPE string
      RAISING zcx_monitor
      .

ENDINTERFACE.
