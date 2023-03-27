view: placement_country {
  sql_table_name: dbo.country (NOLOCK) ;;

  dimension: country_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Placement Country"
    description: "The country of the placement, which may or may not be the country of the publisher."
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.country_name
  }
}
