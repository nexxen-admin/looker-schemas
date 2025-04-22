view: snodba_database_storage_history_mtd {

derived_table: {
    sql:
select usage_month,
database_name,
sum(monthly_billable_tb) usage
from (
select database_name,date_trunc(month, usage_date) as usage_month
  , avg(billable_tb) as monthly_billable_tb
from (select database_name,usage_date
        , ((average_database_bytes + average_failsafe_bytes)*1.0) / power(1024, 4) as billable_tb
      from table(information_schema.database_storage_usage_history(date_trunc(month, dateadd(month,-1,current_date)), dateadd(day, -1, current_date)))) as daily_billable_tb
group by 1,2) dt group by 1,2;;
        }



  dimension: usage_month {
    type: date
    view_label: "Storage"
    label: "Usage Month"
    #hidden: yes
    sql: ${TABLE}.usage_month;;
  }

  dimension: database_name {
    type: string
    view_label: "Storage"
    label: "Database Name"
    #hidden: yes
    sql: ${TABLE}.database_name;;
  }


  dimension: usage {
    type: number
    view_label: "Storage"
    label: "Storage Used (in TB)"
    hidden: yes
    value_format_name: decimal_2
    sql: ${TABLE}.usage ;;
  }

  measure: total_usage {
    type: sum
    view_label: "Storage"
    label: "Storage Used (in TB)"
    #hidden: yes
    value_format_name: decimal_2
    sql: ${usage} ;;
  }


  measure: storage_cost {
    type: sum
    view_label: "Storage"
    label: "Storage Cost"
    #hidden: yes
    value_format_name: usd
    sql: ${usage} * 40.00;;
  }


        }
