view: dim_dsp_monthly_enterprise_targets {
  sql_table_name: BI_DSP.dim_dsp_monthly_enterprise_targets ;;

  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }
  dimension: generalist_rep_name {
    type: string
    sql: ${TABLE}.Generalist_Rep_Name ;;
  }
  dimension: gross_revenue {
    type: number
    sql: ${TABLE}.Gross_Revenue ;;
  }


  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }
  dimension: monthly_enterprise_targets_key {
    type: number
    sql: ${TABLE}.monthly_enterprise_targets_key ;;
  }
  dimension: net_revenue {
    type: number
    sql: ${TABLE}.Net_Revenue ;;
  }


  dimension: related_brand {
    type: string
    sql: ${TABLE}.Related_Brand ;;
  }

  ###---MAESURES---###

  measure: sum_gross_revenue {
    type: sum
    sql: ${TABLE}.gross_revenue ;;
    value_format: "#,##0.00"
    label: "GR Revenue"
  }

  measure: sum_net_revenue {
    type: sum
    sql: ${TABLE}.net_revenue ;;
    value_format: "#,##0.00"
    label: "NR Revenue"
  }

  measure: count {
    type: count
    drill_fields: [account_name, generalist_rep_name]
  }
}
