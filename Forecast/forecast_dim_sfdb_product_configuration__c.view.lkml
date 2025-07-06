view: forecast_dim_sfdb_product_configuration__c {
  sql_table_name: BI_DSP.dim_sfdb_product_configuration__c ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: aid__c {
    type: string
    sql: ${TABLE}.aid__c ;;
  }
  dimension: brand_safety__c {
    type: string
    sql: ${TABLE}.brand_safety__c ;;
  }
  dimension: createdbyid {
    type: string
    sql: ${TABLE}.createdbyid ;;
  }
  dimension_group: createddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.createddate ;;
  }
  dimension: creative_format__c {
    type: string
    sql: ${TABLE}.creative_format__c ;;
  }
  dimension: creative_size__c {
    type: string
    sql: ${TABLE}.creative_size__c ;;
  }
  dimension: creative_type__c {
    type: string
    sql: ${TABLE}.creative_type__c ;;
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
  dimension: demo_targeting_details__c {
    type: string
    sql: ${TABLE}.demo_targeting_details__c ;;
  }
  dimension: device__c {
    type: string
    sql: ${TABLE}.device__c ;;
  }
  dimension: device_text__c {
    type: string
    sql: ${TABLE}.device_text__c ;;
  }
  dimension: frequency_cap__c {
    type: string
    sql: ${TABLE}.frequency_cap__c ;;
  }
  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
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
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: opportunity__c {
    type: string
    sql: ${TABLE}.opportunity__c ;;
  }
  dimension: opportunitylineitem_id__c {
    type: string
    sql: ${TABLE}.opportunitylineitem_id__c ;;
  }
  dimension: order__c {
    type: string
    sql: ${TABLE}.order__c ;;
  }
  dimension: orderitem__c {
    type: string
    sql: ${TABLE}.orderitem__c ;;
  }
  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
  }
  dimension: product_level_i__c {
    type: string
    sql: ${TABLE}.product_level_i__c ;;
  }
  dimension: product_name_for_quote_pdf__c {
    type: string
    sql: ${TABLE}.product_name_for_quote_pdf__c ;;
  }
  dimension: product_names__c {
    type: string
    sql: ${TABLE}.product_names__c ;;
  }
  dimension: recordtypeid {
    type: string
    sql: ${TABLE}.recordtypeid ;;
  }
  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
  }
  dimension: retargeting__c {
    type: string
    sql: ${TABLE}.retargeting__c ;;
  }
  dimension: sales_package_text__c {
    type: string
    sql: ${TABLE}.sales_package_text__c ;;
  }
  dimension: sales_packages__c {
    type: string
    sql: ${TABLE}.sales_packages__c ;;
  }
  dimension: supply_mandates__c {
    type: string
    sql: ${TABLE}.supply_mandates__c ;;
  }
  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
  }
  dimension: targeting_age__c {
    type: string
    sql: ${TABLE}.targeting_age__c ;;
  }
  dimension: targeting_age_text__c {
    type: string
    sql: ${TABLE}.targeting_age_text__c ;;
  }
  dimension: targeting_behavioral__c {
    type: string
    sql: ${TABLE}.targeting_behavioral__c ;;
  }
  dimension: targeting_city__c {
    type: string
    sql: ${TABLE}.targeting_city__c ;;
  }
  dimension: targeting_contextual__c {
    type: string
    sql: ${TABLE}.targeting_contextual__c ;;
  }
  dimension: targeting_country__c {
    type: string
    sql: ${TABLE}.targeting_country__c ;;
  }
  dimension: targeting_country_text__c {
    type: string
    sql: ${TABLE}.targeting_country_text__c ;;
  }
  dimension: targeting_dma_al__c {
    type: string
    sql: ${TABLE}.targeting_dma_al__c ;;
  }
  dimension: targeting_dma_al_text__c {
    type: string
    sql: ${TABLE}.targeting_dma_al_text__c ;;
  }
  dimension: targeting_dma_mz__c {
    type: string
    sql: ${TABLE}.targeting_dma_mz__c ;;
  }
  dimension: targeting_dma_mz_text__c {
    type: string
    sql: ${TABLE}.targeting_dma_mz_text__c ;;
  }
  dimension: targeting_ethnicity__c {
    type: string
    sql: ${TABLE}.targeting_ethnicity__c ;;
  }
  dimension: targeting_exclude__c {
    type: string
    sql: ${TABLE}.targeting_exclude__c ;;
  }
  dimension: targeting_gender__c {
    type: string
    sql: ${TABLE}.targeting_gender__c ;;
  }
  dimension: targeting_hhi__c {
    type: string
    sql: ${TABLE}.targeting_hhi__c ;;
  }
  dimension: targeting_hhi_text__c {
    type: string
    sql: ${TABLE}.targeting_hhi_text__c ;;
  }
  dimension: targeting_language__c {
    type: string
    sql: ${TABLE}.targeting_language__c ;;
  }
  dimension: targeting_locations__c {
    type: string
    sql: ${TABLE}.targeting_locations__c ;;
  }
  dimension: targeting_region__c {
    type: string
    sql: ${TABLE}.targeting_region__c ;;
  }
  dimension: targeting_state__c {
    type: string
    sql: ${TABLE}.targeting_state__c ;;
  }
  dimension: targeting_state_text__c {
    type: string
    sql: ${TABLE}.targeting_state_text__c ;;
  }
  dimension: targeting_viewership__c {
    type: string
    sql: ${TABLE}.targeting_viewership__c ;;
  }
  dimension: targeting_zip__c {
    type: string
    sql: ${TABLE}.targeting_zip__c ;;
  }
  dimension: x3rd_party_services__c {
    type: string
    sql: ${TABLE}.x3rd_party_services__c ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
