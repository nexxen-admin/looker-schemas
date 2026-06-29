view: dim_poi {
  sql_table_name: SunFlower.dim_poi ;;

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }
  dimension: poi_id {
    type: number
    sql: ${TABLE}.poi_id ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  measure: count {
    type: count
  }
}
