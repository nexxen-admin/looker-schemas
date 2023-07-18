# The name of this view in Looker is "V Fact Ad Bid Request Daily Agg"
view: fact_ad_bid_request_daily_agg {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Fact_Ad_BidRequest_Daily_Agg ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Size Height Key" in Explore.

  dimension: ad_size_height_key {
    type: number
    sql: ${TABLE}.Ad_Size_Height_Key ;;
    hidden: yes
  }

  dimension: ad_size_width_key {
    type: number
    sql: ${TABLE}.Ad_Size_Width_Key ;;
    hidden: yes
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: data_center_key {
    type: number
    sql: ${TABLE}.DataCenter_Key ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
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

  dimension: dsp_deal_type_key {
    type: number
    sql: ${TABLE}.DSP_Deal_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_filter_reason_key {
    type: number
    sql: ${TABLE}.DSP_Filter_Reason_Key ;;
    hidden: yes
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
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

  dimension: media_name_key {
    type: number
    sql: ${TABLE}.Media_Name_Key ;;
    hidden: yes
  }

  dimension: media_type_key {
    type: number
    sql: ${TABLE}.Media_Type_Key ;;
    hidden: yes
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
    hidden: yes
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
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

  measure: click_count {
    type: sum
    label: "Clicks"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_click_count_from_ad_data ;;
    #hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    description: "Media Cost  (3rd Party SSP or Publisher Cost)"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cogs_from_ad_data ;;
  }


  measure:: cost {
    label: "Cost"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cost ;;
  }

  measure: sum_of_deal_requests_from_bidrequest {
    type: sum
    label: "Deal Requests"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_deal_requests_from_bidrequest ;;
  }


  dimension: sum_of_dsp_deals_count_from_bidrequest {
    type: number
    sql: ${TABLE}.sum_of_dsp_deals_count_from_bidrequest ;;
    hidden: yes
  }

  measure: sum_of_dsp_requests_from_bidrequest {
    type: sum
    label: "Outbound Requests"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_dsp_requests_from_bidrequest ;;
  }

  dimension: sum_of_ias_ivt_impression_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_ias_ivt_impression_from_ad_data ;;
  }

  measure: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_measurable_impression_from_ad_data  ;;
  }

  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Daily Measures"
    sql:  ${TABLE}.sum_of_ias_viewable_impression_from_ad_data ;;
  }

  measure:: ias_viewability {
    type: number
    description: "Analyses the video views amount"
    value_format: "0.00\%"
    label: "IAS Viewability"
    group_label: "Daily Measures"
    sql: ${ias_viewable_impression}/NULLIF(${ias_measurable_impression},0);;
  }

  measure: impression_pixel {
    type: sum
    label: "Impressions"
    description: "Successfully delivered ad impression.   Billable event. ."
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_pixel_from_ad_data ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    description: "The win event is post our bid response back to the publisher/ssp, indicating that we have won the bid in their auction.   "
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_win_from_ad_data ;;
  }

  measure: Pub_eCPM {
    type: number
    label: "Pub eCPM"
    description: "Cogs/Impressions"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: (${cogs}/NULLIF(${impression_pixel},0))*1000 ;;
  }

  dimension: sum_of_media_requests_from_bidrequest {
    type: number
    sql: ${TABLE}.sum_of_media_requests_from_bidrequest ;;

  }

  dimension: sum_of_moat_impressions_ivt_measurable_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_ivt_measurable_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_moat_impressions_viewable_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_viewable_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_pub_cost_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_pub_cost_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_pub_platform_fee_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_pub_platform_fee_from_ad_data ;;
  }

  dimension: sum_of_requests_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_requests_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_requests_from_bidrequest {
    type: number
    sql: ${TABLE}.sum_of_requests_from_bidrequest ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    label: "Bids"
    description: "Bid responses returned from dsps.   There may be more than one bid response per bid request.   "
    value_format: "#,##0"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_responses_from_ad_data ;;
  }

  measure: revenue
  {
    type: sum
    label: "Revenue"
    #sql_distinct_key: ${deal_key} ;;
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_revenue_from_ad_data;;
  }


  dimension: sum_of_rmp_attempts_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_rmp_attempts_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_rmp_requests_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_rmp_requests_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_slot_attempts_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_slot_attempts_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_slot_requests_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_slot_requests_from_ad_data ;;
    hidden: yes
  }


  measure:: video_completes {
    type: sum
    label: "Video Completes"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_completes_from_ad_data ;;
    #hidden: yes
  }
  measure:CTR {
    type: number
    label: "CTR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${click_count}/NULLIF(${impression_pixel},0))*100;;
  }

  measure: VTR {
    type: number
    label: "VTR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${video_completes}/NULLIF(${impression_pixel},0))*100;;
  }

  measure: VCR {
    type: number
    label: "VCR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${video_completes}/NULLIF(${video_starts},0))*100;;

  }

  measure:: video_starts {
    type: sum
    label: "Video Starts"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_starts_from_ad_data ;;
    #hidden: yes
  }

  measure: video_creative_views {
    type: sum
    label: "Video Creative Views"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_creative_views_from_ad_data ;;
    #hidden: yes
  }

  measure: video_errors {
    type: sum
    label: "Video Errors"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_errors_from_ad_data ;;
    #hidden: yes
  }

  measure: Change_Revenue{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Revenue Change Last Day"
    description: "Change in the revenue from yesterday"
    sql: ${revenue_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Impressions{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Impressinos Change Last Day"
    description: "Change in the impressions from yesterday"
    sql: ${impressions_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Bids{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Bids Change Last Day"
    description: "Change in the bids from yesterday"
    sql: ${responses_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Clicks{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Clicks Change Last Day"
    description: "Change in the clicks from yesterday"
    sql: ${clicks_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_VCR{
    type: number
    group_label: "Time Shifted Measures"
    label:  "VCR Change Last Day"
    description: "Change in the VCR from yesterday"
    sql: ${VCR_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Cogs{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Cogs Change Last Day"
    description: "Change in the cogs from yesterday"
    sql: ${cogs_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_CPM{
    type: number
    group_label: "Time Shifted Measures"
    label:  "CPM Change Last Day"
    description: "Change in the CPM from yesterday"
    sql: ${CPM_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Net_Revenue{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Net Revenue Change Last Day"
    description: "Change in the net revenue from yesterday"
    sql: ${Net_Revenue_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Render_Rate{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Render Rate Change Last Day"
    description: "Change in the render rate from yesterday"
    sql: ${Render_Rate_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_CTR{
    type: number
    group_label: "Time Shifted Measures"
    label:  "CTR Change Last Day"
    description: "Change in the CTR from yesterday"
    sql: ${CTR_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: impressions_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_impressions}-${Previous_day_impressions})/ NULLIF(${Previous_day_impressions},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: responses_lastday_change_parameter {
    type: number
    label: "Bids Last Day Change Parameter"
    sql: coalesce((${Last_day_bids}-${previous_day_responses})/ NULLIF(${previous_day_responses},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: clicks_lastday_change_parameter {
    type: number
    label: "Clicks Last Day Change Parameter"
    sql: coalesce((${Last_day_clicks}-${Previous_day_clicks})/ NULLIF(${Previous_day_clicks},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: VCR_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_VCR}-${previous_day_VCR})/ NULLIF(${previous_day_VCR},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: CTR_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_CTR}-${previous_day_CTR})/ NULLIF(${previous_day_CTR},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: cogs_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_cogs}-${Previous_day_cogs})/ NULLIF(${Previous_day_cogs},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: CPM_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_CPM}-${Previous_day_CPM})/ NULLIF(${Previous_day_CPM},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: Net_Revenue_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_Day_net_Revenue}-${prev_Day_net_Revenue})/ NULLIF(${prev_Day_net_Revenue},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: Render_Rate_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_Render_Rate}-${Previous_day_Render_Rate})/ NULLIF(${Previous_day_Render_Rate},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure:  Previous_day_impressions {
    label: "Impressions Previous day "
    type: sum
    description: "The impressions of 2 days ago"
    sql: ${TABLE}.sum_of_impression_pixel_from_ad_data ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]

  }


  measure:  Previous_day_clicks {
    label: "Clicks Previous day "
    type: sum
    description: "The clicks of 2 days ago"
    sql: ${TABLE}.sum_of_click_from_ad_data ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]

  }

  measure:  Last_day_clicks {
    label: "Clicks Last day "
    type: sum
    description: "The clicks of the last day"
    sql: ${TABLE}.sum_of_click_from_ad_data ;;
    group_label: "Time Shifted Measures"
    value_format: "#,##0"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_CPM {
    label: "CPM Last day "
    type: number
    description: "The CPM of the last day"
    sql: (${Last_day_cogs}/NULLIF(${Last_day_impressions},0))*1000 ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    #filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Previous_day_CPM {
    label: "CPM Previous day "
    type: number
    description: "The CPM of 2 days ago"
    sql: (${Previous_day_cogs}/NULLIF(${Previous_day_impressions},0))*1000 ;;
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    #filters: [date_key_date: "2 days ago"]
  }


  measure:  Previous_day_cogs {
    label: "Cogs Previous day "
    type: sum
    description: "The cogs of 2 days ago"
    sql: ${TABLE}.sum_of_cogs_from_ad_data ;;
    value_format: "$#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]
  }

  measure: previous_day_responses {
    type: sum
    label: "Bids Previous day"
    description: "The responses of 2 days ago"
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_responses_from_ad_data  ;;
    filters: [date_key_date: "2 days ago"]

  }

  measure: prev_Day_net_Revenue {
    type: sum
    label: "Net Revenue prev Day"
    description: "The net revenue (difference between revenue and cogs) of 2 days ago"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue_from_ad_data - ${TABLE}.sum_of_cogs_from_ad_data  ;;
    filters: [date_key_date: "2 days ago"]

  }

  measure:  Last_day_cogs {
    label: "Cogs Last day "
    type: sum
    description: "The cogs of the last day"
    sql: ${TABLE}.sum_of_cogs_from_ad_data ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_impressions {
    label: "Impressions Last day "
    type: sum
    description: "The impressions of the last day"
    sql: ${TABLE}.sum_of_impression_pixel_from_ad_data ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_Day_net_Revenue {
    type: sum
    description: "The difference between revenue and cogs of the last day"
    label: "Net Revenue Last Day"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue_from_ad_data - ${TABLE}.sum_of_cogs_from_ad_data  ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_bids {
    type: sum
    description: "The bid reponses of the last day"
    label: "Bids Last day"
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_responses_from_ad_data ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_VCR {
    type: number
    description: "The VCR of the last day"
    label: "VCR Last day"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${Last_day_video_completes}/NULLIF(${Last_day_video_starts},0)) ;;
    #filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_video_completes {
    type: sum
    description: "The video completes of the last day"
    label: "viceo completes Last day"
    #value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_video_completes_from_ad_data ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_video_starts {
    type: sum
    description: "The video starts of the last day"
    label: "video starts Last day"
    #value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_video_starts_from_ad_data ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_CTR {
    type: number
    description: "The CTR of the last day"
    label: "CTR Last day"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${Last_day_click_count}/NULLIF(${Last_day_impressions},0)) ;;
    #filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_click_count{
    type: sum
    description: "The click count of the last day"
    label: "click count Last day"
    #value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_click_count_from_ad_data ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: previous_day_click_count {
    type: sum
    label: "click count Previous day"
    description: "The click count of 2 days ago"
    #value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_click_count_from_ad_data  ;;
    filters: [date_key_date: "2 days ago"]
  }

  measure: previous_day_VCR {
    type: number
    label: "VCR Previous day"
    description: "The VCR of 2 days ago"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${previous_day_video_completes}/NULLIF(${previous_day_video_starts},0))  ;;
    #filters: [date_key_date: "2 days ago"]
  }

  measure: previous_day_video_completes {
    type: sum
    label: "video completes Previous day"
    description: "The video completes of 2 days ago"
    #value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_video_completes_from_ad_data  ;;
    filters: [date_key_date: "2 days ago"]
  }

  measure: previous_day_video_starts{
    type: sum
    label: "video starts Previous day"
    description: "The video starts of 2 days ago"
    #value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_video_starts_from_ad_data  ;;
    filters: [date_key_date: "2 days ago"]
  }

  measure: previous_day_CTR {
    type: number
    label: "CTR Previous day"
    description: "The CTR of 2 days ago"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${previous_day_click_count}/NULLIF(${Previous_day_impressions},0))  ;;
    #filters: [date_key_date: "2 days ago"]

  }


  measure: revenue_comparison {
    type: string
    sql: CASE WHEN ${revenue_lastday_change} > 0.15 THEN "positive"
              WHEN ${revenue_lastday_change} < -0.15 THEN 'negative' ELSE 'none' END ;;
  }



  parameter: choose_filter {
    type: unquoted
    allowed_value: {
      label: "Revenue"
      value: "revenue"
    }
    allowed_value: {
      label: "Positive Change"
      value: "positive_change"
    }

  }

  # measure: positive_change{
  #   type: sum
  #   filters: [revenue_lastday_change: ">=0.15", revenue: ">=1000"]
  #   sql: ${revenue} ;;
  # }

  # measure: dynamic_sum {
  #   type: sum
  #   sql: {% parameter choose_filter %};; #${TABLE}.sum_of_{% parameter choose_filter %}_from_ad_data ;;
  #   value_format_name: "usd"
  # }

  # measure: calculation_filter {
  #   sql: {% if choose_filter._parameter_value == 'revenue' %} ;;
  # }

  measure: revenue_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_Revenue}-${Previous_day_Revenue})/ NULLIF(${Previous_day_Revenue},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure:  Last_day_Revenue {
    label: "Revenue Last day "
    type: sum
    description: "The last day revenue"
    sql: ${TABLE}.sum_of_revenue_from_ad_data ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Previous_day_Revenue {
    label: "Revenue Previous day "
    type: sum
    description: "The revenue of 2 days ago"
    sql: ${TABLE}.sum_of_revenue_from_ad_data ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "2 days ago"]

  }

  measure: revenue_lastday_change {
    type: number
    description: "Change in revenue from 2 days ago to yesterday"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${Last_day_Revenue}/${Previous_day_Revenue})-1 ;;

  }

  measure: revenue_change_from_yesterday_pivot {
    type: number
    description: "Change in revenue from 2 days ago to yesterday"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${revenue} / pivot_offset(${revenue}, 1)) -1 ;;

  }

  measure:  Last_day_Render_Rate {
    label: "Render Rate Last day "
    type: number
    description: "The last day Render Rate"
    sql: ${Last_day_impressions}/NULLIF(${Last_day_bids},0) ;;
    group_label: "Time Shifted Measures"
    value_format: "0.00%"
    #filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Previous_day_Render_Rate{
    label: "Render Rate Previous day "
    type: number
    description: "The Render Rate of 2 days ago"
    sql: ${Previous_day_impressions}/NULLIF(${previous_day_responses},0) ;;
    group_label: "Time Shifted Measures"
    value_format: "0.00%"
    #filters: [date_key_date: "2 days ago"]

  }

  measure: render_rate_lastday_change {
    type: number
    description: "Change in Render Rate from 2 days ago to yesterday"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${Last_day_Render_Rate}/coalesce(${Previous_day_Render_Rate},0))-1 ;;
    hidden: yes
  }


  parameter: choose_measure {
    type: unquoted
    allowed_value: {
      label: "Revenue"
      value: "revenue"
    }
    allowed_value: {
      label: "Positive Change"
      value: "positive_change"
    }

  }

  # dimension: test {

  #   type: yesno
  #   sql:  case when ${revenue_lastday_change} > 0.15 then yes else no end ;;

  #   }


#   measure: positive_change {
#     type: sum
#     filters: [test: "yes"]
#     sql:  ${TABLE}.sum_of_revenue_from_ad_data;;
# }


  dimension: user_matched_key {
    type: number
    sql: ${TABLE}.User_Matched_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
