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
    sql: ${TABLE}.id ;;
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
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_affects_net_of_related_line_items__c {
    type: sum
    sql: ${affects_net_of_related_line_items__c} ;;  }
  measure: average_affects_net_of_related_line_items__c {
    type: average
    sql: ${affects_net_of_related_line_items__c} ;;  }

  dimension: cloned_from_line_item__c {
    type: string
    sql: ${TABLE}.cloned_from_line_item__c ;;
  }

  dimension: configured_3rd_party_services__c {
    type: string
    sql: ${TABLE}.configured_3rd_party_services__c ;;
  }

  dimension: configured_brand_safety__c {
    type: string
    sql: ${TABLE}.configured_brand_safety__c ;;
  }

  dimension: configured_creative_format__c {
    type: string
    sql: ${TABLE}.configured_creative_format__c ;;
  }

  dimension: configured_creative_size__c {
    type: string
    sql: ${TABLE}.configured_creative_size__c ;;
  }

  dimension: configured_creative_type__c {
    type: string
    sql: ${TABLE}.configured_creative_type__c ;;
  }

  dimension: configured_device__c {
    type: string
    sql: ${TABLE}.configured_device__c ;;
  }

  dimension: configured_product_name__c {
    type: string
    sql: ${TABLE}.configured_product_name__c ;;
  }

  dimension: configured_retargeting__c {
    type: string
    sql: ${TABLE}.configured_retargeting__c ;;
  }

  dimension: configured_sales_packages__c {
    type: string
    sql: ${TABLE}.configured_sales_packages__c ;;
  }

  dimension: configured_supply_mandates__c {
    type: string
    sql: ${TABLE}.configured_supply_mandates__c ;;
  }

  dimension: configured_targeting_ages__c {
    type: string
    sql: ${TABLE}.configured_targeting_ages__c ;;
  }

  dimension: configured_targeting_behavioral__c {
    type: string
    sql: ${TABLE}.configured_targeting_behavioral__c ;;
  }

  dimension: configured_targeting_cities__c {
    type: string
    sql: ${TABLE}.configured_targeting_cities__c ;;
  }

  dimension: configured_targeting_contextual__c {
    type: string
    sql: ${TABLE}.configured_targeting_contextual__c ;;
  }

  dimension: configured_targeting_countries__c {
    type: string
    sql: ${TABLE}.configured_targeting_countries__c ;;
  }

  dimension: configured_targeting_dma_al__c {
    type: string
    sql: ${TABLE}.configured_targeting_dma_al__c ;;
  }

  dimension: configured_targeting_dma_mz__c {
    type: string
    sql: ${TABLE}.configured_targeting_dma_mz__c ;;
  }

  dimension: configured_targeting_ethnicity__c {
    type: string
    sql: ${TABLE}.configured_targeting_ethnicity__c ;;
  }

  dimension: configured_targeting_exclude__c {
    type: string
    sql: ${TABLE}.configured_targeting_exclude__c ;;
  }

  dimension: configured_targeting_gender__c {
    type: string
    sql: ${TABLE}.configured_targeting_gender__c ;;
  }

  dimension: configured_targeting_household_income__c {
    type: string
    sql: ${TABLE}.configured_targeting_household_income__c ;;
  }

  dimension: configured_targeting_language__c {
    type: string
    sql: ${TABLE}.configured_targeting_language__c ;;
  }

  dimension: configured_targeting_locations__c {
    type: string
    sql: ${TABLE}.configured_targeting_locations__c ;;
  }

  dimension: configured_targeting_region__c {
    type: string
    sql: ${TABLE}.configured_targeting_region__c ;;
  }

  dimension: configured_targeting_state__c {
    type: string
    sql: ${TABLE}.configured_targeting_state__c ;;
  }

  dimension: configured_targeting_viewership__c {
    type: string
    sql: ${TABLE}.configured_targeting_viewership__c ;;
  }

  dimension: configured_targeting_zip__c {
    type: string
    sql: ${TABLE}.configured_targeting_zip__c ;;
  }

  dimension: createdbyid {
    type: string
    sql: ${TABLE}.createdbyid ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: createddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.createddate ;;
  }

  dimension: currencyisocode {
    type: string
    sql: ${TABLE}.currencyisocode ;;
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }

  dimension: delivery_manager__c {
    type: string
    sql: ${TABLE}.delivery_manager__c ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension_group: end_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
  }

  dimension: expected_amount__c {
    type: number
    sql: ${TABLE}.expected_amount__c ;;
  }

  dimension: free__c {
    type: string
    sql: ${TABLE}.free__c ;;
  }

  dimension: free_reason__c {
    type: string
    sql: ${TABLE}.free_reason__c ;;
  }

  dimension: free_reason_other__c {
    type: string
    sql: ${TABLE}.free_reason_other__c ;;
  }

  dimension: gross_billable__c {
    type: number
    sql: ${TABLE}.gross_billable__c ;;
  }

  dimension: has_product_config__c {
    type: number
    sql: ${TABLE}.has_product_config__c ;;
  }

  dimension: hasquantityschedule {
    type: number
    sql: ${TABLE}.hasquantityschedule ;;
  }

  dimension: hasrevenueschedule {
    type: number
    sql: ${TABLE}.hasrevenueschedule ;;
  }

  dimension: hasschedule {
    type: number
    sql: ${TABLE}.hasschedule ;;
  }

  dimension: incremental_amount__c {
    type: number
    sql: ${TABLE}.incremental_amount__c ;;
  }

  dimension: io_currency__c {
    type: string
    sql: ${TABLE}.io_currency__c ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
  }

  dimension: is_free__c {
    type: number
    sql: ${TABLE}.is_free__c ;;
  }

  dimension: is_hidden__c {
    type: number
    sql: ${TABLE}.is_hidden__c ;;
  }

  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
  }

  dimension: item_type__c {
    type: string
    sql: ${TABLE}.item_type__c ;;
  }

  dimension: lastmodifiedbyid {
    type: string
    sql: ${TABLE}.lastmodifiedbyid ;;
  }

  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
  }

  dimension: legacy_amobee_ids__c {
    type: string
    sql: ${TABLE}.legacy_amobee_ids__c ;;
  }

  dimension: line_item_name__c {
    type: string
    sql: ${TABLE}.line_item_name__c ;;
  }

  dimension: line_item_number__c {
    type: number
    sql: ${TABLE}.line_item_number__c ;;
  }

  dimension: listprice {
    type: number
    sql: ${TABLE}.listprice ;;
  }

  dimension: live_status__c {
    type: string
    sql: ${TABLE}.live_status__c ;;
  }

  dimension: margin_type__c {
    type: string
    sql: ${TABLE}.margin_type__c ;;
  }

  dimension: market__c {
    type: string
    sql: ${TABLE}.market__c ;;
  }

  dimension: market_in_effect__c {
    type: number
    sql: ${TABLE}.market_in_effect__c ;;
  }

  dimension: net__c {
    type: number
    sql: ${TABLE}.net__c ;;
  }

  dimension: opportunity_owner__c {
    type: string
    sql: ${TABLE}.opportunity_owner__c ;;
  }

  dimension: opportunityid {
    type: string
    sql: ${TABLE}.opportunityid ;;
  }

  dimension: opportunitylineitem_aid__c {
    type: string
    sql: ${TABLE}.opportunitylineitem_aid__c ;;
  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
  }

  dimension: owner_code__c {
    type: string
    sql: ${TABLE}.owner_code__c ;;
  }

  dimension: price_type__c {
    type: string
    sql: ${TABLE}.price_type__c ;;
  }

  dimension: price_type_name__c {
    type: string
    sql: ${TABLE}.price_type_name__c ;;
  }

  dimension: price_type_select__c {
    type: string
    sql: ${TABLE}.price_type_select__c ;;
  }

  dimension: pricebookentryid {
    type: string
    sql: ${TABLE}.pricebookentryid ;;
  }

  dimension: primary_kpi__c {
    type: string
    sql: ${TABLE}.primary_kpi__c ;;
  }

  dimension: primary_kpi_metric__c {
    type: string
    sql: ${TABLE}.primary_kpi_metric__c ;;
  }

  dimension: product_configuration__c {
    type: string
    sql: ${TABLE}.product_configuration__c ;;
  }

  dimension: product_level_i__c {
    type: string
    sql: ${TABLE}.product_level_i__c ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: rate__c {
    type: number
    sql: ${TABLE}.rate__c ;;
  }

  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
  }

  dimension: related_adjustments__c {
    type: number
    sql: ${TABLE}.related_adjustments__c ;;
  }

  dimension: related_line_items__c {
    type: string
    sql: ${TABLE}.related_line_items__c ;;
  }

  dimension: reporting__c {
    type: string
    sql: ${TABLE}.reporting__c ;;
  }

  dimension: sales_engineer__c {
    type: string
    sql: ${TABLE}.sales_engineer__c ;;
  }

  dimension: sales_rep__c {
    type: string
    sql: ${TABLE}.sales_rep__c ;;
  }

  dimension: secondary_kpi__c {
    type: string
    sql: ${TABLE}.secondary_kpi__c ;;
  }

  dimension: secondary_kpi_metric__c {
    type: string
    sql: ${TABLE}.secondary_kpi_metric__c ;;
  }

  dimension: service_type__c {
    type: string
    sql: ${TABLE}.service_type__c ;;
  }

  dimension_group: servicedate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.servicedate ;;
  }

  dimension: sortorder {
    type: number
    sql: ${TABLE}.sortorder ;;
  }

  dimension: spend__c {
    type: number
    sql: ${TABLE}.spend__c ;;
  }

  dimension: spend_adjusted__c {
    type: number
    sql: ${TABLE}.spend_adjusted__c ;;
  }

  dimension_group: start_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
  }

  dimension: totalprice {
    type: number
    sql: ${TABLE}.totalprice ;;
  }

  dimension: unitprice {
    type: number
    sql: ${TABLE}.unitprice ;;
  }

  dimension: units__c {
    type: number
    sql: ${TABLE}.units__c ;;
  }

  dimension: vat_tax__c {
    type: number
    sql: ${TABLE}.vat_tax__c ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
