# The name of this view in Looker is "Targets Up Gal"
view: targets_up_gal {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.targets_actual_gal_up ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Month Year" in Explore.

    dimension_group: month_year {
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
      sql: ${TABLE}.month_year ;;
    }


  dimension: population {
    type: string
    sql: ${TABLE}.population ;;
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.Net_Revenue ;;
    value_format: "$#,##0"
  }

  measure: revenue {
    type: sum
    label: "Gross Revenue"
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0"
  }

  measure: target {
    type: sum
    sql: ${TABLE}.target ;;
    value_format: "$#,##0"
  }

  measure: net_emea {
    label: "Net EMEA Pub"
    type: sum
    sql: ${TABLE}.net_emea ;;
    value_format: "$#,##0"
  }

  measure: net_net {
    label: "Net Net"
    type: sum
    sql: case when ${TABLE}.population ='Team Shir In App' or ${TABLE}.population='Team Shir Web' then ${TABLE}.Net_Revenue
    else ${TABLE}.Net_Revenue + ${TABLE}.net_emea end;;
    value_format: "$#,##0"
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.cogs ;;
    value_format: "$#,##0"
  }

  measure: tech_fee {
    type: sum
    sql: ${TABLE}.tech_fee ;;
    hidden: yes
  }

  measure: count {
    type: count
  }
}
