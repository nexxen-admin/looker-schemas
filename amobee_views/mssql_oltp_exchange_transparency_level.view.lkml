view: exchange_transparency_level {
  sql_table_name: dbo.exchange_transparency_level (NOLOCK) ;;

  dimension: exchange_transparency_level_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.exchange_transparency_level_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: description {
    type: string
    label: "Placement Exchange Transparency Level"
    view_label: "Placement"
    sql: ${TABLE}.description ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

}
