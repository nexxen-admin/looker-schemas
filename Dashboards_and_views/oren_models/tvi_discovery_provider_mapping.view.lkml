view: tvi_discovery_provider_mapping {
  sql_table_name: bi.TVI_Discovery_Provider_Mapping ;;

  dimension: data_source {
    type: string
    sql: ${TABLE}.data_source ;;
    hidden: yes
  }
  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
    hidden: no
  }
  dimension: data_use {
    type: string
    sql: ${TABLE}.data_use ;;
    hidden:  no
  }
  dimension: provider_id {
    type: number
    sql: ${TABLE}.provider_id ;;
    hidden: no
  }
  measure: count {
    type: count
    hidden:  yes
  }
}
