view: forecast_dim_sfdb_opportunity {
  derived_table: {
    sql: SELECT *
    FROM BI_DSP.dim_sfdb_opportunity
    WHERE is_deleted=0;;
  }
  # sql_table_name: BI_DSP.dim_sfdb_opportunity ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: account_manager__c {
    type: string
    sql: ${TABLE}.account_manager__c ;;
  }
  dimension: account_owner__c {
    type: string
    sql: ${TABLE}.account_owner__c ;;
  }
  dimension: account_type__c {
    type: string
    sql: ${TABLE}.account_type__c ;;
  }
  dimension: accountid {
    type: string
    sql: ${TABLE}.accountid ;;
  }
  dimension: active_owner__c {
    type: number
    sql: ${TABLE}.active_owner__c ;;
  }
  dimension: ae_bet__c {
    type: number
    sql: ${TABLE}.ae_bet__c ;;
  }
  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }
  dimension: approved_by_account_manager__c {
    type: number
    sql: ${TABLE}.approved_by_account_manager__c ;;
  }
  dimension: approved_by_client_services_manager__c {
    type: number
    sql: ${TABLE}.approved_by_client_services_manager__c ;;
  }
  dimension: approved_by_sales_planner__c {
    type: number
    sql: ${TABLE}.approved_by_sales_planner__c ;;
  }
  dimension: approved_quotes__c {
    type: number
    sql: ${TABLE}.approved_quotes__c ;;
  }
  dimension: billing_account__c {
    type: string
    sql: ${TABLE}.billing_account__c ;;
  }
  dimension: billing_instructions__c {
    type: string
    sql: ${TABLE}.billing_instructions__c ;;
  }
  dimension: brand_classification__c {
    type: string
    sql: ${TABLE}.brand_classification__c ;;
  }
  dimension: campaign_manager__c {
    type: string
    sql: ${TABLE}.campaign_manager__c ;;
  }
  dimension: campaign_objectives__c {
    type: string
    sql: ${TABLE}.campaign_objectives__c ;;
  }
  dimension: cancellation_clause__c {
    type: string
    sql: ${TABLE}.cancellation_clause__c ;;
  }
  dimension: change_reason__c {
    type: string
    sql: ${TABLE}.change_reason__c ;;
  }
  dimension: client_paperwork__c {
    type: string
    sql: ${TABLE}.client_paperwork__c ;;
  }
  dimension: client_services_manager__c {
    type: string
    sql: ${TABLE}.client_services_manager__c ;;
  }
  dimension_group: closed_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.closed_date__c ;;
  }
  dimension_group: closedate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.closedate ;;
  }
  dimension: confidence_level__c {
    type: string
    sql: ${TABLE}.confidence_level__c ;;
  }
  dimension: corp_entity__c {
    type: string
    sql: ${TABLE}.corp_entity__c ;;
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
  dimension: credit_review__c {
    type: string
    sql: ${TABLE}.credit_review__c ;;
  }
  dimension: currencyisocode {
    type: string
    sql: ${TABLE}.currencyisocode ;;
  }
  dimension: customer_signed_by__c {
    type: string
    sql: ${TABLE}.customer_signed_by__c ;;
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

# Convert the full timestamp to a sortable number (Unix seconds)
  dimension: db_updated_number {
    type: number
    sql: EXTRACT(EPOCH FROM ${db_updated_raw}) ;;
    label: "DB Updated Unix Time"
    hidden: yes
  }

  measure: max_database_update_timestamp {
    type: max
    sql: ${db_updated_number} ;;
    label: "Max DB Update"
    hidden: yes
  }


  measure: final_database_last_update {
    type: string # Must be string or number for this method
    # Use a Vertica function to convert the max number (seconds) back to a formatted string
    sql: TO_CHAR(TO_TIMESTAMP(${max_database_update_timestamp}), 'YYYY-MM-DD HH24:MI:SS') ;;
    label: "Database Last Update"
  }




  dimension: calculated_margin__c {
    type: number
    sql: ${TABLE}.calculated_margin__c ;;
  }

  dimension: deal_review_approved__c {
    type: number
    sql: ${TABLE}.deal_review_approved__c ;;
  }
  dimension: deal_review_manager__c {
    type: string
    sql: ${TABLE}.deal_review_manager__c ;;
  }
  dimension: deal_review_required__c {
    type: string
    sql: ${TABLE}.deal_review_required__c ;;
  }
  dimension: deal_review_slide_attachment__c {
    type: string
    sql: ${TABLE}.deal_review_slide_attachment__c ;;
  }
  dimension: deal_reviewer_2__c {
    type: string
    sql: ${TABLE}.deal_reviewer_2__c ;;
  }
  dimension: deal_reviewer_3__c {
    type: string
    sql: ${TABLE}.deal_reviewer_3__c ;;
  }
  dimension: deal_reviewer_4__c {
    type: string
    sql: ${TABLE}.deal_reviewer_4__c ;;
  }
  dimension: deal_type__c {
    type: string
    sql: ${TABLE}.deal_type__c ;;
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
  dimension: expected_revenue__c {
    type: number
    sql: ${TABLE}.expected_revenue__c ;;
  }

  measure: Full_Pipeline {
    type: number
    label: "Full Pipeline"
    sql:
    CASE
      WHEN SUM(${line_item_count__c}) = 0 THEN SUM(${proposed_spend__c})
      ELSE 0
    END + SUM(${expected_revenue__c}) ;;
    value_format: "$#,##0"
  }


  measure: weighted_pipeline {
    type: number
    label: "Weighted Pipeline"
    sql: (sum (${probability}) * ${Full_Pipeline}) / 100 ;;
    value_format: "$#,##0"
  }

  dimension: expectedrevenue {
    type: number
    sql: ${TABLE}.expectedrevenue ;;
  }
  dimension: expedited_market_request__c {
    type: number
    sql: ${TABLE}.expedited_market_request__c ;;
  }
  dimension: external_reference_id__c {
    type: string
    sql: ${TABLE}.external_reference_id__c ;;
  }
  dimension: fdw_billing__c {
    type: string
    sql: ${TABLE}.fdw_billing__c ;;
  }
  dimension: finance_approved__c {
    type: number
    sql: ${TABLE}.finance_approved__c ;;
  }
  dimension: fiscal {
    type: string
    sql: ${TABLE}.fiscal ;;
  }
  dimension: fiscalquarter {
    type: number
    sql: ${TABLE}.fiscalquarter ;;
  }
  dimension: fiscalyear {
    type: number
    sql: ${TABLE}.fiscalyear ;;
  }
  dimension: forecast_opp__c {
    type: number
    sql: ${TABLE}.forecast_opp__c ;;
  }
  dimension: forecastcategory {
    type: string
    sql: ${TABLE}.forecastcategory ;;
  }
  dimension: gross_profit__c {
    type: number
    sql: ${TABLE}.gross_profit__c ;;
  }
  dimension: has_msa__c {
    type: number
    sql: ${TABLE}.has_msa__c ;;
  }
  dimension: hasopportunitylineitem {
    type: number
    sql: ${TABLE}.hasopportunitylineitem ;;
  }
  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
  }
  dimension: is_it_a_purchase__c {
    type: string
    sql: ${TABLE}.is_it_a_purchase__c ;;
  }
  dimension: isclosed {
    type: number
    sql: ${TABLE}.isclosed ;;
  }
  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
  }
  dimension: iswon {
    type: number
    sql: ${TABLE}.iswon ;;
  }
  dimension: last_line_item_num__c {
    type: number
    sql: ${TABLE}.last_line_item_num__c ;;
  }
  dimension_group: lastactivitydate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastactivitydate ;;
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
  dimension: leadsource {
    type: string
    sql: ${TABLE}.leadsource ;;
  }
  dimension: legacy_amobee_ids__c {
    type: string
    sql: ${TABLE}.legacy_amobee_ids__c ;;
  }
  dimension: legacy_turn_ids__c {
    type: string
    sql: ${TABLE}.legacy_turn_ids__c ;;
  }
  dimension: line_item_count__c {
    type: number
    sql: ${TABLE}.line_item_count__c ;;
  }
  dimension: lob__c {
    type: string
    sql: ${TABLE}.lob__c ;;
  }
  dimension: loss_reason__c {
    type: string
    sql: ${TABLE}.loss_reason__c ;;
  }
  dimension: loss_reason_details__c {
    type: string
    sql: ${TABLE}.loss_reason_details__c ;;
  }
  dimension: market__c {
    type: string
    sql: ${TABLE}.market__c ;;
  }
  dimension: market_id__c {
    type: string
    sql: ${TABLE}.market_id__c ;;
  }
  dimension: monthly_budget_approved__c {
    type: number
    sql: ${TABLE}.monthly_budget_approved__c ;;
  }
  dimension: msa_margin__c {
    type: number
    sql: ${TABLE}.msa_margin__c ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: new_market__c {
    type: number
    sql: ${TABLE}.new_market__c ;;
  }
  dimension: new_msa__c {
    type: number
    sql: ${TABLE}.new_msa__c ;;
  }
  dimension: new_msa_market__c {
    type: string
    sql: ${TABLE}.new_msa_market__c ;;
  }
  dimension: new_msa_market_status__c {
    type: string
    sql: ${TABLE}.new_msa_market_status__c ;;
  }
  # dimension: new_vs_existing_customer {
  #   type: string
  #   sql: ${TABLE}.new_vs_existing_customer ;;
  # }
    dimension: new_vs_existing_customer {
    type: string
    sql: CASE ${TABLE}.deal_type__c
    WHEN 'New Customer' THEN 'New'
    WHEN 'Existing' THEN 'Existing'
    WHEN 'New Line of Business' THEN 'Existing'
    END;;
  }
  dimension: nextstep {
    type: string
    sql: ${TABLE}.nextstep ;;
  }
  # dimension: numbered_stage {
  #   type: string
  #   sql: ${TABLE}.numbered_stage ;;
  # }
  dimension: numbered_stage {
    type: string
    sql: CASE ${TABLE}.stagename
    WHEN 'Draft' THEN 'a. Draft'
    WHEN 'Discovery Meeting' THEN 'b. Discovery Meeting'
    WHEN 'LowEngage' THEN 'c. LowEngage'
    WHEN 'RFP/RFI Received'THEN 'd. RFP/RFI Received'
    WHEN 'HighEngage' THEN 'e. HighEngage'
    WHEN 'Proposal Discussion' THEN 'f. Proposal Discussion'
    WHEN 'Proposal' THEN 'g. Proposal'
    WHEN 'Proposal Ready' THEN 'h. Proposal Ready'
    WHEN 'Proposal Sent' THEN 'i. Proposal Sent'
    WHEN 'Verbal' THEN 'j. Verbal'
    WHEN 'IO Ready' THEN 'k. IO Ready'
    WHEN 'Final Approval' THEN 'l. Final Approval'
    END;;
  }
  dimension: opportunity_aid__c {
    type: string
    sql: ${TABLE}.opportunity_aid__c ;;
  }
  dimension: opportunity_console_id__c {
    type: string
    sql: ${TABLE}.opportunity_console_id__c ;;
  }
  dimension: opportunity_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.opportunity_id_key ;;
  }
  dimension: opportunity_margin__c {
    type: number
    sql: ${TABLE}.opportunity_margin__c ;;
  }
  dimension: opportunity_number__c {
    type: string
    sql: ${TABLE}.opportunity_number__c ;;
  }
  dimension: order__c {
    type: string
    sql: ${TABLE}.order__c ;;
  }
  dimension: order_generated__c {
    type: number
    sql: ${TABLE}.order_generated__c ;;
  }
  dimension: original_record_type__c {
    type: string
    sql: ${TABLE}.original_record_type__c ;;
  }
  dimension: owner_code__c {
    type: string
    sql: ${TABLE}.owner_code__c ;;
  }
  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
  }
  dimension: payment_terms__c {
    type: string
    sql: ${TABLE}.payment_terms__c ;;
  }
  dimension: political_advertiser__c {
    type: string
    sql: ${TABLE}.political_advertiser__c ;;
  }
  dimension: populate_end_date__c {
    type: number
    sql: ${TABLE}.populate_end_date__c ;;
  }
  dimension: populate_start_date__c {
    type: number
    sql: ${TABLE}.populate_start_date__c ;;
  }
  dimension: pricebook2id {
    type: string
    sql: ${TABLE}.pricebook2id ;;
  }
  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }
  dimension: products_sold__c {
    type: string
    sql: ${TABLE}.products_sold__c ;;
  }
  dimension: proposed_spend__c {
    type: number
    sql: ${TABLE}.proposed_spend__c ;;
  }
  dimension: record_type__c {
    type: string
    sql: ${TABLE}.record_type__c ;;
  }
  dimension: recordtypeid {
    type: string
    sql: ${TABLE}.recordtypeid ;;
  }
  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
  }
  dimension: region__c {
    type: string
    sql: ${TABLE}.region__c ;;
  }
  dimension: related_account__c {
    type: string
    sql: ${TABLE}.related_account__c ;;
  }
  dimension: related_account_aid__c {
    type: string
    sql: ${TABLE}.related_account_aid__c ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension: revenue_stage {
    type: string
    sql: ${TABLE}.revenue_stage ;;
  }
  dimension_group: rfp_due_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.rfp_due_date__c ;;
  }
  dimension: rfp_required__c {
    type: number
    sql: ${TABLE}.rfp_required__c ;;
  }
  dimension: rfp_rfi_request_attachment__c {
    type: string
    sql: ${TABLE}.rfp_rfi_request_attachment__c ;;
  }
  dimension: rfp_rfi_response_attachment__c {
    type: string
    sql: ${TABLE}.rfp_rfi_response_attachment__c ;;
  }
  dimension: sales_engineer__c {
    type: string
    sql: ${TABLE}.sales_engineer__c ;;
  }
  dimension: sales_planner__c {
    type: string
    sql: ${TABLE}.sales_planner__c ;;
  }
  dimension: sales_rep__c {
    type: string
    sql: ${TABLE}.sales_rep__c ;;
  }
  dimension: sales_team__c {
    type: string
    sql: ${TABLE}.sales_team__c ;;
  }
  dimension: senior_account_manager__c {
    type: string
    sql: ${TABLE}.senior_account_manager__c ;;
  }
  dimension: signed_io_attachment__c {
    type: string
    sql: ${TABLE}.signed_io_attachment__c ;;
  }
  dimension: signed_msa_attachment__c {
    type: string
    sql: ${TABLE}.signed_msa_attachment__c ;;
  }
  dimension: signed_msa_review_case__c {
    type: string
    sql: ${TABLE}.signed_msa_review_case__c ;;
  }
  dimension: signed_nda_attachment__c {
    type: string
    sql: ${TABLE}.signed_nda_attachment__c ;;
  }
  dimension: special_deal_notes__c {
    type: string
    sql: ${TABLE}.special_deal_notes__c ;;
  }
  dimension: special_terms__c {
    type: string
    sql: ${TABLE}.special_terms__c ;;
  }
  dimension: stagename {
    type: string
    sql: ${TABLE}.stagename ;;
  }
  dimension_group: start_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
  }
  dimension: status__c {
    type: string
    sql: ${TABLE}.status__c ;;
  }
  dimension: status_reason__c {
    type: string
    sql: ${TABLE}.status_reason__c ;;
  }
  dimension: super_region__c {
    type: string
    sql: ${TABLE}.super_region__c ;;
  }
  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
  }
  dimension: total_adjusted_spend__c {
    type: number
    sql: ${TABLE}.total_adjusted_spend__c ;;
  }
  dimension: total_amount__c {
    type: number
    sql: ${TABLE}.total_amount__c ;;
  }
  dimension: total_gross_spend__c {
    type: number
    sql: ${TABLE}.total_gross_spend__c ;;
  }
  dimension: total_units__c {
    type: number
    sql: ${TABLE}.total_units__c ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
  }
  dimension: valid_conversions__c {
    type: string
    sql: ${TABLE}.valid_conversions__c ;;
  }
  dimension: vat_tax__c {
    type: number
    sql: ${TABLE}.vat_tax__c ;;
  }
  dimension: vertical {
    type: string
    sql: ${TABLE}.vertical ;;
  }
  dimension: win_reason__c {
    type: string
    sql: ${TABLE}.win_reason__c ;;
  }
  dimension: win_reason_details__c {
    type: string
    sql: ${TABLE}.win_reason_details__c ;;
  }

  dimension: opportunity_link {
    type: string
    sql: CONCAT('https://amobee-sfv.lightning.force.com/', ${TABLE}.id) ;;
  }

  dimension: probability_level {
    type: number
    label: "Probability Level"
    sql:
    CASE
      WHEN ${confidence_level__c} IS NOT NULL
           AND ${confidence_level__c} ~ '^[0-9]+(\.[0-9]+)?$' THEN CAST(${confidence_level__c} AS FLOAT)
      ELSE CAST(${probability} AS FLOAT)
    END ;;
  }

  dimension: forecast_checkbox {
    type: number
    sql: ${TABLE}.forecast_opp__c ;;
  }

  measure: count_of_opps {
    type: count_distinct
    label: "# of Opps"
    sql: ${TABLE}.id;;
  }
}
