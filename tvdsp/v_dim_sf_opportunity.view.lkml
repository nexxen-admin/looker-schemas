# The name of this view in Looker is "V Dim Sf Opportunity"
view: v_dim_sf_opportunity {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_SF_Opportunity ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ri Info" in Explore.

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: sf_account_id {
    type: string
    sql: ${TABLE}.SF_Account_ID ;;
  }

  dimension: sf_ad_sale_number {
    type: string
    sql: ${TABLE}.SF_AdSale_Number ;;
  }

  dimension: sf_billing_ad_server {
    type: string
    sql: ${TABLE}.SF_Billing_Ad_Server ;;
  }

  dimension: sf_billing_agency {
    type: string
    sql: ${TABLE}.SF_Billing_Agency ;;
  }

  dimension: sf_billing_agency_net_suit_id {
    type: number
    sql: ${TABLE}.SF_Billing_Agency_NetSuit_ID ;;
  }

  dimension: sf_billing_agency_up_sap_id {
    type: string
    sql: ${TABLE}.SF_Billing_Agency_UP_SAP_ID ;;
  }

  dimension: sf_billing_instructions {
    type: string
    sql: ${TABLE}.SF_Billing_Instructions ;;
  }

  dimension: sf_booked_quantity {
    type: number
    sql: ${TABLE}.SF_Booked_Quantity ;;
  }

  dimension: sf_booked_revenue {
    type: number
    sql: ${TABLE}.SF_Booked_Revenue ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sf_booked_revenue {
    type: sum
    sql: ${sf_booked_revenue} ;;
  }

  measure: average_sf_booked_revenue {
    type: average
    sql: ${sf_booked_revenue} ;;
  }

  dimension: sf_booked_revenue_usd {
    type: number
    sql: ${TABLE}.SF_Booked_Revenue_USD ;;
  }

  dimension_group: sf_campaign_end {
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
    sql: ${TABLE}.SF_Campaign_End_Date ;;
  }

  dimension: sf_campaign_name {
    type: string
    sql: ${TABLE}.SF_Campaign_Name ;;
  }

  dimension: sf_campaign_purchase_order_number {
    type: string
    sql: ${TABLE}.SF_Campaign_Purchase_Order_Number ;;
  }

  dimension_group: sf_campaign_start {
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
    sql: ${TABLE}.SF_Campaign_Start_Date ;;
  }

  dimension: sf_client_owner {
    type: string
    sql: ${TABLE}.SF_Client_Owner ;;
  }

  dimension: sf_client_services_manager_id {
    type: string
    sql: ${TABLE}.SF_Client_Services_Manager_ID ;;
  }

  dimension_group: sf_close {
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
    sql: ${TABLE}.SF_Close_Date ;;
  }

  dimension: sf_currency_code_iso {
    type: string
    sql: ${TABLE}.SF_Currency_Code_ISO ;;
  }

  dimension: sf_further_information {
    type: string
    sql: ${TABLE}.SF_Further_Information ;;
  }

  dimension: sf_geo {
    type: string
    sql: ${TABLE}.SF_GEO ;;
  }

  dimension_group: sf_loaded {
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
    sql: ${TABLE}.SF_Loaded ;;
  }

  dimension: sf_opportunity_auto_number {
    type: string
    sql: ${TABLE}.SF_Opportunity_Auto_Number ;;
  }

  dimension: sf_opportunity_id {
    type: string
    sql: ${TABLE}.SF_Opportunity_ID ;;
  }

  dimension: sf_opportunity_key {
    type: number
    sql: ${TABLE}.SF_Opportunity_Key ;;
  }

  dimension: sf_opportunity_name {
    type: string
    sql: ${TABLE}.SF_Opportunity_Name ;;
  }

  dimension: sf_opportunity_number {
    type: string
    sql: ${TABLE}.SF_Opportunity_Number ;;
  }

  dimension: sf_opportunity_number_historical {
    type: string
    sql: ${TABLE}.SF_Opportunity_Number_Historical ;;
  }

  dimension: sf_probability {
    type: number
    sql: ${TABLE}.SF_Probability ;;
  }

  dimension: sf_record_type_id {
    type: string
    sql: ${TABLE}.SF_Record_Type_ID ;;
  }

  dimension: sf_seller_id {
    type: string
    sql: ${TABLE}.SF_Seller_ID ;;
  }

  dimension: sf_stage_name {
    type: string
    sql: ${TABLE}.SF_Stage_Name ;;
  }

  dimension: sf_un_agency_discount {
    type: number
    sql: ${TABLE}.SF_UN_Agency_Discount ;;
  }

  dimension: sf_un_discretionary_discount {
    type: number
    sql: ${TABLE}.SF_UN_Discretionary_Discount ;;
  }

  dimension: sf_un_invoice_number {
    type: string
    sql: ${TABLE}.SF_UN_Invoice_Number ;;
  }

  dimension: sf_un_opportunity_number {
    type: string
    sql: ${TABLE}.SF_UN_Opportunity_Number ;;
  }

  dimension: sf_vertical {
    type: string
    sql: ${TABLE}.SF_Vertical ;;
  }

  measure: count {
    type: count
    drill_fields: [sf_opportunity_name, sf_stage_name, sf_campaign_name]
  }
}
