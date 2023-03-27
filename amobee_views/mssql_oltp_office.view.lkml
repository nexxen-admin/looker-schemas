view: office {
  sql_table_name: AN_MAIN..office (NOLOCK) ;;

  dimension: office_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.office_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: office_name {
    type: string
    view_label: "Publisher"
    label: "Publisher Office"
    description: "The location of the office of the publisher."
    sql: ${TABLE}.office_name ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.office_name
  }

  dimension: timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.timezone_id ;;
  }
}
