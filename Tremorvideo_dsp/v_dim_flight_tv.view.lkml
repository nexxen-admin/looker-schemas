# The name of this view in Looker is "V Dim Flight"
view: v_dim_flight_tv {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Flight ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: actual_start {
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
    sql: ${TABLE}.Actual_Start_Date ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Format" in Explore.

  dimension: ad_format {
    type: string
    sql: ${TABLE}.Ad_Format ;;
    hidden: yes
  }

  dimension: ad_format_key {
    type: number
    sql: ${TABLE}.Ad_Format_Key ;;
    hidden: yes
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.Advertiser_ID ;;
    hidden: yes
  }

  dimension: advertiser_key {
    type: number
    sql: ${TABLE}.Advertiser_Key ;;
    hidden: yes
  }

  dimension: agency_fee_pct {
    type: number
    sql: ${TABLE}.Agency_Fee_PCT ;;
  }

  dimension: allowed_on_ssp {
    type: number
    sql: ${TABLE}.Allowed_On_SSP ;;
  }

  dimension: archived {
    type: number
    sql: ${TABLE}.Archived ;;
  }

  dimension: behavior_modeling_enabled {
    type: number
    sql: ${TABLE}.Behavior_Modeling_Enabled ;;
  }

  dimension: bid_strategy_type {
    type: string
    sql: ${TABLE}.Bid_Strategy_Type ;;
    hidden: yes
  }

  dimension: bid_strategy_type_key {
    type: number
    sql: ${TABLE}.Bid_Strategy_Type_Key ;;
    hidden: yes
  }

  dimension: billing_ad_server {
    type: string
    sql: ${TABLE}.Billing_Ad_Server ;;
  }

  dimension: brand_id {
    type: number
    sql: ${TABLE}.Brand_ID ;;
    hidden: yes
  }

  dimension: brand_key {
    type: number
    sql: ${TABLE}.Brand_Key ;;
    hidden: yes
  }

  dimension: brand_metric {
    type: string
    sql: ${TABLE}.Brand_Metric ;;
  }

  dimension: brand_protection_enabled {
    type: number
    sql: ${TABLE}.Brand_Protection_Enabled ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.Budget ;;
  }

  dimension: buy_sub_type {
    type: string
    sql: ${TABLE}.Buy_Sub_Type ;;
    hidden: yes
  }

  dimension: buy_sub_type_key {
    type: number
    sql: ${TABLE}.Buy_Sub_Type_Key ;;
    hidden: yes
  }

  dimension: buy_type {
    type: string
    sql: ${TABLE}.Buy_Type ;;
    hidden: yes
  }

  dimension: buy_type_key {
    type: number
    sql: ${TABLE}.Buy_Type_Key ;;
    hidden: yes
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.Campaign_ID ;;
    hidden: yes
  }

  dimension: campaign_key {
    type: number
    sql: ${TABLE}.Campaign_Key ;;
    hidden: yes
  }

  dimension: comscore_target_demo_ages {
    type: string
    sql: ${TABLE}.Comscore_Target_Demo_Ages ;;
  }

  dimension: cross_screen_targeting_enabled {
    type: number
    sql: ${TABLE}.Cross_Screen_Targeting_Enabled ;;
  }

  dimension: daily_budget_limit {
    type: number
    sql: ${TABLE}.Daily_Budget_Limit ;;
  }

  dimension_group: db_create {
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
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
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
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: deleted {
    type: number
    sql: ${TABLE}.Deleted ;;
  }

  dimension: dynamic_daily_budget {
    type: number
    sql: ${TABLE}.Dynamic_Daily_Budget ;;
  }

  dimension: dynamic_effective_rate_enabled {
    type: number
    sql: ${TABLE}.Dynamic_Effective_Rate_Enabled ;;
  }

  dimension: effective_rate {
    type: number
    sql: ${TABLE}.Effective_Rate ;;
  }

  dimension: enabled_30s_completion {
    type: number
    sql: ${TABLE}.Enabled_30s_Completion ;;
  }

  dimension: end {
    type: date
    sql: ${TABLE}.End_Date ;;
  }

  dimension: external_id {
    type: number
    sql: ${TABLE}.External_ID ;;
  }

  dimension: external_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.External_ID_Key ;;
    hidden: yes
  }

  dimension: flight_id {
    type: number
    sql: ${TABLE}.Flight_ID ;;
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
    hidden: yes
  }

  dimension: flight_name {
    type: string
    sql: ${TABLE}.Flight_Name ;;
  }

  dimension: flight_number {
    type: string
    sql: ${TABLE}.Flight_Number ;;
  }

  dimension: flight_type {
    type: string
    sql: ${TABLE}.Flight_Type ;;
    hidden: yes
  }

  dimension: flight_type_key {
    type: number
    sql: ${TABLE}.Flight_Type_Key ;;
    hidden: yes
  }

  dimension: goal_kpi_value {
    type: number
    sql: ${TABLE}.Goal_KPI_Value ;;
  }

  dimension: goal_net_cpm {
    type: number
    sql: ${TABLE}.Goal_Net_CPM ;;
  }

  dimension: gross_budget {
    type: number
    sql: ${TABLE}.Gross_Budget ;;
  }

  dimension: gross_entered {
    type: number
    sql: ${TABLE}.Gross_Entered ;;
  }

  dimension: grp {
    type: number
    sql: ${TABLE}.Grp ;;
  }

  dimension: grp_tier {
    type: string
    sql: ${TABLE}.Grp_Tier ;;
  }

  dimension: has_approved_creative {
    type: number
    sql: ${TABLE}.Has_Approved_Creative ;;
  }

  dimension: holdback_override_ratio {
    type: number
    sql: ${TABLE}.Holdback_Override_Ratio ;;
  }

  dimension: impressions_cap {
    type: number
    sql: ${TABLE}.Impressions_Cap ;;
  }

  dimension: is_behavioral_targeted {
    type: number
    sql: ${TABLE}.Is_Behavioral_Targeted ;;
  }

  dimension: is_browser_targeted {
    type: number
    sql: ${TABLE}.Is_Browser_Targeted ;;
  }

  dimension: is_content_category_targeted {
    type: number
    sql: ${TABLE}.Is_Content_Category_Targeted ;;
  }

  dimension: is_day_part_targeted {
    type: number
    sql: ${TABLE}.Is_Day_Part_Targeted ;;
  }

  dimension: is_geo_targeted {
    type: number
    sql: ${TABLE}.Is_Geo_Targeted ;;
  }

  dimension: is_inventory_targeted {
    type: number
    sql: ${TABLE}.Is_Inventory_Targeted ;;
  }

  dimension: is_managed_placement {
    type: number
    sql: ${TABLE}.Is_Managed_Placement ;;
  }

  dimension: is_multiscreen {
    type: number
    sql: ${TABLE}.Is_Multiscreen ;;
  }

  dimension: is_neustar {
    type: yesno
    sql: ${TABLE}.Is_Neustar ;;
  }

  dimension: is_os_targeted {
    type: number
    sql: ${TABLE}.Is_OS_Targeted ;;
  }

  dimension: is_player_size_targeted {
    type: number
    sql: ${TABLE}.Is_Player_Size_Targeted ;;
  }

  dimension: kpi {
    type: string
    sql: ${TABLE}.KPI ;;
  }

  dimension: last_pacing_target_ratio {
    type: number
    sql: ${TABLE}.Last_Pacing_Target_Ratio ;;
  }

  dimension: line_number {
    type: string
    sql: ${TABLE}.Line_Number ;;
  }

  dimension: manual_control_enabled {
    type: number
    sql: ${TABLE}.Manual_Control_Enabled ;;
  }

  dimension: max_rtb_bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Max_RTB_Bid ;;
  }

  dimension: min_bid_value {
    type: number
    sql: ${TABLE}.Min_Bid_Value ;;
  }

  dimension: network_id {
    type: number
    sql: ${TABLE}.Network_ID ;;
  }

  dimension: network_key {
    type: number
    sql: ${TABLE}.Network_Key ;;
    hidden: yes
  }

  dimension: nielsen_fee {
    type: number
    sql: ${TABLE}.Nielsen_Fee ;;
  }

  dimension: nielsen_target_demo_ages {
    type: string
    sql: ${TABLE}.Nielsen_Target_Demo_Ages ;;
  }

  dimension: placement_group_id {
    type: number
    sql: ${TABLE}.Placement_Group_ID ;;
    hidden: yes
  }

  dimension: placement_group_key {
    type: number
    sql: ${TABLE}.Placement_Group_Key ;;
    hidden: yes
  }

  dimension: predictive_viewability_cpm {
    type: number
    sql: ${TABLE}.Predictive_Viewability_CPM ;;
  }

  dimension: private_exchange_enabled {
    type: number
    sql: ${TABLE}.Private_Exchange_Enabled ;;
  }

  dimension: product_type_code {
    type: number
    sql: ${TABLE}.Product_Type_Code ;;
  }

  dimension: product_type_key {
    type: number
    sql: ${TABLE}.Product_Type_Key ;;
    hidden: yes
  }

  dimension: rate_type {
    type: string
    sql: ${TABLE}.Rate_Type ;;
    hidden: yes
  }

  dimension: rate_type_key {
    type: number
    sql: ${TABLE}.Rate_Type_Key ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: secondary_goal_kpi_value {
    type: number
    sql: ${TABLE}.Secondary_Goal_KPI_Value ;;
  }

  dimension: secondary_kpi {
    type: string
    sql: ${TABLE}.Secondary_KPI ;;
  }

  dimension: sf_flight_key {
    type: number
    sql: ${TABLE}.SF_Flight_Key ;;
    hidden: yes
  }

  dimension: site_fraud_brand_safety_double_verify_fee_cpm {
    type: number
    sql: ${TABLE}.Site_Fraud_Brand_Safety_Double_Verify_Fee_CPM ;;
  }

  dimension: site_fraud_cpm {
    type: number
    sql: ${TABLE}.Site_Fraud_CPM ;;
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: target_demo_gender {
    type: string
    sql: ${TABLE}.Target_Demo_Gender ;;
  }

  dimension: target_demo_provider {
    type: string
    sql: ${TABLE}.Target_Demo_Provider ;;
  }

  dimension: targeting_data_cost {
    type: number
    sql: ${TABLE}.Targeting_Data_Cost ;;
  }

  dimension: tech_fee_percent {
    type: number
    sql: ${TABLE}.Tech_Fee_Percent ;;
  }

  dimension: third_party_fee_cpm {
    type: number
    sql: ${TABLE}.Third_Party_Fee_CPM ;;
  }

  dimension: third_party_viewable_impression_fee_cpm {
    type: number
    sql: ${TABLE}.Third_Party_Viewable_Impression_Fee_CPM ;;
  }

  dimension: tremor_video_dsp_fee_base_type {
    type: string
    sql: ${TABLE}.Tremor_Video_DSP_Fee_Base_Type ;;
    #hidden: yes
  }

  dimension: tremor_video_dsp_fee_base_type_key {
    type: number
    sql: ${TABLE}.Tremor_Video_DSP_Fee_Base_Type_Key ;;
    hidden: yes
  }

  dimension: tremor_video_dsp_fee_pct {
    type: number
    sql: ${TABLE}.Tremor_Video_DSP_fee_PCT ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.Version ;;
  }

  dimension: viewable_impression_methodology {
    type: string
    sql: ${TABLE}.Viewable_Impression_Methodology ;;
  }

  measure: count {
    type: count
    drill_fields: [flight_name]
    hidden: yes
  }
}
