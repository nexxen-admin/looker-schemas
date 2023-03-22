view: exchange_daily_report_component {
  derived_table: {
    sql: Select event_date::date as event_date,
      to_char(event_date, 'yy') as year,
      to_char(event_date, 'mm') as month,
      region,
      category,
      subcategory,
      record_type,
      file_record,
      sum(revenue) as Revenue,
      sum(cost) as Cost
    From BI.SVC_DRR_Daily_Revenue_Report
    where event_date>= '2022-01-01' and event_date< current_date()
    --event_date >= date_trunc('quarter',timestampadd('month',-2,date_trunc('month',current_date())))
     -- and event_date < date_trunc('month',current_date())
    --and category = 'Exchange'
    Group by 1, 2, 3, 4, 5, 6, 7, 8
    Order by 1, 2, 3, 4, 5

      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: file_record {
    type: string
    sql: ${TABLE}.file_record ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  measure: Revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue ;;
  }

  measure: Cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Cost ;;
  }

  measure: Net_Revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue-${TABLE}.Cost ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}.event_date ;;
  }


  set: detail {
    fields: [file_record, Revenue]
  }
}
