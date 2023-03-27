view: opt_main_campaign {
  sql_table_name: AN_MAIN..campaign ;;
  dimension: campaign_id {
    description: "campaign_id"
    type: number
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }
  dimension: campaign_name {
    description: "campaign_name"
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
}
