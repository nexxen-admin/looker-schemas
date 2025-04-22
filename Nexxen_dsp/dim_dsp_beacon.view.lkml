view: dim_dsp_beacon {
  sql_table_name: BI_DSP.dim_dsp_beacon ;;

  dimension: beacon_id {
    type: number
    sql: ${TABLE}.beacon_id ;;
    hidden: yes
  }
  dimension: beacon_key {
    type: number
    sql: ${TABLE}.beacon_key ;;
    hidden: yes
  }
  dimension: beacon_name {
    type: string
    sql: ${TABLE}.beacon_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
}
