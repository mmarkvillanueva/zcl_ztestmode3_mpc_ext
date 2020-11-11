CLASS zcl_ztestmode3_mpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_ztestmode3_mpc
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS define
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ztestmode3_mpc_ext IMPLEMENTATION.


  METHOD define.

    super->define( ).
    cl_s4hana_odata_util=>set_alpha_default_numc_conv( model ).

    DATA: lo_tag         TYPE REF TO /iwbep/if_mgw_odata_tag, "#EC NEEDED
          lo_entity_set  TYPE REF TO /iwbep/if_mgw_odata_entity_set,
          lo_entity_type TYPE REF TO /iwbep/if_mgw_odata_entity_typ,
          lo_action      TYPE REF TO /iwbep/if_mgw_odata_action, "#EC NEEDED
          lo_parameter   TYPE REF TO /iwbep/if_mgw_odata_property. "#EC NEEDED

    "Take fields out of metadata
    model->get_entity_type( 'A_FinPlanningEntryItemTPType' )->get_property( 'ChartOfAccounts' )->set_disabled( ). ##NO_TEXT
    model->get_entity_type( 'A_FinPlanningEntryItemTPType' )->get_property( 'FiscalYearVariant' )->set_disabled( ). ##NO_TEXT
    model->get_entity_type( 'A_FinPlanningEntryItemTPType' )->get_property( 'CostSourceUnit' )->set_disabled( ). ##NO_TEXT
    model->get_entity_type( 'A_FinPlanningEntryItemTPType' )->get_property( 'ValuationQuantity' )->set_disabled( ). ##NO_TEXT

    "Set tag for the OData service
    lo_tag = model->create_tag( 'SACEXPORTTOS4HANA' ).      "#EC NOTEXT

    "Set tag for entity set and entity type
    lo_entity_set = model->get_entity_set( 'A_FinPlanningEntryItemTP' ).
    lo_entity_set->/iwbep/if_mgw_odata_item~set_label_from_text_element( iv_text_element_symbol = '001' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ). "ZCL_ZTESTMODE3_MPC_EXT====CP

    lo_entity_type = model->get_entity_type( 'A_FinPlanningEntryItemTPType' ).
    lo_entity_type->/iwbep/if_mgw_odata_item~set_label_from_text_element( iv_text_element_symbol = '001' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ).

    lo_entity_set = model->get_entity_set( 'A_FinPlanItemStagingArea' ).
    lo_entity_set->/iwbep/if_mgw_odata_item~set_label_from_text_element( iv_text_element_symbol = '005' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ).

    lo_entity_type = model->get_entity_type( 'A_FinPlanItemStagingAreaType' ).
    lo_entity_type->/iwbep/if_mgw_odata_item~set_label_from_text_element( iv_text_element_symbol = '005' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ).

    "Set tag for function import parameters
    lo_action = model->get_action( 'commit' ).
    lo_parameter = lo_action->get_input_parameter( 'P_TransactionID' ).
    lo_parameter->set_label_from_text_element( iv_text_element_symbol = '002' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ). "#EC NOTEXT
    lo_parameter = lo_action->get_input_parameter( 'P_DeleteScopeFieldsString' ).
    lo_parameter->set_label_from_text_element( iv_text_element_symbol = '004' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ). "#EC NOTEXT
    lo_parameter = lo_action->get_input_parameter( 'P_AggregationLevelFieldsString' ).
    lo_parameter->set_label_from_text_element( iv_text_element_symbol = '003' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ). "#EC NOTEXT

    "Set tag for function import parameters
    lo_action = model->get_action( 'checkPlanDataAggrgnLvlFields' ).
    lo_parameter = lo_action->get_input_parameter( 'P_AggregationLevelFieldsString' ).
    lo_parameter->set_label_from_text_element( iv_text_element_symbol = '003' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ). "#EC NOTEXT

    "Set tag for function import parameters
    lo_action = model->get_action( 'checkPlanDataDelScopeFields' ).
    lo_parameter = lo_action->get_input_parameter( 'P_DeleteScopeFieldsString' ).
    lo_parameter->set_label_from_text_element( iv_text_element_symbol = '004' iv_text_element_container = 'ZCL_ZTESTMODE3_MPC_EXT========CP' ). "#EC NOTEXT





    DATA(lo_reference) = vocab_anno_model->create_vocabulary_reference(
                            iv_vocab_id = '/IWBEP/VOC_COMMON'
                            iv_vocab_version = '0001').

    lo_reference->create_include(
        iv_namespace = 'com.sap.vocabularies.Common.v1'
        iv_alias = 'Common' ).

    lo_reference = vocab_anno_model->create_vocabulary_reference(
                    iv_vocab_id = '/IWBEP/VOC_CAPABILITIES'
                    iv_vocab_version = '0001').

    lo_reference->create_include(
        iv_namespace = 'Org.OData.Capabilities.V1'
        iv_alias = 'Capabilities' ).

    lo_reference = vocab_anno_model->create_vocabulary_reference(
                    iv_vocab_id = '/IWBEP/VOC_COMMUNICATION'
                    iv_vocab_version = '0001').

    lo_reference->create_include(
        iv_namespace = 'com.sap.vocabularies.Communication.v1'
        iv_alias = 'Communication' ).

    lo_reference = vocab_anno_model->create_vocabulary_reference(
            iv_vocab_id = '/IWBEP/VOC_AGGREGATION'
            iv_vocab_version = '0001').

    lo_reference->create_include(
        iv_namespace = 'Org.OData.Aggregation.V1'
        iv_alias = 'Aggregation' ).

    lo_reference = vocab_anno_model->create_vocabulary_reference(
            iv_vocab_id = '/IWBEP/VOC_PERSONALDATA'
            iv_vocab_version = '0001').

    lo_reference->create_include(
        iv_namespace = 'com.sap.vocabularies.PersonalData.v1'
        iv_alias = 'PersonalData' ).



    DATA(lo_ann_target) = vocab_anno_model->create_annotations_target( 'API_FINANCIALPLANDATA_SRV_Entities' ).
    lo_ann_target->set_namespace_qualifier( 'API_FINANCIALPLANDATA_SRV' ).

    DATA(lo_annotation) = lo_ann_target->create_annotation( 'Aggregation.ApplySupported' ).
    DATA(lo_record) = lo_annotation->create_record( ).
    DATA(lo_property) = lo_record->create_property( 'Transformations' ).
    DATA(lo_collection) = lo_property->create_collection( ).

    lo_collection->create_simple_value( )->set_string( 'aggregate' ).
    lo_collection->create_simple_value( )->set_string( 'groupby' ).
    lo_collection->create_simple_value( )->set_string( 'filter' ).

    lo_property = lo_record->create_property( 'Rollup' ).
    lo_property->create_simple_value( )->set_enum_member_by_name( 'None' ).



    lo_ann_target = vocab_anno_model->create_annotations_target( 'API_FINANCIALPLANDATA_SRV_Entities/A_FinPlanItemStagingArea' ).
    lo_ann_target->set_namespace_qualifier( 'API_FINANCIALPLANDATA_SRV' ).

    lo_annotation = lo_ann_target->create_annotation( 'Capabilities.FilterRestrictions' ).
    lo_record = lo_annotation->create_record( ).
    lo_property = lo_record->create_property( 'NonFilterableProperties' ).

    lo_collection = lo_property->create_collection( ).
    lo_collection->create_simple_value( )->set_property_path( 'ID' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInTransactionCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInCompanyCodeCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInGlobalCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInObjectCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'ValuationQuantity' ).

    lo_annotation = lo_ann_target->create_annotation( 'Capabilities.SortRestrictions' ).
    lo_record = lo_annotation->create_record( ).
    lo_property = lo_record->create_property( 'NonSortableProperties' ).
    lo_collection = lo_property->create_collection( ).
    lo_collection->create_simple_value( )->set_property_path( 'ID' ).



    lo_ann_target = vocab_anno_model->create_annotations_target( 'API_FINANCIALPLANDATA_SRV_Entities/A_FinPlanningEntryItemTP' ).
    lo_ann_target->set_namespace_qualifier( 'API_FINANCIALPLANDATA_SRV' ).

    lo_annotation = lo_ann_target->create_annotation( iv_term = 'Capabilities.FilterRestrictions' ).
    lo_record = lo_annotation->create_record( ).
    lo_property = lo_record->create_property( 'NonFilterableProperties' ).

    lo_collection = lo_property->create_collection( ).
    lo_collection->create_simple_value( )->set_property_path( 'ID' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInTransactionCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInCompanyCodeCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInGlobalCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'AmountInObjectCurrency' ).
    lo_collection->create_simple_value( )->set_property_path( 'ValuationQuantity' ).

    lo_annotation = lo_ann_target->create_annotation( iv_term = 'Capabilities.SortRestrictions' ).
    lo_record = lo_annotation->create_record( ).
    lo_property = lo_record->create_property( 'NonSortableProperties' ).

    lo_collection = lo_property->create_collection( ).
    lo_collection->create_simple_value( )->set_property_path( 'ID' ).



    DATA(lo_entity_tp) = model->get_entity_type( 'A_FinPlanningEntryItemTPType' ).

    DATA(lo_field) = CAST /iwbep/cl_mgw_odata_property( lo_entity_tp->get_property( 'AmountInCompanyCodeCurrency' ) ).
    DATA(lo_anno) = lo_field->/iwbep/if_mgw_odata_annotatabl~create_annotation( /iwbep/if_mgw_med_odata_types=>gc_sap_namespace ).
    lo_anno->add( iv_key = 'aggregation-role' iv_value = 'measure' ).

    lo_field = CAST /iwbep/cl_mgw_odata_property( lo_entity_tp->get_property( 'CompanyCodeCurrency' ) ).
    lo_anno = lo_field->/iwbep/if_mgw_odata_annotatabl~create_annotation( /iwbep/if_mgw_med_odata_types=>gc_sap_namespace ).
    lo_anno->add( iv_key = 'aggregation-role' iv_value = 'dimension' ).

    lo_field = CAST /iwbep/cl_mgw_odata_property( lo_entity_tp->get_property( 'CompanyCode' ) ).
    lo_anno = lo_field->/iwbep/if_mgw_odata_annotatabl~create_annotation( /iwbep/if_mgw_med_odata_types=>gc_sap_namespace ).
    lo_anno->add( iv_key = 'aggregation-role' iv_value = 'dimension' ).


*    model->get_entity_type( 'A_FinPlanItemStagingAreaType' )->create_annotation( /iwbep/if_mgw_med_odata_types=>gc_sap_namespace )->add( iv_key = 'label' iv_value = 'SACEXPORTTOS4HANA StagingArea' ).
*    model->get_entity_type( 'A_FinPlanningEntryItemTPType' )->create_annotation( /iwbep/if_mgw_med_odata_types=>gc_sap_namespace )->add( iv_key = 'label' iv_value = 'SACEXPORTTOS4HANA EntryItem' ).

  ENDMETHOD.
ENDCLASS.
