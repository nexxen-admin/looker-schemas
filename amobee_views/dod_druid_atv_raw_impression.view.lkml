view: dod_druid_atv_raw_impression {
  label: "Druid Raw Impression Metrics"
  sql_table_name: druid.atv_raw_impression ;;

  dimension: adid {
    type: string
    label: "Ad ID"
    description: "The unique ID for each ad shown"
    sql: ${TABLE}.adid ;;
  }

  dimension: time {
    type: date_time
    label: "Time"
    description: "Time"
    sql: ${TABLE}.__time ;;
  }

  dimension: ad_buyer_id {
    type: string
    description: "The ID of the Ad Buyer"
    view_label: "Supplemental Facets"
    hidden: yes
    sql: ${TABLE}.ad_buyer ;;
  }

  dimension: ad_pod_count {
    type: number
    label: "Ad Pod Count"
    description: "The total number of ads used to fill the Ad Pod."
    sql: ${TABLE}.ad_pod_count ;;
  }

  dimension: ad_pod_duration {
    type: number
    label: "Ad Pod Duration"
    description: "The amount of time left in the Ad Pod after all proceeding requests (the duration available to this request)."
    sql: ${TABLE}.ad_pod_duration ;;
  }

  dimension: total_ad_pod_duration {
    type: number
    label: "Total Ad Pod Duration"
    description: "The total amount of time available in the entire ad pod."
    sql: ${ad_pod_duration} + ${ad_pod_total_served_duration} ;;
  }

  dimension: ad_pod_position {
    type: number
    label: "Ad Pod Position"
    description: "The total place in the ad pod for this ad, starting with the number 1."
    sql: ${TABLE}.ad_pod_position ;;
  }

  dimension: ad_pod_total_served_duration {
    type: number
    label: "Ad Pod Served Duration"
    description: "For the given request, how much of the pod has already been filed."
    sql: ${TABLE}.ad_pod_total_served_duration ;;
  }

  dimension: ad_size {
    type: string
    label: "Ad Size"
    description: "The size of the displayed Ad."
    sql: ${TABLE}.ad_size ;;
  }

  measure: sum_autoplay {
    type: sum
    label: "Autoplay"
    description: "The number of impressions that were autoplay impressions (not click to play)."
    #hidden: yes
    sql: ${TABLE}.autoplay ;;
  }

  dimension: bid {
    type: number
    label: "Bid Price"
    description: "Price of a bid"
    sql: ${TABLE}.bid ;;
  }

  measure: avg_bid_price {
    type: average
    label: "Average Bid Price"
    description: "The average price of all bids."
    value_format_name: decimal_2
    sql: ${bid} ;;
  }

  dimension: adserver_code {
    type: string
    label: "Rejection Code"
    view_label: "Supplemental Facets"
    description: "The logged code identifying the reason the request was not served"
    sql: CASE WHEN ${TABLE}.adserver_code = -12 then 'Internal Bidding Failed'
      WHEN ${TABLE}.adserver_code = -10 then 'Campaign Domain Targeting Failed'
      WHEN ${TABLE}.adserver_code = -11 then 'FlightMedia Bot Prevention'
      WHEN ${TABLE}.adserver_code = 1 then 'Served'
      WHEN ${TABLE}.adserver_code = -9 then 'Bot Rejection'
      WHEN ${TABLE}.adserver_code = -3 then 'Overage Shutoff'
      WHEN ${TABLE}.adserver_code = -2 then 'Blacklist'
      WHEN ${TABLE}.adserver_code = -1 then 'Whitelist'
      WHEN ${TABLE}.adserver_code = 0 then 'Passback - General'
      WHEN ${TABLE}.adserver_code = -6 then 'Bad Geo'
      WHEN ${TABLE}.adserver_code = -4 then 'Network Redirect'
      WHEN ${TABLE}.adserver_code = -5 then 'Offset weight pacing'
      WHEN ${TABLE}.adserver_code = -7 then 'Placement Freq Cap'
      WHEN ${TABLE}.adserver_code = -13 then 'No Consent'
      ELSE 'Other'
      End
      ;;
  }

  dimension: adserving_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.adserving_cost ;;
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
    sql: ${TABLE}.adserving_cost_currency ;;
  }

  dimension: adserving_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.adserving_cost_markup ;;
  }

  measure: sum_adserving_cost_markup {
    type: sum
    label: "Adserving Costs Markup"
    description: "Total of all markups on Adserving Costs"
    value_format_name: decimal_2
    sql: ${adserving_cost_markup} ;;
  }

  dimension: age_description {
    type: string
    label: "Age"
    view_label: "Supplemental Facets"
    description: "The age of the person who saw the ad, this could be known or unknown"
    sql: ${TABLE}.age_description ;;
  }

  dimension: asset_group_restricted_clearcast_codes {
    type: string
    hidden: yes
    sql: ${TABLE}.asset_group_restricted_clearcast_codes ;;
  }

  dimension: asset_id {
    type: string
    hidden: yes
    sql: ${TABLE}.asset_id ;;
  }

  dimension: attributes {
    type: string
    hidden: yes
    sql: ${TABLE}.attributes ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.impressions ;;
  }

  measure: sum_impressions {
    type: sum
    label: "Impressions"
    description: "The total impressions"
    value_format_name: decimal_0
    sql: ${impressions} ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement ;;
  }

  dimension: data_cost_responsible_party {
    type: string
    label: "Data Code Responsible Party"
    description: "Data Code Responsible Party."
    sql: LOOKUP(CONCAT(${TABLE}.placement,''), 'atv_data_cost_responsible_party') ;;
  }

  dimension: bt_cluster_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.bt_cluster_cost ;;
  }

  measure: sum_bt_cluster_cost {
    type: sum
    label: "BT Cluster Costs"
    description: "The total of all BT Cluster Costs"
    value_format_name: decimal_2
    sql: ${bt_cluster_cost} ;;
  }

  measure: avg_clearing_price {
    type: number
    label: "Average Clearing Price"
    description: "The Average Clearing Price for impressions"
    value_format_name: decimal_2
    sql: COALESCE((1.0 * ${clearing_price_sum}) / NullIF(${sum_cost_units},0),0)  ;;
  }

  dimension: cost_units {
    type: number
    hidden: yes
    sql: ${TABLE}.cost_units ;;
  }

  measure: sum_cost_units {
    type: sum
    label: "Cost Units"
    description: "The total units which attribute to the cost of media"
    value_format_name: decimal_0
    sql: ${cost_units} ;;
  }

  dimension: clearing_price {
    type: number
    hidden: yes
    sql: ${TABLE}.clearing_price ;;
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
    sql: COALESCE((1.0 * ${TABLE}.clearing_price) * NULLIF(${TABLE}.cost_units,0),0) ;;
  }

  dimension: country {
    type: string
    label: "Country Code"
    view_label: "Supplemental Facets"
    description: "The country code where the request was placed"
    #hidden: yes
    sql: ${TABLE}.country ;;
  }


  dimension: country_name {
    type: string
    label: "Country"
    view_label: "Supplemental Facets"
    description: "The country where the request was placed"
    sql: ${TABLE}.country_description ;;

  }

}
