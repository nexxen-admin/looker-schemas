view: mssql_oltp_deal_media_plan {
  label: "Deal"
  sql_table_name: dbo.deal_media_plan (NOLOCK) ;;

  dimension: deal_media_plan_id {
    type: number
    primary_key: yes
    hidden: yes
    label: "Deal Media Plan ID"
    sql: ${TABLE}.deal_media_plan_id ;;
  }

  dimension: deal_id {
    type: number
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: media_plan_name {
    type: string
    hidden: yes
    label: "Media Plan Name"
    sql: ${TABLE}.media_plan_name ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    label: "Active"
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: deal_media_plan_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.deal_media_plan_status_id ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  measure: creation_date {
    type: date_time
    label: "Proposal Creation Date"
    sql: max(case when ${deal_media_plan_status_id} = 4 then ${createdon_time} end) ;;
  }

  measure: approval_date {
    type: date_time
    label: "Proposal Approval Date"
    sql: max(case when ${deal_media_plan_status_id} = 4 then ${changedon_time} end) ;;
  }
}
