# The name of this view in Looker is "Dim Sfdb Opportunity"
view: dim_sfdb_opportunity {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_opportunity ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Manager C" in Explore.

  dimension: account_manager__c {
    type: string
    sql: ${TABLE}.account_manager__c ;;
    hidden: yes
  }

  dimension: account_owner__c {
    type: string
    label: "Account Manager Name"
    sql: ${TABLE}.account_owner__c ;;
    hidden: yes
  }

  dimension: account_type__c {
    type: string
    sql: ${TABLE}.account_type__c ;;
    hidden: yes
  }

  dimension: accountid {
    type: string
    sql: ${TABLE}.accountid ;;
    hidden: yes

  }

  dimension: active_owner__c {
    type: number
    sql: ${TABLE}.active_owner__c ;;
    hidden: yes
  }

  dimension: ae_bet__c {
    type: number
    sql: ${TABLE}.ae_bet__c ;;
    hidden: yes
  }

  dimension: amount {
    type: number
    label: "Amount"
    sql: ${TABLE}.amount ;;
   }

  dimension: approved_by_account_manager__c {
    type: number
    sql: ${TABLE}.approved_by_account_manager__c ;;
    hidden: yes
  }

  dimension: approved_by_client_services_manager__c {
    type: number
    sql: ${TABLE}.approved_by_client_services_manager__c ;;
    hidden: yes
  }

  dimension: approved_by_sales_planner__c {
    type: number
    sql: ${TABLE}.approved_by_sales_planner__c ;;
    hidden: yes
  }

  dimension: approved_quotes__c {
    type: number
    sql: ${TABLE}.approved_quotes__c ;;
    hidden: yes
  }

  dimension: billing_account__c {
    type: string
    label: "Billing Account ID"
    sql: ${TABLE}.billing_account__c ;;
  }

  dimension: brand_classification__c {
    type: string
    label: "Brand Clasification"
    sql: ${TABLE}.brand_classification__c ;;
  }

  dimension: campaign_manager__c {
    type: string
    sql: ${TABLE}.campaign_manager__c ;;
    hidden: yes
  }

  dimension: campaign_objectives__c {
    type: string
    sql: ${TABLE}.campaign_objectives__c ;;
    hidden: yes
  }

  dimension: cancellation_clause__c {
    type: string
    sql: ${TABLE}.cancellation_clause__c ;;
    hidden: yes
  }

  dimension: change_reason__c {
    type: string
    sql: ${TABLE}.change_reason__c ;;
    hidden: yes
  }

  dimension: client_paperwork__c {
    type: string
    sql: ${TABLE}.client_paperwork__c ;;
    hidden: yes
  }

  dimension: client_services_manager__c {
    type: string
    sql: ${TABLE}.client_services_manager__c ;;
    hidden: yes
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension: closed_date__c {
    type: date
    label: "Closed Date"
    sql: ${TABLE}.closed_date__c ;;
  }

  dimension_group: closedate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.closedate ;;
    hidden: yes
  }

  dimension: confidence_level__c {
    type: number
    sql: ${TABLE}.confidence_level__c ;;
    hidden: yes
  }

  dimension: corp_entity__c {
    type: string
    sql: ${TABLE}.corp_entity__c ;;
    hidden: yes
  }

  dimension: createdbyid {
    type: string
    sql: ${TABLE}.createdbyid ;;
    hidden: yes
  }

  dimension: createddate {
    type: date
    label: "Created Date"
    sql: ${TABLE}.createddate ;;
  }

  dimension: credit_review__c {
    type: string
    sql: ${TABLE}.credit_review__c ;;
    hidden: yes
  }

  dimension: currencyisocode {
    type: string
    label: " Opportunity Currency"
    sql: ${TABLE}.currencyisocode ;;

  }

  dimension: customer_signed_by__c {
    type: string
    sql: ${TABLE}.customer_signed_by__c ;;
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

  dimension: deal_review_approved__c {
    type: number
    sql: ${TABLE}.deal_review_approved__c ;;
    hidden: yes
  }

  dimension: deal_review_manager__c {
    type: string
    sql: ${TABLE}.deal_review_manager__c ;;
    hidden: yes
  }

  dimension: deal_review_required__c {
    type: string
    sql: ${TABLE}.deal_review_required__c ;;
    hidden: yes
  }

  dimension: deal_review_slide_attachment__c {
    type: string
    sql: ${TABLE}.deal_review_slide_attachment__c ;;
    hidden: yes
  }

  dimension: deal_reviewer_2__c {
    type: string
    sql: ${TABLE}.deal_reviewer_2__c ;;
    hidden: yes
  }

  dimension: deal_reviewer_3__c {
    type: string
    sql: ${TABLE}.deal_reviewer_3__c ;;
    hidden: yes
  }

  dimension: deal_reviewer_4__c {
    type: string
    sql: ${TABLE}.deal_reviewer_4__c ;;
    hidden: yes
  }

  dimension: deal_type__c {
    type: string
    label: "Opportunity Deal Type"
    sql: ${TABLE}.deal_type__c ;;
  }

  dimension: delivery_manager__c {
    type: string
    sql: ${TABLE}.delivery_manager__c ;;
    hidden: yes
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;

    # no data
  }

  dimension_group: end_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    label: "Opportunity End Date"
    sql: ${TABLE}.end_date__c ;;
  }

  dimension: expected_revenue__c {
    type: number
    sql: ${TABLE}.expected_revenue__c ;;
    hidden: yes
  }

  dimension: expectedrevenue {
    type: number
    label: "Expected Revenue"
    sql: ${TABLE}.expectedrevenue ;;
  }

  dimension: expedited_market_request__c {
    type: number
    sql: ${TABLE}.expedited_market_request__c ;;
    hidden: yes
  }

  dimension: external_reference_id__c {
    type: string
    sql: ${TABLE}.external_reference_id__c ;;
    hidden: yes
  }

  dimension: fdw_billing__c {
    type: string
    sql: ${TABLE}.fdw_billing__c ;;
    hidden: yes
  }

  dimension: finance_approved__c {
    type: number
    sql: ${TABLE}.finance_approved__c ;;
    hidden: yes
  }

  dimension: fiscal {
    type: string
    sql: ${TABLE}.fiscal ;;
    hidden: yes
  }

  dimension: fiscalquarter {
    type: number
    sql: ${TABLE}.fiscalquarter ;;
    hidden: yes
  }

  dimension: fiscalyear {
    type: number
    sql: ${TABLE}.fiscalyear ;;
    hidden: yes
  }

  dimension: forecast_opp__c {
    type: number
    sql: ${TABLE}.forecast_opp__c ;;
    hidden: yes
  }

  dimension: forecastcategory {
    type: string
    label: "Forecast Category"
    sql: ${TABLE}.forecastcategory ;;
  }

  dimension: gross_profit__c {
    type: number
    sql: ${TABLE}.gross_profit__c ;;
    hidden: yes
  }

  dimension: has_msa__c {
    type: number
    sql: ${TABLE}.has_msa__c ;;
    hidden: yes
  }

  dimension: hasopportunitylineitem {
    type: number
    label: "Has Opp Line item?"
    sql: ${TABLE}.hasopportunitylineitem ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension: is_it_a_purchase__c {
    type: string
    sql: ${TABLE}.is_it_a_purchase__c ;;
    hidden: yes
  }

  dimension: isclosed {
    type: number
    sql: ${TABLE}.isclosed ;;
    hidden: yes
  }

  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
    hidden: yes
  }

  dimension: iswon {
    type: number
    sql: ${TABLE}.iswon ;;
    hidden: yes
  }

  dimension: last_line_item_num__c {
    type: number
    sql: ${TABLE}.last_line_item_num__c ;;
    hidden: yes
  }

  dimension_group: lastactivitydate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastactivitydate ;;
    hidden: yes
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

  dimension: leadsource {
    type: string
    sql: ${TABLE}.leadsource ;;
    hidden: yes
  }

  dimension: legacy_amobee_ids__c {
    type: string
    sql: ${TABLE}.legacy_amobee_ids__c ;;
    hidden: yes
  }

  dimension: legacy_turn_ids__c {
    type: string
    sql: ${TABLE}.legacy_turn_ids__c ;;
    hidden: yes
  }

  dimension: line_item_count__c {
    type: number
    sql: ${TABLE}.line_item_count__c ;;
    hidden: yes
  }

  dimension: lob__c {
    type: string
    label: "Opportunity LOB"
    sql: ${TABLE}.lob__c ;;
  }

  dimension: loss_reason__c {
    type: string
    sql: ${TABLE}.loss_reason__c ;;
    hidden: yes
  }

  dimension: loss_reason_details__c {
    type: string
    sql: ${TABLE}.loss_reason_details__c ;;
    hidden: yes
  }

  dimension: market__c {
    type: string
    sql: ${TABLE}.market__c ;;
    hidden: yes
  }

  dimension: market_id__c {
    type: string
    sql: ${TABLE}.market_id__c ;;
    hidden: yes
  }

  dimension: monthly_budget_approved__c {
    type: number
    sql: ${TABLE}.monthly_budget_approved__c ;;
    hidden: yes
  }

  dimension: msa_margin__c {
    type: number
    sql: ${TABLE}.msa_margin__c ;;
    hidden: yes
  }




  dimension: name {
    type: string
    label: "Opportunity Name"
    sql: ${TABLE}."name" ;;
  }

  dimension: opp_name_shortcut {
    type: string
    sql: SUBSTRING(dim_sfdb_opportunity.name FROM (POSITION('F-' IN dim_sfdb_opportunity.name) + 1) FOR 8) ;;
  }

  dimension: new_market__c {
    type: number
    sql: ${TABLE}.new_market__c ;;
    hidden: yes
  }

  dimension: new_msa__c {
    type: number
    sql: ${TABLE}.new_msa__c ;;
    hidden: yes
  }

  dimension: new_msa_market__c {
    type: string
    sql: ${TABLE}.new_msa_market__c ;;
    hidden: yes
  }

  dimension: new_msa_market_status__c {
    type: string
    sql: ${TABLE}.new_msa_market_status__c ;;
    hidden: yes
  }

  dimension: nextstep {
    type: string
    sql: ${TABLE}.nextstep ;;
    hidden: yes
  }

  dimension: opportunity_aid__c {
    type: string
    sql: ${TABLE}.opportunity_aid__c ;;
    hidden: yes
  }

  dimension: opportunity_console_id__c {
    type: string
    sql: ${TABLE}.opportunity_console_id__c ;;
    hidden: yes
  }

  dimension: opportunity_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.opportunity_id_key ;;
    hidden: yes
  }

  dimension: opportunity_margin__c {
    type: number
    sql: ${TABLE}.opportunity_margin__c ;;
    hidden: no
  }

  dimension: opportunity_margin_check {
    type: string
    label: "Opportunity Margin Check"
    sql:
    CASE
      WHEN ${opportunity_margin__c} IS NULL THEN 'Missing'
      ELSE 'Entered'
    END ;;
  }


  dimension: opportunity_number__c {
    type: string
    label: "Opportunity Number"
    sql: ${TABLE}.opportunity_number__c ;;

  }

  dimension: order__c {
    type: string
    sql: ${TABLE}.order__c ;;
    hidden: yes
  }

  dimension: order_generated__c {
    type: number
    sql: ${TABLE}.order_generated__c ;;
    hidden: yes
  }

  dimension: original_record_type__c {
    type: string
    sql: ${TABLE}.original_record_type__c ;;
    hidden: yes
  }

  dimension: owner_code__c {
    type: string
    sql: ${TABLE}.owner_code__c ;;
    hidden: yes
  }

  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
    hidden: yes
  }

  dimension: payment_terms__c {
    type: string
    sql: ${TABLE}.payment_terms__c ;;
    hidden: yes
  }

  dimension: political_advertiser__c {
    type: string
    label: "Is Political Advertiser?"
    sql: ${TABLE}.political_advertiser__c ;;
  }

  dimension: populate_end_date__c {
    type: number
    sql: ${TABLE}.populate_end_date__c ;;
    hidden: yes
  }

  dimension: populate_start_date__c {
    type: number
    sql: ${TABLE}.populate_start_date__c ;;
    hidden: yes
  }

  dimension: pricebook2id {
    type: string

    sql: ${TABLE}.pricebook2id ;;
    hidden: yes
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
    hidden: no
  }


  # You need to ensure you're only casting when the value is not null AND numeric.
  # Vertica doesn’t have ISNUMERIC() natively, but a safe workaround is using a regex to test for numeric content

  # The ~ is Vertica's regex match operator.
  # This pattern '^[0-9]+(\.[0-9]+)?$' matches integers and decimals like 10 or 10.5.
  # If your values may contain commas or other formats, we can adjust the regex.

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


  dimension: products_sold__c {
    type: string
    label: "Product Sold"
    sql: ${TABLE}.products_sold__c ;;
  }

  dimension: proposed_spend__c {
    type: number
    label: "Proposed Spend"
    sql: ${TABLE}.proposed_spend__c ;;
  }

  dimension: record_type__c {
    type: string
    sql: ${TABLE}.record_type__c ;;
    hidden: yes
  }

  dimension: recordtypeid {
    type: string
    sql: ${TABLE}.recordtypeid ;;
    hidden: yes
  }

  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
    hidden: yes
  }

  dimension: region__c {
    type: string
    label: "Opportunity Region"
    sql: ${TABLE}.region__c ;;

  }

  dimension: related_account__c {
    type: string
    label: "Related Brand ID"
    sql: ${TABLE}.related_account__c ;;

  }

  dimension: related_account_aid__c {
    type: string
    sql: ${TABLE}.related_account_aid__c ;;
    hidden: yes

  }

  dimension: rfp_due_date__c {
    type: date
    label: "RFP Due Date"
    sql: ${TABLE}.rfp_due_date__c ;;
    hidden: yes
  }

  dimension: rfp_required__c {
    type: number
    sql: ${TABLE}.rfp_required__c ;;
    hidden: yes
  }

  dimension: rfp_rfi_request_attachment__c {
    type: string
    sql: ${TABLE}.rfp_rfi_request_attachment__c ;;
    hidden: yes
  }

  dimension: rfp_rfi_response_attachment__c {
    type: string
    sql: ${TABLE}.rfp_rfi_response_attachment__c ;;
    hidden: yes
  }

  dimension: sales_engineer__c {
    type: string
    sql: ${TABLE}.sales_engineer__c ;;
    hidden: yes
  }

  dimension: sales_planner__c {
    type: string
    sql: ${TABLE}.sales_planner__c ;;
    hidden: yes
  }

  dimension: sales_rep__c {
    type: string
    sql: ${TABLE}.sales_rep__c ;;
    hidden: yes
  }

  dimension: sales_team__c {
    type: string
    sql: ${TABLE}.sales_team__c ;;
    hidden: yes
  }

  dimension: signed_io_attachment__c {
    type: string
    sql: ${TABLE}.signed_io_attachment__c ;;
    hidden: yes
  }

  dimension: signed_msa_attachment__c {
    type: string
    sql: ${TABLE}.signed_msa_attachment__c ;;
    hidden: yes
  }

  dimension: signed_msa_review_case__c {
    type: string
    sql: ${TABLE}.signed_msa_review_case__c ;;
    hidden: yes
  }

  dimension: signed_nda_attachment__c {
    type: string
    sql: ${TABLE}.signed_nda_attachment__c ;;
    hidden: yes
  }

  dimension: special_deal_notes__c {
    type: string
    sql: ${TABLE}.special_deal_notes__c ;;

  }

  dimension: special_terms__c {
    type: string
    sql: ${TABLE}.special_terms__c ;;
    hidden: yes
  }

  dimension: stagename {
    type: string
    label: "Stage Name"
    sql: ${TABLE}.stagename ;;
  }

  dimension: revenue_stage {
    type: string
    label: "Revenue Stage"
    sql:
    CASE
      WHEN ${stagename} LIKE '%Closed Won%' THEN 'Booked'
      WHEN ${stagename} LIKE '%Closed Lost%' THEN 'Lost'

      WHEN ${stagename} = 'Verbal' THEN 'Committed'
      WHEN ${stagename} = 'Final Approval' THEN 'Committed'

      WHEN ${stagename} = 'Discovery Meeting' THEN 'Pre-Pipeline'
      WHEN ${stagename} = 'Draft' THEN 'Pre-Pipeline'

      ELSE 'Pipeline'
      END ;;
  }



  dimension_group: start_date__c {
    type: time
    label: "Opportunity Start Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
  }

  dimension: status__c {
    type: string
    label: "Status"
    sql: ${TABLE}.status__c ;;
  }

  dimension: status_reason__c {
    type: string
    sql: ${TABLE}.status_reason__c ;;
    hidden: yes
  }

  dimension: super_region__c {
    type: string
    sql: ${TABLE}.super_region__c ;;
    hidden: no
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
    hidden: yes
  }

  dimension: total_adjusted_spend__c {
    type: number
    label: "Total Adjusted Spend"
    sql: ${TABLE}.total_adjusted_spend__c ;;
  }

  dimension: total_amount__c {
    type: number
    label: "Total Amount"
    sql: ${TABLE}.total_amount__c ;;

  }

  dimension: total_gross_spend__c {
    type: number
    label: "Total Gross Spend"
    sql: ${TABLE}.total_gross_spend__c ;;
  }

  dimension: total_units__c {
    type: number
    label: "Booked Units"
    sql: ${TABLE}.total_units__c ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
  }

  dimension: revenue_line_v2 {
    type: string
    label: "Revenue Line v2"
    sql:
    CASE
      WHEN ${type} = 'All - Market Expectation' THEN 'All - Market Expectation'

      WHEN ${type} IN (
      'Amobee TV Media Managed',
      'Amobee TV Platform Managed',
      'Amobee TV Platform HOK',
      'Amobee TV Platform ATD',
      'Amobee TV',
      'TV Supply',
      'TV',
      'TV Demand - Media Managed',
      'TV Demand - Platform Managed',
      'TV Demand - HOK'
      ) THEN 'TV'

      WHEN ${type} = 'Media Managed' THEN 'MS'

      WHEN ${type} = 'Platform Managed' THEN 'DSP (Self-Service & Managed)'

      WHEN ${type} LIKE '%Media%' THEN 'MS'
      WHEN ${type} LIKE '%MS%' THEN 'MS'

      WHEN ${type} IN ('Platform ATD', 'Platform MSP', 'Platform HOK', 'SS') THEN 'DSP (Self-Service & Managed)'

      WHEN ${type} LIKE '%Platform%' THEN 'DSP (Self-Service & Managed)'

      WHEN ${type} IN ('Social Managed', 'Social ATD', 'Social MSP', 'Social HOK') THEN 'Social'
      WHEN ${type} LIKE '%Social%' THEN 'Social'

      WHEN ${type} LIKE '%PMP%' THEN 'PMP'

      ELSE NULL
      END ;;
  }


  dimension: valid_conversions__c {
    type: string
    sql: ${TABLE}.valid_conversions__c ;;
    hidden: yes
  }

  dimension: vat_tax__c {
    type: number
    sql: ${TABLE}.vat_tax__c ;;
    hidden: yes
  }

  dimension: win_reason__c {
    type: string
    label: "Win Reason"
    sql: ${TABLE}.win_reason__c ;;
  }

  dimension: win_reason_details__c {
    type: string
    label: "Win Reason dETAILS"
    sql: ${TABLE}.win_reason_details__c ;;
  }

  dimension: billing_instructions__c {
    type: string
    label: "Billing Instructions"
    sql: ${TABLE}.billing_instructions__c ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, stagename]
    hidden: no
  }

  measure: name_count_distinct {
    type: count_distinct
    label: "# of Opps in Stagedden"
    sql: ${TABLE}."name" ;;
  }


  # measure: name_count {
  #   type: count
  #   label: "# of Opps in Stage"
  #   sql: ${TABLE}."name" ;;
  # }

  # measure: distinctcount {
  #   type: count_distinct
  #   drill_fields: [id, name, stagename]
  #   hidden: no
  # }



  # measure: distinctcount {
  #   type: count_distinct
  #   sql: ${TABLE}.opportunity.Name ;;
  #   label: "# of Opps in Stagedden"
  #   hidden: no
  # }

}
