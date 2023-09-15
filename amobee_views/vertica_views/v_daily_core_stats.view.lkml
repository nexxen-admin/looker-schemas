view: v_daily_core_stats {
  label: "Impression Metrics"
  sql_table_name:
  {% if _explore._name == 'v_demand_metrics' and v_campaign_bookings._in_query %}
    (select * from DEMAND_MART.DAILY_CORE_STATS as v_daily_core_stats
      where {% condition demand_date %} v_daily_core_stats.demand_date {% endcondition %})
    {% else %} DEMAND_MART.DAILY_CORE_STATS {% endif %} ;;
  suggestions: no

  dimension: primary_key {
    type: number
    label: "Primary Key - Core Stats"
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK_ID;;
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

  measure: measure_space_holder {
    type: number
    label: "Space Holder"
    view_label: "Custom Dimensions"
    sql:'';;
  }

  measure: measure_space_holder_b {
    type: number
    label: "Space Holder"
    view_label: "Custom Dimensions"
    sql:'';;
  }

  dimension: addon_product_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.ADDON_PRODUCT_COST ;;
  }

  measure: sum_addon_product_cost {
    type: sum
    label: "Addon Product Cost"
    description: "The total of all costs for add-ons"
    value_format_name: decimal_2
    sql: ${addon_product_cost} ;;
  }

  measure: avg_addon_product_cost {
    type: average
    label: "Average Addon Product Costs"
    description: "The average of all costs for add-ons"
    value_format_name: decimal_2
    sql: ${addon_product_cost} ;;
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

  measure: sum_adserving_cost_usd {
    type: sum
    label: "Adserving Costs- USD"
    description: "Total of all Adserving converted to USD"
    value_format_name: decimal_2
    sql:  (${demand_adserving_cost} * ${usd_exchange_rate}) ;;
  }


  dimension: adserving_cost_currency {
    type: string
    description: "The native currency of the adserving costs"
    sql: ${TABLE}.ADSERVING_COST_CURRENCY ;;
  }

  dimension: adserving_cost_currency_id {
    type: number
    description: "The native currency id of the adserving costs"
    sql: public.F_CURRENCYID_LOOKUP(${TABLE}.ADSERVING_COST_CURRENCY);;
    value_format_name: id
  }

  dimension: adserving_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.ADSERVING_COST_MARKUP ;;
  }

  measure: sum_adserving_cost_markup {
    type: sum
    label: "Adserving Cost Markup"
    description: "Total of all markup costs on adserving"
    value_format_name: decimal_2
    sql: ${adserving_cost_markup} ;;
  }

  dimension: agency_fee {
    type: number
    hidden: yes
    sql: ${TABLE}.AGENCY_FEE ;;
  }

  measure: sum_agency_fee {
    type: sum
    value_format_name: decimal_2
    hidden: yes
    sql: ${TABLE}.AGENCY_FEE ;;
  }

  dimension: avg_bid_price {
    type: string
    hidden: yes
    sql: ${TABLE}.AVG_BID_PRICE ;;
  }

  dimension: avg_clearing_price {
    type: string
    hidden: yes
    sql: ${TABLE}.AVG_CLEARING_PRICE ;;
  }

  dimension: bid_currency {
    type: string
    description: "The native currency of the bid amount"
    sql: ${TABLE}.BID_CURRENCY ;;
  }

  dimension: autoplay {
    type: number
    hidden: yes
    sql: ${TABLE}.AUTOPLAY ;;
  }

  measure: sum_autoplay {
    type: sum
    description: "Total of all impressions which were autoplay impressions"
    label: "Autoplay"
    value_format_name: decimal_2
    sql: ${autoplay} ;;
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

  measure: grp_audience_size {
    type: max
    label: "GRP Audience Size"
    hidden: yes
    description: "The audience size used in calculating the Gross Rating Points"
    sql: ${v_flight_media_details_base.grp_audience_size} ;;
  }

  measure: GRP {
    type: number
    label: "GRP"
    description: "Gross Rating Points (Billable Impressions / GRP Audience)."
    sql: COALESCE( ((${sum_billable_impressions} * 1.0) / NULLIF(${grp_audience_size},0)) * 100,0) ;;
  }

  measure: trp_audience_size {
    type: max
    label: "TRP Audience Size"
    hidden: yes
    description: "The audience size used in calculating the Targeted Rating Points"
    sql: ${v_flight_media_details_base.trp_audience_size} ;;
  }

  measure: TRP {
    type: number
    label: "TRP"
    description: "Targeted Rating Points (Effective Impressions / GRP Audience)."
    sql:  COALESCE(((${sum_effective_impressions} * 1.0) / NULLIF(${trp_audience_size},0)) * 100,0) ;;
  }

  dimension: billable_units {
    type: number
    hidden: yes
    sql: case when ${v_campaign_details_base.cpu_type_id} in (4,5) then ${TABLE}.DEMAND_REVENUE else ${TABLE}.BILLABLE_UNITS end ;;
  }

  measure: sum_billable_units {
    type: sum
    label: "Billable Units"
    value_format_name: decimal_0
    description: "The number of units that were billable to the client.  The unit will depend on the CPU type."
    sql: ${billable_units} ;;
  }

  measure: sum_billable_units_yesterday_gmt {
    type: sum
    label: "Billable Units - Yesterday UTC"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    description: "The number of units that were billable to the client yesterday in UTC. The unit will depend on the CPU type."
    sql: case when ${gmt_raw} = case when ${v_demand_mart_load_tracking_start_timezone.utc_offset} > 0 then TIMESTAMPADD(d, -1, ${v_demand_mart_load_tracking.load_through_date}) else ${v_demand_mart_load_tracking.load_through_date} end then ${billable_units} else 0 end ;;
  }

  measure: billable_units_pct {
    type: number
    label: "% Billable Units Delivered"
    description: "Percentage of delivered billable units"
    value_format_name: percent_0
    sql: ${sum_billable_units} / nullif(${v_flight_demand_units_budget.sum_units}, 0) ;;
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
    description: "The currency of the BT cluster cost"
    sql: ${TABLE}.BT_CLUSTER_COST_CURRENCY ;;
  }

  dimension: bt_cluster_cost_currency_id {
    type: number
    description: "The currency id of the BT cluster cost"
    sql:public.F_CURRENCYID_LOOKUP (${TABLE}.BT_CLUSTER_COST_CURRENCY) ;;
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
    label: "BT Cluster Provider ID"
    view_label: "Impression Facets"
    description: "The Data Provider used in creating the BT Cluster"
    hidden: yes
    sql: ${TABLE}.BT_CLUSTER_PROVIDER ;;
  }

  dimension: bt_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.BT_COST_MARKUP ;;
  }

  measure: sum_bt_cost_markup {
    type: sum
    label: "BT Cost Markup"
    description: "The total markup cost for Behavioral Targeting"
    value_format_name: decimal_2
    sql: ${bt_cost_markup} ;;
  }

  dimension: btcostcurrency {
    type: string
    label: "BT Cost Currency"
    description: "The currency of the BT Cost"
    sql: ${TABLE}.BTCOSTCURRENCY ;;
  }

  dimension: btcostcurrency_id {
    type: number
    label: "BT Cost Currency ID"
    description: "The currency ID of the BT Cost"
    sql: public.F_CURRENCYID_LOOKUP(${TABLE}.BTCOSTCURRENCY) ;;
    value_format_name: id
  }

  dimension: btproviderdatacost {
    type: number
    hidden: yes
    sql: ${TABLE}.BTPROVIDERDATACOST ;;
  }

  measure: sum_btproviderdatacost {
    type: sum
    label: "BT Provider Data Cost"
    description: "The total of data costs owed to the BT provider"
    value_format_name: decimal_2
    sql: ${btproviderdatacost} ;;
  }

  dimension: btproviderid {
    type: string
    hidden:  yes
    view_label: "Impression Facets"
    label: "BT Provider ID"
    description: "The name of the behavioral targeting provider, if applicable."
    sql: ${TABLE}.btproviderid ;;
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

  measure: ctr {
    type: number
    label: "CTR"
    description: "Click Thru Rate - The number of clicks / the number of click impressions"
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_clicks}/NULLIF(${sum_click_impressions},0),0);;
  }

  dimension: clicktoplay {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICKTOPLAY ;;
  }

  measure: demand_cpm {
    type: number
    label: "CPM - Demand"
    value_format_name: decimal_2
    description: "(Media Price / Impressions) * 1000"
    sql: COALESCE(${sum_media_price} / NULLIF(${sum_billable_impressions},0),0) * 1000  ;;
  }

  measure: sum_clicktoplay {
    type: sum
    label: "Click to Play"
    description: "The total of all impressions that were Click to Play"
    value_format_name: decimal_0
    sql: ${clicktoplay} ;;
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

  measure: sum_completed_100_pct {
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
    hidden: yes
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
    hidden: yes
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

  measure: vtr {
    type: number
    label: "VTR"
    description: "Video Through Rate - the percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100} / nullif(${sum_completed_pct_impressions},0),0) ;;
  }

  measure: vcr {
    type: number
    label: "VCR"
    description: "Video Completed Rate - The avarage completion rate of the impression."
    value_format_name: percent_2
    sql: COALESCE(((${abs_completed_25}*.25) + (${abs_completed_50} *.50) + (${abs_completed_75} *.75)
      + (${sum_completed_100} *1.0)) / nullif(${sum_completion_pct_impressions},0),0) ;;
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

  dimension: demand_bt_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_BT_COST ;;
  }

  measure: sum_demand_bt_cost {
    type: sum
    label: "BT Costs - Demand"
    description: "The total Behavioral Targeting costs converted from native currency to the demand currency."
    value_format_name: decimal_2
    sql: ${demand_bt_cost} ;;
  }

  dimension: demand_currency {
    type: string
    description: "The currency of demand partner."
    sql: ${TABLE}.DEMAND_CURRENCY ;;
  }

  dimension: demand_demo_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_DEMO_COST ;;
  }

  measure: sum_demand_demo_cost {
    type: sum
    label: "Demo Cost - Demand"
    description: "The total Demo costs converted from native currency to the demand currency."
    value_format_name: decimal_2
    sql: ${TABLE}.DEMAND_DEMO_COST ;;
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
  }

  measure: sum_demand_payout_usd {
    type: sum
    label: "Gross Payout USD"
    description: "The total amount due to the Publisher for the media in converted to USD."
    value_format_name: decimal_2
    sql: CASE WHEN ${payout_currency} = 'USD' then ${payout} else (${demand_payout}* ${usd_exchange_rate}) end;;
  }

  dimension: demand_platform_client_group_id {
    type: string
    view_label: "Impression Facets"
    description: "The ID of the Demand Partners Platform Client Group"
    hidden: yes
    sql: ${TABLE}.DEMAND_PLATFORM_CLIENT_GROUP_ID ;;
  }

  dimension: demand_platform_client_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_PLATFORM_CLIENT_ID ;;
  }

  dimension: demand_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_REVENUE ;;
  }

  measure: sum_demand_revenue {
    type: sum
    label: "Net Spend"
    description: "Total Net Spend converted to Demand Currency"
    value_format_name: decimal_2
    sql: ${demand_revenue} ;;
  }

  measure: gross_spend {
    type:  sum
    label: "Gross Spend"
    description: "Total Gross Spend converted to Demand Currency: Net Spend * 1 + Agency Fee"
    value_format_name: decimal_2
    sql: ${demand_revenue} * (1+(${v_flight_media_details_base.agency_fee}));;
  }

  measure: effective_cpm {
    type:  number
    label: "Effective CPM"
    description: "Gross Spend / (Billable Impression / 1000)"
    value_format_name: decimal_2
    sql: (COALESCE( 1.0 * ${gross_spend} / nullif(${sum_billable_impressions},0),0) * 1000) ;;
  }

  measure: sum_demand_revenue_usd {
    type: sum
    label: "Net Spend- USD"
    description: "Total Net Spend converted to USD"
    value_format_name: decimal_2
    sql: ${demand_revenue} * ${usd_exchange_rate};;
  }

  measure: gross_spend_usd {
    type:  sum
    label: "Gross Spend - USD"
    description: "Total Gross Spend converted to USDy: Net Spend * 1 + Agency Fee"
    value_format_name: decimal_2
    sql: (${demand_revenue} * (1+(${v_flight_media_details_base.agency_fee}))) * ${usd_exchange_rate};;
  }

  dimension: demand_tracking_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_TRACKING_COST ;;
  }

  measure: sum_demand_tracking_cost {
    type: sum
    label: "Tracking Costs - Demand"
    description: "The total Tracking Costs converted to demand currency"
    value_format: "#.00;(#.00)"
    sql: ${demand_tracking_cost} ;;
  }

  dimension: demo_cost_markup {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMO_COST_MARKUP ;;
  }

  measure: sum_demo_cost_markup {
    type: sum
    label: "Demo Cost Markup"
    description: "The total of markups on Demo Costs"
    value_format_name: decimal_2
    sql: ${demo_cost_markup} ;;
  }

  dimension: democostcurrency {
    type: string
    label: "Demo Cost Currency"
    description: "The currency of the Demo Costs"
    sql: ${TABLE}.DEMOCOSTCURRENCY ;;
  }

  dimension: democostcurrency_id {
    type: number
    label: "Demo Cost Currency ID"
    description: "The currency ID of the Demo Costs"
    sql:public.F_CURRENCYID_LOOKUP(${TABLE}.DEMOCOSTCURRENCY) ;;
    value_format_name: id
  }

  dimension: demoproviderdatacost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMOPROVIDERDATACOST ;;
  }

  measure: sum_demoproviderdatacost {
    type: sum
    label: "Demo Provider Data Cost"
    description: "The total Data Costs of the Data Provider"
    value_format_name: decimal_2
    sql: ${demoproviderdatacost} ;;
  }

  dimension: demoproviderid {
    type: string
    view_label: "Impression Facets"
    label: "Demo Provider ID"
    description: "The ID of the Demo provider"
    hidden: yes
    sql: ${TABLE}.DEMOPROVIDERID ;;
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
    sql: ${distinct_clicks} ;;
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

  dimension_group: EST {
    type: time
    label: "EST"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time of the impression in EST"
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension_group: gmt {
    type: time
    label: "UTC"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time of the impression in UTC"
    sql: ${TABLE}.GMT_DATE ;;
  }

  dimension_group: _demand {
    type: time
    hidden: yes
    timeframes: [
      date
    ]
    convert_tz: no
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension_group: demand {
    type: time
    label: "Demand"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time of the impression in demand timezone"
    sql: {% if _explore._name == "demand_metrics" and (mediaplanner_allocation_view._in_query or daily_ccp_metrics._in_query) %}COALESCE(${TABLE}.DEMAND_DATE{% if mediaplanner_allocation_view._in_query %}, mediaplanner_allocation_view.ALLOCATION_DATE{% endif %}{% if daily_ccp_metrics._in_query %}, daily_ccp_metrics.KEYDATE{% endif %}){% else %}${TABLE}.DEMAND_DATE{% endif %} ;;
  }

  dimension_group: local_demand {
    type: time
    label: "Local Demand"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time of the impression in demand timezone in accordance with season clock shift"
    sql: {% if _explore._name == "demand_metrics" and (mediaplanner_allocation_view._in_query or daily_ccp_metrics._in_query) %}COALESCE(${TABLE}.LOCAL_DEMAND_DATE{% if mediaplanner_allocation_view._in_query %}, mediaplanner_allocation_view.ALLOCATION_DATE{% endif %}{% if daily_ccp_metrics._in_query %}, daily_ccp_metrics.KEYDATE{% endif %}){% else %}${TABLE}.LOCAL_DEMAND_DATE{% endif %} ;;
  }

  dimension_group: region {
    type: time
    label: "Region"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time of the impression in the Regional timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: flight_media_id {
    type: string
    hidden: yes
    view_label: "Impression Facets"
    label: "Flight Media ID"
    description: "The ID of the flight media that was served in the impression."
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: import_config_id {
    type: string
    hidden: yes
    sql: ${TABLE}.IMPORT_CONFIG_ID ;;
  }

  dimension: gbp_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.GBP_EXCHANGE_RATE ;;
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

  dimension: isselected {
    type: string
    hidden: yes
    sql: ${TABLE}.ISSELECTED ;;
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

  dimension: is_viewability_satisfied {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_VIEWABILITY_SATISFIED ;;
  }

  measure: sum_is_viewability_satisfied {
    type: sum
    label: "Viewable Impressions"
    description: "The total of all impressions where viewablity criteria was satisfied"
    value_format_name: decimal_0
    sql: ${is_viewability_satisfied} ;;
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

  measure: pct_is_viewable_100 {
    type: number
    label: "Viewable 100%"
    description: "The percent of impressions that were viewable for 100% of the impression."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_is_viewable_100} / nullif(${sum_is_viewability_measurable},0),0);;
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

  measure: viewable_percent {
    type: number
    label: "Viewable %"
    description: "Percent of impressions where viewability criteria is satisfied. (Viewability Satisfied / Impressions)"
    value_format_name: percent_2
    sql: ${sum_is_viewability_satisfied} / ${sum_impressions};;
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

  measure: sum_media_price_usd {
    type: sum
    label: "Media Price - USD"
    value_format_name: decimal_2
    description: "The total price of media converted to USD currency."
    sql: ${media_price} * ${usd_exchange_rate} ;;
  }

  measure: avg_media_price {
    type: average
    label: "Average Media Price"
    value_format_name: decimal_2
    description: "The average price of all media."
    sql: ${media_price} ;;
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
    sql: ${muted} ;;
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
    sql: ${TABLE}.PAYOUT ;;
  }

  measure: IBMM_Amount{
    type:sum
    label:"IBMM - Demand Currency"
    value_format_name: decimal_2
    description: "The difference between the PRICE OF MEDIA (cost plus markup) and Gross Payout-Demand"
    sql: ${media_price} - ${demand_payout} ;;
  }

  dimension: payout_currency {
    type: string
    label: "Payout Currency"
    description: "The Publisher's (supply) currency."
    sql: ${TABLE}.PAYOUT_CURRENCY ;;
  }

  dimension: payout_currency_id {
    type: number
    label: "Payout Currency ID"
    description: "The Publisher's (supply) currency id."
    sql:public.F_CURRENCYID_LOOKUP(${TABLE}.PAYOUT_CURRENCY) ;;
    value_format_name: id
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

  dimension: placement_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
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

  dimension: primary_clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.PRIMARY_CLICKS ;;
  }

  dimension: companions {
    type: number
    hidden: yes
    sql: ${TABLE}.companions ;;
  }

  measure: companion_impressions {
    type: sum
    label: "Companion Impressions"
    value_format_name: decimal_0
    sql: ${companions} ;;
  }

  measure: companion_clicks {
    type: number
    label: "Companion Clicks"
    value_format_name: decimal_0
    description: "Number of clicks on companion impressions"
    sql: ${sum_clicks} - ${sum_primary_clicks} ;;
  }

  measure: sum_primary_clicks {
    type: sum
    label: "Primary Clicks"
    description: "The number of clicks on the primary impression and not companion impressions."
    value_format_name: decimal_0
    sql: ${primary_clicks} ;;
  }

  dimension: processingid {
    type: string
    label: "Processing ID"
    view_label: "Impression Facets"
    description: "The system processing id used to process the raw data into the database tables.  Used by the data team only."
    hidden: yes
    sql: ${TABLE}.PROCESSINGID ;;
  }

  dimension: region_exchange_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_EXCHANGE_RATE ;;
  }

  measure: revenue {
    type: sum
    hidden: yes
    value_format: "#.00;(#.00)"
    sql: ${TABLE}.REVENUE ;;
  }

  dimension: rpu_currency {
    type: string
    label: "Revenue Currency"
    sql: ${TABLE}.RPU_CURRENCY ;;
  }

  dimension: rpu_currency_id {
    type: number
    label: "Revenue Currency ID"
    sql: public.F_CURRENCYID_LOOKUP(${TABLE}.RPU_CURRENCY) ;;
    value_format_name: id
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

  dimension: tracking_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.TRACKING_COST ;;
  }

  measure: sum_tracking_cost {
    type: sum
    label: "Tracking Cost"
    value_format_name: decimal_2
    description: "The total of all tracking costs in natvie currency."
    sql: ${TABLE}.TRACKING_COST ;;
  }

  measure: sum_tracking_cost_usd {
    type: sum
    label: "Tracking Cost USD"
    description: "Total Tracking Cost converted to USD"
    value_format_name: decimal_2
    sql:  (${demand_tracking_cost} * ${usd_exchange_rate}) ;;
  }

  dimension: tracking_cost_currency {
    type: string
    label: "Tracking Cost Currency"
    description: "The native currency of the tracking costs."
    sql: ${TABLE}.TRACKING_COST_CURRENCY ;;
  }

  dimension: tracking_cost_currency_id {
    type: number
    label: "Tracking Cost Currency ID"
    description: "The native currency id of the tracking costs."
    sql:public.F_CURRENCYID_LOOKUP(${TABLE}.TRACKING_COST_CURRENCY) ;;
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
    sql: ${units} ;;
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

  dimension: usd_exchange_rate {
    type: string
    hidden: no
    sql: ${TABLE}.USD_EXCHANGE_RATE ;;
  }

  dimension: videology_viewable {
    type: string
    hidden: yes
    sql: ${TABLE}.VIDEOLOGY_VIEWABLE ;;
  }

  dimension: viewability_measurable_code {
    type: number
    hidden: yes
    sql: ${TABLE}.VIEWABILITY_MEASURABLE_CODE ;;
  }

  measure: pacing {
    type: number
    label: "Pacing"
    description: "Current pacing based on expected delivery vs. actual delivery and total days vs. remaining days."
    hidden: yes
    sql: case when ${v_campaign_details_base.max_cpu_type_id} in (4, 5) then coalesce(${gross_spend}::float / nullif(${v_expected_delivery.expected_gross_spend}::float, 0), 0)
      else coalesce(${sum_billable_units}::float / nullif(${v_expected_delivery.expected_units}::float, 0), 0) end ;;
  }

  measure: flight_pacing {
    type: number
    label: "Flight Pacing"
    value_format_name: percent_2
    description: "Current pacing of the flight based on expected delivery vs. actual delivery and total days vs. remaining days"
    sql: ${pacing} ;;
  }

  measure: campaign_pacing {
    type: number
    label: "Campaign Pacing"
    value_format_name: percent_2
    description: "Current pacing of the campaign based on expected delivery vs. actual delivery and total days vs. remaining days"
    sql: ${pacing} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: min_date {
    type: date
    label: "First Delivery Date"
    description: "First actual date of delivery on a campaign"
    view_label: "Dates"
    sql: min(${TABLE}.GMT_DATE) ;;
  }

  measure: max_date {
    type: date
    label: "Maximum Date"
    description: "Newest date in database table"
    view_label: "Dates"
    sql: max(${TABLE}.GMT_DATE) ;;
  }

  measure: count_date {
    type: number
    label: "# of Days"
    description: "# of Days in the database table"
    view_label: "Dates"
    sql: count(distinct ${TABLE}.GMT_DATE) ;;
  }

  measure: average_units_by_day {
    type: number
    label: "Average Units by Day"
    hidden: yes
    description: "Planned Units minus Served Billable Units divided by Remaining Days"
    sql: CASE WHEN ${v_campaign_days.campaign_remaining_days} > 0 and ${v_campaign_details_base.max_contracted_units} > ${sum_billable_units}
          THEN (${v_campaign_details_base.max_contracted_units} - ${sum_billable_units}) / ${v_campaign_days.campaign_remaining_days}
          ELSE 0 END ;;
  }

  measure: average_spend_by_day {
    type: number
    label: "Average Spend by Day"
    value_format_name: decimal_2
    hidden: yes
    description: "Planned Units minus Served Billable Units divided by Remaining Days"
    sql: CASE WHEN ${v_campaign_days.campaign_remaining_days} > 0 and ${v_campaign_details_base.max_planned_spend} > ${sum_demand_revenue}
          THEN (${v_campaign_details_base.max_planned_spend} - ${sum_demand_revenue}) / ${v_campaign_days.campaign_remaining_days}
          ELSE 0
          END ;;
  }

  measure: daily_goal {
    type: number
    label: "Daily Goal"
    description: "Planned Units/Spend minus Served Billable Units/Spend divided by Remaining Days"
    value_format_name: decimal_0
    sql:  CASE WHEN ${v_campaign_details_base.max_cpu_type_id} IN (4, 5)
                THEN ${average_spend_by_day}
              ELSE ${average_units_by_day} END ;;
  }

  measure: sum_impressions_2_days_ago {
    type:  sum
    label: "Impressions - 2 Days Ago"
    description: "Total Impressions from two days ago"
    value_format_name: decimal_0
    sql: ${impressions} ;;
    filters: {
      field: demand_date
      value: "2 days ago"
    }
  }

  measure: margin {
    type: number
    label: "Margin %"
    description: "Percentage diffence between spend and payout."
    value_format_name: percent_2
    sql: COALESCE(1 - (${sum_demand_payout}*1.0 / nullif(${gross_spend},0)), 0) ;;
  }

  measure: inventory_contribution {
    type:  number
    label: "I/C"
    description: "Difference between revenue and media cost"
    value_format_name: decimal_0
    sql: ${gross_spend}-${sum_demand_payout};;
  }

  measure: inventory_contribution_usd {
    type:  number
    label: "I/C - USD"
    description: "Difference between revenue and media cost in USD Currency"
    value_format_name: decimal_0
    sql: (${gross_spend_usd} - ${sum_demand_payout_usd})  ;;
  }

  measure: house_served {
    type:  sum
    label: "House Impressions"
    description: "Total impressions served by the house"
    value_format_name: decimal_0
    sql: ${impressions} ;;
    filters: {
      field: v_campaign_details_base.isfiller
      value: "yes"
    }
  }

  measure: non_house_served {
    type:  sum
    label: "Non-House Impressions"
    description: "Total impressions served by all campaigns except the house"
    value_format_name: decimal_0
    sql: ${impressions} ;;
    filters: {
      field: v_campaign_details_base.isfiller
      value: "no"
    }
  }

  measure: house_served_yesterday {
    type:  sum
    label: "House Impressions Yesterday"
    description: "Total impressions served by the house"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${impressions} ;;
    filters: {
      field: demand_date
      value: "Yesterday"
    }
    filters: {
      field: v_campaign_details_base.isfiller
      value: "yes"
    }
  }

  measure: non_house_served_yesterday {
    type:  sum
    label: "Non-House Impressions Yesterday"
    description: "Total impressions served by all campaigns except the house"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${impressions} ;;
    filters: {
      field: demand_date
      value: "Yesterday"
    }
    filters: {
      field: v_campaign_details_base.isfiller
      value: "no"
    }
  }

  measure: house_cost {
    type:  sum
    label: "House Cost"
    description: "Total media cost by the house"
    value_format_name: decimal_0
    sql: ${payout} ;;
    filters: {
      field: v_campaign_details_base.isfiller
      value: "yes"
    }
  }

  measure: non_house_cost {
    type:  sum
    label: "Non-House Cost"
    description: "Total media cost by all campaigns except the house"
    value_format_name: decimal_0
    sql: ${payout} ;;
    filters: {
      field: v_campaign_details_base.isfiller
      value: "no"
    }
  }

  measure: house_cost_yesterday {
    type:  sum
    label: "House Cost Yesterday"
    description: "Total media cost by the house"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${payout} ;;
    filters: {
      field: demand_date
      value: "Yesterday"
    }
    filters: {
      field: v_campaign_details_base.isfiller
      value: "yes"
    }
  }

  measure: non_house_cost_yesterday {
    type:  sum
    label: "Non-House Cost Yesterday"
    description: "Total media cost by all campaigns except the house"
    view_label: "Yesterday Impression Metrics"
    value_format_name: decimal_0
    sql: ${payout} ;;
    filters: {
      field: demand_date
      value: "Yesterday"
    }
    filters: {
      field: v_campaign_details_base.isfiller
      value: "no"
    }
  }

  measure: remaining_units {
    type:  number
    label: "Remaining Units"
    description: "Remaining units to be delivered on the campaign."
    value_format_name: decimal_0
    sql: CASE WHEN COALESCE(1.0 * ${v_campaign_demand_units_budget.sum_campaign_delivery_units} - ${sum_billable_units},0) >= 0 THEN COALESCE(1.0 * ${v_campaign_demand_units_budget.sum_campaign_delivery_units} - ${sum_billable_units},0) ELSE 0 END  ;;
  }

  measure: target_units {
    type:  number
    label: "Target Units"
    description: "Based on current pacing, the number of units that will be delivered at the end of the campaign: (Total Days / Elapsed Days) * Delivered Units"
    value_format_name: decimal_0
    sql: (${v_campaign_days.campaign_total_days} / NULLIF(${v_campaign_days.campaign_elapsed_days},0)) * ${sum_billable_units};;
  }

  measure: percent_target {
    type: number
    label: "% Target"
    description: "Based on current pacing, percentage of units that will be delivered at the end of the campaign: (Target Units / Planned Units)"
    value_format_name: percent_2
    sql: ${target_units}/NULLIF(${v_campaign_demand_units_budget.sum_campaign_delivery_units},0);;
  }

  measure: shortfall_units {
    type: number
    label: "Shortfall Units"
    description: "Estimated underdelivered units: (Total Units - Target Units)"
    value_format_name: decimal_0
    sql: CASE WHEN (${v_campaign_demand_units_budget.sum_campaign_delivery_units} - (COALESCE(${sum_billable_units}*${v_campaign_days.campaign_remaining_days}/NULLIF(${v_campaign_days.campaign_elapsed_days},0),0) + ${sum_billable_units})) >= 0 THEN (${v_campaign_demand_units_budget.sum_campaign_delivery_units} - (COALESCE(${sum_billable_units}*${v_campaign_days.campaign_remaining_days}/NULLIF(${v_campaign_days.campaign_elapsed_days},0),0) + ${sum_billable_units})) ELSE 0 END ;;
  }

  measure: shortfall_revenue {
    type: number
    label: "Shortfall Revenue"
    description: "Estimated under delivered revenue: (Shortfall Units * CPU)"
    value_format_name: decimal_2
    sql: CASE WHEN (${v_campaign_demand_units_budget.campaign_target_gross_spend} - (COALESCE(${gross_spend}*${v_campaign_days.campaign_remaining_days}/NULLIF(${v_campaign_days.campaign_elapsed_days},0),0) + ${gross_spend})) >= 0 THEN (${v_campaign_demand_units_budget.campaign_target_gross_spend} - (COALESCE(${gross_spend}*${v_campaign_days.campaign_remaining_days}/NULLIF(${v_campaign_days.campaign_elapsed_days},0),0) + ${gross_spend})) ELSE 0.00 END ;;
  }

  dimension: previous_date {
    type: date
    label: "Demand Date - Previous Date"
    description: "Previous date/time (Demand Date)"
    hidden: yes
    sql: dateadd(day, -1, to_date(${demand_date}))
      ;;
  }

  measure: target_pacing {
    type: number
    label: "Target Pacing"
    description: "Expected pacing on the Campaign: (Elapsed Days / Total Days)"
    value_format_name: percent_2
    sql: COALESCE(1.0*${v_campaign_days.campaign_elapsed_days}/NULLIF(${v_campaign_days.campaign_total_days},0),0) ;;
  }

  measure: forecast_delivery {
    type: number
    label: "% Forecast Delivery"
    description: "Percentage of estimated required delivery on a campaign: (Contracted Units - Shortfall Units) / Contracted Units"
    value_format_name: percent_2
    sql: COALESCE(1.0*(${v_campaign_demand_units_budget.sum_campaign_delivery_units}-${shortfall_units})/NULLIF(${v_campaign_demand_units_budget.sum_campaign_delivery_units},0),0) ;;
  }

  measure: percent_completed {
    type: number
    label: "% Completed"
    description: "Served Units / Contracted Units"
    value_format_name: percent_2
    sql: COALESCE(${sum_units} / NULLIF(${v_campaign_details_base.sum_contracted_units}, 0), 0) ;;
  }

  measure: demo_index {
    type: number
    label: "Demo Index"
    view_label: "Campaign"
    description: "Ratio between effective and billable units relative to demo composition."
    value_format_name: decimal_0
    sql: COALESCE(${sum_effective_units} / ${sum_billable_impressions} / NULLIF(${v_flight_media_details_base.max_democomp}, 0) * 100, 0) ;;
  }

  measure: revenue_booked {
    type: number
    label: "Revenue Booked"
    description: "Custom revenue for monthly CCP report"
    value_format_name: decimal_0
    sql: ((CASE WHEN ${v_campaign_details_base.max_cpu_type_id} = 1 THEN 0.001 ELSE 1.00 END)
          * ${v_flight_details.max_cpu}
          * (CASE WHEN ${v_campaign_details_base.is_filler} = 1 THEN 0
          ELSE ${v_flight_details.sum_units} END));;
  }

  measure: monthly_impressions_delivered {
    type: sum
    label: "Monthly Impressions Delivered"
    description: "Number of impressions delivered in month"
    sql: ${impressions} ;;
    filters: {
      field: demand_date
      value: "this month"
    }

  }

  measure: monthly_revenue_delivered {
    type: sum
    value_format_name: decimal_2
    label: "Monthly Revenue Delivered"
    description: "The total amount of revenue delivered in month"
    sql: ${demand_revenue} ;;
    filters: {
      field:  demand_date
      value: "this month"
    }

  }

  measure: monthly_units_delivered {
    type: sum
    label: "Monthly Units Delivered"
    description: "The number of units delivered in month"
    sql: ${units} ;;
    filters: {
      field: demand_date
      value: "this month"
    }

  }

  measure: client_spend {
    type: sum
    label: "Client Spend"
    value_format_name: decimal_2
    description: "Total Client spend converted to Gross Spend Currency: Gross Spend * (1- Campaign Discount)"
    sql:${demand_revenue} * (1 + ${v_flight_media_details_base.agency_fee}) * (1- ${v_campaign_details_base.spend_discount});;
  }
}
