view: ssot_drr_v {

  derived_table: {
    sql: SELECT
            ssot_drr_v.date_period,
            ssot_drr_v.event_date,
            ssot_drr_v.region,
            ssot_drr_v.category,
            ssot_drr_v.tremor_ssp_inventory,
            ssot_drr_v.is_tremor,
            ssot_drr_v.subcategory,
            ssot_drr_v.media_type,
            ssot_drr_v.device_type,
            ssot_drr_v.gross_revenue,
            ssot_drr_v.cost
        FROM BI_DSP.ssot_drr_v
        WHERE ssot_drr_v.status = 'OPEN' AND ssot_drr_v.event_date >= '2026-05-01';;
    }

  dimension_group: date_period {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_period ;;
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  dimension: region{
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: category{
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: tremor_ssp_inventory{
    type: string
    label: "Tremor SSP Inventory"
    sql: ${TABLE}.tremor_ssp_inventory ;;
  }

  dimension: is_tremor{
    type: yesno
    sql: ${TABLE}.is_tremor ;;
  }

  dimension: subcategory{
    type: string
    sql: ${TABLE}.subcategory ;;
  }

  dimension: media_type{
    type: string
    sql: ${TABLE}.media_type ;;
  }

  dimension: device_type{
    type: string
    sql: ${TABLE}.device_type ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.gross_revenue ;;
    value_format: "$#,##0.00"
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "$#,##0.00"
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.gross_revenue - ${TABLE}.cost ;;
    value_format: "$#,##0.00"
  }

  measure: net_revenue_perc {
    type: number
    sql: ${net_revenue}/${revenue} ;;
    value_format: "0.0%"
  }


}
