view: tier_1_resolution_reason_code {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: string
    label: "Tier 1 Resolution Reason Code"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue ;;
  }
}
