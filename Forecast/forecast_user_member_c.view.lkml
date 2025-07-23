view: forecast_user_member_c {
  sql_table_name: BI_DSP.dim_sfdb_user ;;
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

  dimension: Strat_Sales_RVP {
    type: string
    sql: ${TABLE}.Strat_Sales_RVP ;;
  }

  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
  }


  measure: count {
    type: count
    drill_fields: [id, firstname, lastname, username, companyname]
  }
}
