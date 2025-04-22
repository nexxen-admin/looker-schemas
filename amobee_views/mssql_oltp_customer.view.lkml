view: mssql_oltp_customer {
  sql_table_name: dbo.customer (NOLOCK) ;;
  label: "Customer"

  dimension: customer_id {
    primary_key: yes
    type: number
    label: "Customer ID"
    sql: ${TABLE}.customer_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: addr_line1 {
    type: string
    hidden: yes
    sql: ${TABLE}.addr_line1 ;;
  }

  dimension: addr_line2 {
    type: string
    hidden: yes
    sql: ${TABLE}.addr_line2 ;;
  }

  dimension: ahc_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ahc_id ;;
  }

  dimension: business_unit {
    type: string
    hidden: yes
    sql: ${TABLE}.business_unit ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension: city {
    type: string
    hidden: yes
    sql: ${TABLE}.city ;;
  }

  dimension: client_agency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.client_agency_id ;;
  }

  dimension: contact_notes {
    type: string
    hidden: yes
    sql: ${TABLE}.contact_notes ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension: customer_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_group_id ;;
  }

  dimension: customer_name {
    type: string
    hidden: no
    sql: ${TABLE}.customer_name ;;
  }

  dimension: customer_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_type_id ;;
  }

  dimension: default_site_categories {
    type: string
    hidden: yes
    sql: ${TABLE}.default_site_categories ;;
  }

  dimension: email {
    type: string
    hidden: yes
    sql: ${TABLE}.email ;;
  }

  dimension: external_app_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_app_id ;;
  }

  dimension: fax {
    type: string
    hidden: yes
    sql: ${TABLE}.fax ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: is_archived {
    type: string
    hidden: yes
    sql: ${TABLE}.is_archived ;;
  }

  dimension: is_demo {
    type: string
    hidden: yes
    sql: ${TABLE}.is_demo ;;
  }

  dimension: is_hidden {
    type: string
    hidden: yes
    sql: ${TABLE}.is_hidden ;;
  }

  dimension: mapped_to {
    type: number
    hidden: yes
    sql: ${TABLE}.mapped_to ;;
  }

  dimension: netsuite_internal_id {
    type: string
    hidden: yes
    sql: ${TABLE}.netsuite_internal_id ;;
  }

  dimension: office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.office_id ;;
  }

  dimension: order_file_location_id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_file_location_id ;;
  }

  dimension: parent_id {
    type: number
    hidden: yes
    sql: ${TABLE}.parent_id ;;
  }

  dimension: phone {
    type: string
    hidden: yes
    sql: ${TABLE}.phone ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: postalcode {
    type: string
    hidden: yes
    sql: ${TABLE}.postalcode ;;
  }

  dimension: preferred_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.preferred_currency_id ;;
  }

  dimension: source_id {
    type: number
    hidden: yes
    sql: ${TABLE}.source_id ;;
  }

  dimension: stateprovince {
    type: string
    hidden: yes
    sql: ${TABLE}.stateprovince ;;
  }

  dimension: taxid {
    type: string
    hidden: yes
    sql: ${TABLE}.taxid ;;
  }

  dimension: taxid2 {
    type: string
    hidden: yes
    sql: ${TABLE}.taxid2 ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [customer_id, customer_name, hostname]
  }

  dimension: cab_names_hash_id {
    type: string
    label: "CAB Names Hash ID"
    description: "Hash ID of concatenated Customer, Advertiser, Brand names - HASHBYTES('MD5', customer_name + advertiser_name + brand_name)."
    view_label: "Custom Dimensions"
    sql: CONVERT(NVARCHAR(32),HASHBYTES('MD5', (${mssql_oltp_customer.customer_name} + ${mssql_oltp_advertiser.advertiser_name} + ${mssql_oltp_advertiser_brand.brand_name})),2) ;;
  }
}
