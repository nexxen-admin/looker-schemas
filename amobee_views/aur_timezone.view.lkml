view: aur_timezone {

  label: "Aurora Timezone Dimension"

  sql_table_name: dim.timezone ;;

  dimension: timezone_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.timezone_id ;;
    value_format_name: id
  }

  dimension: timezone_code {
    type: string
    sql: ${TABLE}.timezone_code ;;
  }

  dimension: timezone_description {
    type: string
    sql: ${TABLE}.timezone_description ;;
  }

  dimension: timezone_name {
    type: string
    sql: ${TABLE}.timezone_name ;;
  }

  dimension: utc_offset {
    type: number
    sql: ${TABLE}.utc_offset ;;
  }
}
