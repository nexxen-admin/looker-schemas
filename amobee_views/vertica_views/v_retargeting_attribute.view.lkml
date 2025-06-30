view: v_retargeting_attribute {
  sql_table_name: DIM.RETARGETING_ATTRIBUTE_DETAILS_VIEW ;;
  view_label: "Retargeting Attribute"
  suggestions: no

#Note DIM.RETARGETING_ATTRIBUTE_DETAILS is a custom view. Read definition in Snowflake.*

  dimension: retargeting_attribute_id {
    primary_key: yes
    type: number
    description: "Videology’s ID to identify the segment"
    sql: ${TABLE}.RETARGETING_ATTRIBUTE_ID ;;
  }

  dimension: retargeting_attribute_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.RETARGETING_ATTRIBUTE_TYPE_ID ;;
  }

  dimension_group: createdon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    description: "Date Segment was Created"
    label: "Created"
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension_group: dst_createdon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    description: "Date Segment was Created in local time accounting DST."
    label: "[DST] Local Created"
    sql: case when ${v_platform_client.use_daylight_saving} then (${TABLE}.CREATEDON) AT TIMEZONE ${v_timezone.timezone_name}
      else ${TABLE}.CREATEDON end ;;
  }

  dimension: description {
    type: string
    description: "The name of a segment i.e. Bluekai > Custom > Auto > Jeep"
    label: "Retargeting Attribute"
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: data_provider_id {
    type: number
    description: "The ID number we create & associate with each data provider"
    sql: ${TABLE}.DATA_PROVIDER_ID ;;
  }

  dimension: provider_name {
    type: string
    description: "The entity that distributes segments to us (known as the ‘pipe’)"
    label: "Data Provider"
    sql: ${TABLE}.PROVIDER_NAME ;;
  }

  dimension: type_description {
    type: string
    hidden: yes
    sql: ${TABLE}.TYPE_DESCRIPTION ;;
  }

  dimension: external_name {
    type: string
    description: "The data provider's unique identifier for each segment sent to us"
    label: "External Retargeting Name"
    sql: ${TABLE}.EXTERNAL_NAME ;;
  }

  dimension: behavioral_category {
    type: string
    description: "Identifies the type of segment i.e. Auto, CPG, Travel, etc. "
    sql: ${TABLE}.BEHAVIORAL_CATEGORY ;;
  }

  dimension: data_vendor_cost_id {
    type: number
    label: "Data Vendor Cost ID"
    description: "ID of the data vendor cost attribute."
    sql: ${TABLE}.DATA_VENDOR_COST_ID ;;
    value_format_name: id
  }

  dimension: data_vendor_cost_description {
    description: "Describes the cost associated with the segment/group of segments"
    type: string
    sql: ${TABLE}.DATA_VENDOR_COST_DESCRIPTION ;;
  }

  dimension: format_type_category_id {
    label: "Format Type Category ID"
    type: string
    description: "Unique identification for the category of the device medium"
    sql: ${TABLE}.FORMAT_TYPE_CATEGORY_ID ;;
  }

  dimension: format_type_category {
    description: "Describes the grouping of the advertising medium"
    label: "Format Type Category"
    type: string
    sql: ${TABLE}.FORMAT_TYPE_CATEGORY ;;
  }

  dimension: payee_provider_id {
    label: "Payee Provider ID"
    description: "Set up the same as data provider ID"
    type: number
    sql: ${TABLE}.PAYEE_PROVIDER_ID ;;
    value_format_name: id
  }

  dimension: payee_provider_name {
    label: "Payee Provider"
    type: string
    description: "The entity we pay for supplying segments (could be first or third party)"
    sql: ${TABLE}.PAYEE_PROVIDER_NAME ;;
  }

  dimension: source_provider_id {
    description: "Set up the same as data provider ID"
    type: string
    sql: ${TABLE}.SOURCE_PROVIDER_ID ;;
  }

  dimension: source_provider_Name {
    label: "Source Provider"
    type: string
    sql: ${TABLE}.SOURCE_PROVIDER_NAME ;;
  }

  dimension: retargeting_attribute_active {
    type: yesno
    label: "Is Retargeting Attribute Active"
    description: "A yes/no indicator if the Retargeting Attbribute is active or not"
    sql: ${TABLE}.RETARGETING_ATTRIBUTE_ACTIVE ;;
  }

  dimension: user_data_vendor_type {
    type: string
    label: "Retargeting Data Vendor Type"
    description: "Shows different kind of data vendor type known/inferred etc"
    sql: ${TABLE}.USER_DATA_VENDOR_TYPE ;;
  }

  dimension: user_data_vendor_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.USER_DATA_VENDOR_TYPE_ID ;;
  }

  dimension: code {
    type: string
    label: "Code"
    description: "Eliza Segment ID"
    sql: ${TABLE}.code ;;
  }

  dimension: is_priority {
    type: yesno
    label: "Is Priority"
    description: "A yes/no indicator if the segment is priority."
    sql: ${TABLE}.IS_PRIORITY ;;
  }

  dimension: attribute_check {
    type: yesno
    label: "External ID Match"
    description: "Yes/No indicator if retargeting attribute id matches with external retargeting attribute id"
    sql: ${retargeting_attribute_id}::varchar = ${external_name} ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [retargeting_attribute_id, provider_name, external_name]
  }
}
