# The name of this view in Looker is "Fact Nexxen Dsp"
view: fact_nexxen_dsp {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.fact_nexxen_dsp ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID Key" in Explore.

  dimension: account_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_key ;;
    hidden: yes
  }

  dimension: advertiser_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.advertiser_id_key ;;
    hidden: yes
  }

  dimension: creative_file_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_file_key ;;
    hidden: yes
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;

  }

  measure: cost {
    type: sum
    label: "Adv Invoice"
    value_format: "$#,##0.00"
    sql: ${TABLE}.cost ;;

  }


  dimension: creative_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_id_key ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
    hidden: yes
  }

  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date IN Timezona"
    sql: ${TABLE}.date_key_in_timezone ;;
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  measure: impressions {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.impressions ;;
  }

  dimension: market_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.market_id_key ;;
    hidden: yes
  }

  dimension: opportunity_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.opportunity_id_key ;;
    hidden: yes
  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }

  dimension: opportunitylineitemschedule_key {
    type: number
    sql: ${TABLE}.opportunitylineitemschedule_key ;;
    hidden: yes

  }

  dimension: package_budget_schedule_key {
    type: number
    sql: ${TABLE}.package_budget_schedule_key ;;
    hidden: yes
  }

  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
    hidden: yes


  }
   measure: inventory_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.inventory_cost ;;
  }
  measure: inv_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.inv_cost ;;
  }
  measure:   brand_safety_data_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.brand_safety_data_cost ;;
  }
  measure: first_party_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.first_party_cost ;;
  }
  measure: turn_third_party_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.turn_third_party_cost ;;
  }
  measure: turn_audience_data_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.turn_audience_data_cost ;;
  }

  measure: concatenated_brand_intelligence_data_cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.  concatenated_brand_intelligence_data_cost ;;
  }
  measure: complete_events  {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.complete_events  ;;
  }

  dimension: time_zone_code {
    type: string
    sql: ${TABLE}.time_zone_code ;;
    hidden: yes
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
    hidden: yes
  }
  measure: count {
    type: count
    hidden: yes
  }
}
