view: raw_impression {
  label: "Raw Impression Metrics"
  derived_table: {
    sql: SELECT * FROM RAWDB.RAW_IMPRESSION
    WHERE
    {% if dst_epoch_raw_date._is_filtered %}
      epoch::timestamp_ntz >= DATEADD('day', -1, {% date_start dst_epoch_raw_date %}) AND
      epoch::timestamp_ntz < DATEADD('day', 1, {% date_end dst_epoch_raw_date %}) AND
    {% endif %}
    {% if dst_eventtime_date._is_filtered %}
      eventtime >= DATEADD('day', -1, {% date_start dst_eventtime_date %}) AND
      eventtime < DATEADD('day', 1, {% date_end dst_eventtime_date %}) AND
    {% endif %}
    {% if dst_eventtime_time._is_filtered %}
      eventtime >= DATEADD('day', -1, {% date_start dst_eventtime_time %}) AND
      eventtime < DATEADD('day', 1, {% date_end dst_eventtime_time %}) AND
    {% endif %}
    {% if dst_eventtime_week._is_filtered %}
      eventtime >= DATEADD('day', -1, {% date_start dst_eventtime_week %}) AND
      eventtime < DATEADD('day', 1, {% date_end dst_eventtime_week %}) AND
    {% endif %}
    {% if dst_eventtime_month._is_filtered %}
      eventtime >= DATEADD('day', -1, {% date_start dst_eventtime_month %}) AND
      eventtime < DATEADD('day', 1, {% date_end dst_eventtime_month %}) AND
    {% endif %}
    {% if dst_eventtime_quarter._is_filtered %}
      eventtime >= DATEADD('day', -1, {% date_start dst_eventtime_quarter %}) AND
      eventtime < DATEADD('day', 1, {% date_end dst_eventtime_quarter %}) AND
    {% endif %}
    {% if dst_eventtime_year._is_filtered %}
      eventtime >= DATEADD('day', -1, {% date_start dst_eventtime_year %}) AND
      eventtime < DATEADD('day', 1, {% date_end dst_eventtime_year %}) AND
    {% endif %}
    {% if dst_keydate_date._is_filtered %}
      keydate >= DATEADD('day', -1, {% date_start dst_keydate_date %}) AND
      keydate < DATEADD('day', 1, {% date_end dst_keydate_date %}) AND
    {% endif %}
    {% if dst_keydate_week._is_filtered %}
      keydate >= DATEADD('day', -1, {% date_start dst_keydate_week %}) AND
      keydate < DATEADD('day', 1, {% date_end dst_keydate_week %}) AND
    {% endif %}
    {% if dst_keydate_month._is_filtered %}
      keydate >= DATEADD('day', -1, {% date_start dst_keydate_month %}) AND
      keydate < DATEADD('day', 1, {% date_end dst_keydate_month %}) AND
    {% endif %}
    {% if dst_keydate_quarter._is_filtered %}
      keydate >= DATEADD('day', -1, {% date_start dst_keydate_quarter %}) AND
      keydate < DATEADD('day', 1, {% date_end dst_keydate_quarter %}) AND
    {% endif %}
    {% if dst_keydate_year._is_filtered %}
      keydate >= DATEADD('day', -1, {% date_start dst_keydate_year %}) AND
      keydate < DATEADD('day', 1, {% date_end dst_keydate_year %}) AND
    {% endif %}
    1=1 ;;
}
  suggestions: no

  dimension: ad_buyer_id {
    type: string
    description: "The ID of the Ad Buyer"
    view_label: "Supplemental Facets"
    hidden: yes
    sql: ${TABLE}.AD_BUYER ;;
  }

  dimension: space_holder {
    type: number
    label: "Space Holder"
    view_label: "Custom Dimensions"
    sql:'';;
  }

  dimension: space_holder_b {
    type: number
    label: "Space Holder"
    view_label: "Custom Dimensions"
    sql:'';;
  }

  dimension: ad_pod_count {
    type: number
    label: "Ad Pod Count"
    description: "The total number of ads used to fill the Ad Pod."
    sql: ${TABLE}.AD_POD_COUNT ;;
  }

  dimension: ad_pod_duration {
    type: number
    label: "Ad Pod Duration"
    description: "The amount of time left in the Ad Pod after all proceeding requests (the duration available to this request)."
    sql: ${TABLE}.AD_POD_DURATION ;;
  }

  dimension: total_ad_pod_duration {
    type: number
    label: "Total Ad Pod Duration"
    description: "The total amount of time available in the entire ad pod."
    sql: ${ad_pod_duration} + ${ad_pod_total_served_duration} ;;
  }

  dimension: ad_pod_id {
    type: string
    label: "Ad Pod ID"
    description: "The unique ID of the Ad Pod"
    sql: ${TABLE}.AD_POD_ID ;;
  }

  dimension: ad_pod_position {
    type: number
    label: "Ad Pod Position"
    description: "The total place in the ad pod for this ad, starting with the number 1."
    sql: ${TABLE}.AD_POD_POSITION ;;
  }

  dimension: ad_pod_total_served_duration {
    type: number
    label: "Ad Pod Served Duration"
    description: "For the given request, how much of the pod has already been filed."
    sql: ${TABLE}.AD_POD_TOTAL_SERVED_DURATION ;;
  }

  dimension: ad_size {
    type: string
    label: "Ad Size"
    description: "The size of the displayed Ad."
    sql: ${TABLE}.AD_SIZE ;;
  }

  dimension: adid {
    type: string
    label: "Ad ID"
    description: "The unique ID for each ad shown"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.ADID ;;
  }

  dimension: adserver_code {
    type: string
    label: "Rejection Code"
    view_label: "Supplemental Facets"
    description: "The logged code identifying the reason the request was not served"
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -12 then 'Internal Bidding Failed'
      WHEN ${TABLE}.ADSERVER_CODE = -10 then 'Campaign Domain Targeting Failed'
      WHEN ${TABLE}.ADSERVER_CODE = -11 then 'FlightMedia Bot Prevention'
      WHEN ${TABLE}.ADSERVER_CODE = 1 then 'Served'
      WHEN ${TABLE}.ADSERVER_CODE = -9 then 'Bot Rejection'
      WHEN ${TABLE}.ADSERVER_CODE = -3 then 'Overage Shutoff'
      WHEN ${TABLE}.ADSERVER_CODE = -2 then 'Blacklist'
      WHEN ${TABLE}.ADSERVER_CODE = -1 then 'Whitelist'
      WHEN ${TABLE}.ADSERVER_CODE = 0 then 'Passback - General'
      WHEN ${TABLE}.ADSERVER_CODE = -6 then 'Bad Geo'
      WHEN ${TABLE}.ADSERVER_CODE = -4 then 'Network Redirect'
      WHEN ${TABLE}.ADSERVER_CODE = -5 then 'Offset weight pacing'
      WHEN ${TABLE}.ADSERVER_CODE = -7 then 'Placement Freq Cap'
      WHEN ${TABLE}.ADSERVER_CODE = -13 then 'No Consent'
      ELSE 'Other'
      End
      ;;
  }

  dimension: adserving_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.ADSERVING_COST ;;
  }

  measure: sum_adserving_cost {
    type: sum
    label: "Adserving Costs"
    description: "Total of all Adserving Costs"
    value_format_name: decimal_2
    sql: ${adserving_cost} ;;
  }

  dimension: adserving_cost_currency {
    type: string
    description: "The native currency of the adserving costs"
    sql: ${TABLE}.ADSERVING_COST_CURRENCY ;;
  }

  dimension: adserving_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.ADSERVING_COST_MARKUP ;;
  }

  measure: sum_adserving_cost_markup {
    type: sum
    label: "Adserving Costs Markup"
    description: "Total of all markups on Adserving Costs"
    value_format_name: decimal_2
    sql: ${adserving_cost_markup} ;;
  }


  dimension: age {
    type: string
    label: "Age"
    hidden: no
    sql: public.f_attr_lookup(${TABLE}.AGE) ;;
  }

  dimension: age_description {
    type: string
    label: "Age"
    view_label: "Supplemental Facets"
    description: "The age of the person who saw the ad, this could be known or unknown"
    sql: ${TABLE}.AGE_DESCRIPTION ;;
  }

  dimension: agency_fee {
    type: string
    hidden: yes
    sql: ${TABLE}.AGENCY_FEE ;;

  }

  dimension: pk_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK_ID ;;
  }

  dimension: asset_group_ids {
    type: string
    hidden: yes
    sql: ${TABLE}.ASSET_GROUP_IDS ;;
  }

  dimension: asset_group_restricted_clearcast_codes {
    type: string
    hidden: yes
    sql: ${TABLE}.ASSET_GROUP_RESTRICTED_CLEARCAST_CODES ;;
  }

  dimension: asset_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ASSET_ID ;;
  }

  dimension: attributes {
    type: string
    hidden: yes
    sql: ${TABLE}.ATTRIBUTES ;;
  }

  dimension: autoplay {
    type: number
    hidden: yes
    sql: ${TABLE}.AUTOPLAY ;;
  }

  measure: sum_autoplay {
    type: sum
    label: "Autoplay"
    description: "The number of impressions that were autoplay impressions (not click to play)."
    #hidden: yes
    sql: ${TABLE}.AUTOPLAY ;;
  }


  dimension: awsregion {
    type: number
    label: "AWS Region"
    view_label: "Supplemental Facets"
    description: "The ad request was captured in this AWS adserver region."
    sql: ${TABLE}.AWSREGION ;;
  }

  dimension: bid {
    type: number
    label: "Bid Price"
    description: "Price of a bid"
    sql: ${TABLE}.BID ;;
  }

  measure: avg_bid_price {
    type: average
    label: "Average Bid Price"
    description: "The average price of all bids."
    value_format_name: decimal_2
    sql: ${bid} ;;
  }

  dimension: bid_currency {
    type: string
    description: "The native currency of the bid"
    sql: ${TABLE}.BID_CURRENCY ;;
  }


  dimension: bid_schedule_id {
    type: number
    hidden: yes
    sql: ${TABLE}.BID_SCHEDULE_ID ;;
  }

  dimension: billable_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.BILLABLE_IMPRESSIONS ;;
  }

  measure: sum_billable_impressions {
    type: sum
    label: "Billable Impressions"
    description: "The number of impressions that were billable to the client"
    value_format_name: decimal_0
    sql: ${billable_impressions} ;;
  }

  dimension: billable_units {
    type: number
    hidden: yes
    sql: case when ${campaign_details_base.cpu_type_id} in (4,5) then ${TABLE}.DEMAND_REVENUE else ${TABLE}.BILLABLE_UNITS end ;;
  }

  measure: sum_billable_units {
    type: sum
    label: "Billable Units"
    description: "The number of units that were billable to the client.  The unit will depend on the CPU type."
    value_format_name: decimal_0
    sql: ${billable_units};;
    }

  dimension: browser {
    type: string
    view_label: "Supplemental Facets"
    description: "The browser which was used to view the impression"
    sql: prod.public.f_attr_lookup(${TABLE}.BROWSERID) ;;
  }

  dimension: browserid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.BROWSERID ;;
  }

  dimension: bt_cluster_attribute {
    type: number
    description: "The attribute used in determining the BT Cluster Costs."
    label: "BT Cluster Attribute"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.BT_CLUSTER_ATTRIBUTE ;;
  }

  dimension: bt_cluster_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.BT_CLUSTER_COST ;;
  }

  measure: sum_bt_cluster_cost {
    type: sum
    label: "BT Cluster Costs"
    description: "The total of all BT Cluster Costs"
    value_format_name: decimal_2
    sql: ${bt_cluster_cost} ;;
  }

  dimension: bt_cluster_cost_currency {
    type: string
    label: "BT Cluster Cost Currency"
    description: "The currency of the BT cluster cost"
    sql: ${TABLE}.BT_CLUSTER_COST_CURRENCY ;;
  }

  dimension: bt_cluster_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.BT_CLUSTER_COST_MARKUP ;;
  }

  measure: sum_bt_cluster_cost_markup {
    type: sum
    label: "BT Cluster Cost Markup"
    value_format_name: decimal_2
    description: "The total of all markups on BT cluster costs"
    sql: ${bt_cluster_cost_markup} ;;
  }

  dimension: bt_cluster_provider {
    type: string
    view_label: "Supplemental Facets"
    hidden: yes
    description: "The Data Provider used in creating the BT Cluster"
    sql: ${TABLE}.BT_CLUSTER_PROVIDER ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: category {
    type: string
    hidden: yes
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: clearing_price {
    type: number
    hidden: yes
    sql: ${TABLE}.CLEARING_PRICE ;;
  }

  measure: avg_clearing_price {
    type: number
    label: "Average Clearing Price"
    description: "The Average Clearing Price for impressions"
    value_format_name: decimal_2
    sql: COALESCE((1.0 * ${clearing_price_sum}) / NullIF(${sum_cost_units},0),0)  ;;
  }

  measure: clearing_price_sum {
    type: sum
    label: "Total Clearing Price"
    hidden: yes
    value_format_name: decimal_2
    sql: ${clearing_price} ;;
  }

  measure: sum_clearing_price {
    type: sum
    label: "Total Clearing Price"
    description: "Total Clearing Price of all bids [Clearing Price * Cost Units]"
    value_format_name: decimal_2
    sql: COALESCE((1.0 * ${TABLE}.CLEARING_PRICE) * NULLIF(${TABLE}.COST_UNITS,0),0) ;;
  }


  dimension: click_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICK_IMPRESSIONS ;;
  }

  measure: sum_click_impressions {
    type: sum
    label: "Click Impressions"
    description: "The total of all impressions where clicks are tracked"
    value_format_name: decimal_0
    sql: ${click_impressions} ;;
  }

  measure: ctr {
    type: number
    label: "CTR"
    description: "Click Thru Rate - The number of clicks / the number of click impressions"
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_clicks}/NULLIF(${sum_click_impressions},0),0);;
  }

  dimension: click_to_play {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICK_TO_PLAY ;;
  }

  measure: sum_clicktoplay {
    type: sum
    label: "Click to Play"
    description: "The total of all impressions that were Click to Play, not autoplay."
    value_format_name: decimal_0
    sql: ${click_to_play} ;;
  }

  dimension: clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.clicks ;;
  }

  measure: sum_clicks {
    type: sum
    label: "Clicks"
    description: "The total of all clicks (where an impression was clicked upon)."
    value_format_name: decimal_0
    sql: ${clicks} ;;
  }

  dimension: clock_number {
    type: string
    label: "Clock Number"
    view_label: "Supplemental Facets"
    description: "The clock number associated with the impression"
    sql: ${TABLE}.CLOCK_NUMBER ;;
  }

  dimension: clock_number_clearcast_codes {
    type: string
    label: "Clock Number Clearcast Code"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.CLOCK_NUMBER_CLEARCAST_CODES ;;
  }

  dimension: cluster_matched_attributes {
    type: string
    hidden: yes
    sql: ${TABLE}.CLUSTER_MATCHED_ATTRIBUTES ;;
  }

  dimension: clusterid {
    type: number
    label: "Cluster ID"
    view_label: "Supplemental Facets"
    description: "The unique identifier for the cluster"
    value_format_name: id
    sql: ${TABLE}.CLUSTERID ;;
  }

  dimension: companion_media {
    type: string
    label: "Companion Media ID"
    view_label: "Supplemental Facets"
    description: "The ID of the Companion Media."
    sql: ${TABLE}.COMPANION_MEDIA ;;
  }

  dimension: completed_100 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_100 ;;
  }

  measure: sum_completed_100 {
    type: sum
    label: "Completed 100"
    description: "The total of all impression which were 100% completed."
    value_format_name: decimal_0
    sql: ${completed_100} ;;
  }

  measure: completed_100_pct {
    type: number
    label: "Completed 100%"
    description: "The percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100} / nullif(${sum_completed_pct_impressions},0),0) ;;
  }

  dimension: completed_25 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_25 ;;
  }

  measure: sum_completed_25 {
    type: sum
    label: "Completed 25"
    description: "The total of all impression which were 25% completed."
    value_format_name: decimal_0
    sql: ${completed_25} ;;
  }

  measure: abs_completed_25 {
    type: sum
    description: "The sum of completed 25 used in calculating VCR."
    label: "Completed 25 only"
    value_format_name: decimal_0
    sql: ${completed_25} ;;
  }

  measure: completed_25_pct {
    type: number
    label: "Completed 25%"
    description: "The percentage of all impression which were 25% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0* (${sum_completed_25}+${sum_completed_50}+${sum_completed_75}+${sum_completed_100})) /nullif(${sum_completion_pct_impressions},0),0);;
  }

  dimension: completed_50 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_50 ;;
  }

  measure: sum_completed_50 {
    type: sum
    label: "Completed 50"
    description: "The total of all impression which were 50% completed."
    value_format_name: decimal_0
    sql: ${completed_50} ;;
  }

  measure: abs_completed_50 {
    type: sum
    description: "The sum of completed 50 used in calculating VCR."
    label: "Completed 50 only"
    value_format_name: decimal_0
    sql: ${completed_50} ;;
  }

  measure: completed_50_pct {
    type: number
    label: "Completed 50%"
    description: "The percentage of all impression which were 50% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0 * (${sum_completed_50}+${sum_completed_75}+${sum_completed_100})) / nullif(${sum_completion_pct_impressions},0),0) ;;
  }

  dimension: completed_75 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_75 ;;
  }

  measure: sum_completed_75 {
    type: sum
    label: "Completed 75"
    description: "The total of all impression which were 75% completed."
    value_format_name: decimal_0
    sql: ${completed_75} ;;
  }

  measure: abs_completed_75 {
    type: sum
    description: "The sum of completed 75 used in calculating VCR."
    label: "Completed 75 only"
    value_format_name: decimal_0
    sql: ${completed_75} ;;
  }

  measure: completed_75_pct {
    type: number
    label: "Completed 75%"
    description: "The percentage of all impression which were 75% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0 * (${sum_completed_75}+${sum_completed_100})) / nullif(${sum_completion_pct_impressions},0),0) ;;
  }

  dimension: completed_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_PCT_IMPRESSIONS ;;
  }

  measure: sum_completed_pct_impressions {
    type: sum
    label: "Completed Percent Impressions"
    description: "The total number of impression where completed (completed 100) is measured."
    value_format_name: decimal_0
    sql: ${completed_pct_impressions} ;;
  }

  dimension: completion_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETION_PCT_IMPRESSIONS ;;
  }

  measure: sum_completion_pct_impressions {
    type: sum
    label: "Completion Percent Impressions"
    description: "The total of impressions where completion percentage is measured.
    This is used in calculating the various completion percentages, and VCR"
    value_format_name: decimal_0
    sql: ${completion_pct_impressions} ;;
  }

  measure: VTR {
    type: number
    label: "VTR"
    description: "Video Through Rate - the percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100} / nullif(${sum_completed_pct_impressions},0),0) ;;
  }

  measure: VCR {
    type: number
    label: "VCR"
    description: "Video Completed Rate - The avarage completion rate of the impression."
    value_format_name: percent_2
    sql: COALESCE(((${abs_completed_25}*.25) + (${abs_completed_50} *.50) + (${abs_completed_75} *.75)
      + (${sum_completed_100} *1.0)) / nullif(${sum_completion_pct_impressions},0),0) ;;
  }


  dimension: content_verification_code {
    type: string
    label: "Content Verification Code"
    description: "Request response from WhiteOps (ex. Bot, Not Bot, Throttled)"
    view_label: "Supplemental Facets"
    sql: CASE WHEN ${TABLE}.CONTENT_VERIFICATION_CODE = 8000 THEN 'WhiteOps Timeout'
      WHEN ${TABLE}.CONTENT_VERIFICATION_CODE = 8001 THEN 'WhiteOps Error'
      WHEN ${TABLE}.CONTENT_VERIFICATION_CODE = 8002 THEN 'WhiteOps Bot'
      WHEN ${TABLE}.CONTENT_VERIFICATION_CODE = 8003 THEN 'WhiteOps Not Bot'
      WHEN ${TABLE}.CONTENT_VERIFICATION_CODE = 8004 THEN 'WhiteOps Throttled'
      ELSE 'Unknown'
      End
      ;;
  }

  dimension: cost_units {
    type: number
    hidden: yes
    sql: ${TABLE}.COST_UNITS ;;
  }

  measure: sum_cost_units {
    type: sum
    label: "Cost Units"
    description: "The total units which attribute to the cost of media"
    value_format_name: decimal_0
    sql: ${cost_units} ;;
  }

  dimension: country {
    type: string
    label: "Country Code"
    view_label: "Supplemental Facets"
    description: "The country code where the request was placed"
    #hidden: yes
    sql: ${TABLE}.COUNTRY ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.country
  }


  dimension: country_name {
    type: string
    label: "Country"
    view_label: "Supplemental Facets"
    description: "The country where the request was placed"
    sql: ${TABLE}.COUNTRY_DESCRIPTION ;;

  }

  dimension: cs_referer_url {
    type: string
    label: "CS Referer URL"
    view_label: "Supplemental Facets"
    description: "URL where the impression was seen as it comes from clickstream log."
    sql: ${TABLE}.CS_REFERER_URL ;;
  }

  dimension: currency_metrics {
    type: string
    label: "KPI Metrics"
    description: "3rd Party KPI Metrics"
    sql: ${TABLE}.CURRENCY_METRICS ;;
  }

  dimension: currency_vendors {
    type: string
    label: "KPI Vendors"
    description: "3rd Party KPI Vendors"
    sql: ${TABLE}.CURRENCY_VENDORS ;;
  }

   dimension: day_abbreviation {
    type: string
    hidden: yes
    sql: ${TABLE}.DAY_ABBREVIATION ;;
  }

  dimension: day_of_week {
    type: string
    label: "Day of Week"
    view_label: "Supplemental Facets"
    description: "The day of the week that the viewer saw the impression, based on the viewer's local time."
    sql: ${TABLE}.DAY_OF_WEEK ;;
  }

  dimension: daypart {
    type: number
    hidden: yes
    sql: ${TABLE}.DAYPART ;;
  }

  dimension: daypart_description {
    type: string
    view_label: "Supplemental Facets"
    description: "The daypart (day and time) that a request was served.
    This is based on the day and time of the viewer."
    sql: ${TABLE}.DAYPART_DESCRIPTION ;;
  }

  dimension: deal_causing_house {
    type: string
    label: "Deal Causing House"
    view_label: "Supplemental Facets"
    description: "The ID of the deal which caused a house impression to be shown."
    sql: ${TABLE}.DEAL_CAUSING_HOUSE ;;
  }

  dimension: decisionattributes {
    type: string
    label: "Decision Attributes"
    view_label: "Supplemental Facets"
    description: "The attributes used in decisioning the ad to be shown."
    sql: ${TABLE}.DECISIONATTRIBUTES ;;
  }

  dimension: demand_adserving_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_ADSERVING_COST ;;
  }

  measure: sum_demand_adserving_cost {
    type: sum
    label: "Adserving Cost - Demand Currency"
    description: "The total adserving costs converted from the native currency to the demand currency."
    value_format_name: decimal_2
    sql: ${demand_adserving_cost} ;;
  }

