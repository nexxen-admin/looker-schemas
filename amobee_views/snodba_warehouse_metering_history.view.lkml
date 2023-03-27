view: warehouse_metering_history {


  derived_table: {
    sql:
    select
to_date(date_trunc('d',start_time)) as run_date,
warehouse_name,
sum(credits_used) as credits_used,
round(sum(credits_used * src.rate),2) as credit_spend
from table(information_schema.warehouse_metering_history
           (date_range_start=>dateadd('day', 1, dateadd('month', -6, current_date())))) m
            left join dpsystems.snowflake_rate_card src on to_date(date_trunc('d',m.start_time)) between src.start_date and src.end_date
group by to_date(date_trunc('d',start_time)),warehouse_name
    ;;
  }

  dimension_group: Dates {
    type: time
    label: "Run Dates"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month
    ]
    convert_tz: no
    sql: ${TABLE}.run_date ;;
  }

  dimension: warehouse {
    type: string
    label: "Actual Usage Warehouse"

    sql: ${TABLE}.warehouse_name ;;
  }

  dimension: credits_used {
    type: number
    hidden: yes
    sql: ${TABLE}.credits_used ;;
  }

  measure: sum_credits_used {
    type: sum
    label: "Total Credits Used"

    value_format_name: decimal_0
    sql: ${credits_used} ;;
  }

  measure: avg_credits_used {
    type: average
    label: "Average Credits Used"

    value_format_name: decimal_2
    sql: ${credits_used} ;;
  }

  dimension: credit_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.credit_spend ;;
  }

  measure: sum_credits_spend {
    type: sum
    label: "Total Cost"

    value_format_name: usd
    sql: ${credit_spend} ;;
  }

  measure: avg_credits_spend {
    type: average
    label: "Average Cost"

    value_format_name: usd
    sql: ${credit_spend} ;;
  }


}
