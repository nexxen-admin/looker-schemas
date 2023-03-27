view: customer_details {
  label: "Customer"
  sql_table_name: DIM.CUSTOMER_DETAILS ;;

  dimension: addr_line1 {
    type: string
    label: "Customer Address 1"
    description: "The first address line for the customer."
    sql: ${TABLE}.ADDR_LINE1 ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.addr_line1
  }

  dimension: addr_line2 {
    type: string
    label: "Customer Address 2"
    description: "The second address line for the customer."
    sql: ${TABLE}.ADDR_LINE2 ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.addr_line2
  }

  dimension: ahc_description {
    type: string
    label: "AHC"
    description: "The agency holding company of the customer."
    sql: ${TABLE}.AHC_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.ahc_description
  }

  dimension: ahc_id {
    type: string
    hidden: yes
    sql: ${TABLE}.AHC_ID ;;
  }

  dimension: business_unit {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_UNIT ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: city {
    type: string
    label: "Customer City"
    description: "The city of the customer address."
    sql: ${TABLE}.CITY ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.city
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.COUNTRY_ID ;;
  }

  dimension: createdon {
    type: date
    label: "Customer Created Date"
    description: "The date the customer was created in the system"
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: dst_createdon {
    type: date
    label: "[DST] Customer Local Created Date"
    description: "The date the customer was created in the system in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.CREATEDON)
      else ${TABLE}.CREATEDON end ;;
  }

  dimension: customer_active {
    type: yesno
    label: "Customer Active"
    description: "A yes/no indicator if the customer is active."
    sql: ${TABLE}.CUSTOMER_ACTIVE ;;
  }

  dimension: customer_group_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_GROUP_ID ;;
  }

  dimension: customer_group_name {
    type: string
    label: "Customer Group"
    description: "The name of the group the customer belongs to, if applicable."
    sql: ${TABLE}.CUSTOMER_GROUP_NAME ;;
    drill_fields: [customer_name]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.customer_group_name
  }

  dimension: customer_id {
    type: number
    label: "Customer ID"
    description: "Identification number for the customer"
    value_format_name: id
    sql: ${TABLE}.CUSTOMER_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.customer_id
  }

  dimension: customer_name {
    type: string
    label: "Customer"
    description: "The name of the customer."
    sql: ${TABLE}.CUSTOMER_NAME ;;
    drill_fields: [advertiser_brand_details.advertiser_name, advertiser_brand_details.brand_name, insertion_order_details.insertion_order_name]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.customer_name
  }

  measure:  count_of_customers {
    type: number
    label: "Count of Customers"
    description: "The distinct count of Customers."
    sql: count(distinct ${customer_id}) ;;
  }

  dimension: customer_office_description {
    type: string
    label: "Customer Office"
    description: "The location of the office of the customer."
    sql: ${TABLE}.CUSTOMER_OFFICE_DESCRIPTION ;;
    drill_fields: [customer_name]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.customer_office_description
  }

  dimension: customer_office_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_OFFICE_ID ;;
  }

  dimension: customer_preferred_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_PREFERRED_CURRENCY_ID ;;
  }

  dimension: customer_type_description {
    type: string
    label: "Customer Type"
    hidden: yes
    sql: ${TABLE}.CUSTOMER_TYPE_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.customer_type_description
  }

  dimension: customer_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_TYPE_ID ;;
  }

  dimension: default_site_categories {
    type: string
    hidden: yes
    sql: ${TABLE}.DEFAULT_SITE_CATEGORIES ;;
  }

  dimension: is_demo {
    type: yesno
    label: "Demo Customer"
    description: "A yes/no indicator if the customer is a demo customer."
    sql: ${TABLE}.IS_DEMO ;;
  }

  dimension: parent_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PARENT_ID ;;
  }

  dimension: postalcode {
    type: string
    label: "Customer Zip"
    description: "The postal code of the customer's address."
    sql: ${TABLE}.POSTALCODE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.postalcode
  }

  dimension: stateprovince {
    type: string
    label: "Customer State"
    description: "The state/province of the customer's address."
    sql: ${TABLE}.STATEPROVINCE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.stateprovince
  }

  dimension: future_customers {
    type: yesno
    label: "Include All Customers"
    description: "Include this field as a filter in your Look if you want to include all relevant customers in the Look. Without this included in your filter, results will include customers with at least one associated campaign only"
    sql: true ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name, customer_group_name, country.country_id]
  }
}
