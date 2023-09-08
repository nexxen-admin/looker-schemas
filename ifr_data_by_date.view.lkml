
view: ifr_data_by_date {
  derived_table: {
    sql: select * from financial.fact_programmatic_revenue_by_data_type
      -- where  "Market ID" in ('141','861','927','999','1356','1379','1405','1472','1602','2048','2107','2139','2143','2147','2145','2149') ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: period {
    type: string
    sql: ${TABLE}."Period" ;;
  }

  dimension: impression_date {
    type: date
    label: "Impression Date"
    sql: ${TABLE}."Impression Date" ;;
  }

  dimension: market_id {
    type: string
    label: "Market ID"
    sql: ${TABLE}."Market ID" ;;
  }

  dimension: market_name {
    type: string
    label: "Market Name"
    sql: ${TABLE}."Market Name" ;;
  }

  dimension: advertiser_id {
    type: string
    label: "Advertiser ID"
    sql: ${TABLE}."Advertiser ID" ;;
  }

  dimension: advertiser {
    type: string
    sql: ${TABLE}."Advertiser" ;;
  }

  dimension: total_billable {
    type: number
    label: "Total Billable"
    sql: ${TABLE}."Total Billable" ;;
  }

  dimension: total_net {
    type: number
    label: "Total Net"
    sql: ${TABLE}."Total Net" ;;
  }

  dimension: total_net_ {
    type: number
    label: "Total Net %"
    sql: ${TABLE}."Total Net %" ;;
  }

  dimension: tech_fee {
    type: number
    label: "Tech Fee"
    sql: ${TABLE}."Tech Fee" ;;
  }

  dimension: tech_fee__of_gross {
    type: number
    label: "Tech Fee (% of Gross)"
    sql: ${TABLE}."Tech Fee (% of Gross)" ;;
  }

  dimension: brand_safety {
    type: number
    label: "Brand Safety"
    sql: ${TABLE}."Brand Safety" ;;
  }

  dimension: brand_safety__of_gross {
    type: number
    label: "Brand Safety (% of Gross)"
    sql: ${TABLE}."Brand Safety (% of Gross)" ;;
  }

  dimension: contextual_data {
    type: number
    label: "Contextual Data"
    sql: ${TABLE}."Contextual Data" ;;
  }

  dimension: contextual_data__of_gross {
    type: number
    label: "contextual data (% of Gross)"
    sql: ${TABLE}."contextual data (% of Gross)" ;;
  }

  dimension: cross_device {
    type: number
    label: "Cross Device"
    sql: ${TABLE}."Cross Device" ;;
  }

  dimension: cross_device__of_gross {
    type: number
    label: "cross_device (% of Gross)"
    sql: ${TABLE}."cross_device (% of Gross)" ;;
  }

  dimension: viewability {
    type: number
    sql: ${TABLE}."Viewability" ;;
  }

  dimension: viewability__of_gross {
    type: number
    label: "viewability (% of Gross)"
    sql: ${TABLE}."viewability (% of Gross)" ;;
  }

  dimension: audience_data {
    type: number
    label: "Audience Data"
    sql: ${TABLE}."Audience Data" ;;
  }

  dimension: audience__of_gross {
    type: number
    label: "audience (% of Gross)"
    sql: ${TABLE}."audience (% of Gross)" ;;
  }

  dimension: other_data {
    type: number
    label: "Other Data"
    sql: ${TABLE}."Other Data" ;;
  }

  dimension: other_data__of_gross {
    type: number
    label: "Other Data (% of Gross)"
    sql: ${TABLE}."Other Data (% of Gross)" ;;
  }

  dimension: publisher {
    type: number
    sql: ${TABLE}."Publisher" ;;
  }

  dimension: tac__of_gross {
    type: number
    label: "tac (% of Gross)"
    sql: ${TABLE}."tac (% of Gross)" ;;
  }

  set: detail {
    fields: [
        period,
	impression_date,
	market_id,
	market_name,
	advertiser_id,
	advertiser,
	total_billable,
	total_net,
	total_net_,
	tech_fee,
	tech_fee__of_gross,
	brand_safety,
	brand_safety__of_gross,
	contextual_data,
	contextual_data__of_gross,
	cross_device,
	cross_device__of_gross,
	viewability,
	viewability__of_gross,
	audience_data,
	audience__of_gross,
	other_data,
	other_data__of_gross,
	publisher,
	tac__of_gross
    ]
  }
}
