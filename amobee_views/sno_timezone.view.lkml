view: timezone {
  label: "Timezone Information"
  sql_table_name: DIM.TIMEZONE ;;

  dimension: timezone_id {
    type: number
    label: "Timezone Id"
    description: "The Videology timezone id"
    sql: ${TABLE}.TIMEZONE_ID ;;
    primary_key: yes
  }

  dimension: utc_offset {
    type: number
    label: "UTC Offset"
    description: "The number of hours offset from UTC"
    sql: ${TABLE}.UTC_OFFSET ;;
  }

  dimension: timezone_description {
    type: string
    label: "Timezone Description"
    description: "A description of the timezone"
    sql: ${TABLE}.TIMEZONE_DESCRIPTION ;;
    bypass_suggest_restrictions: yes
  }

  dimension: active {
    type: number
    label: "Active"
    hidden: yes
    description: "1 if the timezone is active"
    sql: ${TABLE}.TIMEZONE_DESCRIPTION ;;
  }

  dimension: lookup_locale_id {
    type: string
    label: "Lookup Locale Id"
    description: "The lookup locale Id"
    sql: ${TABLE}.LOOKUP_LOCALE_ID ;;
    bypass_suggest_restrictions: yes
  }

  dimension: timezone_code {
    type: string
    label: "Timezone Code"
    description: "The timezone code"
    sql: ${TABLE}.TIMEZONE_CODE ;;
    bypass_suggest_restrictions: yes
  }

  dimension: timezone_name {
    type: string
    label: "Timezone Name"
    sql: ${TABLE}.timezone_name ;;
    bypass_suggest_restrictions: yes
  }
}
