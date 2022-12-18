# The name of this view in Looker is "Advertisers Lk"
view: advertisers_lk {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: taptica.AdvertisersLK ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
    hidden: yes
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Acc Manager ID" in Explore.

  dimension: acc_manager_id {
    type: string
    sql: ${TABLE}.AccManagerID ;;
    hidden: yes
  }

  dimension: acc_manager_name {
    type: string
    sql: ${TABLE}.AccManagerName ;;
    hidden: yes
  }

  dimension: acc_sales_person_id {
    type: string
    sql: ${TABLE}.AccSalesPersonId ;;
    hidden: yes
  }

  dimension: acc_sales_person_name {
    type: string
    label: "Sales Person Name"
    sql: ${TABLE}.AccSalesPersonName ;;
  }

  dimension: address1 {
    type: string
    sql: ${TABLE}.address1 ;;
    hidden: yes
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
    hidden: yes
  }

  dimension: advertiser_type {
    type: number
    sql: ${TABLE}.AdvertiserType ;;
    hidden: yes
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    hidden: yes
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
    hidden: yes
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_added {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_added ;;
    hidden: yes
  }

  dimension: expected_cr {
    type: number
    sql: ${TABLE}.ExpectedCr ;;
    hidden: yes
  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
    hidden: yes
  }

  dimension_group: last_retargeting_file_upload {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LastRetargetingFileUpload ;;
    hidden: yes
  }

  dimension: late_conversion {
    type: number
    sql: ${TABLE}.LateConversion ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_late_conversion {
    type: sum
    sql: ${late_conversion} ;;
    hidden: yes
  }

  measure: average_late_conversion {
    type: average
    sql: ${late_conversion} ;;
    hidden: yes
  }

  dimension: managing_office_id {
    type: number
    sql: ${TABLE}.ManagingOfficeId ;;
    hidden: yes
  }

  dimension: managing_office_name {
    type: string
    sql: ${TABLE}.ManagingOfficeName ;;
    hidden: yes
  }

  dimension: modified {
    type: number
    sql: ${TABLE}.modified ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}."Name" ;;
    hidden: yes
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    hidden: yes
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    hidden: yes
  }

  dimension: signup_ip {
    type: string
    sql: ${TABLE}.signup_ip ;;
    hidden: yes
  }

  dimension: start {
    type: date
    label: "Start Date"
      sql: ${TABLE}.StartDate ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    hidden: yes
  }

  dimension: tenant_id {
    type: number
    sql: ${TABLE}.TenantId ;;
    hidden: yes
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.UpdatedAt ;;
    hidden: yes
  }

  dimension: wants_alerts {
    type: number
    sql: ${TABLE}.wants_alerts ;;
    hidden: yes
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
    hidden: yes
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}.zipcode ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, acc_sales_person_name, acc_manager_name, name, managing_office_name]
    hidden: yes
  }
}
