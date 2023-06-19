view: customfieldvalue_satisfaction {
  sql_table_name: public.customfieldvalue ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: customfield {
    type: number
    hidden: yes
    sql: ${TABLE}.customfield ;;
  }

  dimension: satisfaction {
    type: string
    label: "Satisfaction"
    view_label: "Custom Fields"
    sql: ${TABLE}.stringvalue ;;
  }

  dimension: satisfaction_scale {
    type: number
    label: "Satisfaction Scale"
    view_label: "Custom Fields"
    sql: (${TABLE}.stringvalue::json ->> 'scale')::int ;;
  }

  dimension: satisfaction_rate {
    type: number
    label: "Satisfaction Rate"
    view_label: "Custom Fields"
    sql: (${TABLE}.stringvalue::json ->> 'rate')::int ;;
  }

  dimension: satisfaction_type {
    type: number
    label: "Satisfaction Type"
    view_label: "Custom Fields"
    sql: (${TABLE}.stringvalue::json ->> 'type')::int ;;
  }
}
