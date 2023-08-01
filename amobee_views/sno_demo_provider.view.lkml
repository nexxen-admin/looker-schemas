view: demo_provider {
  sql_table_name: DIM.USER_DATA_VENDOR_VIEW ;;

  dimension: user_data_vendor_id {
    label: "Demo Provider ID"
    primary_key: yes
    type: number
    description: "ID of the provider"
    sql: ${TABLE}.USER_DATA_VENDOR_ID ;;
  }

  dimension: active {
    type: yesno
    label: "Provider Active"
    description: "A yes/no indicator if the demo provider is active."
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: created_on {
    type: date
    label: "Provider Created Date"
    description: "The date, in UTC, the provider was created in the system"
    sql: ${TABLE}.CREATED_ON ;;
  }

  dimension: dst_created_on {
    type: date
    label: "[DST] Provider Local Created Date"
    description: "The date the provider was created in the system in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.CREATED_ON)
      else ${TABLE}.CREATED_ON end ;;
  }

  dimension: description {
    type: string
    label: "Demo Provider"
    description: "The name of the Demo Provider"
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: expire_time {
    hidden: yes
    type: string
    sql: ${TABLE}.EXPIRE_TIME ;;
  }

  dimension: user_data_vendor_type {
    type: string
    label: "Demo Data Vendor Type"
    description: "Shows different kind of data vendor type known/inferred etc"
    sql: ${TABLE}.USER_DATA_VENDOR_TYPE ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [user_data_vendor_id]
  }
}
