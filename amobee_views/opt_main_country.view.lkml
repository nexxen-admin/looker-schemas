view: opt_main_country {
  # You can specify the table name if it's different from the view name:
  sql_table_name: AN_MAIN..country ;;

  # Define your dimensions and measures here, like this:
  dimension: country_id {
    description: "country_id"
    type: number
    sql: ${TABLE}.country_id ;;
    value_format_name: id
  }

  dimension: country {
    description: "Country Name"
    type: string
    sql: ${TABLE}.description ;;
  }



}
