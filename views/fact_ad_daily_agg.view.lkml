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

  measure: revenue_parameter {
    type: number
    sql: ${Last_day_Revenue} ;;
    value_format: "$0.00,,\" M\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: request_parameter {
    type: number
    sql: ${Last_day_Requests} ;;
    value_format: "$0.00,,\" M\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: fillRate_parameter {
    type: number
    sql: ${Last_day_Fill_Rate} ;;
    value_format: "0.00\%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: bidRate_parameter {
    type: number
    sql: ${Last_day_Bid_Rate} ;;
    value_format: "0.00\%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: Net_Margin_parameter {
    type: number
    sql: ${Last_Day_net_Revenue} ;;
    value_format: "$0.00,,\" M\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: revenue_lastday_change_parameter {
    type: number
    sql: (${Last_day_Revenue}/${Previous_day_Revenue})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: impressions_lastday_change_parameter {
    type: number
    sql: (${Last_day_impressions}/${Previous_day_impressions})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: request_lastday_change_parameter {
    type: number
    sql: (${Last_day_Requests}/${Previous_day_Requests})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }
  measure: net_revenue_lastday_change_parameter {
    type: number
    sql: (${Last_Day_net_Revenue}/${prev_Day_net_Revenue})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }

  measure: change_parameter {
    type: number
    sql: case when ${revenue_lastday_change_parameter}>0
        then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
  }

  measure: impression_variable {
    type: count
    html:
    <div style="linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px;"><strong>Impressions</strong>
        <div style="display: block; line-height: 12px; font-size: 25px;">{{rendered_value}}
        <div style="display: inline-block;line-height: 12px; font-size: font-size: 15px;"><span class="vis-single-value-comparison-value positive; style= font-sise:15px;"><script type="text/javascript">
        //<![CDATA] if (revenue_lastday_change_parameter._rendered_value >0){greeting ="▲";} else {greeting = "▼"} document.getElementById("demo").innerHTML = greeting;</script>
        <span class="drillable-item" data-links="" data-context="" data-add-filter-json=""><span class="drillable-item-content">10%</span></span></span></div></div>
         last day change</div>
    </div> ;;
  }

  measure: revenue_variable {
    type: count
    html:
     <div>
     <img src="https://files.fm/thumb_show.php?i=mp8b8xfaq">
    </div>
    <div style = "background:#393838;">
    <div style="margin-right: 60px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Revenue {{change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ revenue_parameter._rendered_value }}
        <div style="  margin-Left: -500px ;display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{revenue_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
     <div style="margin-right: 60px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Impressions {{change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ impression_parameter._rendered_value }}
        <div style="  margin-Left: -400px ;display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{impressions_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
    <div style="display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em">Net Revenue {{change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ Net_Margin_parameter._rendered_value }}
        <div style="  margin-Left: -400px ;display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{net_revenue_lastday_change_parameter._rendered_value}} from past day </div>
    </div></div>;;
  }

  measure: revenue_variable_2 {
    type: count
    html:
    <div style = "background:#fff; border-radius: 10px;">
    <div style="margin-right: 60px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#393838;letter-spacing: 0.01em;">Revenue {{change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#393838">{{ revenue_parameter._rendered_value }}
        <div style="  margin-Left: -400px ;display: inline-block; font-size: 15px;color:#393838">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{revenue_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
     <div style="margin-right: 60px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#393838;letter-spacing: 0.01em;">Impressions {{change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#393838">{{ impression_parameter._rendered_value }}
        <div style="  margin-Left: -400px ;display: inline-block; font-size: 15px;color:#393838">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{impressions_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
    <div style="display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#393838;letter-spacing: 0.01em">Net Revenue {{change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#393838">{{ Net_Margin_parameter._rendered_value }}
        <div style="  margin-Left: -400px ;display: inline-block; font-size: 15px;color:#393838">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{net_revenue_lastday_change_parameter._rendered_value}} from past day </div>
    </div></div>;;
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


  measure:  Previous_day_Revenue {
    label: "Previous day Revenue"
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0.00"
    filters: [date_key_date: "2 days ago"]
  }

  measure:  Previous_day_Requests {
    label: "Previous day Requests"
    type: sum
    sql: ${TABLE}.requests ;;
    value_format: "$0.00,,\" M\""
    filters: [date_key_date: "2 days ago"]
  }
  measure:  Previous_day_impressions {
    label: "Previous day Impressions"
    type: sum
    sql: ${TABLE}.impression_pixel ;;
    value_format: "$0.00,,\" M\""
    filters: [date_key_date: "2 days ago"]
  }
  measure:  previous_day_Bid_Rate {
    label: "Bid Rate Previous day"
    type: sum
    sql: ${TABLE}.responses/NULLIF(${TABLE}.requests,0) ;;
    value_format: "0.00\%"
    filters: [date_key_date: "2 days ago"]
  }
  measure: previous_day_Fill_Rate {
    type: sum
    label: "Fill Rate Previous day"
    value_format: "0.00%"
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_pixel/NULLIF(${TABLE}.requests,0)  ;;
    filters: [date_key_date: "2 days ago"]
  }
  measure: prev_Day_net_Revenue {
    type: sum
    label: "Net Revenue Last Day"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.revenue - ${TABLE}.cogs  ;;
    filters: [date_key_date: "2 days ago"]
  }
  measure:  Last_day_Revenue {
    label: "Last day Revenue"
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }
  measure:  Last_day_impressions {
    label: "Previous day Impressions"
    type: sum
    sql: ${TABLE}.impression_pixel ;;
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }
  measure: Last_Day_net_Revenue {
    type: sum
    label: "Net Revenue Last Day"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.revenue - ${TABLE}.cogs  ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_Fill_Rate {
    type: sum
    label: "Fill Rate Last day"
    value_format: "0.00%"
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_pixel/NULLIF(${TABLE}.requests,0) ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_Requests {
    label: "Last day Revenue"
    type: sum
    sql: ${TABLE}.requests/NULLIF(${TABLE}.requests,0) ;;
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }
  measure:  Last_day_Bid_Rate {
    label: "Last day Revenue"
    type: sum
    sql: ${TABLE}.responses/NULLIF(${TABLE}.requests,0) ;;
    value_format: "0.00\%"
    filters: [date_key_date: "last 1 day ago for 1 day"]
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
