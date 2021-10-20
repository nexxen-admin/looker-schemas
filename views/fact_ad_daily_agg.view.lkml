view: fact_ad_daily_agg {
  sql_table_name: BI_New.V_Fact_Ad_Daily_Agg ;;

  parameter: max_rank {
    type: number
  }

  measure: impression_parameter {
    type: number
    sql: ${impression_pixel} ;;
    value_format: "#,##0"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: example {
    type: count
    html:
    <div style="border-radius: 10px;box-shadow: inset 4.33643px -4.33643px 4.33643px; background-color: #fff; color: #010e0f;">
        <div style="display: block;  font-size: 25px;"><strong>Impressions</strong>
        <div style="display: block; line-height: 10px; font-size: 25px;">{{rendered_value}}</div>
        (last day increases to 22%)</div>
    </div> ;;
  }
  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
  hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.cogs ;;
  }

  measure:: cost {
    label: "Cost"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.cost ;;
  }

  measure:: ias_ivt_impression {
    type: sum
    label: "IAS IVT Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_ivt_impression ;;
  }

  measure:: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_measurable_impression ;;
  }

  measure:: ias_viewability {
    type: number
    value_format: "0.00\%"
    label: "IAS Viewability"
    group_label: "Daily Measures"
    sql: ${ias_viewable_impression}/NULLIF(${ias_measurable_impression},0);;
  }

  measure:: ias_total_impression {
    type: sum
    label: "Total IAS Count"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_total_impression ;;
  }

  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_viewable_impression ;;
  }

  measure:: video_completes {
    type: sum
    label: "Video Completes"
    group_label: "Daily Measures"
    sql: ${TABLE}.video_completes ;;
  }

  measure:: video_starts {
    type: sum
    label: "Video Starts"
    group_label: "Daily Measures"
    sql: ${TABLE}.video_starts ;;
  }


  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension_group: date_key {
    type: time
    timeframes:
    [ date,
      month,
      raw
    ]
    label: "Date"
    group_label: "Time Frame"
    sql: ${TABLE}.Date_Key ;;
    hidden: yes
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_flight_key {
    type: number
    sql: ${TABLE}.DSP_Flight_Key ;;
    hidden: yes
  }


  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
    hidden: yes
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
    hidden: yes
  }

  dimension: imp_sub_type_key {
    type: number
    sql: ${TABLE}.Imp_SubType_Key ;;
    hidden: yes
  }

  dimension: imp_type_key {
    type: number
    sql: ${TABLE}.Imp_Type_Key ;;
    hidden: yes
  }

  measure: impression_pixel {
    type: sum
    label: "Impressions"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_pixel ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_win ;;
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
    hidden: yes
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
    hidden: yes
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
    hidden: yes
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
    hidden: yes
  }

  measure: requests {
    type: sum
    label: "Inbound Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.requests ;;
  }

  measure: Bid_Rate {
    type: number
    label: "Bid Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: ${responses}/NULLIF(${requests},0) ;;
  }

  measure: Fill_Rate {
    type: number
    label: "Fill Rate"
    value_format: "0.00%"
    group_label: "Daily Measures"
    sql: ${impression_pixel}/NULLIF(${requests},0) ;;
  }

  measure: Net_Revenue {
    type: number
    label: "Net Revenue"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue} - ${cogs} ;;
  }

  measure: Margin {
    type: number
    label: "Margin%"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${revenue} - ${cogs})/NULLIF(${revenue},0) ;;
  }

  measure: Pub_eCPM {
    type: number
    label: "Pub eCPM"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: (${cogs}/NULLIF(${impression_pixel},0))*1000 ;;
  }

  measure: Render_Rate {
    type: number
    label: "Render Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: ${impression_pixel}/NULLIF(${impression_win},0) ;;
  }

  measure: Response_Rate {
    type: number
    label: "Response Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: ${responses}/NULLIF(${requests},0) ;;
  }

  measure: RPM {
    type: number
    label: "RPM"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue}/NULLIF((${requests}/1000000),0) ;;
  }

  measure: VTR {
    type: number
    label: "VTR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: ${video_completes}/NULLIF(${impression_pixel},0);;
  }

  measure: VCR {
    type: number
    label: "VCR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: ${video_completes}/NULLIF(${video_starts},0);;
  }

  measure: Win_Rate {
    type: number
    label: "Win Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: ${impression_pixel}/NULLIF(${responses},0);;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    label: "Bids"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.responses ;;
  }

  measure: revenue {
    type: sum
    label: "Revenue"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.revenue ;;
  }

  measure: Ad_eCPM{
    type: number
    label: "Ad eCPM"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue}/NULLIF((${impression_pixel}/1000),0) ;;
  }


  measure: rmp_requests {
    type: sum
    label: "Pub Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.rmp_requests ;;
  }

  measure: rx_bid_floor {
    type: number
    group_label: "Daily Measures"
    sql: ${TABLE}.rx_bid_floor ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