dimension: demand_bt_cluster_cost {
  type: number
  hidden: yes
  sql: ${TABLE}.DEMAND_BT_CLUSTER_COST ;;
}

measure: sum_demand_bt_cluster_cost {
  type: sum
  label: "BT Cluster Costs - Demand Currency"
  description: "The total BT Cluster costs converted from the native currency to the demand currency."
  value_format_name: decimal_2
  sql: ${demand_bt_cluster_cost};;
}

dimension: demand_currency {
  type: string
  description: "The currency of demand partner."
  sql: ${TABLE}.DEMAND_CURRENCY ;;
}

 dimension: raw_demand_date {
  type: date
  label: "Demand Date (raw)"
  view_label: "Raw Impression Dates"
  description: "The raw Date the event occured in the demand timezone"
  sql: ${TABLE}.DEMAND_DATE ;;
}

dimension_group: demand_date {
  type: time
  label: "Demand"
  view_label: "Raw Impression Dates"
  timeframes: [date,month,year,raw]
  description: "The date of the impression in the Demand timezone"
  sql: ${TABLE}.DEMAND_DATE ;;
}

dimension_group: local_demand_date {
    type: time
    label: "Local Demand"
    view_label: "Raw Impression Dates"
    timeframes: [date,month,year,raw]
    description: "The date of the impression in the Demand timezone in accordance with season clock shift"
    sql: ${TABLE}.LOCAL_DEMAND_DATE ;;
  }
  dimension: demand_demo_provider_cost {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_DEMO_PROVIDER_COST ;;
  }

  measure: sum_demand_demo_provider_cost {
    type: sum
    label: "Demo Cost - Demand"
    description: "The total Demo costs converted from native currency to the demand currency."
    value_format_name: decimal_2
    sql: ${demand_demo_provider_cost} ;;
  }

   dimension: demand_payout {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_PAYOUT ;;
  }

  measure: sum_demand_payout {
    type: sum
    label: "Gross Payout Minus IBMM - Demand"
    description: "The payout including Exchange fee or media_price minus IBMM converted to the demand currency"
    value_format_name: decimal_2
    sql: ${demand_payout} ;;
  }

 dimension: demand_revenue {
  type: number
  hidden: yes
  sql: ${TABLE}.DEMAND_REVENUE ;;
}

