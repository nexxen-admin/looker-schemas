view: dwh_validation_config {
  sql_table_name: BI_DSP.dwh_validation_config ;;

  dimension: validation_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.validation_id ;;
    label: "Validation ID"
  }

  dimension: validation_name {
    type: string
    sql: ${TABLE}.validation_name ;;
    label: "Validation Name"
    suggest_persist_for: "1 hour"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    label: "Description"
  }

  dimension: validation_severity {
    type: string
    sql: ${TABLE}.validation_severity ;;
    label: "Validation Severity"
    suggest_persist_for: "1 hour"
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Is Active"
  }

  measure: count {
    type: count
    label: "Total Validations"
  }
}
