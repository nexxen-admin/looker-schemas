# The name of this view in Looker is "Dim Sfdb Opportunitylineitem"
view: dim_sfdb_opportunitylineitem {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_opportunitylineitem ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    label: "opp id"
    sql: ${TABLE}.id ;;
    #hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Manager C" in Explore.

  dimension: account_manager__c {
    type: string
    sql: ${TABLE}.account_manager__c ;;
  }

  dimension: affects_net_of_related_line_items__c {
    type: number
    sql: ${TABLE}.affects_net_of_related_line_items__c ;;
    hidden: yes
  }

  dimension: calculated_margin__c {
    type: number
    label: "Calculated Margin C (* Do Not Use)"
    sql: ${TABLE}.calculated_margin__c ;;
    hidden: no
  }

  dimension: cloned_from_line_item__c {
    type: string
    sql: ${TABLE}.cloned_from_line_item__c ;;
    hidden: yes
  }

  dimension: configured_3rd_party_services__c {
    type: string
    sql: ${TABLE}.configured_3rd_party_services__c ;;
    hidden: yes
  }

  dimension: configured_brand_safety__c {
    type: string
    sql: ${TABLE}.configured_brand_safety__c ;;
    hidden: yes
  }

  dimension: configured_creative_format__c {
    type: string
    sql: ${TABLE}.configured_creative_format__c ;;
    hidden: yes
  }

  dimension: configured_creative_size__c {
    type: string
    sql: ${TABLE}.configured_creative_size__c ;;
    hidden: yes
  }

  dimension: configured_creative_type__c {
    type: string
    sql: ${TABLE}.configured_creative_type__c ;;
    hidden: yes
  }

  dimension: configured_device__c {
    type: string
    sql: ${TABLE}.configured_device__c ;;
    hidden: yes
  }

  dimension: configured_product_name__c {
    type: string
    label: "Product Level 2"
    sql: ${TABLE}.configured_product_name__c ;;
  }

  dimension: configured_retargeting__c {
    type: string
    sql: ${TABLE}.configured_retargeting__c ;;
    hidden: yes
  }

  dimension: configured_sales_packages__c {
    type: string
    sql: ${TABLE}.configured_sales_packages__c ;;
    hidden: yes
  }

  dimension: configured_supply_mandates__c {
    type: string
    sql: ${TABLE}.configured_supply_mandates__c ;;
    hidden: yes
  }

  dimension: configured_targeting_ages__c {
    type: string
    label: "Configured Targeting Ages"
    sql: ${TABLE}.configured_targeting_ages__c ;;
    hidden: yes
  }

  dimension: configured_targeting_behavioral__c {
    type: string
    label: "Configure Targeting Behavioral"
    sql: ${TABLE}.configured_targeting_behavioral__c ;;
    hidden: yes
  }

  dimension: configured_targeting_cities__c {
    type: string
    label: "Configured Targeting Cities"
    sql: ${TABLE}.configured_targeting_cities__c ;;
    hidden: yes
  }

  dimension: configured_targeting_contextual__c {
    type: string
    sql: ${TABLE}.configured_targeting_contextual__c ;;
    hidden: yes
  }

  dimension: configured_targeting_countries__c {
    type: string
    label: "Configured Targeting Country"
    sql: ${TABLE}.configured_targeting_countries__c ;;
    hidden: yes
  }

  dimension: configured_targeting_dma_al__c {
    type: string
    label: "Configured Targeting Dma AL"
    sql: ${TABLE}.configured_targeting_dma_al__c ;;
    hidden: yes
  }

  dimension: configured_targeting_dma_mz__c {
    type: string
    label: "Configures Targeting DMA MZ"
    sql: ${TABLE}.configured_targeting_dma_mz__c ;;
    hidden: yes
  }

  dimension: configured_targeting_ethnicity__c {
    type: string
    label: "Configures Targeting Ethnicity"
    sql: ${TABLE}.configured_targeting_ethnicity__c ;;
    hidden: yes
  }

  dimension: configured_targeting_exclude__c {
    type: string
    label: "Configured Targeting Exclude"
    sql: ${TABLE}.configured_targeting_exclude__c ;;
    hidden: yes
  }

  dimension: configured_targeting_gender__c {
    type: string
    label: "Configured Targeting Gender"
    sql: ${TABLE}.configured_targeting_gender__c ;;
    hidden: yes
  }

  dimension: configured_targeting_household_income__c {
    type: string
    label: "Configured Targeting Household income"
    sql: ${TABLE}.configured_targeting_household_income__c ;;
    hidden: yes
  }

  dimension: configured_targeting_language__c {
    type: string
    label: "Configured Targeting language"
    sql: ${TABLE}.configured_targeting_language__c ;;
    hidden: yes
  }

  dimension: configured_targeting_locations__c {
    type: string
    label: "Configured Targeting Location"
    sql: ${TABLE}.configured_targeting_locations__c ;;
    hidden: yes
  }

  dimension: configured_targeting_region__c {
    type: string

    sql: ${TABLE}.configured_targeting_region__c ;;
    hidden: yes
  }

  dimension: configured_targeting_state__c {
    type: string
    sql: ${TABLE}.configured_targeting_state__c ;;
    hidden: yes
  }

  dimension: configured_targeting_viewership__c {
    type: string
    sql: ${TABLE}.configured_targeting_viewership__c ;;
    hidden: yes
  }

  dimension: configured_targeting_zip__c {
    type: string
    sql: ${TABLE}.configured_targeting_zip__c ;;
    hidden: yes
  }

  dimension: createdbyid {
    type: string
    sql: ${TABLE}.createdbyid ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: createddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.createddate ;;
    hidden: yes
  }

  dimension: currencyisocode {
    type: string
    sql: ${TABLE}.currencyisocode ;;
    hidden: yes
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: delivery_manager__c {
    type: string
    sql: ${TABLE}.delivery_manager__c ;;
    hidden: yes
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    hidden: yes
  }

  dimension_group: end_date__c {
    type: time
    label: "OPP Line Item End"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
    description: "End date of line item in salesforce"
  }

  # dimension: item_days {
  #   type: number
  #   description: "The difference in days between the io start and end date."
  #   sql: DATEDIFF(day, start_date__c, end_date__c) ;;
  #   # hidden: yes
  # }

  dimension: item_days {
    type: number
    description: "The difference in days between the io start and end date."
    # Use the LookML reference for the 'date' timeframe of the dimension groups
    sql: DATEDIFF(day, ${start_date__c_date}, ${end_date__c_date}) ;;
    # hidden: yes
  }

  dimension: item_days_left {
    type: number
    description: "The difference in days between the io end date and current date."
    sql: DATEDIFF(day, now(), ${end_date__c_date}) ;;
    hidden: yes
  }

  measure: days_till_campaign_midpoint {
    type: number
    label: "Days till Campaign Midpoint"
    sql:
          DATEDIFF(
            'day',
            CURRENT_DATE(),
            -- Use native Vertica INTERVAL math instead of DATEADD to calculate the midpoint date
            MAX(${start_date__c_date}) + (FLOOR(DATEDIFF('day', MAX(${start_date__c_date}), MAX(${end_date__c_date})) / 2) * INTERVAL '1 day')
          )
        ;;
  }

  dimension: days_remaining {
    type: number
    description: "Days remaining until IO End Date, minimum 0 days."
    sql: GREATEST( DATEDIFF(day, CURRENT_DATE(), ${end_date__c_date}) + 1, 0 ) ;;
  }

  dimension: days_elapsed_today{
    type: number
    label: "Days Elapsed Today"
    sql:
    CASE
      WHEN DATEDIFF('day', ${TABLE}.start_date__c, CURRENT_DATE) < 0
        THEN 0
      ELSE DATEDIFF('day', ${TABLE}.start_date__c, CURRENT_DATE)
    END ;;
  }

  dimension:  live_campaign_filter{
    type: string
    label: "Is Campaign Live"
    sql: CASE WHEN DATEDIFF('day', NOW(),dim_sfdb_opportunitylineitem.end_date__c)>=0 and DATEDIFF('day', NOW(),dim_sfdb_opportunitylineitem.start_date__c)<=0 THEN 'Live'ELSE 'Not Live' END ;;
  }

  dimension: expected_amount__c {
    type: number
    sql: ${TABLE}.expected_amount__c ;;
  }

  dimension: free__c {
    type: string
    label: "Line Item Status"
    sql: ${TABLE}.free__c ;;
    #hidden: yes
  }

  dimension: free_reason__c {
    type: string
    sql: ${TABLE}.free_reason__c ;;
    hidden: yes
  }

  dimension: free_reason_other__c {
    type: string
    sql: ${TABLE}.free_reason_other__c ;;
    hidden: yes
  }

  dimension: gross_billable__c {
    type: number
    sql: ${TABLE}.gross_billable__c ;;
    label: "Total Booked Budget"
    description: "Gross Billable times the Opp's Probability"
    #hidden: yes
  }

  dimension: Booked_Spend {
    type: number
    label: "Booked Spend"
    sql:
    CASE
      WHEN ${free__c} IN ('Hidden/Included', 'Added Value', 'Make Good')
        THEN 0
      ELSE ${gross_billable__c}
    END ;;
  }


  dimension: has_product_config__c {
    type: number
    sql: ${TABLE}.has_product_config__c ;;
    hidden: yes
  }

  dimension: hasquantityschedule {
    type: number
    sql: ${TABLE}.hasquantityschedule ;;
    hidden: yes
  }

  dimension: hasrevenueschedule {
    type: number
    sql: ${TABLE}.hasrevenueschedule ;;
    hidden: yes
  }

  dimension: hasschedule {
    type: number
    sql: ${TABLE}.hasschedule ;;
    hidden: yes
  }

  dimension: incremental_amount__c {
    type: number
    sql: ${TABLE}.incremental_amount__c ;;
    hidden: yes
  }

  dimension: io_currency__c {
    type: string
    label: "IO Currency"
    sql: ${TABLE}.io_currency__c ;;

  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    #hidden: yes
  }

  dimension: is_free__c {
    type: number
    sql: ${TABLE}.is_free__c ;;
    hidden: yes
  }

  dimension: is_hidden__c {
    type: number
    sql: ${TABLE}.is_hidden__c ;;
    hidden: yes
  }

  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
    hidden: yes
  }

  dimension: item_type__c {
    type: string
    label: "Item Type"
    sql: ${TABLE}.item_type__c ;;
    hidden: no
  }

  dimension: lastmodifiedbyid {
    type: string
    sql: ${TABLE}.lastmodifiedbyid ;;
    hidden: yes
  }

  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
    hidden: yes
  }

  dimension: legacy_amobee_ids__c {
    type: string
    sql: ${TABLE}.legacy_amobee_ids__c ;;
    hidden: yes
  }

  dimension: line_item_name__c {
    type: string
    label: "Line Item Name"
    sql: ${TABLE}.line_item_name__c ;;
    drill_fields: [datorama_dsp_third_party.media_buy_key, v_dim_dsp_date.date_key_date]
  }

  dimension: line_item_number__c {
    type: number
    label: "Line Item Number"
    sql: ${TABLE}.line_item_number__c ;;
  }

  dimension: listprice {
    type: number
    sql: ${TABLE}.listprice ;;
    hidden: yes
  }

  dimension: live_status__c {
    type: string
    sql: ${TABLE}.live_status__c ;;
    hidden: yes
  }

  dimension: margin_type__c {
    type: string
    sql: ${TABLE}.margin_type__c ;;
    hidden: yes
  }

  dimension: market__c {
    type: string
    label: "Salsforce Market"
    sql: ${TABLE}.market__c ;;
    hidden: yes
  }

  dimension: market_in_effect__c {
    type: number
    sql: ${TABLE}.market_in_effect__c ;;
    hidden: yes
  }

  dimension: net__c {
    type: number
    label: "Net"
    sql: ${TABLE}.net__c ;;
    hidden: yes
  }

  dimension: rate_cart_discount__c {
    type: number
    label: "Rate Card Discount"
    sql: ${TABLE}.rate_card_discount__c ;;
    description: "The Discount Rate applied from the Rate Card listed on the Product Configuration"
  }

  dimension: overall_discount__c {
    type: number
    label: "Overall Discount"
    sql: ${TABLE}.overall_discount__c ;;
  }

  dimension: discount__c {
    type: number
    label: "Manual Discount"
    sql: ${TABLE}.discount__c ;;
    description: "In addition to any discount from the Rate Card. This percentage will be combined with the Rate Card Discount to yield the Overall Discount percentage. (This is not for rebates.)"
  }

  dimension: opportunity_owner__c {
    type: string
    label: "Opportunity Owner"
    sql: ${TABLE}.opportunity_owner__c ;;
    # hidden: yes

  }

  dimension: opportunityid {
    type: string
    label: "Opportunity ID"
    sql: ${TABLE}.opportunityid ;;

  }

  dimension: opportunity_link {
    type: string
    sql: CONCAT('https://amobee-sfv.lightning.force.com/',${TABLE}.opportunityid) ;;
    html: <a href="{{ value }}"/>[SF Opportunity Link]</a> ;;
  }

  dimension: opportunitylineitem_aid__c {
    type: string
    label: "Case Safe OPP line item ID"
    sql: ${TABLE}.opportunitylineitem_aid__c ;;
    description: "Line item from salesforce"

  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
    hidden: yes
  }

  dimension: owner_code__c {
    type: string
    sql: ${TABLE}.owner_code__c ;;
    hidden: yes
  }

  dimension: price_type__c {
    type: string
    label: "Price Type"
    sql: ${TABLE}.price_type__c ;;
   hidden: yes
  }

  dimension: price_type_name__c {
    type: string
    label: "Price Type Name"
    sql: ${TABLE}.price_type_name__c ;;
    description: "How do we measure the revenue"

  }

  dimension: price_type_select__c {
    type: string
    sql: ${TABLE}.price_type_select__c ;;
    hidden: yes
  }

  dimension: pricebookentryid {
    type: string
    sql: ${TABLE}.pricebookentryid ;;
    hidden: yes
  }

  dimension: primary_kpi__c {
    type: string
    label: "Primary KPI"
    sql: ${TABLE}.primary_kpi__c ;;
  }

  dimension: primary_kpi_metric__c {
    type: string
    label: "Primary KPI Value"
    sql: ${TABLE}.primary_kpi_metric__c ;;
    #hidden: yes
  }

  dimension: primary_kpi_metric_clean {
    type: number
    label: "Primary KPI Value - Clean"
    sql: CASE WHEN REPLACE(${TABLE}.primary_kpi_metric__c, '%', '!PERCENTAGE!') LIKE '%!PERCENTAGE!%' THEN SUBSTR(${TABLE}.primary_kpi_metric__c,1, LENGTH(${TABLE}.primary_kpi_metric__c)-1)::!float
    WHEN ${TABLE}.primary_kpi_metric__c LIKE '%$%' THEN SUBSTR(${TABLE}.primary_kpi_metric__c,2)::!float
    ELSE ${TABLE}.primary_kpi_metric__c::!float END ;;
    hidden: yes
  }

  dimension: product_configuration__c {
    type: string
    sql: ${TABLE}.product_configuration__c ;;
    hidden: yes
  }

  dimension: product_level_i__c {
    type: string
    label: "Product Level 1"
    sql: ${TABLE}.product_level_i__c ;;

  }

  dimension: quantity {
    type: number
    label: "Quantity"
    sql: ${TABLE}.quantity ;;
    hidden: yes
  }

  dimension: rate__c {
    type: number
    label: "Rate"
    sql: ${TABLE}.rate__c ;;
  }

  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
    hidden: yes
  }

  dimension: related_adjustments__c {
    type: number
    label: "Related Adjustment"
    sql: ${TABLE}.related_adjustments__c ;;
    hidden: yes
  }

  dimension: related_line_items__c {
    type: string
    sql: ${TABLE}.related_line_items__c ;;
    hidden: yes
  }

  dimension: reporting__c {
    type: string
    label: "Server Reporting"
    sql: ${TABLE}.reporting__c ;;
  }

  dimension: sales_engineer__c {
    type: string
    sql: ${TABLE}.sales_engineer__c ;;
    hidden: yes
  }

  dimension: sales_rep__c {
    type: string
    sql: ${TABLE}.sales_rep__c ;;
    hidden: yes
  }

  dimension: secondary_kpi__c {
    type: string
    label: "Secondary KPI "
    sql: ${TABLE}.secondary_kpi__c ;;
  }

  dimension: secondary_kpi_metric__c {
    type: string
    label: "Secondary KPI Metric"
    sql: ${TABLE}.secondary_kpi_metric__c ;;
  }

  dimension: service_type__c {
    type: string
    label: "Serivce Type"
    sql: ${TABLE}.service_type__c ;;

  }

  dimension_group: servicedate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.servicedate ;;
    hidden: yes
  }

  dimension: sortorder {
    type: number
    sql: ${TABLE}.sortorder ;;
    hidden: yes
  }

  dimension: spend__c {
    type: number
    label: "Line Item Spend"
    sql: ${TABLE}.spend__c ;;
  }

  measure: budgeted_spend{
    type: sum
    description: "Shows the same number as dimension 'Line Item Spend', but is a measure, so will show total"
    label: "Budgeted Spend"
    sql: ${TABLE}.spend__c ;;
  }

  dimension: spend_adjusted__c {
    type: number
    label: "Line Item Spend Adjusted"
    sql: ${TABLE}.spend_adjusted__c ;;
  }

  dimension_group: start_date__c {
    type: time
    label: "OPP Line Item Start"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
    description: "Start date of line item from salesforce"
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
    hidden: yes
  }

  dimension: totalprice {
    type: number
    label: "Total Price"
    sql: ${TABLE}.totalprice ;;
  }

  dimension: unitprice {
    type: number
    label: "Unit Price"
    sql: ${TABLE}.unitprice ;;
  }

  dimension: units__c {
    type: number
    label: "Booked Units"
    sql: ${TABLE}.units__c ;;
  }

  measure: budgeted_units {
    type: sum
    description: "Shows the same number as dimension 'Booked Units', but is a measure, so will show total"
    label: "Budgeted Units"
    sql: ${TABLE}.units__c ;;
  }

  dimension: rate_card_discount_applies_to__c {
    type: string
    label: "Rate Card Discount Applies To"
    sql: ${TABLE}.rate_card_discount_applies_to__c ;;
  }

  dimension: undiscounted_spend__c {
    type: number
    label: "Undiscounted Spend"
    sql: ${TABLE}.undiscounted_spend__c ;;
  }

  dimension: vat_tax__c {
    type: number
    sql: ${TABLE}.vat_tax__c ;;
    hidden: yes
  }

  dimension: tactic {
    type: string
    label: "Tactic"
    sql: CASE WHEN ${line_item_name__c} LIKE '%RET%' THEN 'Retargeting'
    WHEN ${line_item_name__c} LIKE '%BI%' THEN 'Brand Intelligence'
    WHEN ${line_item_name__c} LIKE '%DEMO%' THEN 'Demographic'
    WHEN ${line_item_name__c} LIKE '%BT%' THEN 'Behavioral'
    WHEN ${line_item_name__c} LIKE '%PERF%' THEN 'Performance'
    WHEN ${line_item_name__c} LIKE '%PMP%' THEN 'PMP'END ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }
  dimension: date_diff {
    type: number
    sql: case when ${end_date__c_date} <fact_nexxen_dsp.date_key_in_timezone then 1
              when ${start_date__c_date} > fact_nexxen_dsp.date_key_in_timezone then 0  else
         (fact_nexxen_dsp.date_key_in_timezone - ${start_date__c_date})+1 end;;
        hidden: yes
  }


  measure: gross_billable_comp {
    type: max
    sql: ${gross_billable__c} ;;
    hidden: yes
  }

  measure: monthy_budget_breakout_temp {
    type: number
    sql: ${gross_billable_comp}-${fact_nexxen_dsp.capped_revenue} ;;
    hidden: yes
  }

  dimension: daily_units_needed_comp {
    type: number
    sql: case when ${dim_sfdb_opportunitylineitem.price_type_name__c} in ('dCPM', 'CPR') then
    ${dim_sfdb_opportunitylineitem.gross_billable__c} else ${dim_sfdb_opportunitylineitem.units__c} end;;
    hidden: yes
  }

  measure: daily_units_needed_comp_2 {
    type: max
    sql: ${daily_units_needed_comp} ;;
    hidden: yes
  }

  measure: daily_units_needed_comp_3 {
    type: number
    sql: ${daily_units_needed_comp_2}-${fact_nexxen_dsp.delivered_units}/nullif(${v_dim_sfdb_opportunitylineitemschedule_new.total_days_left_in_sl},0) ;;
    hidden: yes
  }

  measure: total_booked_budget_meas {
    type: sum
    sql: ${TABLE}.gross_billable__c ;;
  }

  dimension: booked_rate {
    type: number
    label: "Booked Rate"
    sql: CASE WHEN ${TABLE}.free__c='Added Value' AND ${TABLE}.price_type_name__c='CPM' THEN 0 ELSE ${TABLE}.rate__c END  ;;
  }

}
