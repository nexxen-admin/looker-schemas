# The name of this view in Looker is "Ivt Report"
view: ivt_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.IVT_Report ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cost" in Explore.

  measure: cost_1_party {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Cost_1_party ;;
  }

  measure: cost_3_party {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Cost_3_party ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  #measure: total_cost {
   # type: sum
    #sql: ${cost} ;;
  #}

  #measure: average_cost {
   # type: average
  #  sql: ${cost} ;;
 # }

  dimension: domain_bundle {
    type: string
    sql: ${TABLE}.Domain_Bundle ;;
  }

  measure: givt_1_party {
    type: sum
    sql: ${TABLE}.GIVT_1_party ;;
  }

  measure: impressions_1_party {
    type: sum
    sql: ${TABLE}.Impressions_1_party ;;
  }

  measure: ivt_1_party {
    type: sum
    sql: ${TABLE}.IVT_1_party ;;
  }

  measure: ivt_cost_1_party {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.IVT_1_party_Cost ;;
  }

  measure: givt_3_party {
    type: sum
    sql: ${TABLE}.GIVT_3_party ;;
  }

  measure: impressions_3_party {
    type: sum
    sql: ${TABLE}.Impressions_3_party ;;
  }

  measure: ivt_3_party {
    type: sum
    sql: ${TABLE}.IVT_3_party ;;
  }

  measure: ivt_cost_3_party {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.IVT_3_party_Cost ;;
  }


  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."Month" ;;
  }

  dimension: ops_owner {
    type: string
    sql: ${TABLE}.Ops_Owner ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.Publisher ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.revenue_type ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: rx_dsp_account_id {
    type: string
    sql: ${TABLE}.rx_dsp_account_id ;;
  }

  measure: sivt_1_party {
    type: sum
    sql: ${TABLE}.SIVT_1_party ;;
  }

  measure: sivt_3_party {
    type: sum
    sql: ${TABLE}.SIVT_3_party ;;
  }

  dimension: ssp {
    type: string
    sql: ${TABLE}.SSP ;;
  }

  measure: count {
    type: count
    drill_fields: [publisher_name]
  }
}
