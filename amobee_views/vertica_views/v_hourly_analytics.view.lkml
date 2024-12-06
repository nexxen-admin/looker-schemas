view: v_hourly_analytics {
  label: "Request and Impression Metrics"

  derived_table: {
    sql: SELECT * FROM RAWDB.analytics_view
          WHERE

          {% if demand_date_date._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end demand_date_date %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if demand_date_hour._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end demand_date_hour %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if demand_date_month._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end demand_date_month %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if demand_date_time._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end demand_date_time %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if demand_date_year._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end demand_date_year %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if raw_demand_date._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end raw_demand_date %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}


          {% if local_demand_date_date._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_demand_date_date %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_demand_date_hour._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_demand_date_hour %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_demand_date_month._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_demand_date_month %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_demand_date_time._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_demand_date_time %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_demand_date_year._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_demand_date_year %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}

          {% if supply_date_date._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end supply_date_date %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if supply_date_hour._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end supply_date_hour %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if supply_date_month._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end supply_date_month %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if supply_date_time._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end supply_date_time %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if supply_date_year._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end supply_date_year %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}

          {% if local_supply_date_date._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_supply_date_date %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_supply_date_hour._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_supply_date_hour %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_supply_date_month._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_supply_date_month %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_supply_date_time._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_supply_date_time %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
          {% endif %}
          {% if local_supply_date_year._is_filtered %}
            PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start local_supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, IFNULL({% date_end local_supply_date_year %}, DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC'))), 'YYYYMMDDHH')::Integer AND
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

  dimension: pk_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK_ID ;;
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

  dimension: bt_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BT_ID;;
  }

  dimension: aws_region {
    type: string
    label: "AWS Region"
    description: "The ad request was captured in this AWS adserver region."
    view_label: "Supplemental Facets"
    sql: public.f_awsregion(${TABLE}.AWS_REGION) ;;
    suggestable: no
  }

  dimension: source {
    type: string
    hidden: yes
    sql: ${TABLE}.SOURCE ;;
  }

  dimension: addon_product_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.ADDON_PRODUCT_COST ;;
  }

  measure: total_addon_product_cost {
    type: sum
    label: "Addon Product Cost-Demand Currency"
    description: "The total of all costs for add-ons"
    value_format_name: decimal_2
    sql: ${addon_product_cost} ;;
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
      WHEN ${TABLE}.ADSERVER_CODE = -5 then 'Offset Weight Pacing'
      WHEN ${TABLE}.ADSERVER_CODE = -7 then 'Placement Freq Cap'
      WHEN ${TABLE}.ADSERVER_CODE = -13 then 'No Consent'
      ELSE 'Other'
      End
      ;;
  }

  measure: sum_supply_rejections {
    type: sum
    label: "Supply Rejections"
    hidden: yes
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE IN (-9, -7, -6, -4, -3, -2, -1) THEN ${publisher_requests} ELSE 0 END ;;
  }

  measure: supply_rejection_rate {
    type: number
    label: "Supply Rejection Rate"
    description: "Supply Request Rejections (Whitelist, Blacklist, Overage Shutoff, Network Redirect, Bad Geo, Placement Freq Cap, Bot Rejection) / Total Publisher Requests."
    value_format_name: percent_0
    sql: COALESCE(${sum_supply_rejections} / NULLIF(${sum_publisher_requests},0),0) ;;
  }

#   dimension: bad_geo_requests {
#     type: number
#     hidden: yes
#     sql: case when ${TABLE}.ADSERVER_CODE = -6 then ${publisher_requests} else 0 end;;
#   }
#
#   measure: sum_bad_geo_requests {
#     type: sum
#     label: "Bad Geo Requests"
#     view_label: "Requests"
#     sql: ${bad_geo_requests};;
#   }
#
#   dimension: requests_lost_to_blacklist {
#     type: number
#     hidden: yes
#     sql: case when ${TABLE}.ADSERVER_CODE = -2 then ${publisher_requests} else 0 end;;
#   }
#
#   measure: sum_requests_lost_to_blacklist {
#     type: sum
#     label: "Requests Lost to Blacklist"
#     view_label: "Requests"
#     sql: ${requests_lost_to_blacklist};;
#   }
#
#   dimension: requests_lost_to_pid_freq_cap {
#     type: number
#     hidden: yes
#     sql: case when ${TABLE}.ADSERVER_CODE = -7 then ${publisher_requests} else 0 end;;
#   }
#
#   measure: sum_requests_lost_to_pid_freq_cap {
#     type: sum
#     label: "Requests Lost to Placement Frequency Cap"
#     view_label: "Requests"
#     sql: ${requests_lost_to_pid_freq_cap};;
#   }
#
#   dimension: requests_lost_to_whitelist {
#     type: number
#     hidden: yes
#     sql: case when ${TABLE}.ADSERVER_CODE = -1 then ${publisher_requests} else 0 end;;
#   }
#
#   measure: sum_requests_lost_to_whitelist {
#     type: sum
#     label: "Requests Lost to Whitelist"
#     view_label: "Requests"
#     sql: ${requests_lost_to_whitelist};;
#   }

  dimension: eligible_requests {
    type: number
    hidden: yes
    description: "Publisher requests where rejection code not in (Blacklist, Bad Geo, Whitelist, Placement Freq Cap, Bot Rejection, No Consent)"
    sql: case when ${TABLE}.ADSERVER_CODE NOT IN (-6, -2, -1, -7, -9, -13) then ${publisher_requests} else 0 end;;
  }

  measure: sum_eligible_requests {
    type: sum
    label: "Eligible Requests"
    description: "Sum of publisher requests where rejection code is not Blacklist, Bad Geo, Whitelist, Placement Freq Cap or Bot Rejection"
    value_format_name: decimal_0
    sql: ${eligible_requests};;
  }

  dimension: ineligible_requests {
    type: number
    hidden: yes
    description: "Publisher requests where rejection code in (Blacklist, Bad Geo, Whitelist, Placement Freq Cap, Bot Rejection, No Consent)"
    sql: case when ${TABLE}.ADSERVER_CODE IN (-6, -2, -1, -7, -9, -13) then ${publisher_requests} else 0 end;;
  }

  measure: sum_ineligible_requests {
    type: sum
    label: "Ineligible Requests"
    description: "Sum of publisher requests where rejection code is Blacklist, Bad Geo, Whitelist, Placement Freq Cap or Bot Rejection"
    value_format_name: decimal_0
    sql: ${ineligible_requests};;
  }

  dimension: served_requests {
    type: number
    hidden: yes
    sql: case when ${TABLE}.ADSERVER_CODE = 1 then ${publisher_requests} else 0 end ;;
  }

  dimension: unserved_requests {
    type: number
    hidden: yes
    sql: ${eligible_requests} - ${served_requests} ;;
  }

  measure: sum_unserved_requests {
    type: sum
    label: "Unserved Requests"
    sql: ${unserved_requests};;
  }
#
#   dimension: returned_fmid {
#     type: number
#     hidden: yes
#     sql: case when ${flight_media} > 0 then ${publisher_requests} else 0 end ;;
#   }
#
#   measure: sum_returned_fmid {
#     type: sum
#     label: "Returned FMID"
#     view_label: "Requests"
#     description: "Sum of publisher requests where flight media id > 0"
#     sql: ${returned_fmid} ;;
#   }
#
  dimension: house_impressions {
    type: number
    hidden: yes
    sql: case when ${v_campaign_details_base.isfiller} then ${impressions} else 0 end ;;
  }

  measure: sum_house_impressions {
    type: sum
    label: "House Impressions"
    description: "Sum of filler campaign impressions"
    sql: ${house_impressions} ;;
  }

  measure: supply_house_rate {
    type: number
    label: "Supply House Rate"
    description: "Total House Impressions / Total Publisher Requests"
    value_format_name: percent_2
    sql: COALESCE(${sum_house_impressions}/NULLIF(${sum_publisher_requests},0),0);;
  }

  dimension: non_house_impressions {
    type: number
    hidden: yes
    sql: case when not ${v_campaign_details_base.isfiller} then ${impressions} else 0 end ;;
  }

  measure: sum_good_requests {
    type: sum
    label: "Good Requests"
    description: "The sum of requests which were served or rejected for Network Redirect, Offset Weight Pacing, Passback, or Overage Shutoff."
    value_format_name: decimal_0
    sql: CASE WHEN ${v_placement_details_base.fallback_type_id} = 1 then (${publisher_requests} - CASE WHEN ${TABLE}.ADSERVER_CODE = 1 then ${publisher_requests} else 0 end) ELSE '0' End + CASE WHEN ${TABLE}.ADSERVER_CODE = -5 then ${publisher_requests} ELSE '0' End + CASE WHEN ${TABLE}.ADSERVER_CODE = 0 then ${publisher_requests} ELSE '0' End + CASE WHEN ${TABLE}.ADSERVER_CODE = -3 then ${publisher_requests} ELSE '0' End +CASE WHEN ${TABLE}.ADSERVER_CODE = 1 then ${publisher_requests} else 0 end ;;
  }

  measure: sum_non_house_impressions {
    type: sum
    label: "Non-House Impressions"
    description: "Sum of non-filler campaign impressions"
    sql: ${non_house_impressions} ;;
  }

  measure: sum_passback_general_requests {
    type: sum
    label: "Rejected Requests: Passback - General"
    description: "Requests for which no eligible flight media was available to serve due to campaign targeting, frequency cap, incompatible xf type, etc."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = 0 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_whitelist_requests {
    type: sum
    label: "Rejected Requests: Whitelist"
    description: "Requests from URLs included in the Placement Whitelist."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -1 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_blacklist_requests {
    type: sum
    label: "Rejected Requests: Blacklist"
    description: "Requests from URLs included in the Platform Global Blacklist."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -2 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_overage_shutoff_requests {
    type: sum
    label: "Rejected Requests: Overage Shutoff"
    description: "Requests for placements where the impression delivery cap set in the Platform has been exceeded."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -3 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_network_redirect_requestss {
    type: sum
    label: "Rejected Requests: Network Redirect"
    description: "Unserved requests from placements with a Redirect URL set in the Platform."
    value_format_name: decimal_0
    sql: CASE WHEN ${v_placement_details_base.fallback_type_id} = 1 then (${publisher_requests} - CASE WHEN ${TABLE}.ADSERVER_CODE = 1 then ${publisher_requests} else 0 end) else '0' END;;
  }

  measure: sum_offset_weight_pacing_requests {
    type: sum
    label: "Rejected Requests: Offset Weight Pacing"
    description: "Requests that were not monetized to ensure even campaign delivery throughout the day."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -5 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_of_bad_geo_requests {
    type: sum
    label: "Rejected Requests: Bad Geo"
    description: "Requests which do not match the country of the placement"
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -6 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_placement_freq_cap_requests {
    type: sum
    label: "Rejected Requests: Placement Frequency Cap"
    description: "Requests received after the Placement Frequency Cap has been met."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -7 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_whiteops_rejection_requests {
    type: sum
    label: "Rejected Requests: Bot Rejection"
    description: "Requests where the Platform deems a placement as bot; powered by White Ops Technology."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -9 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_campaign_domain_targeting_failed_requests {
    type: sum
    label: "Rejected Requests: Campaign Domain Targeting Failed"
    description: "Requests that fail to meet campaign domain targeting requirements."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -10 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_flight_media_bot_prevention_requests {
    type: sum
    label: "Rejected Requests: Flight Media Bot Prevention"
    description: "Requests that do not meet flight media bot prevention requirements."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -11 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_internal_bidding_failed_requests {
    type: sum
    label: "Rejected Requests: Internal Bidding Failed"
    description: "Requests where internal bidding failed."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -12 then ${publisher_requests} ELSE '0' End;;
  }

  measure: sum_no_consent_request {
    type: sum
    label: "Rejected Requests: No Consent"
    description: "Requests with No Consent."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.ADSERVER_CODE = -13 then ${publisher_requests} ELSE '0' End;;
  }

  measure:  sum_percent_bad_requests{
    type: number
    label: "% Bad Requests"
    description: "The percentage of requests that are bad (bad geo, blacklist, whitelist or placement frequency cap) of all requests recieved."
    value_format_name: percent_2
    sql: coalesce((${sum_of_bad_geo_requests} + ${sum_blacklist_requests} + ${sum_whitelist_requests} + ${sum_placement_freq_cap_requests}) / nullif(${sum_publisher_requests},0),0) ;;
  }

  measure: estimated_processing_costs{
    type: number
    label: "Estimated Processing Costs"
    description: ".002 USD for every 1000 requests."
    value_format_name: decimal_2
    sql: (${sum_publisher_requests}/1000) * .002 ;;
  }

  measure: bad_imp_report_filter {
    type: number
    sql: case when (${sum_percent_bad_requests} >= .6) or (${inventory_contribution_usd} <= ${estimated_processing_costs}) then 1 else 0 end ;;
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

  dimension: age {
    type: string
    hidden: yes
    sql: ${TABLE}.AGE ;;
  }

  dimension: age_description {
    type: string
    label: "Age"
    view_label: "Supplemental Facets"
    description: "The age of the person who saw the ad, this could be known or unknown"
    suggestions: ["18-20", "21-24", "25-34", "35-44", "45-49", "50-54", "55-64", "65+", "Unknown Age"]
    sql: ${TABLE}.AGE_DESCRIPTION ;;
  }

  dimension: agency_fee {
    type: string
    hidden: yes
    sql: ${TABLE}.AGENCY_FEE ;;
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

  dimension: bid {
    type: number
    hidden: yes
    sql: ${TABLE}.BID_PRICE ;;
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

# =bids? where bids > 0 and bid_requests_filled != bids limit 10
# =Served Requests?
  dimension: bid_requests_filled {
    type: number
    hidden: yes
    sql: ${TABLE}.BID_REQUESTS_FILLED ;;
  }

  dimension: bids {
    type: number
    hidden: yes
    sql: ${TABLE}.BIDS ;;
  }

  measure: sum_bids {
    type: sum
    label: "Bids"
    description: "The Total number of bids placed"
    sql: ${bids} ;;
  }

  dimension: billable_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.BILLABLE_IMPRESSIONS ;;
  }

  measure: sum_billable_impressions_base {
    type: sum
    hidden: yes
    sql: ${billable_impressions} ;;
  }

  measure: sum_billable_impressions {
    type: number
    label: "Billable Impressions"
    description: "The number of impressions that were billable to the client"
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          sum(
               case
               when daypart.daypart_id IS NULL then
                       ${billable_impressions}
               else
                       ${billable_impressions} / 2
               end) + (
               case
               when SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_impressions}
                       end) % 1 = 0 AND SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_impressions}
                       end) % 2 <> 0 AND max(daypart.minute_of_hour) = 0 then
                       0.5
               when SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_impressions}
                       end) % 1 = 0 AND SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_impressions}
                       end) % 2 <> 0 AND max(daypart.minute_of_hour) = 30 then
                       -0.5
               else 0 end)
          {% else %} ${sum_billable_impressions_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign,flight,flight_media,sum_billable_impressions]
  }

  dimension: billable_units {
    type: number
    hidden: yes
    sql: case when ${v_campaign_details_base.cpu_type_id} in (4,5) then ${TABLE}.DEMAND_REVENUE else ${TABLE}.BILLABLE_UNITS end ;;
  }

  dimension: delivery_units {
    type: number
    hidden:  yes
    sql:case when ${v_campaign_details_base.cpu_type_id} = 5
      then  ${TABLE}.DEMAND_REVENUE * (1+(${v_flight_media_details_base.agency_fee})) else  ${TABLE}.UNITS end   ;;
  }

  measure: sum_delivery_units {
    type: sum
    label: "Delivery Units"
    value_format_name: decimal_0
    description: "The number of units served - if campaign type is rDCPM, this will return Spend."
    sql: ${delivery_units} ;;
  }

  measure: sum_billable_units_base {
    type: sum
    hidden: yes
    sql: ${billable_units} ;;
  }

  measure: sum_billable_units {
    type: number
    label: "Billable Units"
    description: "The number of units that were billable to the client.  The unit will depend on the CPU type."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          sum(
               case
               when daypart.daypart_id IS NULL then
                       ${billable_units}
               else
                       ${billable_units} / 2
               end) + (
               case
               when SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_units}
                       end) % 1 = 0 AND SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_units}
                       end) % 2 <> 0 AND max(daypart.minute_of_hour) = 0 then
                       0.5
               when SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_units}
                       end) % 1 = 0 AND SUM(
                       case
                       when daypart.daypart_id IS NOT NULL then
                               ${billable_units}
                       end) % 2 <> 0 AND max(daypart.minute_of_hour) = 30 then
                       -0.5
               else 0 end)
          {% else %} ${sum_billable_units_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign,flight,flight_media,sum_billable_units]
  }

  measure: first_delivery_date {
    type: date_time
    label: "First Delivery Date"
    description: "The date/time in the demand timezone when the first billable units were delivered."
    sql: MIN(case when ${billable_units} > 0 then ${demand_date_raw} end) ;;
  }

  measure: dst_first_delivery_date {
    type: date_time
    label: "[DST] Local First Delivery Date"
    description: "The date/time in the demand timezone when the first billable units were delivered in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then MIN(case when ${billable_units} > 0 then ${local_demand_date_raw} end)
      else MIN(case when ${billable_units} > 0 then ${demand_date_raw} end) end ;;
  }

  dimension: browser {
    type: string
    view_label: "Supplemental Facets"
    description: "The browser which was used to view the impression"
    sql: ${v_attribute_lookup_browserid.description}  ;;
  }

  dimension: browserid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.BROWSER ;;
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

  dimension: buyer_requests {
    type: number
    hidden: yes
    sql: ${TABLE}.BUYER_REQUESTS ;;
  }

  measure: sum_buyer_requests {
    type: sum
    label: "Buyer Requests"
    description: "Total number of requests placed by the buyer"
    value_format_name: decimal_0
    sql: ${TABLE}.BUYER_REQUESTS ;;
  }

  dimension: campaign {
    type: string
    view_label: "Impression Facets"
    label: "Campaign ID"
    hidden: yes
    description: "The ID of the campaign that was served in the impression."
    sql: ${TABLE}.CAMPAIGN_ID ;;
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

  dimension: clearing_price_currency {
    type: string
    label: "Clearing Price Currency"
    description: "The currency of the Clearing Price"
    sql: ${TABLE}.CLEARING_PRICE_CURRENCY ;;
  }

  dimension: click_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICK_IMPRESSIONS ;;
  }

  measure: sum_click_impressions_base {
    type: sum
    hidden: yes
    sql: ${click_impressions} ;;
  }

  measure: sum_click_impressions {
    type: number
    label: "Click Impressions"
    description: "The total of all impressions where clicks are tracked"
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then ${click_impressions}
           else (${click_impressions} / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then ${click_impressions}
           else (${click_impressions} / 2)
           end)) end
          {% else %} ${sum_click_impressions_base} {% endif %} ;;
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

  measure: sum_clicks_base {
    type: sum
    hidden: yes
    sql: ${clicks} ;;
  }

  measure: sum_clicks {
    type: number
    label: "Clicks"
    description: "The total of all clicks (where an impression was clicked upon)."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then ${clicks}
           else (${clicks} / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then ${clicks}
           else (${clicks} / 2)
           end)) end
          {% else %} ${sum_clicks_base} {% endif %} ;;
  }

  dimension: companion_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPANION_IMPRESSIONS ;;
  }

  measure: sum_companion_impressions {
    type: sum
    label: "Companion Impressions"
    description: "Total number of Companion Impressions"
    value_format_name: decimal_0
    sql: ${TABLE}.COMPANION_IMPRESSIONS ;;
  }

  dimension: companion_media {
    type: string
    view_label: "Supplemental Facets"
    label: "Companion Media ID"
    description: "The ID of the Companion Media."
    sql: ${TABLE}.COMPANION_MEDIA ;;
  }

  dimension: completed_100 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_100 ;;
  }

  measure: sum_completed_100_base {
    type: sum
    hidden: yes
    sql: ${completed_100} ;;
  }

  measure: sum_completed_100 {
    type: number
    label: "Completed 100"
    description: "The total of all impression which were 100% completed."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then ${completed_100}
           else (${completed_100} / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then ${completed_100}
           else (${completed_100} / 2)
           end)) end
          {% else %} ${sum_completed_100_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_completed_100]
  }

  measure: completed_100_pct {
    type: number
    label: "Completed 100%"
    description: "The percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100} / nullif(${sum_completed_pct_impressions},0),0) ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, completed_100_pct]
  }

  dimension: completed_25 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_25 ;;
  }

  measure: sum_completed_25_base {
    type: sum
    hidden: yes
    sql: ${completed_25} ;;
  }

  measure: sum_completed_25 {
    type: number
    label: "Completed 25"
    description: "The total of all impression which were 25% completed."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then (${completed_25})
           else ((${completed_25}) / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then (${completed_25})
           else ((${completed_25}) / 2)
           end)) end
          {% else %} ${sum_completed_25_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_completed_25]
  }

  measure: abs_completed_25 {
    type: sum
    description: "The sum of completed 25 used in calculating VCR."
    hidden: yes
    value_format_name: decimal_0
    sql: ${completed_25} ;;
  }

  measure: completed_25_pct {
    type: number
    label: "Completed 25%"
    description: "The percentage of all impression which were 25% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0* (${sum_completed_25}+${sum_completed_50}+${sum_completed_75}+${sum_completed_100})) /nullif(${sum_completion_pct_impressions},0),0);;
    drill_fields: [platform_client_id, campaign, flight, flight_media, completed_25_pct]
  }

  dimension: completed_50 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_50 ;;
  }

  measure: sum_completed_50_base {
    type: sum
    hidden: yes
    sql: ${completed_50} ;;
  }

  measure: sum_completed_50 {
    type: number
    label: "Completed 50"
    description: "The total of all impression which were 50% completed."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then (${completed_50})
           else ((${completed_50}) / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then (${completed_50})
           else ((${completed_50}) / 2)
           end)) end
          {% else %} ${sum_completed_50_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_completed_50]
  }

  measure: abs_completed_50 {
    type: sum
    description: "The sum of completed 50 used in calculating VCR."
    hidden: yes
    value_format_name: decimal_0
    sql: ${completed_50} ;;
  }

  measure: completed_50_pct {
    type: number
    label: "Completed 50%"
    description: "The percentage of all impression which were 50% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0 * (${sum_completed_50}+${sum_completed_75}+${sum_completed_100}) ) / nullif(${sum_completion_pct_impressions},0),0) ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, completed_50_pct]
  }

  dimension: completed_75 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_75 ;;
  }

  measure: sum_completed_75_base {
    type: sum
    hidden: yes
    sql: ${completed_75} ;;
  }

  measure: sum_completed_75 {
    type: number
    label: "Completed 75"
    description: "The total of all impression which were 75% completed."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then (${completed_75})
           else ((${completed_75}) / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then (${completed_75})
           else ((${completed_75}) / 2)
           end)) end
          {% else %} ${sum_completed_75_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_completed_75]
  }

  measure: abs_completed_75 {
    type: sum
    description: "The sum of completed 75 used in calculating VCR."
    hidden: yes
    value_format_name: decimal_0
    sql: ${completed_75} ;;
  }

  measure: completed_75_pct {
    type: number
    label: "Completed 75%"
    description: "The percentage of all impression which were 75% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0 * (${sum_completed_75}+${sum_completed_100}) ) / nullif(${sum_completion_pct_impressions},0),0) ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, completed_75_pct]
  }

  dimension: completed_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_PCT_IMPRESSIONS ;;
  }

  measure: sum_completed_pct_impressions_base {
    type: sum
    hidden: yes
    sql: ${completed_pct_impressions} ;;
  }

  measure: sum_completed_pct_impressions {
    type: number
    label: "Completed Percent Impressions"
    description: "The total number of impression where completed (completed 100) is measured."
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0 then
             ceil(sum(
           case
            when daypart.daypart_id is null
             then ${completed_pct_impressions}
           else (${completed_pct_impressions} / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then ${completed_pct_impressions}
           else (${completed_pct_impressions} / 2)
           end)) end
          {% else %} ${sum_completed_pct_impressions_base} {% endif %} ;;
  }

  dimension: completion_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETION_PCT_IMPRESSIONS ;;
  }

  measure: sum_completion_pct_impressions_base {
    type: sum
    hidden: yes
    sql: ${completion_pct_impressions} ;;
  }

  measure: sum_completion_pct_impressions {
    type: number
    label: "Completion Percent Impressions"
    description: "The total of impressions where completion percentage is measured.
    This is used in calculating the various completion percentages, and VCR"
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0 then
             ceil(sum(
           case
            when daypart.daypart_id is null
             then ${completion_pct_impressions}
           else (${completion_pct_impressions} / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then ${completion_pct_impressions}
           else (${completion_pct_impressions} / 2)
           end)) end
          {% else %} ${sum_completion_pct_impressions_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_completion_pct_impressions]
  }

  measure: VTR {
    type: number
    label: "VTR"
    description: "Video Through Rate - the percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100} / nullif(${sum_completed_pct_impressions},0),0) ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, VTR]
  }

  measure: VCR {
    type: number
    label: "VCR"
    description: "Video Completed Rate - The avarage completion rate of the impression."
    value_format_name: percent_2
    sql: COALESCE(((${abs_completed_25}*.25) + (${abs_completed_50} *.50) + (${abs_completed_75} *.75)
      + (${sum_completed_100} *1.0)) / nullif(${sum_completion_pct_impressions},0),0) ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, VCR]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_cost_units]
  }

  dimension: country {
    type: string
    hidden: yes
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: country_name {
    type: string
    label: "Country"
    view_label: "Supplemental Facets"
    description: "The country where the request was placed"
    sql: CASE WHEN ${TABLE}.COUNTRY = 'U' THEN 'Unknown' ELSE ${TABLE}.COUNTRY_DESCRIPTION END ;;
  }

  dimension: day_abbreviation {
    type: string
    label: "Daypart - Day of Week"
    view_label: "Supplemental Facets"
    description: "The daypart (Day of Week) that a request was served.
    This is based on the day and time of the viewer."
    sql: ${TABLE}.DAY_ABBREVIATION ;;
    order_by_field: day_of_week
  }

  dimension: day_abbreviation_derived {
    type: string
    label: "Daypart - Day of Week (derived)"
    view_label: "Supplemental Facets"
    description: "The daypart (Day of Week) that a request was served.
    This is based on the day and time of the viewer."
    sql: case when ${daypart_id} = 6000 then case ${day_of_week_derived} when 0 then 'Sun' when 1 then 'Mon' when 2 then 'Tue' when 3 then 'Wed' when 4 then 'Thu' when 5 then 'Fri' when 6 then 'Sat' end else ${day_abbreviation} end ;;
    order_by_field: day_of_week_derived
  }

  dimension: day_of_week {
    type: number
    hidden: yes
    description: "The day of the week that the viewer saw the impression, based on the viewer's local time."
    sql: COALESCE(${TABLE}.DAY_OF_WEEK, 0) ;;
  }

  dimension: day_of_week_derived {
    type: number
    hidden: yes
    sql: case when ${daypart_id} = 6000 then date_part(dayofweek, ${demand_date_raw}) else ${day_of_week} end ;;
  }

  dimension: daypart_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DAYPART_ID ;;
  }

  dimension: daypart_description {
    type: string
    view_label: "Supplemental Facets"
    label: "Daypart Description"
    description: "The daypart (day and time) that a request was served.
    This is based on the day and time of the viewer."
    sql: ${TABLE}.DAYPART_DESCRIPTION ;;
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
    type: date_minute
    label: "Demand Date (raw)"
    view_label: "Dates"
    description: "The raw DateTime the event occured in the demand timezone"
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension_group: demand_date {
    type: time
    label: "Demand"
    view_label: "Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the impression in the Demand timezone"
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension_group: local_demand_date {
    type: time
    label: "Local Demand"
    view_label: "Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the impression in the Demand timezone in accordance with season clock shift"
    sql: ${TABLE}.LOCAL_DEMAND_DATE ;;
  }

  dimension: raw_gmt_date {
    type: date_time
    label: "GMT Date (raw)"
    view_label: "Dates"
    description: "The raw date/time of the impression in GMT"
    sql: ${TABLE}.GMT_DATE ;;
  }

  dimension_group: gmt_date {
    type: time
    label: "GMT"
    view_label: "Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the impression in GMT"
    sql: ${TABLE}.GMT_DATE ;;
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

  dimension: demand_gbp_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_GBP_EXCHANGE_RATE ;;
  }

  dimension: demand_payout {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_PAYOUT ;;
  }

  measure: sum_demand_payout {
    type: sum
    label: "Gross Payout - Demand"
    description: "The payout including exchange fee but not IBMM in demand currency"
    value_format_name: decimal_2
    sql: ${demand_payout} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_demand_payout]
  }

  measure: IBMM_Amount{
    type:sum
    label:"IBMM - Demand Currency"
    value_format_name: decimal_2
    description: "The difference between the PRICE OF MEDIA (cost plus markup) and Gross Payout-Demand"
    sql: ${media_price} - ${demand_payout} ;;
  }

  measure: IBMM_Amount_USD{
    type:sum
    label:"IBMM - USD"
    value_format_name: decimal_2
    description: "The difference between the PRICE OF MEDIA (cost plus markup) and Gross Payout in USD"
    sql: ${media_price} * ${demand_usd_exchange_rate} - ${demand_payout} * ${demand_usd_exchange_rate} ;;
  }

  dimension: demand_region_exchange_rate {
    type: string
    hidden:  yes
    sql: ${TABLE}.DEMAND_REGION_EXCHANGE_RATE ;;
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_demand_revenue]
  }

  measure: sum_demand_revenue_usd {
    type: sum
    label: "Net Spend - USD"
    description: "Total Net Spend converted to USD"
    value_format_name: decimal_2
    sql: ${demand_revenue} * ${demand_usd_exchange_rate} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_demand_revenue]
  }

  measure: sum_demand_gross_spend {
    type: sum
    label: "Gross Spend"
    description: "Total Gross Spend in Demand Currency.  Gross Spend is Net Spend plus Agency Fees."
    sql: ${demand_revenue} * (1+(${v_flight_media_details_base.agency_fee})) ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_demand_revenue]
  }

  measure: sum_demand_gross_spend_usd {
    type: sum
    label: "Gross Spend - USD"
    description: "Total Gross Spend converted to USD. Gross Spend is Net Spend plus Agency Fees."
    value_format_name: decimal_2
    sql:( ${demand_revenue} * ${demand_usd_exchange_rate}) * (1+(${v_flight_media_details_base.agency_fee}))  ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_demand_revenue]
  }

  dimension: demand_timezone {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_TIMEZONE ;;
  }

  dimension: tracking_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.TRACKING_COST ;;
  }

  measure: sum_tracking_cost {
    type: sum
    label: "Tracking Cost"
    value_format_name: decimal_2
    description: "The total of all tracking costs in native currency."
    sql: ${TABLE}.TRACKING_COST ;;
  }

  dimension: demand_tracking_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_TRACKING_COST;;
  }

  measure: sum_demand_tracking_cost {
    type: sum
    label: "Tracking Cost - Demand Currency"
    value_format_name: decimal_2
    description: "The total of all tracking costs in demand currency."
    sql: ${demand_tracking_cost} ;;
  }

  dimension: demand_usd_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_USD_EXCHANGE_RATE ;;
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

  dimension: demo_provider {
    type: string
    description: "Exposed through demo_provider view"
    hidden: yes
    sql: ${TABLE}.DEMO_PROVIDER ;;
  }

  measure: sum_demo_usage {
    type: sum
    label: "Demo Usage"
    view_label: "Demo Provider"
    description: "The total Impressions where demo provider data was used to serve."
    value_format_name: decimal_0
    sql: CASE WHEN ${TABLE}.DEMO_PROVIDER_DATA_COST = 0 then 0 else ${TABLE}.impressions END ;;
  }

  measure: demo_cpu {
    type: number
    label: "Demo CPU"
    description: "Demo Cost / Demo Usage"
    view_label: "Demo Provider"
    value_format_name: decimal_2
    sql: COALESCE((${sum_demo_provider_data_cost} /  NULLIF(${sum_demo_usage},0)) * 1000,0) ;;
  }

  dimension: demo_provider_cost_currency {
    type: string
    label: "Demo Cost Currency"
    description: "The currency of the Demo Costs"
    sql: ${TABLE}.DEMO_PROVIDER_COST_CURRENCY ;;
  }

  dimension: demo_provider_data_cost {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMO_PROVIDER_DATA_COST ;;
  }

  measure: sum_demo_provider_data_cost {
    type: sum
    label: "Demo Provider Costs"
    description: "The total costs for using demo targeting data"
    value_format_name: decimal_2
    sql: ${TABLE}.DEMO_PROVIDER_DATA_COST ;;
  }

  dimension: device {
    type: string
    view_label: "Supplemental Facets"
    label: "Device"
    description: "The name of the device where the impression was seen."
    sql: ${v_attribute_lookup_deviceid.description}  ;;
    suggestable: no
  }

  dimension: deviceid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.DEVICE_ID ;;
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_distinct_clicks]
  }

  dimension: dma {
    type: string
    hidden: yes
    sql: ${TABLE}.DMA ;;
  }

  dimension: dma_description {
    type: string
    view_label: "Supplemental Facets"
    label: "DMA"
    description: "Designated Marketing Area (DMA)"
    sql: ${TABLE}.DMA_DESCRIPTION ;;
  }

  dimension: domain {
    type: string
    hidden: yes
    sql: ${TABLE}.DOMAIN ;;
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
    sql: CASE WHEN ${TABLE}.IS_MOBILE_APP = 1 THEN ${TABLE}.APP_BUNDLE ELSE ${TABLE}.DOMAIN_URL END;;
  }

  dimension: effective_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.EFFECTIVE_IMPRESSIONS ;;
  }

  measure: sum_effective_impressions {
    type: sum
    label: "Effective Impressions"
    description: "The total of all impression which were in target."
    value_format_name: decimal_0
    sql: ${effective_impressions} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_impressions, sum_effective_impressions]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_effective_units]
  }

  dimension: raw_est_date {
    type: date_time
    label: "EST Date (raw)"
    view_label: "Dates"
    description: "The raw time of the event stored in ETC"
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension_group: est_date {
    type: time
    label: "EST"
    view_label: "Dates"
    timeframes: [time,hour, date,month,year,raw]
    description: "The date/time of the impression in EST"
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension: exchange_fee {
    type: string
    hidden: yes
    sql: ${TABLE}.EXCHANGE_FEE ;;
  }

  measure: sum_exchange_fee {
    type: sum
    label: "Exchange Fee- Payout Currency"
    description: "The total costs incurred from the exchange fee in the Payout Currency"
    value_format_name: decimal_2
    sql: ${TABLE}.EXCHANGE_FEE ;;
  }

  dimension: flight {
    type: string
    view_label: "Impression Facets"
    label: "Flight ID"
    description: "The ID of the Flight that was served in the impression."
    hidden: yes
    sql: ${TABLE}.FLIGHT ;;
  }

  dimension: flight_media {
    type: string
    #hidden: yes
    view_label: "Impression Facets"
    label: "Flight Media ID"
    description: "The ID of the flight media that was served in the impression."
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID;;
  }

  dimension: floor_price {
    type: number
    hidden: yes
    sql: ${TABLE}.FLOOR_PRICE ;;
  }

  measure: avg_floor_price {
    type: average
    label: "Average Floor Price"
    description: "The average floor price of all bids"
    value_format_name: decimal_2
    sql: ${TABLE}.FLOOR_PRICE ;;
  }

  dimension: gbp_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.GBP_EXCHANGE_RATE ;;
  }

  dimension: gender {
    type: string
    hidden: yes
    sql: ${TABLE}.GENDER)  ;;
  }

  dimension: gender_description {
    type: string
    view_label: "Supplemental Facets"
    label: "Gender"
    description: "The gender of the person who saw the impression."
    suggestions: ["Male", "Female", "Unknown Gender"]
    sql: ${TABLE}.GENDER_DESCRIPTION ;;
  }

  dimension: geo {
    type: string
    hidden: yes
    sql: ${TABLE}.GEO ;;
  }

  dimension: hour_minute_of_day {
    type: number
    hidden: yes
    sql: ${hour_of_day} * 100 + coalesce(${v_daypart.minute_of_hour}, ${minute_of_hour}, 0) ;;
  }

  dimension: hour_minute_of_day_derived {
    type: number
    hidden: yes
    sql: ${hour_of_day_derived} * 100 + coalesce(${v_daypart.minute_of_hour}, ${minute_of_hour}, 0) ;;
  }

  dimension: hour_description {
    type: string
    label: "Daypart - Hour of Day"
    view_label: "Supplemental Facets"
    description: "The daypart (Hour of Day) that a request was served.
    This is based on the day and time of the viewer."
    sql: coalesce(${v_daypart.hour_description}, ${TABLE}.HOUR_DESCRIPTION) ;;
    order_by_field: hour_minute_of_day
  }

  dimension: hour_description_derived {
    type: string
    label: "Daypart - Hour of Day (derived)"
    view_label: "Supplemental Facets"
    description: "The daypart (Hour of Day) that a request was served.
    This is based on the day and time of the viewer."
    sql: case when ${daypart_id} = 6000 then concat((${hour_of_day_derived} + 11) % 12 + 1, case when ${hour_of_day_derived} < 12 then ':00 am' else ':00 pm' end)
      else ${hour_description} end ;;
    order_by_field: hour_minute_of_day_derived
  }

  dimension: hour_of_day {
    type: number
    hidden: yes
    sql: COALESCE(${TABLE}.HOUR_OF_DAY, 0) ;;
  }

  dimension: hour_of_day_derived {
    type: number
    hidden: yes
    sql: case when ${daypart_id} = 6000 then date_part(hour, ${demand_date_raw}) else ${hour_of_day} end ;;
  }

  dimension: minute_of_hour {
    type: number
    hidden: yes
    sql: ${TABLE}.MINUTE_OF_HOUR ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  measure: sum_impressions_base {
    type: sum
    hidden: yes
    sql: ${impressions} ;;
  }

  measure: sum_impressions {
    type: number
    label: "Impressions"
    description: "The total impressions"
    value_format_name: decimal_0
    sql: {% if hour_description._is_selected or hour_description_derived._is_selected %}
          case
            when max(coalesce(daypart.minute_of_hour,${minute_of_hour})) = 0
             then ceil(sum(
           case
            when daypart.daypart_id is null
             then ${impressions}
           else (${impressions} / 2)
           end))
           else floor(sum(
           case
            when daypart.daypart_id is null
             then ${impressions}
           else (${impressions} / 2)
           end)) end
          {% else %} ${sum_impressions_base} {% endif %} ;;
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_impressions]
  }

  measure: sum_impressions_base_18_24 {
    type: sum
    label: "18-24 Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by age 18-24"
    value_format_name: decimal_0
    filters: [age_description: "18-20, 21-24"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_25_34 {
    type: sum
    label: "25-34 Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by age 25-34"
    value_format_name: decimal_0
    filters: [age_description: "25-34"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_35_44 {
    type: sum
    label: "35-44 Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by age 35-44"
    value_format_name: decimal_0
    filters: [age_description: "35-44"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_45_54 {
    type: sum
    label: "45-54 Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by age 45-54"
    value_format_name: decimal_0
    filters: [age_description: "45-49, 50-54"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_55_64 {
    type: sum
    label: "55-64 Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by age 55-64"
    value_format_name: decimal_0
    filters: [age_description: "55-64"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_65_plus {
    type: sum
    label: "65+ Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by age 65+"
    value_format_name: decimal_0
    filters: [age_description: "65+"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_unknown_age {
    type: sum
    label: "Unknown Age Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by unknown age"
    value_format_name: decimal_0
    filters: [age_description: "Unknown Age"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_male {
    type: sum
    label: "Male Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by male gender"
    value_format_name: decimal_0
    filters: [gender_description: "Male"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_female {
    type: sum
    label: "Female Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by female gender"
    value_format_name: decimal_0
    filters: [gender_description: "Female"]
    sql: ${impressions} ;;
  }

  measure: sum_impressions_base_unknown_gender {
    type: sum
    label: "Unknown Gender Impressions"
    view_label: "Custom Measures"
    description: "The total impressions filtered by unknown gender"
    value_format_name: decimal_0
    filters: [gender_description: "Unknown Gender"]
    sql: ${impressions} ;;
  }

  dimension: inferred_age {
    type: string
    hidden: yes
    sql: ${TABLE}.INFERRED_AGE ;;
  }

  dimension: inferred_age_description {
    type: string
    view_label: "Supplemental Facets"
    description: "The inferred age of the person who saw the ad."
    suggestable: no
    sql: ${TABLE}.INFERRED_AGE_DESCRIPTION ;;
  }

  dimension: inferred_gender {
    type: string
    hidden: yes
    sql: ${TABLE}.INFERRED_GENDER ;;
  }

  dimension: inferred_gender_description {
    type: string
    view_label: "Supplemental Facets"
    description: "The inferred gender of the person who saw the ad."
    suggestions: ["Male", "Female", "Unknown Gender"]
    sql: ${TABLE}.INFERRED_GENDER_DESCRIPTION ;;
  }

  dimension: is_known_demo {
    type: string
    hidden: yes
    sql: ${TABLE}.IS_KNOWN_DEMO ;;
  }

  dimension: is_postalcode_targeted {
    type: string
    hidden: yes
    sql: ${TABLE}.IS_POSTALCODE_TARGETED ;;
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_is_viewability_measurable]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_is_viewable_25,sum_is_viewable_50, sum_is_viewable_75, sum_is_viewable_100, VTR]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_is_viewable_25,sum_is_viewable_50, sum_is_viewable_75, sum_is_viewable_100, VTR]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_is_viewable_25,sum_is_viewable_50, sum_is_viewable_75, sum_is_viewable_100, VTR]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_is_viewable_25,sum_is_viewable_50, sum_is_viewable_75, sum_is_viewable_100, VTR]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_is_viewable_start]
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

  dimension: isp {
    type: string
    view_label: "Supplemental Facets"
    label: "ISP"
    description: "The Internet Service Provider (ISP) of the user who saw the impression."
    sql: ${TABLE}.ISP ;;
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_media_markup]
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
    drill_fields: [platform_client_id, campaign, flight, flight_media, sum_media_price]
  }

  measure: avg_media_price {
    type: average
    label: "Average Media Price"
    value_format_name: decimal_2
    description: "The average price of all media."
    sql: ${media_price} ;;
    drill_fields: [platform_client_id, campaign, avg_media_price]
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
    drill_fields: [platform_client_id, campaign, sum_muted]
  }

  dimension: normalized_domain {
    type: string
    label: "Normalized Domain"
    view_label: "Supplemental Facets"
    description: "The normalized domain of the URL where the impression was viewed."
    sql: CASE WHEN ${TABLE}.IS_MOBILE_APP = 1 THEN ${TABLE}.APP_BUNDLE ELSE ${TABLE}.NORMALIZED_DOMAIN END;;
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
    drill_fields: [platform_client_id, campaign,flight, flight_media, sum_payout]
  }

  measure: sum_payout_usd {
    type: sum
    label: "Gross Payout USD"
    description: "The total amount due to the Publisher for the media in the Publisher's (supply) currency."
    value_format_name: decimal_2
    sql: ${payout} * ${usd_exchange_rate} ;;
    drill_fields: [platform_client_id, campaign,flight, flight_media, sum_payout]
  }

  dimension: payout_currency {
    type: string
    label: "Payout Currency"
    description: "The Publisher's (supply) currency."
    sql: ${TABLE}.PAYOUT_CURRENCY ;;
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
    drill_fields: [platform_client_id, campaign,flight, flight_media, sum_pc_impressions]
  }

  dimension: pdata1 {
    type: string
    view_label: "Supplemental Facets"
    label: "PD1"
    description: "Passed Data 1 - A text field that allows the publisher to pass data back when serving the impression."
    sql: ${TABLE}.PDATA1 ;;
  }

  dimension: pdata2 {
    type: string
    view_label: "Supplemental Facets"
    label: "PD2"
    description: "Passed Data 2 - A second text field that allows the publisher to pass data back when serving the impression."
    sql: ${TABLE}.PDATA2 ;;
  }

  dimension: placement_id {
    type: string
    label: "Placement ID"
    description: "The ID of the Placement that sent the request."
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: placement_date {
    type: string
    hidden:  yes
    sql: ${TABLE}.PLACEMENT_DATE ;;
  }

  dimension: platform {
    type: string
    label: "Platform"
    view_label: "Supplemental Facets"
    description: "The platform where the impression was seen examples include Android, iOS, Mac, Windows, etc."
    sql: ${v_attribute_lookup_platformid.description} ;;
  }

  dimension: platformid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.PLATFORM ;;
  }

  dimension: platform_client_id {
    type: string
    label: "Platform Client ID"
    view_label: "Supplemental Facets"
    description: "The Platform Client owning flight media served in the impression"
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    hidden: yes
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

  measure: impressons_player_size_large {
    type: sum
    label: "Impressions - Player Size Large"
    description: "Number of impressions served on a large sized player. (In Pixels, Width:601+ | Height:376+)"
    sql: CASE WHEN ${TABLE}.PLAYER_SIZE in (5, 6) then ${impressions} ELSE '0' END;;
  }

  measure: impressons_player_size_medium {
    type: sum
    label: "Impressions - Player Size Medium"
    description: "Number of impressions served on a medium sized player. (In Pixels, Width:301-600 | Height:251-375)"
    sql: CASE WHEN ${TABLE}.PLAYER_SIZE in (3, 4) then ${impressions} ELSE '0' END;;
  }

  measure: impressons_player_size_small {
    type: sum
    label: "Impressions - Player Size Small"
    description: "Number of impressions served on a small sized player. (In Pixels, Width:0-300 | Height:0-250)"
    sql: CASE WHEN ${TABLE}.PLAYER_SIZE in (1, 2) then ${impressions} ELSE '0' END;;
  }

  measure: impressons_player_size_unknown {
    type: sum
    label: "Impressions - Player Size Unknown"
    description: "Number of impressions served on a unknown sized player."
    sql: CASE WHEN ${TABLE}.PLAYER_SIZE in (0) then ${impressions} ELSE '0' END;;
  }

  dimension: poc_impressions {
    type: string
    hidden: yes
    sql: ${TABLE}.POC_IMPRESSIONS ;;
  }

  dimension: postalcode {
    type: zipcode
    label: "Postal Code"
    view_label: "Supplemental Facets"
    description: "The Postal Code of the viewer who saw the impression."
    sql: RAWDB.DecryptPostalcode(${TABLE}.POSTALCODE) ;;
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

  dimension: preferred_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.PREFERRED_EXCHANGE_RATE ;;
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
    drill_fields: [platform_client_id, campaign,flight, flight_media, sum_primary_clicks]
  }


  dimension: rpu_type_id {
    type: number
    label: "RPU Type ID"
    description: "Update"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.RPU_TYPE_ID ;;
  }

  dimension: publisher_requests {
    type: number
    hidden: yes
    sql: ${TABLE}.PUBLISHER_REQUESTS ;;
  }

  measure: sum_publisher_requests {
    type: sum
    label: "Publisher Requests"
    description: "The total number of all requests"
    value_format_name: decimal_0
    sql: ${publisher_requests} ;;
    drill_fields: [v_placement_details_base.platform_client, v_placement_details_base.partner_name, placement_id, sum_publisher_requests]
  }


  measure: sum_publisher_requests_yesterday {
    type: sum
    label: "Publisher Requests - Yesterday"
    description: "The total number of all requests for yesterday based on supply date."
    value_format_name: decimal_0
    sql: ${publisher_requests} ;;
    filters: {
      field: supply_date_date
      value: "Yesterday"
    }
    drill_fields: [v_placement_details_base.platform_client, v_placement_details_base.partner_name, placement_id, sum_publisher_requests]
  }

  measure: sum_publisher_requests_previous_day {
    type: sum
    label: "Publisher Requests - 2 Days Ago"
    description: "The total number of all requests for 2 days ago based on supply date."
    value_format_name: decimal_0
    sql: ${publisher_requests} ;;
    filters: {
      field: supply_date_date
      value: "2 Days Ago"
    }
    drill_fields: [v_placement_details_base.platform_client, v_placement_details_base.partner_name, placement_id, sum_publisher_requests]
  }



  measure: sum_served_requests {
    type: sum
    label: "Served Requests"
    description: "The total number of all requests that were served.  These may or may not become impressions, but they were intented to be impressions; however, they might not have won
    at auction or there may have been some technical drop-off or any other reason why they did not turn into impressions."
    value_format_name: decimal_0
    sql: ${served_requests} ;;
    drill_fields: [v_placement_details_base.platform_client, v_placement_details_base.partner_name, placement_id, sum_publisher_requests]
  }

  measure: drop_off_rate {
    type: number
    label: "Drop Off Rate"
    description: "The percentage of served requests that did not become impressions.  1- (impressions / served requests)"
    value_format_name: percent_2
    sql:  1-(Coalesce(${sum_impressions}/nullif(${sum_served_requests},0),0)) ;;
  }


  dimension: region {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION ;;
  }

  dimension: region_description {
    type: string
    view_label: "Supplemental Facets"
    label: "Region"
    description: "The geographic region where the request came from. "
    sql: ${TABLE}.REGION_DESCRIPTION ;;
    suggestable: no
  }

  dimension: raw_region_date {
    type: date_time
    label: "Region Date (raw)"
    view_label: "Dates"
    description: "The raw date/time of the impression in the Regional timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension_group: region_date {
    type: time
    label: "Region"
    view_label: "Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the impression in the Regional timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: region_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_EXCHANGE_RATE ;;
  }

  dimension: revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.REVENUE ;;
  }

  dimension: revenue_currency {
    type: string
    label:  "Revenue Currency"
    sql: ${TABLE}.REVENUE_CURRENCY ;;
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

  dimension: social_ab_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.SOCIAL_AB_IMPRESSIONS ;;
  }

  measure: sum_social_ab_impressions {
    type: sum
    label: "Social AB Impressions"
    description: "Impression served to users in the AB Social Grade"
    value_format_name: decimal_0
    sql: ${social_ab_impressions} ;;
  }

  dimension: social_abc_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.SOCIAL_ABC_IMPRESSIONS ;;
  }

  measure: sum_social_abc_impressions {
    type: sum
    label: "Social ABC Impressions"
    description: "Impressions served to users in the ABC Social Grade"
    value_format_name: decimal_0
    sql: ${social_abc_impressions} ;;
  }

  dimension: raw_supply_date {
    type: date_time
    label: "Supply Date (raw)"
    view_label: "Dates"
    description: "The raw date/time of the impression in the Supply timezone"
    sql: ${TABLE}.SUPPLY_DATE ;;
  }

  dimension_group: supply_date {
    type: time
    label: "Supply"
    view_label: "Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the impression in the Supply timezone"
    sql: ${TABLE}.SUPPLY_DATE ;;
  }

  dimension_group: local_supply_date {
    type: time
    label: "Local Supply"
    view_label: "Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the impression in the Supply timezone in accordance with season clock shift"
    sql: ${TABLE}.LOCAL_SUPPLY_DATE ;;
  }

  dimension: supply_exchange_fee {
    type: string
    hidden: yes
    sql: ${TABLE}.SUPPLY_EXCHANGE_FEE ;;
  }

  measure: sum_supply_exchange_fee {
    type: sum
    hidden: yes
    value_format_name:decimal_2
    sql: ${TABLE}.SUPPLY_EXCHANGE_FEE ;;
  }

  measure: sum_supply_exchange_fee_calc {
    type: sum
    label: "Exchange Fee - Supply"
    description: "Total costs incurred from exchange fees in the supply currency"
    value_format_name:decimal_2
    sql: ${supply_exchange_rate} * ${exchange_fee} ;;
  }

  measure: sum_demand_exchange_fee_calc {
    type: sum
    label: "Exchange Fee - Demand"
    description: "Total costs incurred from exchange fees in the demand currency"
    value_format_name:decimal_2
    sql: COALESCE(${supply_exchange_rate} * ${exchange_fee} * (1/nullif(${preferred_exchange_rate},0)),0) ;;
  }

  measure: exchange_fee_usd {
    type: sum
    label: "Exchange Fee - USD"
    description: "Total costs incurred from exchange fees in the USD currency"
    value_format_name:decimal_2
    sql: ${supply_exchange_rate} * ${exchange_fee} * ${usd_exchange_rate} ;;
  }

  dimension: supply_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.SUPPLY_EXCHANGE_RATE ;;
  }

  dimension: supply_payout {
    type: number
    hidden: yes
    sql: ${TABLE}.SUPPLY_PAYOUT ;;
  }

  measure: sum_supply_payout {
    type: sum
    hidden: yes
    label: "Gross Payout Minus IBMM - Supply"
    description: "Gross Payout (Net Payout+ Exchange fee) or Media_price minus IBMM converted to the supply currency"
    value_format_name: decimal_2
    sql: ${supply_payout} ;;
  }

  measure: sum_supply_payout_usd {
    type: sum
    hidden: yes
    label: "Gross Payout Minus IBMM - USD"
    description: "Gross Payout (Net Payout+ Exchange fee) or Media_price minus IBMM in USD"
    value_format_name: decimal_2
    sql: ${demand_payout} * ${demand_usd_exchange_rate} ;;
  }

  measure: sum_net_payout {
    type: sum
    label: "Net Payout - Supply"
    description: "Net Payout removing exchange fee and IBMM converted to the supply currency"
    value_format_name: decimal_2
    sql: ${payout} - ${exchange_fee};;
  }

  measure: sum_net_payout_usd {
    type: sum
    label: "Net Payout - USD"
    description: "Net Payout removing exchange fee and IBMM in USD"
    value_format_name: decimal_2
    sql: ${payout} * ${usd_exchange_rate} - ${exchange_fee} * ${usd_exchange_rate};;
  }

  measure: sum_net_payout_demand {
    type: number
    label: "Net Payout - Demand"
    description: "Net Payout removing exchange fee and IBMM in demand currency"
    value_format_name: decimal_2
    sql: ${sum_demand_payout} - ${sum_demand_exchange_fee_calc};;
  }

  dimension: supply_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.SUPPLY_REVENUE ;;
  }

  measure: sum_supply_revenue {
    type: sum
    label: "Net Spend - Supply"
    description: "The total Spend converted to the supply currency"
    value_format_name: decimal_2
    sql: ${TABLE}.SUPPLY_REVENUE ;;
  }

  dimension: supply_timezone {
    type: string
    hidden: yes
    sql: ${TABLE}.SUPPLY_TIMEZONE ;;
  }

  dimension: third_party_viewable {
    type: number
    hidden: yes
    sql: ${TABLE}.THIRD_PARTY_VIEWABLE ;;
  }

  dimension: tracking_cost_currency {
    type: string
    label: "Tracking Cost Currency"
    description: "The native currency of the tracking costs."
    sql: ${TABLE}.TRACKING_COST_CURRENCY ;;
  }

  dimension: tracking_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.TRACKING_COST_MARKUP ;;
  }

  measure: sum_tracking_cost_markup {
    type: sum
    label: "Tracking Cost Markup"
    value_format_name: decimal_2
    description: "The total of all markups on tracking costs."
    sql: ${TABLE}.TRACKING_COST_MARKUP ;;
  }

  dimension: transparency_type {
    type: string
    label: "Transparency Type"
    hidden: yes
    description: "The transparency type of the Placement"
    sql: case when ${TABLE}.TRANSPARENCY_TYPE = 0 then 'Non-transparent'
              when ${TABLE}.TRANSPARENCY_TYPE = 1 then 'Transparent'
              when ${TABLE}.TRANSPARENCY_TYPE = 5 then 'Price Non-Transparent'
              else 'Unknown Type' end;;
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

  dimension: usd_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.USD_EXCHANGE_RATE ;;
  }

  dimension: version_no {
    type: string
    hidden: yes
    sql: ${TABLE}.VERSION_NO ;;
  }

  dimension: videology_viewable {
    type: string
    hidden: yes
    sql: ${TABLE}.VIDEOLOGY_VIEWABLE ;;
  }

  dimension: viewability_measurable_code {
    type: string
    hidden: yes
    sql: ${TABLE}.VIEWABILITY_MEASURABLE_CODE ;;
  }

  dimension: winning_bid {
    type: string
    hidden: yes
    sql: ${TABLE}.WINNING_BID_PRICE ;;
  }

  measure: avg_winning_bid {
    type: average
    label: "Average Winning Bid"
    description: "Average Cost of the winning auction bid"
    value_format_name: decimal_2
    sql: ${winning_bid} ;;
    drill_fields: [v_placement_details_base.platform_client, v_placement_details_base.partner_name, placement_id, avg_winning_bid]
  }

  dimension: winning_bids {
    type: string
    hidden: yes
    sql: ${TABLE}.WINNING_BIDS ;;
  }

  measure: sum_winning_bids {
    type: sum
    label: "Winning Bids"
    description: "Total number of winning bids"
    value_format_name: decimal_0
    sql: ${winning_bids} ;;
    drill_fields: [v_placement_details_base.platform_client, v_placement_details_base.partner_name, placement_id, sum_winning_bids]
  }

  measure: fill_rate {
    type: number
    label: "Fill Rate"
    description: "The percentage of requests that turn into impressions."
    value_format_name: percent_2
    sql: coalesce(${sum_impressions}/nullif(${sum_publisher_requests},0),0);;
  }

  measure: media_ecpm_usd {
    type: number
    label: "Media eCPM - USD"
    description: "The effective cost of media per 1000 impressions in USD"
    value_format_name: usd
    sql: Coalesce((${sum_supply_payout_usd}/nullif(${sum_impressions},0)) * 1000,0) ;;
  }

  measure: inventory_contribution_usd {
    type: number
    label: "Inventory Contribution - USD"
    description: "The dollar amount difference between gross spend and media cost."
    value_format_name: usd
    sql: ${sum_demand_gross_spend_usd} - ${sum_payout_usd} ;;
  }

  measure: margin_usd {
    type: number
    label: "Margin - USD"
    description: "The difference between spend and media cost as a percentage of spend in USD."
    value_format_name: percent_2
    sql: Coalesce((${sum_demand_gross_spend_usd}::double - ${sum_payout_usd}::double) / nullif(${sum_demand_gross_spend_usd}::double,0),0) ;;
  }

  measure: tech_costs_usd {
    type: number
    label: "Tech Costs - USD"
    description: "$0.0016325 for every 1000 publisher requests"
    value_format_name: usd
    sql:( ${sum_publisher_requests}/1000) *0.0016325 ;;
  }

  measure: true_media_cost_usd {
    type: number
    label: "True Media Costs - USD"
    description: "The cost of media plus tech costs"
    value_format_name: usd
    sql: ${sum_supply_payout_usd} + ${tech_costs_usd} ;;
  }

  measure: true_media_ecpm_usd {
    type: number
    label: "True Media eCPM - USD"
    description: "The effective true media cost for every 1000 impressions"
    value_format_name: usd
    sql: coalesce((${true_media_cost_usd}/nullif(${sum_impressions},0)) * 1000,0) ;;
  }

  measure: true_inventory_contribution {
    type: number
    label: "True Inventory Contribution - USD"
    description: "Gross Spend minus true media costs"
    value_format_name: usd
    sql: ${sum_demand_gross_spend_usd}::double - ${true_media_cost_usd}::double ;;
  }

  measure: true_margin {
    type: number
    label: "True Margin"
    description: "True Inventory Contribution (gross spend - true media costs) divided by gross spend"
    value_format_name: percent_2
    sql: coalesce(${true_inventory_contribution}/nullif(${sum_demand_gross_spend_usd}::double,0),0) ;;
  }

  measure: overhead {
    type: number
    label: "Overhead"
    description: "How much the media cost has to be marked up in order to recoup the tech cost associated with that exchange.
    The lower the number, the less we have to mark up media cost, so the greater the margin we pocket.
    The greater the number, the more it eats into the margin we make on that exchange."
    value_format_name: percent_2
    sql: coalesce((${true_media_ecpm_usd}::double - ${media_ecpm_usd}::double) / nullif(${media_ecpm_usd}::double,0),0) ;;
  }

  measure: contrib_req_ecpm {
    type: number
    label: "Contrib.-Req eCPM"
    description: "True Inventory Contribution per every 1000 publisher requests"
    value_format: "$0.0000"
    sql: coalesce((${true_inventory_contribution} / nullif(${sum_publisher_requests}::double,0)) * 1000,0) ;;
  }

  measure: req_efficiency {
    type: number
    label: "Request Efficiency"
    description: "The multiple in inventory contribution we make for every dollar we invest in tech cost for this exchange.
    The greater the number, the more this exchange 'pays off' for us.
    The lower the number, the harder we have to work to cherry-pick what we like from this exchange."
    value_format_name: decimal_2
    sql:  ${contrib_req_ecpm}::double / 0.0016325 ;;
  }

  measure: inventory_source_score {
    type: number
    label: "Inventory Source Score"
    description: "A desirability score per inventory source. The higher the score, the more we want to work with this inventory source."
    value_format_name: decimal_2
    sql: coalesce(${req_efficiency}::double / nullif(${overhead}::double,0),0) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: min_gmt_date {
    type: date
    label: "Minimum Date"
    view_label: "Dates"
    description: "Oldest date in database table"
    sql: min(${raw_gmt_date}) ;;
  }

  measure: max_gmt_date {
    type: date
    label: "Maximum Date"
    view_label: "Dates"
    description: "Newest date in database table"
    sql: max(${raw_gmt_date}) ;;
  }

  measure: count_date {
    type: number
    label: "# of Days"
    view_label: "Dates"
    description: "# of Days in the database table"
    sql: count(distinct ${gmt_date_date}) ;;
  }

  dimension: presence_of_ttid {
    type: number
    label: "Presence of TTID"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.PRESENCE_OF_TTID ;;
  }

  dimension: presence_of_dvid {
    type: number
    label: "Presence of DVID"
    view_label: "Supplemental Facets"
    sql: ${TABLE}.PRESENCE_OF_DVID ;;
  }

  dimension: presence_of_id {
    type: number
    label: "Presence of ID"
    description: "Will be 1 if either TTID or DVID was present"
    view_label: "Supplemental Facets"
    sql: case when ${TABLE}.PRESENCE_OF_TTID =1 or ${TABLE}.PRESENCE_OF_DVID =1 then 1 else 0 end  ;;
  }

  dimension: supply_month {
    type: number
    label: "Supply date month"
    view_label: "Dates"
    sql: date_part('month', ${TABLE}.Supply_date) ;;
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
    hidden: yes
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
          WHEN ${TABLE}.CONSENT_DECISION = 3 THEN 'Required Consent Given'
          ELSE 'Other' END  ;;
  }

  dimension: consent_present {
    type: string
    label: "GDPR Consent Data Present"
    view_label: "Supplemental Facets"
    description: "Description of whether user's consent string contains any information or not. Presence or non-presence of Data can indicate consent or non-consent decision."
    sql: CASE WHEN ${TABLE}.CONSENT_PRESENT = 0 THEN 'Consent Data Not Present'
         WHEN  ${TABLE}.CONSENT_PRESENT = 1 THEN 'Consent Data Present'
         ELSE 'Other' END    ;;
  }

  measure: sum_impressions_last_hour {
    type: sum
    label: "Impressions - Last Hour"
    description: "The total impressions served within the last hour"
    value_format_name: decimal_0
    sql: case when ${gmt_date_raw} = ${v_load_tracking.load_through_date} then ${impressions} else 0 end ;;
  }

  measure: sum_impressions_last_24_hours {
    type: sum
    label: "Impressions - Last 24 Hours"
    description: "The total impressions served within the last 24 hours"
    value_format_name: decimal_0
    sql: case when ${gmt_date_raw} > TIMESTAMPADD('day', -1, ${v_load_tracking.load_through_date}) and ${gmt_date_raw} <= ${v_load_tracking.load_through_date} then ${impressions} else 0 end ;;
  }

  measure: net_erpm_supply {
    type: number
    label: "Net eRPM - Supply"
    value_format_name: decimal_2
    description: "Net Publisher Payout / (Impressions/1000)"
    sql: COALESCE(${sum_net_payout}/ NULLIF((${sum_impressions}/1000),0),0) ;;
  }

  measure: gross_erpm_supply {
    type: number
    label: "Gross eRPM - Supply"
    value_format_name: decimal_2
    description: "Gross Publisher Payout / (Impressions/1000)"
    sql: COALESCE(${sum_payout}/ NULLIF((${sum_impressions}/1000),0),0) ;;
  }

  measure: payout_to_accrue {
    type: sum
    label: "Payout To Accrue"
    sql: CASE WHEN ${v_customer_details.customer_office_id} = ${v_placement_details_base.partner_office_id} then ${payout} else 0 end;;
  }

  measure: revenue_to_accrue {
    type: sum
    label: "Revenue To Accrue"
    sql: CASE WHEN ${v_customer_details.customer_office_id} = ${v_placement_details_base.partner_office_id} then ${TABLE}.REVENUE else 0 end;;
  }

  dimension: supply_load_through_date {
    type: date_raw
    hidden: yes
    sql: date_trunc('day', TIMESTAMPADD('day', -1, TIMESTAMPADD(hour, ${v_placement_timezone.utc_offset}::INTEGER, ${v_load_tracking.load_through_date}))) ;;
  }

  measure: sum_publisher_requests_yesterday_2 {
    type: sum
    label: "Publisher Requests - Yesterday"
    description: "The total number of all requests for yesterday based on supply date"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${publisher_requests} else 0 end ;;
  }

  measure: sum_eligible_requests_yesterday {
    type: sum
    label: "Eligible Requests - Yesterday"
    description: "Sum of publisher requests for yesterday where rejection code is not Blacklist, Bad Geo, Whitelist, Placement Freq Cap or Bot Rejection"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${eligible_requests} else 0 end ;;
  }

  measure: eligible_requests_pct_yesterday {
    type: number
    label: "% Eligible Requests - Yesterday"
    description: "The percentage of publisher requests for yesterday where rejection code is not Blacklist, Bad Geo, Whitelist, Placement Freq Cap or Bot Rejection"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: percent_0
    sql: coalesce(${sum_eligible_requests_yesterday} / nullif(${sum_publisher_requests_yesterday_2}, 0), 0) ;;
  }

  measure: sum_served_requests_yesterday {
    type: sum
    label: "Served Requests - Yesterday"
    description: "The total number of all requests that were served yesterday. These may or may not become impressions, but they were intended to be impressions; however, they might not have won at auction or there may have been some technical drop-off or any other reason why they did not turn into impressions"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${TABLE}.ADSERVER_CODE = 1 and ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${publisher_requests} else 0 end ;;
  }

  measure: served_requests_pct_yesterday {
    type: number
    label: "% Served Requests - Yesterday"
    description: "The percentage of eligible publisher requests that were served yesterday"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: percent_0
    sql: coalesce(${sum_served_requests_yesterday} / nullif(${sum_eligible_requests_yesterday}, 0), 0) ;;
  }

  measure: sum_impressions_yesterday {
    type: sum
    label: "Impressions - Yesterday"
    description: "The total impressions yesterday"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${impressions} else 0 end ;;
  }

  measure: drop_off_rate_yesterday {
    type: number
    label: "Drop Off Rate - Yesterday"
    description: "The percentage of served requests for yesterday that did not become impressions"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(1 - ${sum_impressions_yesterday} / nullif(${sum_served_requests_yesterday}, 0), 0) ;;
  }

  measure: fill_rate_yesterday {
    type: number
    label: "Fill Rate - Yesterday"
    description: "The percentage of requests that turned into impressions yesterday"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(${sum_impressions_yesterday} / nullif(${sum_eligible_requests_yesterday}, 0), 0) ;;
  }

  measure: sum_house_impressions_yesterday {
    type: sum
    label: "House Impressions - Yesterday"
    description: "Sum of filler campaign impressions yesterday"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${house_impressions} else 0 end ;;
  }

  measure: sum_completed_100_yesterday {
    type: sum
    label: "Completed 100 - Yesterday"
    description: "The total of all impressions yesterday which were 100% completed"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${completed_100} else 0 end ;;
  }

  measure: sum_completed_pct_impressions_yesterday {
    type: sum
    label: "Completed Percent Impressions - Yesterday"
    description: "The total number of impressions yesterday where completed (completed 100) is measured"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${completed_pct_impressions} else 0 end ;;
  }

  measure: vtr_yesterday {
    type: number
    label: "VTR - Yesterday"
    description: "Video Through Rate yesterday - the percentage of all impressions yesterday which were 100% completed"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(1.0 * ${sum_completed_100_yesterday} / nullif(${sum_completed_pct_impressions_yesterday}, 0), 0) ;;
  }

  measure: sum_clicks_yesterday {
    type: sum
    label: "Clicks - Yesterday"
    description: "The total of all clicks (where an impression was clicked upon) yesterday"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${clicks} else 0 end ;;
  }

  measure: sum_click_impressions_yesterday {
    type: sum
    label: "Click Impressions - Yesterday"
    description: "The total of all impressions yesterday where clicks are tracked"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= ${supply_load_through_date} and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${click_impressions} else 0 end ;;
  }

  measure: ctr_yesterday {
    type: number
    label: "CTR - Yesterday"
    description: "Click Through Rate yesterday - the percentage of all impressions yesterday which were clicked"
    view_label: "Yesterday Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(1.0 * ${sum_clicks_yesterday} / nullif(${sum_click_impressions_yesterday}, 0), 0) ;;
  }

  measure: sum_publisher_requests_day_before_yesterday {
    type: sum
    label: "Publisher Requests - Day Before Yesterday"
    description: "The total number of all requests for day before yesterday based on supply date"
    view_label: "Day Before Yesterday Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD('day', -1, ${supply_load_through_date}) and ${supply_date_raw} < ${supply_load_through_date} then ${publisher_requests} else 0 end ;;
  }

  measure: publisher_requests_diff_day_before_yesterday {
    type: number
    label: "Publisher Requests Diff - Day Before Yesterday"
    description: "Difference between publisher requests day before yesterday and publisher requests yesterday"
    view_label: "Day Before Yesterday Request and Impression Metrics"
    value_format: "#,##0;(#,##0)"
    sql: ${sum_publisher_requests_day_before_yesterday} - ${sum_publisher_requests_yesterday_2} ;;
  }

  measure: sum_completed_100_last_14_days {
    type: sum
    label: "Completed 100 - Last 14 Days"
    description: "The total of all impressions during last 14 days which were 100% completed"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD('day', -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${completed_100} else 0 end ;;
  }

  measure: sum_completed_pct_impressions_last_14_days {
    type: sum
    label: "Completed Percent Impressions - Last 14 Days"
    description: "The total number of impressions during last 14 days where completed (completed 100) is measured"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD('day', -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${completed_pct_impressions} else 0 end ;;
  }

  measure: vtr_last_14_days {
    type: number
    label: "VTR - Last 14 Days"
    description: "Video Through Rate during last 14 days - the percentage of all impressions during last 14 days which were 100% completed"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(1.0 * ${sum_completed_100_last_14_days} / nullif(${sum_completed_pct_impressions_last_14_days}, 0), 0) ;;
  }

  measure: sum_clicks_last_14_days {
    type: sum
    label: "Clicks - Last 14 Days"
    description: "The total of all clicks (where an impression was clicked upon) during last 14 days"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD('day', -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${clicks} else 0 end ;;
  }

  measure: sum_click_impressions_last_14_days {
    type: sum
    label: "Click Impressions - Last 14 Days"
    description: "The total of all impressions during last 14 days where clicks are tracked"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD('day', -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD('day', 1, ${supply_load_through_date}) then ${click_impressions} else 0 end ;;
  }

  measure: ctr_last_14_days {
    type: number
    label: "CTR - Last 14 Days"
    description: "Click Through Rate during last 14 days - the percentage of all impressions during last 14 days which were clicked"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(1.0 * ${sum_clicks_last_14_days} / nullif(${sum_click_impressions_last_14_days}, 0), 0) ;;
  }

  measure: sum_impressions_last_14_days {
    type: sum
    label: "Impressions - Last 14 Days"
    description: "The total impressions during last 14 days"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD(day, -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD(day, 1, ${supply_load_through_date}) then ${impressions} else 0 end ;;
  }

  measure: sum_served_requests_last_14_days {
    type: sum
    label: "Served Requests - Last 14 Days"
    description: "The total number of all requests that were served during last 14 days. These may or may not become impressions, but they were intended to be impressions; however, they might not have won at auction or there may have been some technical drop-off or any other reason why they did not turn into impressions"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${TABLE}.ADSERVER_CODE = 1 and ${supply_date_raw} >= TIMESTAMPADD(day, -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD(day, 1, ${supply_load_through_date}) then ${publisher_requests} else 0 end ;;
  }

  measure: drop_off_rate_last_14_days {
    type: number
    label: "Drop Off Rate - Last 14 Days"
    description: "The percentage of served requests during last 14 days that did not become impressions"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: percent_2
    sql: coalesce(1 - ${sum_impressions_last_14_days} / nullif(${sum_served_requests_last_14_days}, 0), 0) ;;
  }

  measure: sum_publisher_requests_last_14_days {
    type: sum
    label: "Publisher Requests - Last 14 Days"
    description: "The total number of all requests during last 14 days based on supply date"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: case when ${supply_date_raw} >= TIMESTAMPADD(day, -13, ${supply_load_through_date}) and ${supply_date_raw} < TIMESTAMPADD(day, 1, ${supply_load_through_date}) then ${publisher_requests} else 0 end ;;
  }

  measure: average_publisher_requests_last_14_days {
    type: number
    label: "Average Publisher Requests - Last 14 Days"
    description: "The average daily number of requests during last 14 days based on supply date"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format_name: decimal_0
    sql: ${sum_publisher_requests_last_14_days} / 14 ;;
  }

  measure: publisher_requests_diff_last_14_days {
    type: number
    label: "Publisher Requests Diff - Last 14 Days"
    description: "Difference between average publisher requests during last 14 days and publisher requests yesterday"
    view_label: "Last 14 Days Request and Impression Metrics"
    value_format: "#,##0;(#,##0)"
    sql: ${average_publisher_requests_last_14_days} - ${sum_publisher_requests_yesterday_2} ;;
  }

  measure: total_cost_without_tech_fee {
    type: string
    label: "Total Cost (Without Tech-Fee)"
    description: "Total Cost (Without Tech-Fee)."
    sql: CONCAT(CASE WHEN count(distinct ${v_plan_currency.currency_id}) = 1
          THEN MAX(${v_plan_currency.currency_symbol})
          ELSE NULL END, ROUND(${total_cost_without_tech_fee_base}, 2)) ;;
    order_by_field: total_cost_without_tech_fee_base
  }

  measure: total_cost_without_tech_fee_base {
    type: number
    hidden: yes
    sql: ${sum_media_price} +
          ${total_addon_product_cost} +
          ${sum_demand_adserving_cost} +
          ${sum_demand_bt_cluster_cost} +
          ${v_bt_cost_attributes_hourly_analytics.sum_demand_bt_provider_cost} +
          ${sum_demo_provider_data_cost} +
          ${sum_demand_tracking_cost} ;;
  }

  measure: tech_fee {
    type: string
    label: "Tech-Fee"
    description: "Tech-Fee."
    sql: CONCAT(CASE WHEN count(distinct ${v_plan_currency.currency_id}) = 1
          THEN MAX(${v_plan_currency.currency_symbol})
          ELSE NULL END, ROUND(${tech_fee_base}, 2)) ;;
    order_by_field: tech_fee_base
  }

  measure: tech_fee_base {
    type: number
    hidden: yes
    sql: ${total_cost_without_tech_fee_base} * 0.075 ;;
  }

  measure: total_cost {
    type: string
    label: "Total Cost"
    description: "Total Cost."
    sql: CONCAT(CASE WHEN count(distinct ${v_plan_currency.currency_id}) = 1
          THEN MAX(${v_plan_currency.currency_symbol})
          ELSE NULL END, ROUND(${total_cost_base}, 2)) ;;
    order_by_field: total_cost_base
  }

  measure: total_cost_base {
    type: number
    hidden: yes
    sql: ${total_cost_without_tech_fee_base} + ${tech_fee_base} ;;
  }

  measure: estimated_operational_margin {
    type: number
    label: "Estimated Operational Margin"
    description: "Estimated Operational Margin."
    value_format_name: percent_2
    sql: case
          when ${sum_demand_gross_spend} = 0 then NULL
          else (${sum_demand_gross_spend}-${total_cost_base})/${sum_demand_gross_spend}
         end;;
  }

  measure: client_spend {
    type: sum
    label: "Client Spend"
    value_format_name: decimal_2
    description: "Total Client spend converted to Gross Spend Currency: Gross Spend * (1- Campaign Discount)"
    sql:${demand_revenue} * (1 + ${v_flight_media_details_base.agency_fee}) * (1- ${v_campaign_details_base.spend_discount});;
  }

  dimension: is_ipv6 {
    type: yesno
    description: "Identifies if the IP address is an IPv6 type"
    sql: ${TABLE}.is_ipv6 = 1;;
  }

  measure: sum_revenue {
    type: sum
    label: "Revenue"
    sql: ${revenue} ;;
  }

  measure: sum_floor_price {
    type: sum
    label: "Floor Price"
    description: "The floor price of all bids"
    value_format_name: decimal_2
    sql: ${floor_price} ;;
  }

  measure: count_distinct_demand_date {
    type: count_distinct
    hidden: yes
    sql: ${demand_date_date} ;;
  }

  measure: avg_impressions {
    type: average
    hidden: yes
    sql: ${impressions} ;;
  }

  measure: min_impressions {
    type: min
    hidden: yes
    sql: ${impressions} ;;
  }

  measure: max_impressions {
    type: max
    hidden: yes
    sql: ${impressions} ;;
  }

  dimension: cookie_set_metrics {
    type: string
    sql:  CASE WHEN ${TABLE}.ASSET_GROUP_RESTRICTED_CLEARCAST_CODES='cd|1' THEN 'Cookies set'
        WHEN ${TABLE}.ASSET_GROUP_RESTRICTED_CLEARCAST_CODES='uc|1' THEN 'Cookies enabled'
        WHEN ${TABLE}.ASSET_GROUP_RESTRICTED_CLEARCAST_CODES='uc|0' THEN 'Cookies disabled'
        END ;;
  }

  measure:  count_cookies_dropped{
    label: "Count of Cookies Dropped"
    type: sum
    sql: CASE WHEN ${TABLE}.ASSET_GROUP_RESTRICTED_CLEARCAST_CODES='cd|1' THEN 1 END;;
  }
}
