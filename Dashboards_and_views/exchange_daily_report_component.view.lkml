view: exchange_daily_report_component {
  derived_table: {
    sql: select month(event_date),file_record,sum(Revenue) as rev
      from(

      Select event_date::date as event_date,
      region,
      subcategory,
      record_type,
      file_record,
      sum(revenue) as Revenue,
      sum(cost) as Cost
      From BI.SVC_DRR_Daily_Revenue_Report
      where event_date >= date_trunc('quarter',timestampadd('month',-2,date_trunc('month',current_date())))
      and event_date < date_trunc('month',current_date())
      and category = 'Exchange'
      Group by 1, 2, 3, 4, 5
      Order by 1, 2, 3, 4, 5) tmp
      where event_date>='2022-10-01' and event_date<='2022-12-31'
      group by 1,2
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month {
    type: number
    sql: ${TABLE}."month" ;;
  }

  dimension: file_record {
    type: string
    sql: ${TABLE}.file_record ;;
  }

  measure: rev {
    type: sum
    sql: ${TABLE}.rev ;;
  }

  set: detail {
    fields: [month, file_record, rev]
  }
}
