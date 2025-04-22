view: v_campaign_bookings {
  label: "Campaign Bookings"
  derived_table: {
    sql:
     select
       t.campaign_id,
       t.insertion_order_id,
       min(t.campaign_start_date) over (partition by t.insertion_order_id) as campaign_start_date,
       max(t.campaign_end_date) over (partition by t.insertion_order_id) as campaign_end_date,
       min(t.campaign_status_id in (0, 2, 4)) over (partition by t.insertion_order_id) as io_campaign_status_finished_paused_ended,
       min(t.campaign_status_id in (5, 6, 14)) over (partition by t.insertion_order_id) as io_campaign_status_planning_reserved,
       min(t.format_type_id in (6, 7, 8)) over (partition by t.insertion_order_id) as io_format_type,
       max(t.isfiller) over (partition by t.insertion_order_id) as isfiller,
       max(t.is_test_campaign) over (partition by t.insertion_order_id) as is_test_campaign,
       max(TIMESTAMPADD (day ,-1 ,TO_DATE((t.billing_year||'-'|| t.billing_month||'-'||0), 'YYYY-MM-DD'))) over (partition by t.insertion_order_id) as end_datetime,
       max(TIMESTAMPADD (day ,-1 ,TO_DATE((t.billing_year||'-'|| t.billing_month||'-'||0), 'YYYY-MM-DD'))) over () as campaign_end_datetime,
       t.previous_month_billed
     from
     (
       select
         cd.campaign_id,
         cd.insertion_order_id,
         cd.campaign_start_date,
         cd.campaign_end_date,
         cd.campaign_status_id,
         cd.format_type_id,
         cd.isfiller,
         cd.is_test_campaign,
         s.billing_year,
         s.billing_month,
         s.previous_month_billed,
         row_number() over (partition by cd.campaign_id order by s.billing_year desc, s.billing_month desc) as rn
       from
         dim.campaign_details_view cd
           left join dim.campaign_billing_stats_view s
             on cd.campaign_id = s.campaign_id and
                s.active
     ) as t
     where
       t.rn = 1 ;;
  }

  dimension: campaign_id  {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: end_datetime {
    type: date_raw
    label : "IO Last Rec Rev Date"
    sql: ${TABLE}.END_DATETIME;;
  }

  measure: end_datetime_measure {
    type:  date_raw
    hidden:  yes
    sql: MAX(${end_datetime}) ;;
  }

  dimension: campaign_end_date {
    type: date_raw
    hidden:  yes
    sql:  ${TABLE}.CAMPAIGN_END_DATE ;;
  }

  dimension: campaign_start_date {
    type: date_raw
    hidden:  yes
    sql:  ${TABLE}.CAMPAIGN_START_DATE ;;
  }

  measure: io_begin_date {
    label : "IO Begin Date"
    type:date_time
    description: "The begin date for campaign billing reporting which reflects Campaign Start Date"
    sql:MIN(${campaign_start_date}) ;;
  }

  measure: io_end_date {
    label : "IO End Date"
    type:date_time
    description: "The end date for campaign billing reporting which reflects Campaign End Date"
    sql:  MAX(${campaign_end_date}) ;;
  }

  dimension: last_rec_rev_date {
    label : "Last Rec Rev Date"
    type: date_raw
    sql: (${TABLE}.CAMPAIGN_END_DATETIME);;
  }

  measure: last_rec_rev_date_measure {
    hidden:  yes
    type:  date_raw
    sql: MAX(${last_rec_rev_date}) ;;
  }

  dimension: insertion_order_id  {
    type: number
    sql: ${TABLE}.INSERTION_ORDER_ID ;;
    value_format_name: id
  }

  dimension: reconciled_revenue  {
    type: number
    hidden :yes
    sql: ${TABLE}.PREVIOUS_MONTH_BILLED ;;
  }

  measure: sum_reconciled_revenue {
    type : sum
    description:"The reconciled revenue for the campaign."
    label: "Reconciled Revenue"
    value_format_name: decimal_2
    sql: ${reconciled_revenue} ;;
  }

  measure: io_delivery_days {
    label: "IO Delivery Days"
    description: "Total Delivery Days for Insertion Order"
    type : number
    value_format_name: decimal_0
    sql: CASE WHEN ${end_datetime_measure} is null
                THEN 0
                WHEN ${last_rec_rev_date_measure} < ${io_begin_date}::TIMESTAMP
                THEN 0
               WHEN ${last_rec_rev_date_measure} > ${io_end_date}::TIMESTAMP
               THEN ${total_io_days}
                ELSE datediff(hour, ${io_begin_date}::TIMESTAMP, ${last_rec_rev_date_measure}::TIMESTAMP) / 24
                END ;;
  }

  measure  : total_io_days {
    label: "Total IO Days"
    description: "Total IO Days based on campaign dates at IO Level"
    hidden :  no
    type : number
    value_format_name: decimal_0
    sql: datediff(hour,${io_begin_date}::TIMESTAMP, ${io_end_date}::TIMESTAMP)/24  ;;

  }

  measure: ccp_days {
    label: "Days for CCP calculation"
    description: "Days for CCP calculation"
    hidden:  yes
    type : number
    value_format_name: decimal_2
    sql: (${total_io_days} - ${io_delivery_days})  ;;
  }

  measure: ccp {
    label: "CCP"
    description: "CCP"
    type: number
    value_format_name: decimal_2
    sql: CASE WHEN (${ccp_days}) != 0
               THEN (${v_insertion_order_demand_units_budget.sum_budget}- ${sum_reconciled_revenue}) /(${ccp_days})
               ELSE 0 END;;
  }

  measure: io_current_month_days_delivered {
    label: " IO Current Month Delivered Days"
    description: "Number of Days in Current month in which IO served"
    type: number
    sql:  GREATEST(DATEDIFF(day, GREATEST(${io_begin_date}::TIMESTAMP, DATE_TRUNC('MONTH', TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ))),
      LEAST(${io_end_date}::TIMESTAMP, TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ))) + 1, 0) ;;
  }

  measure: io_current_month_days {
    label: " IO Current Month Days"
    description: "Number of IO serving Days in Current month"
    type: number
    value_format_name:  decimal_0
    sql:  GREATEST(datediff(hour, GREATEST(${io_begin_date}::TIMESTAMP, DATE_TRUNC('MONTH', TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ))),
      LEAST(${io_end_date}::TIMESTAMP, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ), 1)))) / 24, 0) ;;
  }

  measure: io_next_month_days {
    label: " IO Next Month Days"
    description: "Number of IO Serving Days in Next month"
    type: number
    sql:  GREATEST(datediff(hour, GREATEST(${io_begin_date}::TIMESTAMP, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ),1))),
      LEAST(${io_end_date}::TIMESTAMP, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ), 2)))) / 24, 0) ;;
  }

  measure: io_following_month_days {
    label: " IO Following Month Days"
    description: "Number of IO Serving Days in Following month"
    type: number
    sql:  GREATEST(datediff(hour, GREATEST(${io_begin_date}::TIMESTAMP, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ),2))),
      LEAST(${io_end_date}::date, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ), 3)))) / 24, 0) ;;
  }

  measure: io_following_month_plus_one_days {
    label: " IO Following Month plus One Days"
    description: "Number of IO Serving Days in Following month plus one "
    type: number
    sql:  GREATEST(datediff(hour, GREATEST(${io_begin_date}::TIMESTAMP, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ), 3))),
      LEAST(${io_end_date}::TIMESTAMP, DATE_TRUNC('MONTH', ADD_MONTHS(TO_TIMESTAMP(CURRENT_DATE()::varchar,'YYYY-MM-DD' ), 4)))) / 24, 0) ;;
  }

  measure: bookings_current_month {
    label: "Bookings Current Month"
    description: "Bookings for Current Month"
    type: number
    value_format_name: decimal_2
    sql:  ${io_current_month_days} * ${ccp} ;;
  }

  measure: bookings_next_month {
    label: "Bookings Next Month"
    description: "Bookings for Next Month"
    type: number
    value_format_name: decimal_2
    sql:  ${io_next_month_days} * ${ccp} ;;
  }

  measure: bookings_following_month {
    label: "Bookings Following Month"
    description: "Bookings for Following Month"
    type: number
    value_format_name: decimal_2
    sql:  ${io_following_month_days} * ${ccp} ;;
  }

  measure: bookings_following_month_plus_one {
    label: "Bookings Following Month Plus One"
    description: "Bookings for Following Month Plus One"
    type: number
    value_format_name: decimal_2
    sql:  ${io_following_month_plus_one_days} * ${ccp} ;;
  }

  measure: daily_revenue_run_rate {
    label: "Daily Revenue Run Rate"
    description: "Daily Revenue Run Rate"
    type:  number
    value_format_name: decimal_2
    sql: coalesce(${v_daily_core_stats.monthly_revenue_delivered} / nullif(${io_current_month_days_delivered}, 0), 0) ;;
  }

  measure: revenue_run_rate {
    label: "Revenue Run Rate"
    description: "Revenue Run Rate"
    type:  number
    value_format_name: decimal_2
    sql:  ${daily_revenue_run_rate}*${io_current_month_days};;
  }

  measure: isfiller {
    type: yesno
    label: "IO Is Filler"
    sql: MAX(${TABLE}.isfiller) ;;
  }

  measure: is_test_campaign {
    type: yesno
    label: "IO Is Test"
    sql: MAX(${TABLE}.is_test_campaign) ;;
  }

  measure: io_campaign_status_finished_paused_ended {
    type: yesno
    label: "IO Campaign Status Finished Paused Ended"
    sql: MIN(${TABLE}.io_campaign_status_finished_paused_ended) AND ${v_daily_core_stats.monthly_revenue_delivered} = 0 AND NOT MIN(${TABLE}.io_format_type) ;;
  }

  measure: io_campaign_status_planning_reserved {
    type: yesno
    label: "IO Campaign Status Planning Reserved"
    sql: MIN(${TABLE}.io_campaign_status_planning_reserved) ;;
  }
}
