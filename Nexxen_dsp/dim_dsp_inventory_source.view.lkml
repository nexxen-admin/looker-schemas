view: dim_dsp_inventory_source {
  sql_table_name: BI_DSP.dim_dsp_inventory_source ;;

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
  dimension: inventory_source_id {
    type: number
    sql: ${TABLE}.inventory_source_id ;;
    # hidden: yes
    }

  dimension: inventory_src_name {
    type: string
    label: "Inventory Src Name"
    description: "Daily Tracker Unruly dimension"
    sql: CASE WHEN ${inventory_source_id} in (12, 115, 50, 8, 158, 9, 179, 16, 202, 6, 11, 40, 97, 191, 37, 200, 195)
      THEN ${inventory_source_name} ELSE 'Misc Small Volume Exchanges' END ;;
  }

  dimension: inventory_source_key {
    type: number
    sql: ${TABLE}.inventory_source_key ;;
    hidden: yes
    }
  dimension: inventory_source_name {
    type: string
    sql: ${TABLE}.inventory_source_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
    }
  measure: count {
    type: count
    drill_fields: [inventory_source_name]
    hidden: yes
    }
}
