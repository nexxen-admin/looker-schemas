# The name of this view in Looker is "Dim Sfdb Po C"
view: dim_sfdb_po__c {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_po__c ;;
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
    # This dimension will be called "Account C" in Explore.

  dimension: account__c {
    type: string
    sql: ${TABLE}.account__c ;;
    hidden: yes
  }

  dimension: account_aid__c {
    type: string
    sql: ${TABLE}.account_aid__c ;;
    hidden: yes
  }

  dimension: account_name__c {
    type: string
    sql: ${TABLE}.account_name__c ;;
    hidden: yes
  }

  dimension: account_ns_id__c {
    type: string
    sql: ${TABLE}.account_ns_id__c ;;
    hidden: yes
  }

  dimension: amobee_discount__c {
    type: number
    sql: ${TABLE}.amobee_discount__c ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: auto_po_number__c {
    type: string
    sql: ${TABLE}.auto_po_number__c ;;
    hidden: yes
  }

  dimension: cost_type__c {
    type: string
    sql: ${TABLE}.cost_type__c ;;
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

  dimension_group: end_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
    hidden: yes
  }

  dimension: imported_po_number__c {
    type: string
    sql: ${TABLE}.imported_po_number__c ;;
    hidden: yes
  }

  dimension: isdeleted {
    type: number
    sql: ${TABLE}.isdeleted ;;
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

  dimension: media_buyer__c {
    type: string
    sql: ${TABLE}.media_buyer__c ;;
    hidden: yes
  }

  dimension: media_buyer_name__c {
    type: string
    sql: ${TABLE}.media_buyer_name__c ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
    label: "Purchase Name"
  }

  dimension: net_rate__c {
    type: number
    sql: ${TABLE}.net_rate__c ;;
    hidden: yes
  }

  dimension: net_spend__c {
    type: number
    sql: ${TABLE}.net_spend__c ;;
    hidden: yes
  }

  dimension: net_units__c {
    type: number
    sql: ${TABLE}.net_units__c ;;
    hidden: yes
  }

  dimension: ownerid {
    type: string
    sql: ${TABLE}.ownerid ;;
    hidden: yes
  }

  dimension: po_aid__c {
    type: string
    label: "Purchase Order"
    sql: ${TABLE}.po_aid__c ;;
  }

  dimension: po_number__c {
    type: string
    sql: ${TABLE}.po_number__c ;;
    label: "Purchase Number"
  }

  dimension: rate__c {
    type: number
    sql: ${TABLE}.rate__c ;;
    hidden: yes
  }

  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
    hidden: yes
  }

  dimension: signed_po__c {
    type: string
    sql: ${TABLE}.signed_po__c ;;
    hidden: yes
  }

  dimension: signed_po_attachment__c {
    type: string
    sql: ${TABLE}.signed_po_attachment__c ;;
    hidden: yes
  }

  dimension: site__c {
    type: string
    sql: ${TABLE}.site__c ;;
    hidden: yes
  }

  dimension: special_terms__c {
    type: string
    sql: ${TABLE}.special_terms__c ;;
    hidden: yes
  }

  dimension: spend__c {
    type: number
    sql: ${TABLE}.spend__c ;;
    hidden: yes
  }

  dimension_group: start_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
    hidden: yes
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
    hidden: yes
  }

  dimension: units__c {
    type: number
    sql: ${TABLE}.units__c ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [id, name]
    hidden: yes
  }
}
