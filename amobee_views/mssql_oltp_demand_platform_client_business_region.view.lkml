view: mssql_oltp_demand_platform_client_business_region {
  sql_table_name: dbo.business_region (NOLOCK) ;;

  dimension: business_region_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.business_region_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Demand Platform Client"
    label: "Business Region"
    sql: ${TABLE}.description ;;
  }
}
