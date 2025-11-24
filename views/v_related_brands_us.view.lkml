view: v_related_brands_us {
  sql_table_name: BI_DSP.v_related_brands_us ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: adjusted_data_fee_impressions {
    type: number
    sql: ${TABLE}.adjusted_data_fee_impressions ;;
  }

  dimension: is_live_campaign {
    type: string
    sql: CASE WHEN  ${TABLE}.end_date__c >= current_date() THEN 'Live' ELSE 'Not Live' END ;;
    suggestions: ["Live","Not Live"]
  }

  measure: data_fee_impressions {
    label: "Data Fee Impressions"
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.adjusted_data_fee_impressions ;;
  }

  dimension: classification {
    type: string
    sql: ${TABLE}.classification ;;
  }
  dimension: data_fee_cost {
    type: number
    sql: ${TABLE}.data_fee_cost ;;
  }

  measure: data_fee_cost_meas {
    label: "Data Fee Cost"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.data_fee_cost;;
  }

  dimension_group: date_key_in_timezone {
    label: "Date"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key_in_timezone ;;
  }
  dimension_group: end_date__c {
    label: "End Date"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
  }
  dimension: item_type__c {
    label: "Item Type"
    type: string
    sql: ${TABLE}.item_type__c ;;
  }
  dimension: line_item_name__c {
    label: "Line Item Name"
    type: string
    sql: ${TABLE}.line_item_name__c ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: product_level {
    type: string
    sql: ${TABLE}.product_level ;;
  }

  dimension: opportunity {
    label: "Opportunity"
    type: string
    sql: ${TABLE}.opportunity ;;
  }
  dimension: price_type_name__c {
    label: "Price Type"
    type: string
    sql: ${TABLE}.price_type_name__c ;;
  }
  dimension: rate__c {
    label: "Rate"
    type: number
    sql: ${TABLE}.rate__c ;;
  }
  dimension_group: start_date__c {
    label: "Start Date"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_date__c ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
