view: fact_ad_daily_agg {
  sql_table_name: BI_New.V_Fact_Ad_Daily_Agg ;;

  parameter: max_rank {
    type: number
    group_label: "Admins dim"
    hidden: yes
  }

  measure: impression_parameter {
    type: number
    sql: ${impression_pixel} ;;
    value_format: "0.00,,,\" B\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: revenue_parameter {
    type: number
    sql: ${Last_day_Revenue} ;;
    value_format: "$0.00,,\" M\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: request_parameter {
    type: number
    sql: ${Last_day_Requests} ;;
    value_format: "0.00,,,\" B\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: Bids_parameter {
    type: number
    sql: ${Last_day_bids} ;;
    value_format:"0.00,,,\" B\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: bidRate_parameter {
    type: number
    sql: ${Last_day_Bid_Rate} ;;
    value_format:  "0.00\%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: Net_Margin_parameter {
    type: number
    sql: ${Last_Day_net_Revenue} ;;
    value_format: "$0.00,\" K\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: revenue_lastday_change_parameter {
    type: number
    sql: (${Last_day_Revenue}/${Previous_day_Revenue})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: impressions_lastday_change_parameter {
    type: number
    sql: (${Last_day_impressions}/${Previous_day_impressions})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: request_lastday_change_parameter {
    type: number
    sql: (${Last_day_Requests}/${Previous_day_Requests})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: net_revenue_lastday_change_parameter {
    type: number
    sql: (${Last_Day_net_Revenue}/${prev_Day_net_Revenue})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: bids_lastday_change_parameter {
    type: number
    sql: (${Last_day_bids}/${previous_day_responses})-1 ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: revenue_change_parameter {
    type: number
    sql: case when ${revenue_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: impression_change_parameter {
    type: number
    sql: case when ${impressions_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: requests_change_parameter {
    type: number
    sql: case when ${request_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: bids_change_parameter {
    type: number
    sql: case when ${bids_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: net_rev_change_parameter {
    type: number
    sql: case when ${net_revenue_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: negative_change_meaures{
    type: number
    sql: case when
          ${net_revenue_lastday_change_parameter}<0 then 'Net Revenue'
          end;;
    html:
    <ul>  <li> value: {{ value }} </li>  </ul> ;;
    hidden: yes
  }

  measure: HTML_variable {
    type: count
    html:
    <div style="text-align:center; border-radius: 0px; padding: 5px 10px; background:#eeeeee; height: 60px; color: red;">

    <nav style="font-size: 18px;">
       <a style="color: #393838; padding: 5px 15px; line-height: 40px;" href="#home">Reports
       </a>
      <a style="color: #393838; padding: 5px 15px; line-height: 40px;" href="https://tremor.cloud.looker.com/dashboards-next/29">News️</a>
      <a style="color: #393838; padding: 5px 15px;line-height: 40px;" href="https://tremor.cloud.looker.com/extensions/marketplace_extension_data_dictionary::data-dictionary/models/Exchange/explores/fact_ad_daily_agg">Data Dictionary</a>
      <a style="color: #393838; padding: 5px 15px; line-height: 40px;" href="#about">Contact️</a>
    </nav>

    </div>
     <div>
     <img style= "width: 100%" src="https://i.ibb.co/nzf8gc7/Frame-4-1.png" alt="Frame-4-1" border="0">
    </div>
    <div style = "background:#393838;">
    <div style="margin-right: 120px; display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
         <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Impressions
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ impression_parameter._rendered_value }} {{impression_change_parameter._value}}

        <div style="display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{impressions_lastday_change_parameter._rendered_value}} from past day </div>
     </div>
     <div style="margin-right: 120px; display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Requests {{requests_change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ request_parameter._rendered_value }}
        <div style="display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{request_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
     <div style="display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
         <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Bids {{bids_change_parameter._value}}
        <div style= "display: block; line-height: 10px; font-size: 25px;color:#fff">{{ Bids_parameter._rendered_value }}
        <div style=" display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{bids_lastday_change_parameter._rendered_value}} from past day </div>
     </div>
    </div>
    <div style = "background:#393838; margin-top: 10px;">
    <div style="margin-right: 120px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em">Revenue {{revenue_change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ revenue_parameter._rendered_value }}
        <div style="display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{revenue_lastday_change_parameter._rendered_value}} from past day </div>
    </div>

     <div style="margin-right: 120px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Impressions {{impression_change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ impression_parameter._rendered_value }}
        <div style="display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{impressions_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
    <div style=" display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
        <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em">Net Revenue {{net_rev_change_parameter._value}}
        <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ Net_Margin_parameter._rendered_value }}
        <div style="display: inline-block; font-size: 15px;color:#fff">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{net_revenue_lastday_change_parameter._rendered_value}} from past day </div>
    </div>
    </div>

    <div>
    <a href="https://tremor.cloud.looker.com/explore/Exchange/fact_ad_daily_agg"><img  style= "width:100%"  src= "https://i.ibb.co/7WgQTps/Frame-3-1.png" alt="Frame-3-1" border="0">"></a>
    </div>
    <div style="text-align:center; border-radius: 0px;  padding: 5px 10px; background:#393838; height: 60px; color: red;">

    <nav style="font-size: 18px;">
      <img style=" width;100px ;padding: 5px 15px; float: left; height: 40px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABaAA…prs+779J3Te6590L1/j8HLRpR86ZVlgAAAABJRU5ErkJggg==">
      <a style="color: #efefef; padding: 5px 15px; line-height: 40px;" href="#home">Reports 📊
       </a>
      <a style="color: #efefef; padding: 5px 15px; line-height: 40px;" href="#news">News 📜</a>
      <a style="color: #efefef; padding: 5px 15px;line-height: 40px;" href="#contact">Data Dictionary❓</a>
      <a style=" color: #efefef; padding: 5px 15px; line-height: 40px;" href="#about">Contact️ 📒</a>
    </nav>

    </div>
    ;;
    group_label: "Admins Metrics"
  }

  dimension: rank_limit {
    type: number
    group_label: "Admins dim"
    sql: {% parameter max_rank %} ;;
    hidden: yes
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
    sql: ${TABLE}.sum_of_cogs ;;
  }

  measure:: cost {
    label: "Cost"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cost ;;
  }

  measure:: ias_ivt_impression {
    type: sum
    label: "IAS IVT Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_ivt_impression ;;
  }

  measure:: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_measurable_impression ;;
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
    sql: ${TABLE}.sum_of_ias_total_impression ;;
  }

  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_viewable_impression ;;
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
    sql: ${TABLE}.sum_of_video_starts ;;
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
    sql: ${TABLE}.sum_of_impression_pixel ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_win ;;
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
    sql: ${TABLE}.sum_of_requests ;;
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
    value_format: "0.00"
    group_label: "Daily Measures"
    sql: ((${revenue} - ${cogs})/NULLIF(${revenue},0))*100 ;;
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
    sql: ${impression_win}/NULLIF(${responses},0);;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    label: "Bids"
    value_format: "#,##0"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_responses ;;
  }

  measure: revenue {
    type: sum
    label: "Revenue"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_revenue ;;
  }

  measure: Ad_eCPM{
    type: number
    label: "Ad eCPM"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue}/NULLIF((${impression_pixel}/1000),0) ;;
  }


  measure:  Previous_day_Revenue {
    label: "Revenue Previous day "
    type: sum
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "2 days ago"]

  }

  measure:  Previous_day_Requests {
    label: "Requests Previous day "
    type: sum
    sql: ${TABLE}.sum_of_requests ;;
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]


  }
  measure:  Previous_day_impressions {
    label: "Impressions Previous day "
    type: sum
    sql: ${TABLE}.sum_of_impression_pixel ;;
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]

  }
  measure:  previous_day_Bid_Rate {
    label: "Bid Rate Previous day"
    type: sum
    sql: ${TABLE}.sum_of_responses/NULLIF(${TABLE}.sum_of_requests,0) ;;
    value_format: "0.00\%"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]

  }
  measure: previous_day_responses {
    type: sum
    label: "Bids Previous day"
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.dim_of_responses  ;;
    filters: [date_key_date: "2 days ago"]

  }
  measure: prev_Day_net_Revenue {
    type: sum
    label: "Net Revenue Last Day"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.cogs  ;;
    filters: [date_key_date: "2 days ago"]

  }
  measure:  Last_day_Revenue {
    label: "Revenue Last day "
    type: sum
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }
  measure:  Last_day_impressions {
    label: "Impressions Previous day "
    type: sum
    sql: ${TABLE}.sum_of_impression_pixel ;;
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
    hidden: yes
  }
  measure: Last_Day_net_Revenue {
    type: sum
    label: "Net Revenue Last Day"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.sum_of_cogs  ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_bids {
    type: sum
    label: "Bids Last day"
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_responses ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_Requests {
    label: "Requests Last day "
    type: sum
    sql: ${TABLE}.sum_of_requests ;;
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }
  measure:  Last_day_Bid_Rate {
    label: " Bid Rate Last day"
    type: sum
    sql: ${TABLE}.sum_of_responses/NULLIF(${TABLE}.sum_of_requests,0) ;;
    value_format: "0.00\%"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }


  measure: rmp_requests {
    type: sum
    label: "Pub Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_rmp_requests ;;
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
