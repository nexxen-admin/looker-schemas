view: mssql_oltp_timezone {
  label: "Timezone"
  sql_table_name: AN_MAIN..timezone (NOLOCK) ;;


dimension: timezone_id {
  type: number
  primary_key: yes
  hidden: yes
  sql: ${TABLE}.timezone_id ;;
 }

dimension: description {
  type: string
  label: "Timezone"
  description: "The description of the timezone."
  sql: ${TABLE}.description ;;
 }

dimension: utc_offset {
  type: number
  description: "The number of hours from UTC."
  sql: ${TABLE}.utc_offset ;;
 }
}
