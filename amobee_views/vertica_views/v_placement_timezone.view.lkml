view: v_placement_timezone {
  sql_table_name: DIM.TIMEZONE ;;

  dimension: timezone_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.TIMEZONE_ID ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.LOOKUP_LOCALE_ID ;;
  }

  dimension: timezone_code {
    type: string
    hidden: yes
    sql: ${TABLE}.TIMEZONE_CODE ;;
  }

  dimension: timezone_description {
    type: string
    hidden: yes
    sql: ${TABLE}.TIMEZONE_DESCRIPTION ;;
  }

  dimension: utc_offset {
    type: number
    hidden: yes
    sql: ${TABLE}.UTC_OFFSET ;;
  }
}
