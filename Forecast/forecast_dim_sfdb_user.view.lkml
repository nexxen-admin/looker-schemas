view: forecast_dim_sfdb_user {
  sql_table_name: BI_DSP.dim_sfdb_user ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }
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

  dimension: RVP_Sales_team  {
  type: string
  sql: ${TABLE}.RVP_Sales_team ;;
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
    hidden: yes
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
    sql: ${TABLE}.firstname ;;
    hidden: yes
  }
  dimension: fullname_key {
    type: string
    sql: LOWER(${TABLE}.firstname||' '||${TABLE}.lastname) ;;
    hidden: yes
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
    sql: ${TABLE}.lastname ;;
    hidden: yes
  }
  dimension: lob__c {
    type: string
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
  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
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
  dimension: strat_sales_team {
    type: string
    sql: ${TABLE}.strat_sales_team ;;
    hidden: yes
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    hidden: yes
  }
  dimension: strat_sales_rvp {
    type: string
    sql: ${TABLE}.Strat_Sales_RVP ;;
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
    sql: ${TABLE}.title ;;
    hidden: yes
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
    drill_fields: [id, lastname, firstname, username, companyname]
    hidden: yes
  }
}
