view: sno_converged_approved_campaigns {
  sql_table_name: opt.converged_approved_campaigns ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: approved_campaign_status {
    type: number
    hidden: yes
    sql: ${TABLE}.approved_campaign_status ;;
    value_format_name: id
  }

  dimension_group: cretedon {
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
    view_label: "Campaign"
    label: "Approval"
    description: "The date when converged campaign was approved."
    sql: ${TABLE}.createdon ;;
  }
}
