view: expected_warehouse_usage {
  derived_table: {
    sql:
select date_value as billing_date,warehouse_name,expected_credits,expected_spend
from (
select date_value,'ETL_WH' as warehouse_name,48 as expected_credits, 48 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date  where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'ADHOC_WH' as warehouse_name,48 as expected_credits, 48 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'OASYS_WH' as warehouse_name,64 as expected_credits, 164 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'LI_WH' as warehouse_name,16 as expected_credits, 16 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'MSTR_WH' as warehouse_name,64 as expected_credits, 64 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'KH_WH' as warehouse_name,16 as expected_credits, 16  * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'LOOKER_WH' as warehouse_name,164 as expected_credits, 128 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'MSTR_SMALL_WH' as warehouse_name,48 as expected_credits, 48 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))
union all
select date_value,'MAINT_WH' as warehouse_name,48 as expected_credits, 48 * c.rate as expected_spend from dim.date_dimension dd join dpsystems.snowflake_rate_card c on date_value between c.start_date and c.end_date where date_value >= date_trunc('month',dateadd('month',-1,current_date())) and date_value <= dateadd('day',-1,date_trunc('month',dateadd('month',1,current_date())))

)dt;;
  }

  dimension_group: Dates {
    type: time
    label: "Billing Dates"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month
    ]
    convert_tz: no
    sql: ${TABLE}.billing_date ;;
  }

  dimension: warehouse {
    type: string
    label: "Expected Usage Warehouse"
    #hidden: yes
    sql: ${TABLE}.warehouse_name ;;
  }

  dimension: expected_credits {
    type: number
    hidden: yes
    sql: ${TABLE}.expected_credits ;;
  }

  measure: sum_expected_credits {
    type: sum

    label: "Expected Credits Used"
    value_format_name: decimal_2
    sql: ${expected_credits} ;;
  }

  measure: avg_expected_credits {
    type: average

    label: "Expected Average Credits Used"
    value_format_name: decimal_2
    sql: ${expected_credits} ;;
  }

  dimension: expected_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.expected_spend ;;
  }

  measure: sum_expected_spend {
    type: sum

    label: "Expected Cost"
    value_format_name: usd
    sql: ${expected_spend} ;;
  }

  measure: avg_expected_spend {
    type: average

    label: "Expected Average Cost"
    value_format_name: usd
    sql: ${expected_spend} ;;
  }

}
