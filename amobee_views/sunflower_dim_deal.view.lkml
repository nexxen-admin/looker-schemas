view: sunflower_dim_deal {
  sql_table_name: SunFlower.dim_deal ;;

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
  }
  dimension: deal_floor_price {
    type: number
    sql: ${TABLE}.deal_floor_price ;;
  }
  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }
  dimension: deal_name {
    type: string
    sql: ${TABLE}.deal_name ;;
  }
  dimension: deal_type_id {
    label: "Deal Type ID"
    type: number
    sql: ${TABLE}.deal_type ;;
  }
  dimension: deal_type_calc {
    label: "Deal Type"
    type: string
    sql:
    CASE
      WHEN ${TABLE}.deal_type IN (4, 5) THEN 'PMP'
      WHEN ${TABLE}.deal_type IS NULL THEN 'OMP'
      ELSE ${TABLE}.deal_type_name
    END ;;
  }
  dimension: deal_type_name {
    type: string
    sql: ${TABLE}.deal_type_name ;;
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
  }
  dimension: publisher_deal_id {
    type: number
    sql: ${TABLE}.publisher_deal_id ;;
  }
  measure: count {
    type: count
    drill_fields: [deal_name, deal_type_name]
  }
}
