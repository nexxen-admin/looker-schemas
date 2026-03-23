view: dim_derived_imp_type {
  sql_table_name: BI_New.dim_derived_imp_type ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension: derived_imp_type_key {
    type: number
    sql: ${TABLE}.derived_imp_type_key ;;
    hidden: yes
  }
  dimension: derived_imp_type_name {
    type: string
    label: "Derived Imp Type"
    sql: ${TABLE}.derived_imp_type_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
}
