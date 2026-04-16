view: dim_rtb_device_type {
  sql_table_name: BI_New.dim_rtb_device_type ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  dimension: rtb_device_type_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.rtb_device_type_id ;;
    hidden: yes
  }
  # dimension: rtb_device_type_name {
  #   type: string
  #   sql: ${TABLE}.rtb_device_type_name ;;
  # }

  dimension: rtb_device_type_name {
    group_label: "Request Attributes"
    label: "Device Type (RTB)"
    description: "OpenRTB device type per IAB AdCOM v1.0 specification."
    type: string
    sql: CASE
           WHEN ${fact_ad_daily_agg.rtb_device_type_id} IS NULL
             OR ${fact_ad_daily_agg.rtb_device_type_id} = 0 THEN 'Unknown'
           ELSE ${TABLE}.rtb_device_type_name
         END ;;
  }

  measure: count {
    type: count
    drill_fields: [rtb_device_type_name]
    hidden: yes
  }
}
