view: sno_opt_misdelivery {
  sql_table_name: dim.opt_misdelivery ;;

  dimension: pk {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.pk_id ;;
  }

  dimension: keydate {
    type: date
    hidden: yes
    sql: ${TABLE}.keydate ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: mean_allocation {
    type: number
    hidden: yes
    sql: ${TABLE}.mean_allocation ;;
  }

  measure: sum_mean_allocation {
    type: sum
    label: "Mean Allocation"
    value_format_name: decimal_0
    description: "Allocated Impressions"
    sql: ${mean_allocation} ;;
  }
}
