view: dim_traffic_source {
  sql_table_name: BI_New.V_Dim_Traffic_Source ;;

  dimension_group: db_create {
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
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
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
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: is_active {
    label: "Is Active"
    description: "Specifies whether the traffic source is active"
    type: yesno
    sql: ${TABLE}.Is_Active ;;

  }

  dimension: tmax {
    label: "Tmax"
    description: "Maximum time in milliseconds the exchange allows for bids to be received to avoid timeout.
    This value supersedes any 'a priori guidance' from the exchange. "
    type: number
    sql: ${TABLE}.Tmax ;;
  }

  dimension: traffic_source_id {
    label: "Traffic Source ID"
    description: "Identification of the traffic source"
    type: number
    sql: ${TABLE}.Traffic_Source_ID ;;
  }

  dimension: ts_create {
    label: "Create Date"
    description: "Traffic Source create date"
    type: date
    sql: ${TABLE}.TS_Create_At ;;
  }

  dimension: ts_display_name {
    label: "Traffic Source"
    description: "Traffic Source name"
    type: string
    sql: ${TABLE}.TS_Display_Name ;;
  }

  dimension: ts_key {
    type: number
    sql: ${TABLE}.Ts_Key ;;
    hidden: yes
  }

  dimension: ts_short_name {
    label: "Short Name"
    type: string
    sql: ${TABLE}.TS_Short_Name ;;
    hidden: yes
  }

  dimension_group: ts_update {
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
    sql: ${TABLE}.TS_Update_At ;;
    hidden: yes
  }


  measure: count {
    type: count
    drill_fields: [ts_short_name, ts_display_name]
    hidden: yes
  }
}
