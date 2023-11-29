# The name of this view in Looker is "Dim Sfdb User"
view: dim_sfdb_user {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_user ;;
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
    # This dimension will be called "Aid C" in Explore.

  dimension: aid__c {
    type: string
    sql: ${TABLE}.aid__c ;;
  }

  dimension: alias {
    type: string
    sql: ${TABLE}.alias ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: companyname {
    type: string
    sql: ${TABLE}.companyname ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: deal_review_approver__c {
    type: number
    sql: ${TABLE}.deal_review_approver__c ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_deal_review_approver__c {
    type: sum
    sql: ${deal_review_approver__c} ;;  }
  measure: average_deal_review_approver__c {
    type: average
    sql: ${deal_review_approver__c} ;;  }

  dimension: defaultcurrencyisocode {
    type: string
    sql: ${TABLE}.defaultcurrencyisocode ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: emailencodingkey {
    type: string
    sql: ${TABLE}.emailencodingkey ;;
  }

  dimension: employeenumber {
    type: string
    sql: ${TABLE}.employeenumber ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
  }

  dimension: final_approver__c {
    type: number
    sql: ${TABLE}.final_approver__c ;;
  }

  dimension: finance_account_approver__c {
    type: string
    sql: ${TABLE}.finance_account_approver__c ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: forecastenabled {
    type: number
    sql: ${TABLE}.forecastenabled ;;
  }

  dimension: id_short__c {
    type: string
    sql: ${TABLE}.id_short__c ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
  }

  dimension: isactive {
    type: number
    sql: ${TABLE}.isactive ;;
  }

  dimension: languagelocalekey {
    type: string
    sql: ${TABLE}.languagelocalekey ;;
  }

  dimension_group: lastlogindate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastlogindate ;;
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

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: lob__c {
    type: string
    sql: ${TABLE}.lob__c ;;
  }

  dimension: localesidkey {
    type: string
    sql: ${TABLE}.localesidkey ;;
  }

  dimension: managerid {
    type: string
    sql: ${TABLE}.managerid ;;
  }

  dimension: mobilephone {
    type: string
    sql: ${TABLE}.mobilephone ;;
  }

  dimension_group: offlinepdatrialexpirationdate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.offlinepdatrialexpirationdate ;;
  }

  dimension_group: offlinetrialexpirationdate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.offlinetrialexpirationdate ;;
  }

  dimension: owner_code__c {
    type: string
    sql: ${TABLE}.owner_code__c ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.postalcode ;;
  }

  dimension: profileid {
    type: string
    sql: ${TABLE}.profileid ;;
  }

  dimension: ready_for_sales__c {
    type: number
    sql: ${TABLE}.ready_for_sales__c ;;
  }

  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
  }

  dimension: region__c {
    type: string
    sql: ${TABLE}.region__c ;;
  }

  dimension: sales_team__c {
    type: string
    sql: ${TABLE}.sales_team__c ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street {
    type: string
    sql: ${TABLE}.street ;;
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

  dimension: timezonesidkey {
    type: string
    sql: ${TABLE}.timezonesidkey ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: userroleid {
    type: string
    sql: ${TABLE}.userroleid ;;
  }

  dimension: usertype {
    type: string
    sql: ${TABLE}.usertype ;;
  }
  measure: count {
    type: count
    drill_fields: [id, username, lastname, companyname, firstname]
  }
}
