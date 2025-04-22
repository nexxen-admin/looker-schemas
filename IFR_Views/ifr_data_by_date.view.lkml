
view: ifr_data_by_date {
  derived_table: {
    sql: select * from financial.fact_programmatic_revenue_by_data_type  ;;
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


}
