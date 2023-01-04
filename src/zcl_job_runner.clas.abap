CLASS zcl_job_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      cv_template_name TYPE cl_apj_rt_api=>ty_template_name VALUE 'Z_COLLECTOR_TEMPLATE',
      cv_job_finished  TYPE cl_apj_rt_api=>ty_job_status VALUE 'F'.
    METHODS:
      run_jobs
        RAISING cx_apj_rt_content,
      send_result.
ENDCLASS.



CLASS zcl_job_runner IMPLEMENTATION.


  METHOD if_apj_dt_exec_object~get_parameters.
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.

    me->run_jobs( ).
    me->send_result( ).

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA  et_parameters TYPE if_apj_rt_exec_object=>tt_templ_val  .
    DATA:
      ls_start_info      TYPE cl_apj_rt_api=>ty_start_info
    , ls_scheduling_info TYPE cl_apj_rt_api=>ty_scheduling_info
    , lv_jobname         TYPE cl_apj_rt_api=>ty_jobname
    , lt_job_parameters  TYPE cl_apj_rt_api=>tt_job_parameter_value
    , ls_runned          TYPE ztint_runned
    .

    TRY.

        ls_start_info-start_immediately = abap_true.

        cl_apj_rt_api=>schedule_job(
        EXPORTING
            iv_job_template_name   = 'Z_JOB_RUNNER_TEMPLATE'
            iv_job_text            = 'Test'
            is_start_info          = ls_start_info
            is_scheduling_info     = ls_scheduling_info
            it_job_parameter_value = lt_job_parameters
        IMPORTING
            ev_jobname  = ls_runned-int_job_name
            ev_jobcount = ls_runned-int_job_count
        ).


        out->write( |Finished| ).
*        "CATCH cx_apj_rt_content INTO DATA(job_scheduling_exception).
      CATCH cx_root INTO DATA(job_scheduling_exception).
        out->write( |Exception has occured: { job_scheduling_exception->previous->get_longtext( ) }| ).
    ENDTRY.



  ENDMETHOD.
  METHOD run_jobs.

    DATA:
      ls_start_info      TYPE cl_apj_rt_api=>ty_start_info
    , ls_scheduling_info TYPE cl_apj_rt_api=>ty_scheduling_info
    , lv_jobname         TYPE cl_apj_rt_api=>ty_jobname
    , lt_job_parameters  TYPE cl_apj_rt_api=>tt_job_parameter_value
    , ls_runned          TYPE ztint_runned
    .

    TRY.
        SELECT *
            FROM ztint_collector
            INTO TABLE @DATA(lt_collector).
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_monitor
            EXPORTING
              textid = zcx_monitor=>no_collectors.
        ENDIF.
        LOOP AT lt_collector ASSIGNING FIELD-SYMBOL(<ls_collector>).


          CLEAR: ls_runned, lt_job_parameters.
          ls_runned-collector_job_id = cl_system_uuid=>create_uuid_x16_static( ).
          ls_runned-collector_name = <ls_collector>-collector_name.
          ls_runned-runned_date = sy-datum.

          lt_job_parameters = VALUE #(
   ( name = 'P_JOBID' t_value = VALUE #( ( sign   = 'I'
                                          option = 'EQ'
                                          low    = ls_runned-collector_job_id ) ) )
   ( name = 'P_CLNAME' t_value = VALUE #( ( sign   = 'I'
                                          option = 'EQ'
                                          low    = to_upper( <ls_collector>-collector_name ) ) ) )
  ).

          ls_start_info-start_immediately = <ls_collector>-start_immediately.
          TRY.
              cl_apj_rt_api=>schedule_job(
              EXPORTING
                  iv_job_template_name   = cv_template_name
                  iv_job_text            = <ls_collector>-collector_descr
                  is_start_info          = ls_start_info
                  is_scheduling_info     = ls_scheduling_info
                  it_job_parameter_value = lt_job_parameters
              IMPORTING
                  ev_jobname  = ls_runned-int_job_name
                  ev_jobcount = ls_runned-int_job_count
              ).
            CATCH cx_apj_rt INTO DATA(lx_apj_rt).
              RAISE EXCEPTION TYPE zcx_monitor
                EXPORTING
                  previous = lx_apj_rt.
          ENDTRY.

          INSERT ztint_runned FROM @ls_runned.
          COMMIT WORK.

        ENDLOOP.
      CATCH cx_root INTO DATA(lx_exc).
        RAISE EXCEPTION TYPE cx_apj_rt_content
          EXPORTING
            previous = lx_exc.
    ENDTRY.

  ENDMETHOD.

  METHOD send_result.

    DATA:
      lv_status TYPE cl_apj_rt_api=>ty_job_status
    , lv_job_result TYPE xstring
    .

    SELECT *
        FROM ztint_runned
        WHERE sended <> @abap_true
        INTO TABLE @DATA(lt_runned).

    LOOP AT lt_runned ASSIGNING FIELD-SYMBOL(<ls_runned>).
      TRY.
          cl_apj_rt_api=>get_job_status(
              EXPORTING
                  iv_jobname  = <ls_runned>-int_job_name
                  iv_jobcount = <ls_runned>-int_job_count
              IMPORTING
                  ev_job_status = lv_status
              ).
          IF lv_status = 'F'.

            "Send job data to AWS
            <ls_runned>-sended = abap_true.
          ENDIF.
        CATCH cx_apj_rt INTO DATA(lx_apj_rt).

      ENDTRY.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
