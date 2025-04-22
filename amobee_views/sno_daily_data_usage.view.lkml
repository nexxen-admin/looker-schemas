view: daily_data_usage {
  sql_table_name: EDW.DAILY_DATA_USAGE_EXTENDED ;;
  label: "Data Usage Metrics"

  dimension: cost_attribute_id {
    type: number
    hidden: yes
    label: "Retargeting Attribute ID"
    sql: ${TABLE}.COST_ATTRIBUTE_ID ;;
  }

  dimension: data_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DATA_COST / (case when ${TABLE}.DEMAND_DATE >= '2022-03-09' then 100000000 else 1 end) ;;
  }

  measure: sum_data_cost {
    type: sum
    label: "Data Costs"
    description: "Cost of using Data Provider segements"
    value_format_name: decimal_2
    sql: ${data_cost} ;;
    drill_fields: [source_provider.description,retargeting_attribute.behavioral_category,retargeting_attribute.description,sum_data_cost]
  }

  measure: sum_data_cpu {
    type: number
    label: "Data Usage - CPU"
    description: "Data Costs / Billable Usage"
    value_format_name: decimal_2
    sql: COALESCE(${sum_data_cost} / NULLIF(${billable_usage}, 0) * 1000, 0) ;;
  }

  dimension: data_cost_currency {
    type: string
    label: "Data Cost Currency"
    description: "The currency of the data cost that will be paid to the data provider."
    sql: ${TABLE}.DATA_COST_CURRENCY ;;
  }

  dimension: data_cost_type {
    type: string
    hidden: yes
    sql: ${TABLE}.DATA_COST_TYPE ;;
  }

  dimension: data_cost_type_description {
    type: string
    label: "Data Cost Type"
    view_label: "Data Cost Facets"
    description: "Type of Data (BT, Demo or Cluster)"
    sql: case when ${data_cost_type} = 1 then 'BT'
              when ${data_cost_type} = 2 then 'Demo'
              when ${data_cost_type} = 5 then 'Cluster'
              else 'Other' end;;
  }

  measure: adjusted_cost {
    type: sum
    label: "Adjusted Cost"
    description: "TruOptik Adjusted Cost Value"
    value_format_name: decimal_2
    sql: ${data_cost} - (case
            when ${placement_details_base.device_type} = 'Connected TV' then 0
            when ${placement_details_base.device_type} in ('PC','Mobile') and (lower(${retargeting_attribute.description}) like lower('%Comscore%') or lower(${retargeting_attribute.description}) like lower('%Oracle%')) then 0
            when ${placement_details_base.device_type} in ('PC','Mobile') and (lower(${retargeting_attribute.description}) like lower('%Webbula > B2B%') or lower(${retargeting_attribute.description}) like lower('%Kantar - Shopcom%')) then 0.1 * ${data_cost}
            else 0.2 * ${data_cost} end) ;;
  }

  dimension: data_provider_id {
    type: string
    hidden: yes
    label: "Data Provider ID - Data Usage"
    description: "The internal identifier of the Data Provider"
    sql: ${TABLE}.DATA_PROVIDER_ID ;;
  }

  dimension: demand_data_cost {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_DATA_COST / (case when ${TABLE}.DEMAND_DATE >= '2022-03-09' then 100000000 else 1 end) ;;
  }

  measure: sum_demand_data_cost {
    type: sum
    label: "Data Costs - Demand Currency"
    description: "Costs incurred by demand side clients for using data provider info."
    value_format_name: decimal_2
    sql: ${demand_data_cost} ;;
  }

  measure: sum_demand_data_cpu {
    type: number
    label: "Data Usage - CPU - Demand Currency"
    description: "Data Costs - Demand Currency / Billable Usage"
    value_format_name: decimal_2
    sql: COALESCE(${sum_demand_data_cost} / NULLIF(${billable_usage}, 0) * 1000, 0) ;;
  }

  dimension: demand_data_cost_currency {
    type: string
    label: "Demand Data Cost Currency"
    description: "The native currency of the data costs"
    sql: ${TABLE}.DEMAND_DATA_COST_CURRENCY ;;
  }

  dimension_group: gmt_date {
    type: time
    label: "GMT"
    view_label: "Dates"
    timeframes: [date,month,year,raw,week]
    description: "The date of the impression in GMT"
    sql: ${TABLE}.GMT_DATE ;;
  }

  dimension_group: demand_date {
    type: time
    label: "Demand"
    view_label: "Dates"
    timeframes: [date,month,year,week,raw]
    description: "The date of the impression in the Demand timezone"
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension_group: local_demand_date {
    type: time
    label: "Local Demand"
    view_label: "Dates"
    timeframes: [date,month,year,raw,week]
    description: "The date of the impression in the Demand timezone in accordance with season clock shift"
    sql: ${TABLE}.LOCAL_DEMAND_DATE ;;
  }

  dimension_group: est_date {
    type: time
    label: "EST"
    view_label: "Dates"
    timeframes: [date,month,year,raw,week]
    description: "The date of the impression in EST"
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: impressions {
    type: string
    hidden: yes
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  measure: sum_impressions {
    type: sum
    label: "Usage"
    description: "Usage of data segments based on impressions"
    sql: ${impressions} ;;
    drill_fields: [source_provider.description,retargeting_attribute.behavioral_category,retargeting_attribute.description,sum_impressions]
  }

  measure: billable_usage {
    type: sum
    label: "Billable Usage"
    description: "Impressions where data costs are incurred."
    sql: case when ${data_cost} > 0 then ${impressions}
    else 0 end;;
    drill_fields: [source_provider.description,retargeting_attribute.behavioral_category,retargeting_attribute.description,billable_usage]
  }

  dimension: placement_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: processingid {
    type: string
    hidden: yes
    sql: ${TABLE}.PROCESSINGID ;;
  }

  dimension_group: region_date {
    type: time
    label: "Region"
    view_label: "Dates"
    timeframes: [date,month,year,raw,week]
    description: "The date of the impression in the Regional timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }

  measure: min_gmt_date {
    type: date
    label: "Minimum Date"
    view_label: "Dates"
    description: "Oldest date in database table"
    sql: min(${TABLE}.GMT_DATE) ;;
  }

  measure: max_gmt_date {
    type: date
    label: "Maximum Date"
    view_label: "Dates"
    description: "Newest date in database table"
    sql: max(${TABLE}.GMT_DATE) ;;
  }

  measure: count_gmt_date {
    type: number
    label: "# of Days"
    view_label: "Dates"
    description: "# of Days in the database table"
    sql: count(distinct ${TABLE}.GMT_DATE) ;;
  }

  dimension: revenue_currency {
    type: string
    label: "Revenue Currency"
    description: "The native currency for revenue"
    sql: ${TABLE}.RPU_CURRENCY ;;
  }

  dimension: revenue {
    type: string
    hidden: yes
    sql: ${TABLE}.REVENUE ;;
  }

  measure: sum_revenue {
    type: sum
    label: "Revenue"
    description: "Revenue"
    value_format_name: decimal_2
    sql: ${revenue} ;;
  }

  dimension: payout_currency {
    type: string
    label: "Payout Currency"
    description: "The native currency for payout"
    sql: ${TABLE}.PAYOUT_CURRENCY ;;
  }

  dimension: payout {
    type: string
    hidden: yes
    sql: ${TABLE}.PAYOUT ;;
  }

  measure: sum_payout {
    type: sum
    label: "Payout"
    description: "Payout"
    value_format_name: decimal_2
    sql: ${payout} ;;
  }

  dimension: demand_revenue {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_REVENUE ;;
  }

  measure: sum_demand_revenue {
    type: sum
    label: "Revenue - Demand Currency"
    description: "Revenue in Demand Currency"
    value_format_name: decimal_2
    sql: ${demand_revenue} ;;
  }

  dimension: demand_payout {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_PAYOUT ;;
  }

  measure: sum_demand_payout {
    type: sum
    label: "Payout - Demand Currency"
    description: "Payout in Demand Currency"
    value_format_name: decimal_2
    sql: ${demand_payout} ;;
  }

  dimension: media_price {
    type: string
    hidden: yes
    sql: ${TABLE}.MEDIA_PRICE ;;
  }

  measure: sum_media_price {
    type: sum
    label: "Media Price - Demand Currency"
    description: "Price of media including IBMM in Demand Currency"
    value_format_name: decimal_2
    sql: ${media_price} ;;
  }

  dimension: supply_payout {
    type: string
    hidden: yes
    sql: ${TABLE}.SUPPLY_PAYOUT ;;
  }

  measure: sum_supply_payout {
    type: sum
    label: "Payout - Publisher Currency"
    description: "Price of media excluding IBMM in Partner's preffered Currency"
    value_format_name: decimal_2
    sql: ${supply_payout} ;;
  }

  measure: sum_data_markup {
    type: sum
    label: "Data Markup - Demand Currency"
    description: "Mark up charged on Data Cost in Demand Currency"
    value_format_name: decimal_2
    sql: ${TABLE}.DATA_MARKUP  ;;
  }

  dimension: gender_description {
    type: string
    label: "User Gender"
    description: "User Gender"
    sql: ${TABLE}.DEMO:gender  ;;
  }

  dimension: age_description {
    type: string
    label: "User Age"
    description: "User Age"
    sql: ${TABLE}.DEMO:age ;;
  }

}
