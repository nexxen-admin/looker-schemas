view: fact_reach_frequency {
  sql_table_name: BI_DSP.dim_reach_and_frequency ;;

  dimension: related_brand {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension_group: date_border {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date Border"
    sql: ${TABLE}.date_border ;;
  }

  dimension: date_range {
    type: string
    sql:  ${TABLE}.date_range ;;
  }

 dimension: advertiser_name {
   type: string
  sql: ${TABLE}.advertiser_name;;
 }

  measure: reach {
    type: max
    value_format: "#,##0"
    sql: ${TABLE}.reach ;;
  }

  measure: frequency {
    type: max
    value_format: "#.00"
    sql:  ${TABLE}.frequency ;;
  }

  measure: html_kpi_board {
    type: count
    html:
    <div style = "color:#1982c4; backgroubd: red; ">

        <div style="font-size: 20px; display: inline-block; padding: 0px 40px; letter-spacing: 0.01em; padding-bottom: 5px; ">
          Reach
          <div style="color:#1982c4; line-height: 15px; font-size: 30px;">
            {{ reach._rendered_value }}
          </div>
        </div>

        <div style="font-size: 20px; display: inline-block; padding: 0px 40px; letter-spacing: 0.01em; padding-bottom: 5px;">
        Frequency
          <div style="color:#1982c4; line-height: 15px; font-size: 30px;">
            {{ frequency._rendered_value }}
          </div>
        </div>

      </div>;;
  }

}
