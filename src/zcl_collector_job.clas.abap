CLASS zcl_collector_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_collector_job IMPLEMENTATION.


  METHOD if_apj_dt_exec_object~get_parameters.
    " Return the supported selection parameters here
    et_parameter_def = VALUE #(
      ( selname = 'P_JOBID' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length = 16 param_text = 'Job Id'   lowercase_ind = abap_true changeable_ind = abap_true )
      ( selname = 'P_CLNAME' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length = 30 param_text = 'Class name'   lowercase_ind = abap_true changeable_ind = abap_true ) ).

*    " Return the default parameters values here
    et_parameter_val = VALUE #(
      ( selname = 'P_JOBID' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'DefaulJobId' )
      ( selname = 'P_CLNAME' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'ZCL_PO_ORDER_COLLECTOR' )
    ).
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.

    DATA:
       lt_parameters   TYPE if_apj_dt_exec_object=>tt_templ_val
     , lv_class_name   TYPE c LENGTH 30
     , lv_job_id       TYPE sysuuid_x16
     , lo_collector    TYPE REF TO zif_collector
     , ls_monitor      TYPE ztint_monitor
     .

    LOOP AT it_parameters INTO DATA(ls_parameter).
      CASE ls_parameter-selname.
        WHEN 'P_JOBID'. lv_job_id = ls_parameter-low.
        WHEN 'P_CLNAME'. lv_class_name = ls_parameter-low.
        WHEN OTHERS.
          APPEND ls_parameter TO lt_parameters.
      ENDCASE.
    ENDLOOP.

    TRY.
        CREATE OBJECT lo_collector TYPE (lv_class_name).
        ls_monitor-job_result = lo_collector->run( it_parameters = lt_parameters ).
      CATCH zcx_monitor INTO DATA(lx_monitor).

    ENDTRY.
    ls_monitor-collector_job_id = lv_job_id.

    MODIFY ztint_monitor FROM @ls_monitor.
    COMMIT WORK.


  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA  et_parameters TYPE if_apj_rt_exec_object=>tt_templ_val  .

    SELECT *
        FROM ztint_collector
        INTO TABLE @DATA(lt_collector).
    LOOP AT lt_collector ASSIGNING FIELD-SYMBOL(<ls_collector>).

      et_parameters = VALUE #(
        ( selname = 'P_JOBID' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'A6CE48C494271EDDA2F09DE3E22ACA5F' )
        ( selname = 'P_CLNAME' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'ZCL_PO_ORDER_COLLECTOR' )
      ).
      TRY.
          if_apj_rt_exec_object~execute( it_parameters = et_parameters ).
          out->write( |Finished| ).
        CATCH cx_root INTO DATA(job_scheduling_exception).
          out->write( |Exception has occured: { job_scheduling_exception->previous->get_longtext( ) }| ).
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
