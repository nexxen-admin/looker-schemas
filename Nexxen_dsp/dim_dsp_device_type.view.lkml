view: dim_dsp_device_type {
  sql_table_name: BI_DSP.dim_dsp_device_type ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }
  dimension: device_type_category {
    type: string
    sql: CASE WHEN ${TABLE}.device_type IN ('TV', 'Set Top Box', 'Media Player', 'Games Console') THEN 'CTV'
      WHEN ${TABLE}.device_type='PC' THEN 'Desktop'
       WHEN ${TABLE}.device_type='E-Reader' THEN 'Tablet'
      WHEN ${TABLE}.device_type IS NULL or  ${TABLE}.device_type IN ('Unknown', 'Any Device') THEN  'Other'
      ELSE ${TABLE}.device_type END;;
  }


  dimension: device_type_key {
    type: number
    sql: ${TABLE}.device_type_key ;;
    hidden: yes
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    hidden: yes
  }
}
