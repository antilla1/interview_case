CLASS zcl_po_order_collector DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_collector .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_po_order_collector IMPLEMENTATION.

  METHOD zif_collector~run.

    TYPES:
        BEGIN OF ts_po_data
      ,     po_order TYPE c LENGTH 10
      ,     po_item  TYPE c LENGTH 4
      ,     po_category  TYPE c LENGTH 1
      ,     po_type      TYPE c LENGTH 4
      ,     created_by   TYPE syuname
      ,     created_dt   TYPE d
      ,     material     TYPE c LENGTH 40
      , END OF ts_po_data
      , tt_po_data TYPE TABLE OF ts_po_data
      .

    DATA:
      lt_po_data      TYPE tt_po_data
    .


    lt_po_data = VALUE #( ( po_order = '1000000001'
                            po_item = '0001'
                            po_category = 'P'
                            po_type     = '0001'
                            created_by  = sy-uname
                            created_dt  = sy-datum
                            material    = '1200000001' )
                          ( po_order = '1000000002'
                            po_item = '0001'
                            po_category = 'P'
                            po_type     = '0001'
                            created_by  = sy-uname
                            created_dt  = sy-datum
                            material    = '1200000002' )
                          ( po_order = '1000000003'
                            po_item = '0001'
                            po_category = 'F'
                            po_type     = '0001'
                            created_by  = sy-uname
                            created_dt  = sy-datum
                            material    = '1200000003' )
                          ( po_order = '1000000004'
                            po_item = '0001'
                            po_category = 'P'
                            po_type     = '0001'
                            created_by  = sy-uname
                            created_dt  = sy-datum
                            material    = '1200000004' )
                          ( po_order = '1000000005'
                            po_item = '0001'
                            po_category = '5'
                            po_type     = '0001'
                            created_by  = sy-uname
                            created_dt  = sy-datum
                            material    = '1200000005' ) ).

    rv_data = /ui2/cl_json=>serialize(
                                    EXPORTING
                                        data = lt_po_data
                                        pretty_name = /ui2/cl_json=>pretty_mode-low_case ).


  ENDMETHOD.
ENDCLASS.
