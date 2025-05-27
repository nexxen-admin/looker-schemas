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
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Aid C" in Explore.

  dimension: aid__c {
    type: string
    sql: ${TABLE}.aid__c ;;
    hidden: yes
  }

  dimension: alias {
    type: string
    sql: ${TABLE}.alias ;;
    hidden: yes
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    hidden: yes
  }

  dimension: companyname {
    type: string
    sql: ${TABLE}.companyname ;;
    hidden: yes
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: deal_review_approver__c {
    type: number
    sql: ${TABLE}.deal_review_approver__c ;;
    hidden: yes
  }


  dimension: defaultcurrencyisocode {
    type: string
    sql: ${TABLE}.defaultcurrencyisocode ;;
    hidden: yes
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes

  }

  dimension: emailencodingkey {
    type: string
    sql: ${TABLE}.emailencodingkey ;;
    hidden: yes
  }

  dimension: employeenumber {
    type: string
    sql: ${TABLE}.employeenumber ;;
    hidden: yes

  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
    hidden: yes
  }

  dimension: final_approver__c {
    type: number
    sql: ${TABLE}.final_approver__c ;;
    hidden: yes
  }

  dimension: finance_account_approver__c {
    type: string
    sql: ${TABLE}.finance_account_approver__c ;;
    hidden: yes
  }

  dimension: firstname {
    type: string
    label: "First Name"
    sql: ${TABLE}.firstname ;;
    hidden: yes
  }

  dimension: manager_name {
    type: string
    label: "Manager Name"
    sql: ${TABLE}.firstname||' '||${TABLE}.lastname;;
  }

  dimension: forecastenabled {
    type: number
    sql: ${TABLE}.forecastenabled ;;
    hidden: yes
  }

  dimension: id_short__c {
    type: string
    sql: ${TABLE}.id_short__c ;;
    hidden: yes
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension: isactive {
    type: number
    label: "Is Active?"
    sql: ${TABLE}.isactive ;;
    hidden: yes
  }

  dimension: languagelocalekey {
    type: string
    sql: ${TABLE}.languagelocalekey ;;
    hidden: yes
  }

  dimension_group: lastlogindate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastlogindate ;;
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

  dimension: lastname {
    type: string
    label: "Last Name"
    sql: ${TABLE}.lastname ;;
    hidden: yes
  }

  dimension: lob__c {
    type: string
    label: "LOB C"
    sql: ${TABLE}.lob__c ;;
    hidden: yes
  }

  dimension: localesidkey {
    type: string
    sql: ${TABLE}.localesidkey ;;
    hidden: yes
  }

  dimension: managerid {
    type: string
    sql: ${TABLE}.managerid ;;
    hidden: yes
  }

  dimension: mobilephone {
    type: string
    sql: ${TABLE}.mobilephone ;;
    hidden: yes
  }

  dimension_group: offlinepdatrialexpirationdate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.offlinepdatrialexpirationdate ;;
    hidden: yes
  }

  dimension_group: offlinetrialexpirationdate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.offlinetrialexpirationdate ;;
    hidden: yes
  }

  dimension: owner_code__c {
    type: string
    sql: ${TABLE}.owner_code__c ;;
    hidden: yes
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    hidden: yes
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.postalcode ;;
    hidden: yes
  }

  dimension: profileid {
    type: string
    sql: ${TABLE}.profileid ;;
    hidden: yes
  }

  dimension: ready_for_sales__c {
    type: number
    sql: ${TABLE}.ready_for_sales__c ;;
    hidden: yes
  }

  dimension: recovered_record_id__c {
    type: string
    sql: ${TABLE}.recovered_record_id__c ;;
    hidden: yes
  }

  dimension: region__c {
    type: string
    sql: ${TABLE}.region__c ;;
    hidden: yes
  }

  dimension: sales_team__c {
    type: string
    label: "Sales Team"
    sql: ${TABLE}.sales_team__c ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    hidden: yes
  }

  dimension: street {
    type: string
    sql: ${TABLE}.street ;;
    hidden: yes
  }

  dimension: super_region__c {
    type: string
    sql: ${TABLE}.super_region__c ;;
    hidden: yes
  }

  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
    hidden: yes
  }

  dimension: timezonesidkey {
    type: string
    sql: ${TABLE}.timezonesidkey ;;
    hidden: yes
  }

  dimension: title {
    type: string
    label: "Role"
    sql: ${TABLE}.title ;;
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
    hidden: yes
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
    hidden: yes
  }

  dimension: userroleid {
    type: string
    sql: ${TABLE}.userroleid ;;
    hidden: yes
  }

  dimension: usertype {
    type: string
    sql: ${TABLE}.usertype ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [id, username, lastname, companyname, firstname]
    hidden: yes
  }
}
