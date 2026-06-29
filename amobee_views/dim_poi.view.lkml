view:sunflower_dim_poi {
  sql_table_name: SunFlower.dim_poi ;;

  dimension: address {
    label: "POI Address"
    type: string
    sql: ${TABLE}.address ;;
  }
  dimension: poi_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.poi_id ;;
  }
  dimension: region {
    label: "POI Region"
    type: string
    sql: ${TABLE}.region ;;
  }
  measure: count {
    type: count
  }
}