measure: sum_demand_revenue {
  type: sum
  label: "Net Spend"
  description: "Total Net Spend in Demand Currency"
  value_format_name: decimal_2
  sql: ${demand_revenue} ;;
}

  dimension: demand_sample {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_SAMPLE ;;
  }

  dimension: demand_timezone {
    type: number
    label: "Demand Timezone"
    description: "The timezone that the campaign is setup to run in."
    view_label: "Raw Impression Dates"
    sql: ${TABLE}.DEMAND_TIMEZONE ;;
  }

  dimension: supply_timezone {
    type: number
    label: "Supply Timezone"
    view_label: "Raw Impression Dates"
    description: "The timezone that the publisher of the ad is setup in."
    sql: ${TABLE}.SUPPLY_TIMEZONE ;;
  }

  dimension: tracking_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_TRACKING_COST ;;
  }

  measure: sum_tracking_cost {
    type: sum
    label: "Tracking Cost"
    value_format_name: decimal_2
    description: "The total of all tracking costs in native currency."
    sql: ${tracking_cost};;
  }

    dimension: demo_markup {
      type: string
      hidden:  yes
      sql: ${TABLE}.DEMO_MARKUP ;;
    }

    measure: sum_demo_markup {
      type: sum
      label: "Demo Cost Markup"
      description: "The total of markups on Demo Costs"
      value_format_name: decimal_2
      sql: ${demo_markup} ;;
    }

  dimension: demo_provider_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMO_PROVIDER_COST ;;
  }

  measure: sum_demo_provider_cost {
    type: sum
    label: "Demo Provider Costs"
    description: "The sum of all demo provider costs"
    sql: ${demo_provider_cost} ;;
  }

   dimension: demo_provider_cost_currency {
    type: string
    label: "Demo Cost Currency"
    description: "The currency of the Demo Costs"
    sql: ${TABLE}.DEMO_PROVIDER_COST_CURRENCY ;;
  }

  dimension: demoproviderid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.DEMOPROVIDERID ;;
  }

  dimension: device_description {
    type: string
    label: "Device"
    view_label: "Supplemental Facets"
    description: "The name of the device where the impression was seen."
    sql: prod.public.f_attr_lookup(${TABLE}.DEVICEID) ;;
    suggestable: no
  }

  dimension: deviceid {
    type: number
    label: "Device Id"
    view_label: "Supplemental Facets"
    description: "The name of the device where the impression was seen."
    value_format_name: id
    sql: ${TABLE}.DEVICEID ;;
  }

  dimension: devicetype {
    type: number
    hidden: yes
    sql: ${TABLE}.DEVICETYPE ;;
  }

  dimension: diagnostic_code {
    type: string
    label: "Diagnostic Code"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.DIAGNOSTIC_CODE ;;
  }

  dimension: distinct_clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.DISTINCT_CLICKS ;;
  }

  measure: sum_distinct_clicks {
    type: sum
    label: "Distinct Clicks"
    description: "The total of all distinct clicks"
    value_format_name: decimal_0
    sql: ${distinct_clicks} ;;
  }

  dimension: distinctimpressionpings {
    type: number
    hidden: yes
    sql: ${TABLE}.DISTINCTIMPRESSIONPINGS ;;
  }

  measure: sum_distinctimpressionpings {
    type: sum
    label: "Distinct Impression Pings"
    description: "The sum of Distinct Impression Pings."
    sql: ${distinctimpressionpings} ;;
  }

  dimension: dma {
    type: string
    #hidden: yes
    label: "DMA Code"
    view_label: "Supplemental Facets"
    description: "The code for the Designated Marketing Area (DMA)"
    sql: ${TABLE}.DMA ;;
  }

  dimension: dma_description {
    type: string
    label: "DMA"
    view_label: "Supplemental Facets"
    description: "Designated Marketing Area (DMA)"
    sql: ${TABLE}.DMA_DESCRIPTION ;;
  }

  dimension: domain_hash {
    type: string
    hidden:yes
    sql: ${TABLE}.DOMAIN_HASH ;;
  }

  dimension: domain_url {
    type: string
    view_label: "Supplemental Facets"
    label: "Domain URL"
    description: "The domain of the URL (xyz.com) where the impression was seen."
    sql: CASE WHEN ${TABLE}.TRANSPARANCY_TYPE = 1 AND ${TABLE}.IS_MOBILE_APP != 1 THEN ${TABLE}.DOMAIN_URL
              WHEN ${TABLE}.IS_MOBILE_APP = 1 AND ${TABLE}.TRANSPARANCY_TYPE = 1 THEN ${TABLE}.APP_BUNDLE
              ELSE '' END ;;
  }

  dimension: domain_url_transparent {
    type: string
    view_label: "Supplemental Facets"
    label: "Domain URL (transparent)"
    description: "The transparent domain of the URL (xyz.com) where the impression was seen."
    sql: CASE WHEN ${TABLE}.IS_MOBILE_APP = 1 THEN ${TABLE}.APP_BUNDLE ELSE ${TABLE}.DOMAIN_URL END;;
  }

  dimension: domainid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.DOMAINID ;;
  }

  dimension: duration {
    type: number
    label: "Duration"
    view_label: "Supplemental Facets"
    description: "The duration of the ad."
    sql: ${TABLE}.DURATION ;;
  }

  dimension: dvid {
    type: string
    label: "DVID"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.DVID ;;
  }

  measure: dvid_cnt_distinct {
    type: count_distinct
    label: "Distinct DVIDs"
    description: "The count of distinct DVIDs."
    sql: ${TABLE}.DVID ;;
  }
  measure: dvid_cnt {
    type: sum
    label: "Total DVIDs Received"
    description: "The count of  DVIDs."
    sql: case when ${TABLE}.DVID is null then 0 else 1 end ;;
  }

  measure: userid_cnt {
    type: count_distinct
    label: "Distinct User Ids"
    description: "The count of distinct User IDs."
    sql: ${TABLE}.USERID ;;
  }

  dimension: effective_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.EFFECTIVE_IMPRESSIONS ;;
  }

  measure: sum_effective_impressions {
    type: sum
    label: "Effective Impression"
    description: "The total of all impression which were in target."
    value_format_name: decimal_0
    sql: ${effective_impressions} ;;
  }

  dimension: effective_units {
    type: number
    hidden: yes
    sql: ${TABLE}.EFFECTIVE_UNITS ;;
  }

  measure: sum_effective_units {
    type: sum
    label: "Effective Units"
    description: "The total number of units which were in target."
    value_format_name: decimal_0
    sql: ${effective_units} ;;
  }

  dimension: epoch {
    type: number
    hidden: yes
    sql: ${TABLE}.EPOCH ;;
  }



  dimension_group: epoch {
    type: time
    hidden: no
    datatype: epoch
    label: "Request"
    view_label: "Raw Impression Dates"
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${epoch} ;;
    description: "The date/time of the request in UTC."
  }

  dimension: epoch_raw_date {
    type: date_time
    datatype: epoch
    label: "Event Time (Raw)"
    view_label: "Raw Impression Dates"
    description: "The date/time of the request in UTC. Includes minute and second."
    sql: ${epoch_raw} ;;
  }

  dimension: dst_epoch_raw_date {
    type: date_time
    label: "[DST] Local Event Time (RAW)"
    view_label: "Raw Impression Dates"
    description: "The date/time of the request in local time accounting DST. Includes minute and second."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.EPOCH::timestamp_ntz)
      else ${TABLE}.EPOCH::timestamp_ntz end ;;
  }

  dimension_group: eventtime {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Event Time"
    view_label: "Raw Impression Dates"
    sql: ${TABLE}.EVENTTIME ;;
  }

  dimension_group: dst_eventtime {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "[DST] Local Event Time"
    view_label: "Raw Impression Dates"
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.EVENTTIME)
      else ${TABLE}.EVENTTIME end ;;
  }

  dimension: exchange_fee {
    type: string
    hidden: yes
    sql: ${TABLE}.EXCHANGE_FEE ;;
  }

  measure: sum_exchange_fee {
    type: sum
    label: "Exchange Fee"
    description: "The total costs incurred from the exchange fee"
    value_format_name: decimal_2
    sql: ${TABLE}.EXCHANGE_FEE ;;
  }

  dimension: exchange_floor_price {
    type: number
    label: "Exchange Floor Price"
    description: "The floor price of the exchange.  The miminual value of an ad."
    view_label: "Supplemental Facets"
    sql: ${TABLE}.EXCHANGE_FLOOR_PRICE ;;
  }

  dimension: exchangeid {
    type: number
    label: "Exchange ID"
    description: "The unique identifier of the exchange where the ad was served (if applicable)."
    view_label: "Supplemental Facets"
    value_format_name: id
    sql: ${TABLE}.EXCHANGEID ;;
  }

  dimension: exposure_action_pixels {
    type: string
    hidden: yes
    sql: ${TABLE}.EXPOSURE_ACTION_PIXELS ;;
  }

  dimension: fallbacktype {
    type: string
    hidden: yes
    sql: ${TABLE}.FALLBACKTYPE ;;
  }

  dimension: flight {
    type: string
    label: "Flight ID"
    description: "The ID of the Flight that was served in the impression."
    hidden: yes
    sql: ${TABLE}.FLIGHT ;;
  }

  dimension: flight_media {
    type: string
    #hidden: yes
    label: "Flight Media ID"
    description: "The ID of the flight media that was served in the impression."
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID;;
  }


  dimension: format_type {
    type: number
    hidden: yes
    sql: ${TABLE}.FORMAT_TYPE ;;
  }

  dimension: freq_cap_info {
    type: string
    label: "Frequency Cap"
    description: "The frequency Cap information."
    view_label: "Supplemental Facets"
    sql: ${TABLE}.FREQ_CAP_INFO ;;
  }

  dimension: gender {
    type: string
    label: "Gender"
    hidden: no
    sql: public.f_attr_lookup(${TABLE}.GENDER)  ;;
  }

  dimension: gender_description {
    type: string
    label: "Gender"
    view_label: "Supplemental Facets"
    description: "The gender of the person who saw the impression."
    sql: ${TABLE}.GENDER_DESCRIPTION ;;
  }


  dimension: geoid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.GEOID ;;
  }

  dimension: historic_viewability {
    type: number
    hidden: yes
    sql: ${TABLE}.HISTORIC_VIEWABILITY ;;
  }

  dimension: host {
    type: string
    hidden: yes
    sql: ${TABLE}.HOST ;;
  }

  dimension: hour_description {
    type: string
    label: "Hour Description"
    hidden: yes
    sql: ${TABLE}.HOUR_DESCRIPTION ;;
  }

  dimension: hour_of_day {
    type: number
    hidden: yes
    sql: ${TABLE}.HOUR_OF_DAY ;;
  }

  dimension: house_reason_code {
    type: string
    label: "House Reason Code"
    description: "The reason a house ad was shown."
    view_label: "Supplemental Facets"
    sql: ${TABLE}.HOUSE_REASON_CODE ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  measure: sum_impressions {
    type: sum
    label: "Impressions"
    description: "The total impressions"
    value_format_name: decimal_0
    sql: ${impressions} ;;
  }

  dimension: inferred_age {
    type: number
    hidden: yes
    sql: ${TABLE}.INFERRED_AGE ;;
  }

  dimension: inferred_age_description {
    type: string
    label: "Inferred Age"
    view_label: "Supplemental Facets"
    description: "The age group of the viewer of the ad as inferred by the cluster used."
    sql: ${TABLE}.INFERRED_AGE_DESCRIPTION ;;
  }

  dimension: inferred_gender {
    type: number
    hidden: yes
    sql: ${TABLE}.INFERRED_GENDER ;;
  }

  dimension: inferred_gender_description {
    type: string
    label: "Inferred Gender"
    view_label: "Supplemental Facets"
    description: "The gender of the viewer of the ad as inferred by the cluster used."
    sql: ${TABLE}.INFERRED_GENDER_DESCRIPTION ;;
  }

  dimension: internal_clearing_price {
    type: number
    hidden: yes
    sql: ${TABLE}.INTERNAL_CLEARING_PRICE ;;
  }

  dimension: ip {
    type: string
    hidden: yes
    sql: ${TABLE}.IP ;;
  }

  dimension: ip_exposed {
    type: string
    label: "IP Address"
    description: "IP Address for US consumers, obfuscated IP for all other consumers."
    view_label: "Supplemental Facets"
    sql: CASE WHEN ${country} = 'US' THEN ${ip} ELSE reverse(substring(reverse(${ip}), position('.', reverse(${ip})) + 1)) END   ;;
  }

  dimension: is_known_demo {
    type: yesno
    label: "Is Known Demo"
    description: "A yes/no indiciatior if the demo is known."
    view_label: "Supplemental Facets"
    sql: ${TABLE}.IS_KNOWN_DEMO ;;
  }

  dimension: is_postalcode_targeted {
    type: yesno
    label: "Is Postal Code Targeted"
    view_label: "Supplemental Facets"
    description: "A yes/no indicator if a postal code was targeted in serving the ad."
    sql: ${TABLE}.IS_POSTALCODE_TARGETED ;;
  }

  dimension: ip_last_octet_dropped {
    type: string
    label: "IP Last Octet Dropped"
    description: "Ip address where last octet is dropped."
    sql: reverse(substring(reverse(${ip}), position('.', reverse(${ip})) + 1)) ;;
  }

  dimension: is_viewability_measurable {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABILITY_MEASURABLE ;;
  }

  measure: sum_is_viewability_measurable {
    type: sum
    label: "Viewablity Measurable"
    description: "The total of all impressions where viewablity is measurable"
    value_format_name: decimal_0
    sql: ${is_viewability_measurable} ;;
  }

  dimension: is_viewable_100 {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABLE_100 ;;
  }

  measure: sum_is_viewable_100 {
    type: sum
    label: "Viewable 100"
    description: "The number of impressions that were viewable for 100% of the impression."
    value_format_name: decimal_0
    sql: ${is_viewable_100} ;;
   }

  dimension: is_viewable_25 {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABLE_25 ;;
  }

  measure: sum_is_viewable_25 {
    type: sum
    label: "Viewable 25"
    description: "The number of impressions that were viewable for 25% of the impression."
    value_format_name: decimal_0
    sql: ${is_viewable_25} ;;
   }

  measure: pct_is_viewable_25 {
    type: number
    label: "Viewable 25%"
    description: "The percent of impressions that were viewable for 25% of the impression."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_is_viewable_25} / nullif(${sum_is_viewability_measurable},0),0);;
  }

  dimension: is_viewable_50 {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABLE_50 ;;
  }

  measure: sum_is_viewable_50 {
    type: sum
    label: "Viewable 50"
    description: "The number of impressions that were viewable for 50% of the impression."
    value_format_name: decimal_0
    sql: ${is_viewable_50} ;;
  }

  measure: pct_is_viewable_50 {
    type: number
    label: "Viewable 50%"
    description: "The percent of impressions that were viewable for 50% of the impression."
    value_format_name: percent_2
    sql:COALESCE( 1.0 * ${sum_is_viewable_50} / nullif(${sum_is_viewability_measurable},0),0);;
  }

  dimension: is_viewable_75 {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABLE_75 ;;
  }

  measure: sum_is_viewable_75 {
    type: sum
    label: "Viewable 75"
    description: "The number of impressions that were viewable for 75% of the impression."
    value_format_name: decimal_0
    sql: ${is_viewable_75} ;;
 }

  measure: pct_is_viewable_75 {
    type: number
    label: "Viewable 75%"
    description: "The percent of impressions that were viewable for 75% of the impression.."
    value_format_name: percent_2
    sql:COALESCE( 1.0 * ${sum_is_viewable_75} / nullif(${sum_is_viewability_measurable},0),0);;
  }

  dimension: is_viewable_start {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABLE_START ;;
  }

  measure: sum_is_viewable_start {
    type: sum
    label: "Viewable Start"
    description: "The number of impressions that were viewable at the start of the impression."
    sql: ${is_viewable_start} ;;
  }

  dimension: is_viewability_satisfied {
    type: number
    hidden: yes
    sql: ${TABLE}.is_viewability_satisfied ;;
  }

  measure: sum_is_viewability_satisfied {
    type: sum
    label: "Viewable Impressions"
    description: "The total of all impressions where viewablity criteria was satisfied"
    value_format_name: decimal_0
    sql: ${is_viewability_satisfied} ;;
  }

  measure: non_viewable_impressions {
    type: sum
    label: "Non-viewable Impressions"
    description: "The total of imressions where viewablity was measurable but the impressions where not viewable."
    value_format_name: decimal_0
    sql:  ${is_viewability_measurable} - ${is_viewability_satisfied} ;;
  }

  measure: viewablity_rate {
    type: number
    label: "Viewablity Rate"
    description: "For impressions where viewablity is measurable, the percent of impressions where the viewablity criteria is staisfied."
    value_format_name: percent_2
    sql:case when (${sum_is_viewability_satisfied} + (${sum_is_viewability_measurable}-${sum_is_viewability_satisfied})) <> 0 then (${sum_is_viewability_satisfied} *1.0)  / (${sum_is_viewability_satisfied} + (${sum_is_viewability_measurable}-${sum_is_viewability_satisfied})) else 0.0 End;;
  }

  dimension: iso_region {
    type: string
    label: "ISO Region"
    view_label: "Supplemental Facets"
    description: "The ISO identifier of the region where the impression was viewed."
    sql: ${TABLE}.ISO_REGION ;;
  }

  dimension: isp {
    type: string
    label: "ISP"
    view_label: "Supplemental Facets"
    description: "The Internet Service Provider (ISP) of the user who saw the impression."
    sql: ${TABLE}.ISP ;;
  }

  dimension: joinkey {
    type: string
    hidden: yes
    sql: ${TABLE}.JOINKEY ;;
  }


  dimension_group: keydate {
    type: time
    label: "Key"
    view_label: "Raw Impression Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    description: "The date/time of the impression in UTC."
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension_group: dst_keydate {
    type: time
    label: "[DST] Local"
    view_label: "Raw Impression Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    description: "The date/time of the impression in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.KEYDATE)
      else ${TABLE}.KEYDATE end ;;
  }


  dimension: language {
    type: string
    label: "Browser Language"
    view_label: "Supplemental Facets"
    description: "Language used by the browser"
    sql: prod.public.f_attr_lookup(${TABLE}.LANGUAGE) ;;
  }

  dimension: logging_diagnostic_code {
    type: string
    label: "Logging Diagnostic Code"
    view_label: "Supplemental Facets"
    description: "Any logging diagnostic codes that may be associated with the logging of the impression."
    sql: ${TABLE}.LOGGING_DIAGNOSTIC_CODE ;;
  }

   dimension: media_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.MEDIA_MARKUP ;;
  }

  measure: sum_media_markup {
    type: sum
    label: "Media Markup"
    description: "The total markup on media."
    value_format_name: decimal_2
    sql: ${media_markup} ;;
  }

  dimension: media_price {
    type: number
    hidden: yes
    sql: ${TABLE}.MEDIA_PRICE ;;
  }

  measure: sum_media_price {
    type: sum
    label: "Media Price"
    value_format_name: decimal_2
    description: "The total price of media."
    sql: ${media_price} ;;
  }

  measure: avg_media_price {
    type: average
    label: "Average Media Price"
    value_format_name: decimal_2
    description: "The average price of all media."
    sql: ${media_price} ;;
  }

