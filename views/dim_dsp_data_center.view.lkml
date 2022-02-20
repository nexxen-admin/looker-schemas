# The name of this view in Looker is "V Dim Dsp Data Center"
view: dim_dsp_data_center {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_DSP_DataCenter ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Data Center" in Explore.

  dimension: data_center {
    type: string
    sql: ${TABLE}.DataCenter ;;
    hidden: yes
  }

  dimension: data_center_key {
    type: number
    sql: ${TABLE}.DataCenter_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_data_center_key {
    type: sum
    sql: ${data_center_key} ;;
    hidden: yes
  }

  measure: average_data_center_key {
    type: average
    sql: ${data_center_key} ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension: dsp_data_center_key {
    type: number
    sql: ${TABLE}.DSP_DataCenter_Key ;;
    hidden: yes
  }

  dimension: dsp_id {
    type: string
    sql: ${TABLE}.DSP_ID ;;
    hidden: yes
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: max_qps {
    label: "Max QPS"
    type: number
    sql: ${TABLE}.max_qps ;;
  }

  dimension: qps_opti_method {
    label: "QPS Opti Method"
    type: number
    sql: ${TABLE}.qps_opti_method ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes

  }
}
