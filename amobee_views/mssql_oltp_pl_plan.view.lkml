view: mssql_oltp_pl_plan {
  label: "Plan"
  sql_table_name: dbo.pl_plan (NOLOCK) ;;

  dimension: pl_plan_id{
    type: number
    primary_key: yes
    label: "Plan ID"
    sql: ${TABLE}.pl_plan_id ;;
    value_format_name: id
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_brand_id ;;
  }

  dimension: plan_name{
    type: string
    label: "Plan Name"
    sql: ${TABLE}.plan_name ;;
  }

  dimension: active {
    type: yesno
    label: "Active"
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: pl_plan_status_id {
    type: number
    hidden: yes
    label: "Plan Status ID"
    sql: ${TABLE}.pl_plan_status_id ;;
  }
}
