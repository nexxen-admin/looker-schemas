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

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }

  dimension: omp_group {
    type: string
    label: "OMP Group"
    sql: CASE WHEN ${TABLE}.population='OMP-APAC' AND ${TABLE}.country_name IN ('ANZ', 'India', 'Japan') THEN CONCAT('OMP-APAC ', ${TABLE}.country_name)
        WHEN ${TABLE}.population='OMP-APAC' AND ${TABLE}.country_name = 'Rest' THEN 'OMP-APAC ROW'
        ELSE 'OMP-EMEA' END ;;
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

  measure: completion_rate{
    type: number
    label: "% Goal"
    sql: ${net_net}/${target} ;;
    value_format: "0.00%"
  }

  dimension: quarter {
    type: number
    sql: quarter(${month_year_date});;
  }

  dimension: days_passed {
    type: number
    sql: case when ${quarter}='1' and month(current_date)='1' then day(current_date)
              when ${quarter}='1' and month(current_date)='2' then 31+day(current_date)
              when ${quarter}='1' and month(current_date)='3' then 59+day(current_date)
              when ${quarter}='2' and month(current_date)='4' then day(current_date)
              when ${quarter}='2' and month(current_date)='5' then 30+day(current_date)
              when ${quarter}='2' and month(current_date)='6' then 61+day(current_date)
              when ${quarter}='3' and month(current_date)='7' then day(current_date)
              when ${quarter}='3' and month(current_date)='8' then 31+day(current_date)
              when ${quarter}='3' and month(current_date)='9' then 62+day(current_date)
              when ${quarter}='4' and month(current_date)='10' then day(current_date)
              when ${quarter}='4' and month(current_date)='11' then 31+day(current_date)
              when ${quarter}='4' and month(current_date)='12' then 61+day(current_date)
              end ;;
  }



  dimension: quarter_length {
    type: number
    sql: case
              when month(${month_year_month})='1' OR month(${month_year_month})='2' OR month(${month_year_month})='3' then '90'
              when month(${month_year_month})='4' OR month(${month_year_month})='5' OR month(${month_year_month})='6' then '91'
              else '92' end;;
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
