view: ncd_pacing {
  sql_table_name: BI_DSP.ncd_pacing ;;

  dimension: advertiser_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.advertiser_id_key ;;
    hidden: yes
  }
  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key_in_timezone ;;
    hidden: yes
  }
  dimension_group: end_date_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.end_date_in_timezone ;;
    hidden: yes
  }
  dimension_group: max_date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.max_date_key_in_timezone ;;
    hidden: yes
  }
  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }
  dimension: run_total_delivered {
    type: number
    sql: ${TABLE}.run_total_delivered ;;
    hidden: yes
  }
  dimension_group: start_date_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_date_in_timezone ;;
    hidden: yes
  }
  dimension: units__c {
    type: number
    sql: ${TABLE}.units__c ;;
    hidden: yes
  }

 dimension: campaign_length {
   type: number
  sql: DATE(${TABLE}.end_date_in_timezone) - DATE(${TABLE}.start_date_in_timezone) +1 ;;
  hidden: yes
 }

dimension: day_of_campaign {
  type: number
  sql: DATE(${TABLE}.date_key_in_timezone)-DATE(${TABLE}.start_date_in_timezone )+1 ;;
  hidden: yes
}

dimension: daily_goal{
  type: number
  sql: NULLIF(${TABLE}.units__c,0)/${campaign_length} ;;
  hidden: yes
}

dimension_group: adj_max_date {
  type: time
  timeframes: [raw, date, week, month, quarter, year]
  convert_tz: no
  datatype: date
  sql: CASE WHEN ${TABLE}.max_date_key_in_timezone=CURRENT_DATE() THEN ${TABLE}.max_date_key_in_timezone-1  ELSE ${TABLE}.max_date_key_in_timezone END ;;
  hidden: yes
}

dimension: pacing_dim {
  type: number
  sql: CASE WHEN ${TABLE}.date_key_in_timezone=${adj_max_date_date} THEN ${TABLE}.run_total_delivered/(${daily_goal}*${day_of_campaign}) END ;;
  hidden: yes
}

}
