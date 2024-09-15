view: fact_reach_accumulative {
  sql_table_name: BI_DSP.fact_reach_accumulative ;;

  dimension: related_brand {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date in Timezone"
    sql: ${TABLE}.date_key_in_timezone ;;
  }

 dimension: advertiser_name {
   type: string
  sql: ${TABLE}.advertiser_name;;
 }

  measure: accumulative_unique_users {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.accumulative_unique_users ;;
  }

  measure: impressions {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }

  measure: unique_users {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.unique_users ;;
  }

  measure: frequency {
    type: number
    value_format: "#.00"
    sql: CASE WHEN ${unique_users} >0 THEN ${impressions}/${unique_users} ELSE 0 END ;;
  }

  measure: html_kpi_board {
    type: count
    html:
    <div style = "color:#1982c4; backgroubd: red; ">

        <div style="font-size: 20px; display: inline-block; float: left; padding: 0px 40px; letter-spacing: 0.01em; padding-bottom: 5px; ">
          Reach
          <div style="color:#1982c4; line-height: 15px; font-size: 30px;">
            {{ unique_users._rendered_value }}
          </div>
        </div>

        <div style="font-size: 20px; display: inline-block; float: left; padding: 0px 40px; letter-spacing: 0.01em; padding-bottom: 5px;">
        Frequency
          <div style="color:#1982c4; line-height: 15px; font-size: 30px;">
            {{ frequency._rendered_value }}
          </div>
        </div>

      </div>;;
  }

}
