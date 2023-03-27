view: sno_supply_hourly_core_metrics{
  sql_table_name: supply.hourly_core_metrics;;

  dimension: revenue_currency {
    type: string
    label: "CURRENCY"
    hidden: no
    sql:${TABLE}.revenue_currency ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: is_viewability_satisfied {
    type: number
    hidden: yes
    sql: ${TABLE}.is_viewability_satisfied ;;
  }

  measure: viewability {
    label: "VIEWABILITY"
    hidden: no
    type: sum
    sql: ${is_viewability_satisfied} ;;
  }

  dimension: is_viewability_measurable {
    type: number
    hidden: yes
    sql: ${TABLE}.is_viewability_measurable ;;
  }

  measure: measurable {
    label: "MEASURABLE"
    hidden: no
    type: sum
    sql: ${is_viewability_measurable} ;;
  }

  dimension: ad_click_url {
    type: number
    hidden: yes
    sql: CASE
        WHEN 1 > 0
           THEN NULL
        ELSE 1
        END ;;
  }

  dimension: data_flag {
    type: number
    hidden: yes
    sql: CASE
        WHEN 1 > 0
           THEN NULL
        ELSE 1
        END ;;
  }

  measure: clicks {
    label: "CLICKS"
    hidden: no
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: billable_impressions {
    label: "BILLABLE_IMPRESSIONS"
    hidden: no
    type: sum
    sql: ${TABLE}.billable_impressions ;;
  }

  dimension: click_based_actions {
    type: number
    hidden: yes
    sql: 0 ;;
  }

  dimension: contract_actions {
    type: number
    hidden: yes
    sql: 0 ;;
  }

  dimension: view_based_actions {
    type: number
    hidden: yes
    sql: 0 ;;
  }

  measure: mac {
    label: "MAC"
    hidden: no
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  dimension: demand_date {
    label: "demand_date"
    hidden: no
    type: date_time
    sql: ${TABLE}.demand_date ;;
  }
  #intermediate date to convert to mm/dd/yyyy in activity date
  dimension: demand_date1 {
    hidden: yes
    type: string
    sql: ${TABLE}.demand_date ;;
  }

  dimension: sortby_date {
    label: "ACTIVITY_DATE"
    hidden: no
    type: string
    sql: to_char(date_trunc('day', ${demand_date1}), 'MM/DD/YYYY') ;;
  }

  dimension: impressions {
    label: "impressions"
    hidden: no
    type: number
    sql: ${TABLE}.impressions ;;
  }

  measure: quartile_imp_100 {
    label: "QUARTILE_IMP_100"
    hidden: no
    type: sum
    sql: ${TABLE}.completed_100 ;;
  }

  measure: quartile_imp_25 {
    label: "QUARTILE_IMP_25"
    hidden: no
    type: sum
    sql: ${TABLE}.completed_25 ;;
  }

  measure: quartile_imp_50 {
    label: "QUARTILE_IMP_50"
    hidden: no
    type: sum
    sql: ${TABLE}.completed_50 ;;
  }

  measure: quartile_imp_75 {
    label: "QUARTILE_IMP_75"
    hidden: no
    type: sum
    sql: ${TABLE}.completed_75 ;;
  }

}
