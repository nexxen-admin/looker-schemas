view: business_region {
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
    view_label: "Publisher"
    label: "Publisher Business Region"
    description: "The business region of the publisher."
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.business_region
  }
}
