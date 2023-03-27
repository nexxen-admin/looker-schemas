view: vg_main_campaign_details {
  sql_table_name: vg_main.campaign_details ;;



  dimension: budget_cap_adj_factor {
    type: number
    view_label: "Campaign"
    label: "Budget Cap Adjustment Factor"
    sql: ${TABLE}.budget_cap_adj_factor ;;
  }


  dimension: campaign_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.campaign_id ;;
  }


  dimension: daily_budget_cap {
    type: number
    hidden: yes
    description: "This is one of three flags that the ad server uses for campaign shutoff.  This is the daily budget amonut which should not be exceed
    when compared to budget today."
    view_label: "Campaign"
    label: "Daily Budget Cap"
    sql: ${TABLE}.daily_budget_cap ;;
  }


  measure: sum_daily_budget_cap {
    type: sum
    description: "This is one of three flags that the ad server uses for campaign shutoff.  This is the daily budget amonut which should not be exceed
    when compared to budget today."
    view_label: "Campaign"
    value_format_name: decimal_2
    label: "Daily Budget Cap"
    sql: ${daily_budget_cap};;
  }

}
