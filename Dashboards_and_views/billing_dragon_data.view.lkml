view: billing_dragon_data {
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
derived_table: {
  sql:
  select
  day as date,
  --year(day) as year,
  --month(day) as month,
  os,
  country_code,
  sum(real_unique_device_count)/dayofmonth(last_day(day)) as qualified_unique_devices,
  sum(test_unique_device_count)/dayofmonth(last_day(day)) as unique_test_devices,
  dayofmonth(last_day(day)) as day_of_month
from dragon.unique_devices_daily
WHERE
  day >= DATE_TRUNC('MONTH',ADD_MONTHS(CURRENT_DATE, -3))
group by
  date,
  --year(day),
 -- month(day),
  dayofmonth(last_day(day)),
  country_code, os
having
  country_code in ('US', 'GB', 'UK')
order by
 date,
  --year,
  --month,
  country_code,
  os ;;
}

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }
dimension: day_of_month {
  type: string
  sql: ${TABLE}.day_of_month ;;
}

dimension: os {
  type: string
  sql: ${TABLE}.os ;;
}

dimension: country_code {
  type: string
  sql: ${TABLE}.country_code ;;
}

measure: qualified_unique_devices {
  type: sum
  sql: ${TABLE}.qualified_unique_devices ;;
  value_format: "#,##0"
}

  measure: unique_test_devices {
    type: sum
    sql: ${TABLE}.unique_test_devices ;;
    value_format: "#,##0"
  }
}
