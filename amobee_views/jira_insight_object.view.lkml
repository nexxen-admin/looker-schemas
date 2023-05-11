view: insight_object {
  derived_table: {
    sql:
      SELECT
        "ID",
        "NAME"
      FROM
        "AO_8542F1_IFJ_OBJ" ro
      WHERE "OBJECT_TYPE_ID" = 269
    ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: name {
    type: string
    label: "Name"
    view_label: "Insight Fields"
    sql: ${TABLE}."NAME" ;;
  }

  dimension: working_period_start {
    type: date
    hidden: yes
    sql: {% date_start working_days_filter %} ;;
  }

  dimension: working_period_end {
    type: date
    hidden: yes
    sql: {% date_end working_days_filter %} ;;
  }

  filter: working_days_filter {
    type: date
    label: "Working Days Filter"
    view_label: "Performance Metrics"
  }

  dimension: weekday_datediff {
    type: number
    label: "Working Days"
    view_label: "Performance Metrics"
    sql: round((${working_period_end} - ${working_period_start}) / 1.4) ;;
  }
}
