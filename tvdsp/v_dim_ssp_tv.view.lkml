# The name of this view in Looker is "V Dim Ssp"
view: v_dim_ssp_tv {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_SSP ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Active" in Explore.

  dimension: active {
    type: number
    sql: ${TABLE}.Active ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_active {
    type: sum
    sql: ${active} ;;
  }

  measure: average_active {
    type: average
    sql: ${active} ;;
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
  }

  dimension_group: loaded {
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
    sql: ${TABLE}.Loaded ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: ssp_exchange_name {
    type: string
    sql: ${TABLE}.SSP_Exchange_Name ;;
  }

  dimension: ssp_external_name {
    type: string
    sql: ${TABLE}.SSP_External_Name ;;
  }

  dimension: ssp_id_from_dwh_ssp {
    type: string
    sql: ${TABLE}.SSP_ID_From_DWH_SSP ;;
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
  }

  dimension: ssp_name {
    type: string
    sql: ${TABLE}.SSP_Name ;;
  }

  dimension: ssp_ui_name {
    type: string
    sql: ${TABLE}.SSP_UI_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [ssp_ui_name, ssp_name, ssp_exchange_name, ssp_external_name]
  }
}
