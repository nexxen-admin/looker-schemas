view: sql_placement_integration_type {
  sql_table_name: dbo.placement_integration_type (NOLOCK) ;;

  dimension: placement_integration_type_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_integration_type_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension: description {
    type: string
    label: "Placement Integration Type"
    view_label: "Placement"
    sql: ${TABLE}.description ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

}