measure: IBMM_Amount{
  type:sum
  label:"IBMM - Demand Currency"
  value_format_name: decimal_2
  description: "The difference between the PRICE OF MEDIA (cost plus markup) and the COST OF MEDIA "
  sql: ${media_price} - ${demand_payout} ;;
  }

  dimension: metro {
    type: number
    hidden: yes
    sql: ${TABLE}.METRO ;;
  }

   dimension: muted {
    type: number
    hidden: yes
    sql: ${TABLE}.MUTED ;;
  }

  measure: sum_muted {
    type: sum
    label: "Muted"
    description: "The total of all impressions which were muted during viewing of the impression,"
    value_format_name: decimal_0
    sql: ${muted} ;;
  }

  dimension: normalized_domain {
    type: string
    label: "Normalized Domain"
    view_label: "Supplemental Facets"
    description: "The normalized domain of the URL where the impression was viewed."
    sql: CASE WHEN ${TABLE}.IS_MOBILE_APP = 1 THEN ${TABLE}.APP_BUNDLE ELSE ${TABLE}.NORMALIZED_DOMAIN END;;
  }

  dimension: ocr_sample {
    type: string
    hidden: yes
    sql: ${TABLE}.OCR_SAMPLE ;;
  }

  dimension: payout {
    type: number
    hidden: yes
    sql: ${TABLE}.PAYOUT ;;
  }

  measure: sum_payout {
    type: sum
    label: "Gross Payout"
    description: "The total amount due to the Publisher for the media in the Publisher's (supply) currency."
    value_format_name: decimal_2
    sql: ${payout} ;;
  }


  dimension: payout_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.PAYOUT_CPU ;;
  }

  dimension: payout_currency {
    type: string
    label: "Payout Currency"
    description: "The Publisher's (supply) currency."
    sql: ${TABLE}.PAYOUT_CURRENCY ;;
  }

  dimension: payout_type {
    type: number
    hidden: yes
    sql: ${TABLE}.PAYOUT_TYPE ;;
  }

  dimension: pc_impressions {
    type: string
    hidden: yes
    sql: ${TABLE}.PC_IMPRESSIONS ;;
  }

  measure: sum_pc_impressions {
    type: sum
    label: "PC Impressions"
    description: "Total PC Impressions"
    value_format_name: decimal_0
    sql: ${TABLE}.PC_IMPRESSIONS ;;
  }

  dimension_group: placement {
    type: time
    hidden: yes
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
    sql: ${TABLE}.PLACEMENT_DATE ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: platform_client_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_GROUP_ID ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
  }

  dimension: platform_description {
    type: string
    label: "Platform"
    view_label: "Supplemental Facets"
    description: "The platform where the impression was seen examples include Android, iOS, Mac, Windows, etc."
    sql: public.f_attr_lookup(${TABLE}.PLATFORMID) ;;
  }

  dimension: platform_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_MARKUP ;;
  }

  measure: sum_platform_markup {
    type: sum
    label: "Platform Markup"
    value_format_name: decimal_2
    description: "The total platform markup amount"
    sql: ${platform_markup} ;;
  }

  dimension: platformid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.PLATFORMID ;;
  }


  dimension: player_size_detailed {
    type: string
    label: "Player Size Detailed"
    view_label: "Supplemental Facets"
    description: "The size of the player where the impression was shown, includes all 7 categories."
    sql: CASE when ${TABLE}.PLAYER_SIZE = 6 then 'X-Large'
              when ${TABLE}.PLAYER_SIZE = 5 then 'Large'
              when ${TABLE}.PLAYER_SIZE = 4 then 'Medium'
              when ${TABLE}.PLAYER_SIZE = 3 then 'Small'
              when ${TABLE}.PLAYER_SIZE = 2 then 'X-Small'
              when ${TABLE}.PLAYER_SIZE = 1 then 'Thumbnail'
              when ${TABLE}.PLAYER_SIZE = 0 then 'Unknown'
              else 'Unknown' end;;
  }

  dimension: player_size {
    type: string
    label: "Player Size"
    view_label: "Supplemental Facets"
    description: "The size of the player where the impression was shown"
    sql: CASE when ${TABLE}.PLAYER_SIZE in (5, 6) then 'Large'
              when ${TABLE}.PLAYER_SIZE in (3,4) then 'Medium'
              when ${TABLE}.PLAYER_SIZE in (1,2) then 'Small'
              when ${TABLE}.PLAYER_SIZE = 0 then 'Unknown'
              else 'Unknown' end;;
  }

  dimension: position_id {
    type: number
    hidden: yes
    sql: ${TABLE}.POSITION_ID ;;
  }


  dimension: postalcode {
    type: zipcode
    label: "Postal Code"
    view_label: "Supplemental Facets"
    description: "The Postal Code of the viewer who saw the impression."
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: postalcode_attribute {
    type: string
    hidden: yes
    sql: ${TABLE}.POSTALCODE_ATTRIBUTE ;;
  }

# ID >> needs view
  dimension: postalcode_provider {
    type: string
    label: "Postal Code Provider"
    view_label: "Supplemental Facets"
    description: "The provider who determined the postal code of the viewer who saw the impression."
    hidden: yes
    sql: ${TABLE}.POSTALCODE_PROVIDER ;;
  }


  dimension: presence_of_cars {
    type: number
    hidden: yes
    sql: ${TABLE}.PRESENCE_OF_CARS ;;
  }

  dimension: presence_of_ttid {
    type: number
    label: "Presence of TTID"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.PRESENCE_OF_TTID ;;
  }

  dimension: primary_clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.PRIMARY_CLICKS ;;
  }

  measure: sum_primary_clicks {
    type: sum
    label: "Primary Clicks"
    description: "The number of clicks on the primary impression and not companion impressions."
    value_format_name: decimal_0
    sql: ${primary_clicks} ;;
  }

  dimension: pub_tracking_id {
    type: string
    sql: ${TABLE}.PUB_TRACKING_ID ;;
  }

  dimension: pubid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.PUBID ;;
  }

  dimension: pubpassdata1 {
    type: string
    label: "PD1"
    view_label: "Supplemental Facets"
    description: "Passed Data 1 - A text field that allows the publisher to pass data back when serving the impression."
    sql: ${TABLE}.PUBPASSDATA1 ;;
  }

  dimension: pubpassdata2 {
    type: string label: "PD2"
    view_label: "Supplemental Facets"
    description: "Passed Data 2 - A second text field that allows the publisher to pass data back when serving the impression."
    sql: ${TABLE}.PUBPASSDATA2 ;;
  }

  dimension: redirect_host {
    type: string
    hidden: yes
    sql: ${TABLE}.REDIRECT_HOST ;;
  }

  dimension: referer_url {
    type: string
    label: "Referer URL"
    view_label: "Supplemental Facets"
    description: "URL where the impression was seen."
    sql: ${TABLE}.REFERER_URL ;;
  }

  dimension: region {
    type: string
    #hidden: yes
    label: "Region Code"
    view_label: "Supplemental Facets"
    description: "The geographic region code where the request came from. "
    sql: ${TABLE}.REGION ;;
  }

  dimension: raw_region_date {
    type: date
    label: "Region Date (raw)"
    view_label: "Raw Impression Dates"
    description: "The raw Date the event occured in the region timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension_group: region_date {
    type: time
    label: "Region"
    view_label: "Raw Impression Dates"
    timeframes: [date,month,year,raw]
    description: "The date of the impression in the Regional timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: region_description {
    type: string
    label: "Region"
    view_label: "Supplemental Facets"
    description: "The geographic region name where the request came from. "
    sql: ${TABLE}.REGION_DESCRIPTION ;;
  }

  dimension: requests {
    type: number
    hidden: yes
    sql: ${TABLE}.REQUESTS ;;
  }


  measure: sum_publisher_requests {
    type: sum
    hidden: yes
    label: "Publisher Requests"
    description: "The total number of all requests"
    value_format_name: decimal_0
    sql: ${requests} ;;
  }

  dimension: response_format {
    type: number
    hidden: no
    label: "XF"
    sql: ${TABLE}.RESPONSE_FORMAT ;;
  }

  measure: revenue {
    type: sum
    label: "Revenue"
    description: "Revenue"
    sql: ${TABLE}.REVENUE ;;
  }

  dimension: revenue_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.REVENUE_CPU ;;
  }

  dimension: revenue_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.REVENUE_CURRENCY ;;
  }

  dimension: revenue_type {
    type: number
    hidden: yes
    sql: ${TABLE}.REVENUE_TYPE ;;
  }

  dimension: sample_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.SAMPLE_RATE ;;
  }

  dimension: sg_ab_score {
    type: number
    label: "Social AB Impressions"
    view_label: "Supplemental Facets"
    description: "Impressions served to users in the AB Social Grade"
    value_format_name: decimal_0
    sql: ${TABLE}.SG_AB_SCORE ;;
  }

  dimension: sg_abc_score {
    type: number
    label: "Social ABC Impressions"
    view_label: "Supplemental Facets"
    description: "Impressions served to users in the ABC Social Grade"
    value_format_name: decimal_0
    sql: ${TABLE}.SG_ABC_SCORE ;;
  }

  dimension: skipability_status {
    type: number
    label: "Skippablity Status"
    view_label: "Supplemental Facets"
    description: "A number indicating the skippablity status of the placement"
    sql: ${TABLE}.SKIPABILITY_STATUS ;;
  }

  dimension: skipped {
    type: number
    hidden: yes
    sql: ${TABLE}.SKIPPED ;;
  }

  measure: sum_skipped {
    type: sum
    label: "Skipped"
    description: "The total of impressions which were skipped."
    value_format_name: decimal_0
    sql: ${TABLE}.SKIPPED ;;
  }

  dimension: ssl_secure_status {
    type: number
    hidden: yes
    sql: ${TABLE}.SSL_SECURE_STATUS ;;
  }

  dimension_group: supply_date {
    type: time
    view_label: "Raw Impression Dates"
    label: "Supply"
    timeframes: [date,month,year,raw]
    description: "The date of the impression in the Supply timezone"
    sql: ${TABLE}.SUPPLY_DATE ;;
  }

  dimension_group: local_supply_date {
    type: time
    view_label: "Raw Impression Dates"
    label: "Local Supply"
    timeframes: [date,month,year,raw]
    description: "The date of the impression in the Supply timezone in accordance with season clock shift"
    sql: ${TABLE}.LOCAL_SUPPLY_DATE ;;
  }

  dimension: supply_sample {
    type: number
    hidden: yes
    sql: ${TABLE}.SUPPLY_SAMPLE ;;
  }

  dimension: third_party_served {
    type: number
    label: "Third Party Served"
    view_label: "Supplemental Facets"
    description: "An indicator if the impression is third party served."
    sql: ${TABLE}.THIRD_PARTY_SERVED ;;
  }

  dimension: total_addon_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.TOTAL_ADDON_COST ;;
  }

  measure: sum_total_addon_costs {
    type: sum
    label: "Addon Product Cost"
    description: "The total of all costs for add-ons"
    sql: ${total_addon_cost} ;;
  }

  dimension: tps {
    type: number
    hidden: yes
    sql: ${TABLE}.TPS ;;
  }


  dimension: tracking_cost_currency {
    type: string
    label: "Tracking Cost Currency"
    description: "The currency for which the tracking costs are stored."
    sql: ${TABLE}.TRACKING_COST_CURRENCY ;;
  }

  dimension: tracking_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.TRACKING_COST_MARKUP ;;
  }

  measure: sum_tracking_cost_markup {
    type: sum
    label: "Tracking Costs Markup"
    description: "The sum of all tracking cost markups."
    sql: ${tracking_cost_markup} ;;
  }

  dimension: transparency_type {
    type: string
    label: "Transparency Type"
    view_label: "Supplemental Facets"
    description: "The transparency type of the Placement"
    sql: case when ${TABLE}.TRANSPARANCY_TYPE = 0 then 'Non-transparent'
              when ${TABLE}.TRANSPARANCY_TYPE = 1 then 'Transparent'
              when ${TABLE}.TRANSPARANCY_TYPE = 5 then 'Price Non-Transparent'
              else 'Unknown Type' end;;
  }

  dimension: ttid {
    type: string
    label: "TTID"
    view_label: "Supplemental Facets"
    description: "A unique identifier for a user."
    sql: ${TABLE}.TTID ;;
    suggestable: no
  }

  dimension: tzoffset {
    type: number
    label: "Time Zone Offset"
    view_label: "Raw Impression Dates"
    description: "The time zone offset (the number of hours from UTC) for the demand partner."
    sql: ${TABLE}.TZOFFSET ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.UNITS ;;
  }

  measure: sum_units {
    type: sum
    label: "Units"
    value_format_name: decimal_0
    description: "The number of units served.  This is based on the revenue type of the campaign to determine units."
    sql: ${TABLE}.UNITS ;;
  }


  dimension: uocs {
    type: number
    hidden: yes
    sql: ${TABLE}.UOCS ;;
  }

  dimension: url {
    type: string
    hidden: yes
    sql: ${TABLE}.URL ;;
  }

  dimension: userid {
    type: string
    label: "User ID"
    view_label: "Supplemental Facets"
    description: "The ID of the user who saw the impression."
    sql: ${TABLE}.USERID ;;
  }

  dimension: versionno {
    type: string
    label: "Version Number"
    view_label: "Supplemental Facets"
    description: "The version of the Adserver or Logger that captured the impression."
    sql: ${TABLE}.VERSIONNO ;;
  }

  dimension: videology_viewable {
    type: number
    hidden: yes
    sql: ${TABLE}.VIDEOLOGY_VIEWABLE ;;
  }

  dimension: viewability_unmeasurable_code {
    type: number
    hidden: yes
    sql: ${TABLE}.VIEWABILITY_UNMEASURABLE_CODE ;;
  }

  dimension: whitelisted_media_list {
    type: string
    hidden: yes
    sql: ${TABLE}.WHITELISTED_MEDIA_LIST ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: placement {
    type: string
    label: "Placement"
    description: "The placement name"
    sql: CASE WHEN ${placement_details_base.placement_inventory_type} IN('Private Exchange', 'Exchange') THEN ${placement_details_base.placement_name} ELSE CONCAT('Placement - ', ${TABLE}.placement_id) END ;;
  }

  dimension: placement_transparent {
    type: string
    label: "Placement (transparent)"
    description: "The transparent placement name"
    sql: ${placement_details_base.placement_name} ;;
  }

  dimension: publisher {
    type: string
    label: "Publisher"
    description: "The publisher name"
    sql: CASE WHEN ${placement_details_base.placement_inventory_type} IN('Private Exchange', 'Exchange') THEN ${placement_details_base.partner_name} ELSE CONCAT('Partner - ', ${placement_details_base.partner_id} * 2) END ;;
  }

  dimension: publisher_transparent {
    type: string
    label: "Publisher (transparent)"
    description: "The transparent publisher name"
    sql: ${placement_details_base.partner_name} ;;
  }

  measure: gross_spend {
    type: number
    label: "Gross spend"
    description: "revenue * (1 + agency_fee)"
    sql: ${revenue} * (1 + max(${agency_fee})) ;;
  }

  dimension: quartiles {
    type: number
    label: "Quartiles"
    description: "if completed 100 = 1 then 4 else if completed 75 = 1 then 3 else if completed 50 = 1 then 2 else if completed 25 = 1 then 1 else 0"
    sql: CASE
          WHEN ${completed_100} = 1
            THEN 4
          WHEN ${completed_75} = 1
            THEN 3
          WHEN ${completed_50} = 1
            THEN 2
          WHEN ${completed_25} = 1
            THEN 1
          ELSE 0
         END  ;;
  }

  dimension: viewability {
    type: number
    label: "Viewability"
    description: "if is_viewability_measurable (m) and is_viewability_satisfied (s) then 0 else if m = 1 and s = 0 then 1 else if m = 1 and s = 1 then 2"
    sql:  CASE
            WHEN ${is_viewability_measurable} = 0
              AND ${is_viewability_satisfied} = 0
              THEN 0
            WHEN ${is_viewability_measurable} = 1
              AND ${is_viewability_satisfied} = 0
              THEN 1
            WHEN ${is_viewability_measurable} = 1
              AND ${is_viewability_satisfied} = 1
              THEN 2
          END  ;;
  }

  measure: companion_impressions {
    type: sum
    label: "Companion Impressions"
    description: "Total of all companion impressions"
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.companion_media_id > 0 THEN ${TABLE}.impressions ELSE 0 END ;;
  }

  measure: companion_clicks {
    type: sum
    label: "Companion Clicks"
    description: "Total of all companion clicks"
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.companion_media_id > 0 THEN ${TABLE}.clicks ELSE 0 END ;;
  }

  measure: grp {
    type: number
    label: "GRP"
    description: "Gross Rating Points (Billable Impressions / GRP Audience)."
    sql: (${sum_billable_impressions} / max(${flight_media_details_base.demoaud})) * 100 ;;
  }

  measure: trp {
    type: number
    label: "TRP"
    description: "Targeted Rating Points (Effective Impressions / GRP Audience)."
    sql:  (${sum_effective_impressions} / (max(${flight_media_details_base.demoaud}) * max(${flight_media_details_base.democomp}))) * 100 ;;
  }

  measure: data_price{
    type: number
    hidden:  yes
    label: "Data price"
    description: "demand_bt_cluster_cost + demand_demo_cost + demand_bt_cost"
    sql: ${sum_demand_bt_cluster_cost} + ${sum_demand_demo_provider_cost} + ${bt_cost_attributes.sum_demand_bt_provider_cost};;
  }

  measure: effective_cpm {
    type: number
    label: "Effective CPM"
    description: "Gross Spend / (Billable Impressions / 1000)"
    value_format_name: decimal_2
    sql: COALESCE((${sum_demand_revenue} * (1 + COALESCE(MAX(${agency_fee}), 0))) / NULLIF(${sum_billable_impressions} / 1000, 0), 0) ;;
  }

  dimension: revenue_cpu_usd {
    type: number
    hidden:  yes
    label: "Revenue cpu usd"
    description: "Revenue CPU in usd currency"
    sql: ${TABLE}.REVENUE_CPU * ${hourly_exchange_rates.exchange_rate} ;;

  }

  dimension: is_mobile_app {
    type: number
    label: "Is Mobile App"
    view_label: "Supplemental Facets"
    description: "1 if URL is an App Bundle, 0 if not."
    sql: ${TABLE}.IS_MOBILE_APP ;;
  }

  dimension: app_bundle {
    type: string
    label: "App Bundle"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.APP_BUNDLE ;;
  }

  dimension: gdpr_compliant {
    type: string
    label: "GDPR Regulations Apply"
    view_label: "Supplemental Facets"
    description: "User is either eligible or not eligible for GDPR Regulations (are GDPR Regulations being enforced)."
    sql: CASE WHEN ${TABLE}.GDPR_COMPLIANT = 0 then 'Not Eligible'
         WHEN ${TABLE}.GDPR_COMPLIANT = 1 then 'Eligible'
         ELSE 'Other' END;;
  }

  dimension: consent_decision {
    type: string
    label: "GDPR Consent Decision"
    view_label: "Supplemental Facets"
    description: "GDPR Consent Decision: 0-No Consent, 1-Consent Give, or 2-Legitimate Interest"
    sql: CASE WHEN ${TABLE}.CONSENT_DECISION = 0 THEN 'No Consent'
    WHEN ${TABLE}.CONSENT_DECISION = 1 THEN 'Consent Given'
    WHEN ${TABLE}.CONSENT_DECISION = 2 THEN 'Legitimate Interest'
    ELSE 'Other'
    END  ;;
  }

  dimension: pchain {
    type: string
    label: "Pchain"
    view_label: "Supplemental Facets"
    description: "Payment ID chain defined by TAG protocol"
    sql: ${TABLE}.pchain ;;
  }

  dimension: ads_txt_status {
    type: string
    label: "ADS Txt Status"
    view_label: "Supplemental Facets"
    description: "List of Authorized Digital Sellers as per Advertising Bureau initiative"
    sql: ${TABLE}.ads_txt_status ;;
  }

  measure: payout_to_accrue {
  type: sum
  hidden: yes
  label: "Payout To Accrue"
  sql: CASE WHEN ${customer_details.customer_office_id} = ${placement_details_base.partner_office_id} then ${payout} else 0 end;;
  }

  measure: revenue_to_accrue {
    type: sum
    hidden: yes
    label: "Revenue To Accrue"
    sql: CASE WHEN ${customer_details.customer_office_id} = ${placement_details_base.partner_office_id} then ${TABLE}.REVENUE else 0 end;;
  }

  measure: client_spend {
    type: sum
    label: "Client Spend"
    value_format_name: decimal_2
    description: "Total Client spend converted to Gross Spend Currency: Gross Spend * (1- Campaign Discount)"
    sql:${demand_revenue} * (1 + ${flight_media_details_base.agency_fee}) * (1- ${campaign_details_base.spend_discount});;
  }

  dimension: publisher_ad_category_black_list {
    type: string
    label: "Publisher Ad Category Black List"
    description: "Publisher Ad Category Black List."
    sql: ${TABLE}.PUBLISHER_AD_CATEGORY_BLACK_LIST ;;
  }

  dimension: is_ipv6 {
    type: yesno
    description: "Identifies if the IP address is an IPv6 type"
    sql: ${TABLE}.is_ipv6 = 1;;
  }

}
