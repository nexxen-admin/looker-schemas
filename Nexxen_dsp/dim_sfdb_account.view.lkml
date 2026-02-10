# The name of this view in Looker is "Dim Sfdb Account"
view: dim_sfdb_account {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_account ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    type: string
    label: "Account ID"
    sql: ${TABLE}.id ;;
    # not sure if this is the account id

  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Aid C" in Explore.

  dimension: account_aid__c {
    type: string
    sql: ${TABLE}.account_aid__c ;;
    hidden: yes
    # not sure if this is the account id
  }

  dimension: account_classification__c {
    type: string
    label: "Account Clasification"
    sql: ${TABLE}.account_classification__c ;;

  }

  dimension: account_console_id__c {
    type: string
    sql: ${TABLE}.account_console_id__c ;;
    hidden: yes
    ## no values
  }

  dimension: account_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_key ;;
    hidden: yes
  }

  dimension: account_loss_reason__c {
    type: string
    sql: ${TABLE}.account_loss_reason__c ;;
    hidden: yes
    ## no values
  }

  dimension: account_stage__c {
    type: string
    label: "Account Stage"
    sql: ${TABLE}.account_stage__c ;;
  }

  dimension: account_status__c {
    type: string
    label: "Account Status"
    sql: ${TABLE}.account_status__c ;;
  }

  dimension: accountnumber {
    type: string
    sql: ${TABLE}.accountnumber ;;
    hidden: yes
    ## no values
  }

  dimension: active_owner__c {
    type: number
    sql: ${TABLE}.active_owner__c ;;
    hidden: yes
    ## no values
  }

  dimension: agency_of_record__c {
    type: string
    sql: ${TABLE}.agency_of_record__c ;;
    hidden: yes
    ## no values
  }

  dimension: annualrevenue {
    type: number
    label: "Annual Revenue"
    sql: ${TABLE}.annualrevenue ;;
  }

  dimension: approved_by_rev_ops__c {
    type: number
    sql: ${TABLE}.approved_by_rev_ops__c ;;
    hidden: yes
    ## no values
  }

  dimension: approved_credit_amount__c {
    type: number
    label: "Approved Credit Amount"
    sql: ${TABLE}.approved_credit_amount__c ;;
  }



  dimension: billing_contact_created__c {
    type: number
    sql: ${TABLE}.billing_contact_created__c ;;
    hidden: yes
    ## no values
  }

  dimension: billingcity {
    type: string
    sql: ${TABLE}.billingcity ;;
    hidden: yes
    ## no values
  }

  dimension: billingcountry {
    type: string
    sql: ${TABLE}.billingcountry ;;
    hidden: yes
    ## no values
  }

  dimension: billingpostalcode {
    type: string
    sql: ${TABLE}.billingpostalcode ;;
    hidden: yes
    ## no values
  }

  dimension: billingstate {
    type: string
    sql: ${TABLE}.billingstate ;;
    hidden: yes
    ## no values
  }

  dimension: billingstreet {
    type: string
    sql: ${TABLE}.billingstreet ;;
    hidden: yes
    ## no values
  }

  dimension: client_relationship_status__c {
    type: string
    sql: ${TABLE}.client_relationship_status__c ;;
    hidden: yes
    ## no values
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: contract_expiration_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contract_expiration_date__c ;;

  }

  dimension: contract_type__c {
    type: string
    sql: ${TABLE}.contract_type__c ;;
    hidden: yes
    ## no values
  }

  dimension: createdbyid {
    type: string
    sql: ${TABLE}.createdbyid ;;
    hidden: yes
    ## no values

  }

  dimension: createddate {
    type: date
    label: "Created Date"
    sql: ${TABLE}.createddate ;;
  }

  dimension: credit_application_attachment__c {
    type: string
    sql: ${TABLE}.credit_application_attachment__c ;;
    hidden: yes
    ## no values
  }

  dimension: credit_approved__c {
    type: number
    sql: ${TABLE}.credit_approved__c ;;
    hidden: yes
    ## no values
  }

  dimension: credit_notes__c {
    type: string
    sql: ${TABLE}.credit_notes__c ;;
    hidden: yes
    ## no values
  }

  dimension: credit_review_case__c {
    type: string
    sql: ${TABLE}.credit_review_case__c ;;
    hidden: yes
    ## no values
  }

  dimension: credit_status__c {
    type: string
    sql: ${TABLE}.credit_status__c ;;
    hidden: yes

  }

  dimension: credit_terms__c {
    type: string
    sql: ${TABLE}.credit_terms__c ;;
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    hidden: yes

  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
    hidden: yes
    ## no values
  }

  dimension_group: finance_approval_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.finance_approval_date__c ;;
    hidden: yes

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
    label: "Industry"
    sql: ${TABLE}.industry ;;
  }

  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
    hidden: yes

  }

  dimension_group: last_closed_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_closed_date__c ;;
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

  dimension: legacy_amobee_ids__c {
    type: string
    sql: ${TABLE}.legacy_amobee_ids__c ;;
    hidden: yes

  }

  dimension: legacy_ns_id__c {
    type: string
    sql: ${TABLE}.legacy_ns_id__c ;;
    hidden: yes

  }

  dimension: legacy_turn_ids__c {
    type: string
    sql: ${TABLE}.legacy_turn_ids__c ;;
    hidden: yes

  }

  dimension: legal_entity__c {
    type: string
    label: "Legal Entity"
    sql: ${TABLE}.legal_entity__c ;;
    hidden: yes

    #
  }

  dimension: legal_name__c {
    type: string
    label: "Legal Name"
    sql: ${TABLE}.legal_name__c ;;
  }

  dimension: msa_margin__c {
    type: number
    sql: ${TABLE}.msa_margin__c ;;
    hidden: yes

  }

  dimension: name {
    type: string
    label: "Account Name"
    sql: ${TABLE}."name" ;;
  }

  dimension: ns_id__c {
    type: string
    label: "NetSuite ID"
    sql: ${TABLE}.ns_id__c ;;
  }

  dimension: numberofemployees {
    type: number
    sql: ${TABLE}.numberofemployees ;;
    hidden: yes

  }

  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
    hidden: yes

  }

  dimension: ownership {
    type: string
    sql: ${TABLE}.ownership ;;
    hidden: yes

  }

  dimension: parent_billing_account__c {
    type: string
    sql: ${TABLE}.parent_billing_account__c ;;
    hidden: yes
    ## no values
  }

  dimension: parentid {
    type: string
    sql: ${TABLE}.parentid ;;
    hidden: yes
    ## no values
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    hidden: yes

  }

  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
    hidden: yes
    ## no values
  }

  dimension: ready_for_finance_approval__c {
    type: number
    sql: ${TABLE}.ready_for_finance_approval__c ;;
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
    ## no values
  }

  dimension: region__c {
    type: string
    sql: ${TABLE}.region__c ;;
    hidden: yes


  }

  dimension: require_external_ref_id__c {
    type: number
    value_format_name: id
    sql: ${TABLE}.require_external_ref_id__c ;;
    hidden: yes
    ## no values
  }

  dimension: rev_ops_approver__c {
    type: string
    sql: ${TABLE}.rev_ops_approver__c ;;
    hidden: yes
    ## no values
  }

  dimension: service_contract__c {
    type: string
    sql: ${TABLE}.service_contract__c ;;
    hidden: yes
    ## no values
  }

  dimension: shippingcity {
    type: string
    sql: ${TABLE}.shippingcity ;;
    hidden: yes
    ## no values
  }

  dimension: shippingcountry {
    type: string
    sql: ${TABLE}.shippingcountry ;;
    hidden: yes
    ## no values
  }

  dimension: shippingpostalcode {
    type: string
    sql: ${TABLE}.shippingpostalcode ;;
    hidden: yes
    ## no values
  }

  dimension: shippingstate {
    type: string
    sql: ${TABLE}.shippingstate ;;
    hidden: yes
    ## no values
  }

  dimension: shippingstreet {
    type: string
    sql: ${TABLE}.shippingstreet ;;
    hidden: yes
    ## no values
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
    hidden: yes
    ## no values
  }

  dimension: super_region__c {
    type: string
    sql: ${TABLE}.super_region__c ;;
    hidden: yes
    ## no values
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
    hidden: yes
    ## no values
  }

  dimension: tickersymbol {
    type: string
    sql: ${TABLE}.tickersymbol ;;
    hidden: yes
    ## no values
  }

  dimension: time_zone__c {
    type: string
    sql: ${TABLE}.time_zone__c ;;
    hidden: yes
    ## no values
  }

  dimension: type {
    type: string
    label: "Account Type"
    sql: ${TABLE}."type" ;;
  }

  dimension: vat_tax__c {
    type: number
    label: "Vat TAX"
    sql: ${TABLE}.vat_tax__c ;;
  }

  dimension: website {
    type: string
    label: "Account Website"
    sql: ${TABLE}.website ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
    hidden: yes
  }

  dimension: account_name_drill_to_related_brand {
    type: string
    label: "Account Name (Drill to Related Brand)"
    description: "Click to drill down into Related Brand details"
    # Reuses the SQL from the main name field
    sql: ${name} ;;
    # Only this specific field will have the drill behavior
    drill_fields: [name, dim_sfdb_related_accounts.name]
  }
}
