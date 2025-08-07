view: forecast_dim_sfdb_account {
  sql_table_name: BI_DSP.dim_sfdb_account ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: account_aid__c {
    type: string
    sql: ${TABLE}.account_aid__c ;;
  }
  dimension: account_classification__c {
    type: string
    sql: ${TABLE}.account_classification__c ;;
  }
  dimension: account_console_id__c {
    type: string
    sql: ${TABLE}.account_console_id__c ;;
  }
  dimension: account_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_key ;;
  }
  dimension: account_loss_reason__c {
    type: string
    sql: ${TABLE}.account_loss_reason__c ;;
  }
  dimension: account_stage__c {
    type: string
    sql: ${TABLE}.account_stage__c ;;
  }
  dimension: account_status__c {
    type: string
    sql: ${TABLE}.account_status__c ;;
  }
  dimension: accountnumber {
    type: string
    sql: ${TABLE}.accountnumber ;;
  }
  dimension: active_owner__c {
    type: number
    sql: ${TABLE}.active_owner__c ;;
  }
  dimension: agency_of_record__c {
    type: string
    sql: ${TABLE}.agency_of_record__c ;;
  }
  dimension: annualrevenue {
    type: number
    sql: ${TABLE}.annualrevenue ;;
  }
  dimension: approved_by_rev_ops__c {
    type: number
    sql: ${TABLE}.approved_by_rev_ops__c ;;
  }
  dimension: approved_credit_amount__c {
    type: number
    sql: ${TABLE}.approved_credit_amount__c ;;
  }
  dimension: billing_contact_created__c {
    type: number
    sql: ${TABLE}.billing_contact_created__c ;;
  }
  dimension: billing_instructions__c {
    type: string
    sql: ${TABLE}.billing_instructions__c ;;
  }
  dimension: billingcity {
    type: string
    sql: ${TABLE}.billingcity ;;
  }
  dimension: billingcountry {
    type: string
    sql: ${TABLE}.billingcountry ;;
  }
  dimension: billingpostalcode {
    type: string
    sql: ${TABLE}.billingpostalcode ;;
  }
  dimension: billingstate {
    type: string
    sql: ${TABLE}.billingstate ;;
  }
  dimension: billingstreet {
    type: string
    sql: ${TABLE}.billingstreet ;;
  }
  dimension: client_relationship_status__c {
    type: string
    sql: ${TABLE}.client_relationship_status__c ;;
  }
  dimension_group: contract_expiration_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contract_expiration_date__c ;;
  }
  dimension: contract_type__c {
    type: string
    sql: ${TABLE}.contract_type__c ;;
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
  dimension: credit_application_attachment__c {
    type: string
    sql: ${TABLE}.credit_application_attachment__c ;;
  }
  dimension: credit_approved__c {
    type: number
    sql: ${TABLE}.credit_approved__c ;;
  }
  dimension: credit_notes__c {
    type: string
    sql: ${TABLE}.credit_notes__c ;;
  }
  dimension: credit_review_case__c {
    type: string
    sql: ${TABLE}.credit_review_case__c ;;
  }
  dimension: credit_status__c {
    type: string
    sql: ${TABLE}.credit_status__c ;;
  }
  dimension: credit_terms__c {
    type: string
    sql: ${TABLE}.credit_terms__c ;;
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
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
  }
  dimension_group: finance_approval_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.finance_approval_date__c ;;
  }
  dimension: finance_approved__c {
    type: number
    sql: ${TABLE}.finance_approved__c ;;
  }
  dimension: holding_company_name__c {
    type: string
    sql: ${TABLE}.holding_company_name__c ;;
  }
  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }
  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
  }
  dimension_group: last_closed_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_closed_date__c ;;
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
  dimension: legacy_amobee_ids__c {
    type: string
    sql: ${TABLE}.legacy_amobee_ids__c ;;
  }
  dimension: legacy_ns_id__c {
    type: string
    sql: ${TABLE}.legacy_ns_id__c ;;
  }
  dimension: legacy_turn_ids__c {
    type: string
    sql: ${TABLE}.legacy_turn_ids__c ;;
  }
  dimension: legal_entity__c {
    type: string
    sql: ${TABLE}.legal_entity__c ;;
  }
  dimension: legal_name__c {
    type: string
    sql: ${TABLE}.legal_name__c ;;
    label: "Legal Name"
  }
  dimension: msa_margin__c {
    type: number
    sql: ${TABLE}.msa_margin__c ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
    label: "Account Name"
  }

  dimension: tech_services_group {
    type: string
    sql:
    CASE
      WHEN ${name} = 'ITV' THEN NULL
      WHEN ${name} = 'LG Electronics' THEN NULL
      WHEN ${name} LIKE '%Klick Health%' THEN 'Tech Services - Strategic Sales'
      WHEN ${name} LIKE '%301 Digital Media%' THEN 'Tech Services - Strategic Sales'
      WHEN ${name} LIKE '%Good Karma Brands%' THEN 'Tech Services - Strategic Sales'
      WHEN ${name} LIKE '%Guru%' THEN 'Tech Services - Strategic Sales'
      WHEN ${name} LIKE '%Rescue Agency%' THEN 'Tech Services - Strategic Sales'
      ELSE 'Tech Services - Enterprise Sales'
    END ;;
    label: "Enterprise Technical Services"
  }


  dimension: ns_id__c {
    type: string
    sql: ${TABLE}.ns_id__c ;;
    label: "NetSuite ID"
  }
  dimension: numberofemployees {
    type: number
    sql: ${TABLE}.numberofemployees ;;
  }
  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
  }
  dimension: ownership {
    type: string
    sql: ${TABLE}.ownership ;;
  }
  dimension: parent_billing_account__c {
    type: string
    sql: ${TABLE}.parent_billing_account__c ;;
  }
  dimension: parentid {
    type: string
    sql: ${TABLE}.parentid ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
  }
  dimension: ready_for_finance_approval__c {
    type: number
    sql: ${TABLE}.ready_for_finance_approval__c ;;
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
  dimension: require_external_ref_id__c {
    type: number
    value_format_name: id
    sql: ${TABLE}.require_external_ref_id__c ;;
  }
  dimension: rev_ops_approver__c {
    type: string
    sql: ${TABLE}.rev_ops_approver__c ;;
  }
  dimension: service_contract__c {
    type: string
    sql: ${TABLE}.service_contract__c ;;
  }
  dimension: shippingcity {
    type: string
    sql: ${TABLE}.shippingcity ;;
  }
  dimension: shippingcountry {
    type: string
    sql: ${TABLE}.shippingcountry ;;
  }
  dimension: shippingpostalcode {
    type: string
    sql: ${TABLE}.shippingpostalcode ;;
  }
  dimension: shippingstate {
    type: string
    sql: ${TABLE}.shippingstate ;;
  }
  dimension: shippingstreet {
    type: string
    sql: ${TABLE}.shippingstreet ;;
  }
  dimension: short_name__c {
    type: string
    sql: ${TABLE}.short_name__c ;;
  }
  dimension: sic {
    type: string
    sql: ${TABLE}.sic ;;
  }
  dimension: site {
    type: string
    sql: ${TABLE}."site" ;;
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
  dimension: tickersymbol {
    type: string
    sql: ${TABLE}.tickersymbol ;;
  }
  dimension: time_zone__c {
    type: string
    sql: ${TABLE}.time_zone__c ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
    label: "Account Type"
  }
  dimension: vat_tax__c {
    type: number
    sql: ${TABLE}.vat_tax__c ;;
  }
  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
    label: "Account Website"
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
