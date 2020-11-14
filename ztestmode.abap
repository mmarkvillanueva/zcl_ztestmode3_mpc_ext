*&---------------------------------------------------------------------*
*& Report ZTESTMODE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztestmode.

DATA(lt_aggrlevel) = VALUE fins_plan_api_aggrlevel_tt(
    ( |CATEGORY| ) ( |KTOPL| ) ( |PERIV| ) ( |HPRICE| ) ( |RYEAR| )
    ( |RBUKRS| )   ( |RACCT| ) ( |RLDNR| ) ( |RHCUR| ) ).

DATA(lt_selection) = VALUE fins_plan_api_selection_tt(
    ( fieldname = 'RBUKRS'   range = VALUE #( ( sign = 'I' option = 'EQ' low = '1710' ) ) )
    ( fieldname = 'RACCT'    range = VALUE #( ( sign = 'I' option = 'EQ' low = '0051100000' ) ) )
    ( fieldname = 'RLDNR'    range = VALUE #( ( sign = 'I' option = 'EQ' low = '0L' ) ) )
    ( fieldname = 'CATEGORY' range = VALUE #( ( sign = 'I' option = 'EQ' low = 'PLANORD01' ) ) ) ).

DATA(lt_plandata) = VALUE fins_plan_api_plandata_ext_tt( ).
DATA(lt_return) = VALUE bapiret2_ttab( ).

CALL FUNCTION 'FINPLAN_API_GETDATA'
  EXPORTING
    it_aggrlevel = lt_aggrlevel
    it_selection = lt_selection
  IMPORTING
    et_plandata  = lt_plandata
    et_return    = lt_return.

cl_demo_output=>display( lt_plandata ).

LOOP AT lt_plandata ASSIGNING FIELD-SYMBOL(<ls_plandata>) WHERE hprice > 0.
  <ls_plandata>-hprice = <ls_plandata>-hprice + 1.
ENDLOOP.

CALL FUNCTION 'FINPLAN_API_POSTDATA'
  EXPORTING
    i_testrun    = abap_false
    it_aggrlevel = lt_aggrlevel
    it_selection = lt_selection
    it_plandata  = lt_plandata
*   i_mode       = 'R'
  IMPORTING
    et_return    = lt_return.

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.

cl_demo_output=>display( lt_return ).
