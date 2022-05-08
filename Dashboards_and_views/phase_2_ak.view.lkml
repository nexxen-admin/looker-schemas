view: phase_2_ak {
  derived_table: {
    sql: Select event_month::date as "Event Month",
        dsp_ID as "DSP ID",
        ssp_id as "SSP ID",
        Pub_ID as "Pub ID",
        buyer_id as "Agency ID",
        advertiser_id as "Brand ID",
        buying_channel as "Demand Type",
        Platform,
        Demand_Source as "Demand Source",
        supply_source as "Supply Source",
        pub_hq_country as "Pub HQ Country",
        Supply_integration_type as "Supply Integration",
        publisher_integration as "Publisher Integration",
        device_type as "Device Type",
        impression_type as "Impression Type",
        revenue as "Gross Revenue",
        cost as "Cost"
      From bi.svc_alaska_phase2_data
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    label: "Event Month"
    sql: ${TABLE}."Event Month" ;;
  }

  dimension: dsp_id {
    type: string
    label: "DSP ID"
    sql: ${TABLE}."DSP ID" ;;
  }

  dimension: ssp_id {
    type: string
    label: "SSP ID"
    sql: ${TABLE}."SSP ID" ;;
  }

  dimension: pub_id {
    type: string
    label: "Pub ID"
    sql: ${TABLE}."Pub ID" ;;
  }

  dimension: agency_id {
    type: number
    label: "Agency ID"
    sql: ${TABLE}."Agency ID" ;;
  }

  dimension: brand_id {
    type: number
    label: "Brand ID"
    sql: ${TABLE}."Brand ID" ;;
  }

  dimension: demand_type {
    type: string
    label: "Demand Type"
    sql: ${TABLE}."Demand Type" ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.Platform ;;
  }

  dimension: demand_source {
    type: string
    label: "Demand Source"
    sql: ${TABLE}."Demand Source" ;;
  }

  dimension: supply_source {
    type: string
    label: "Supply Source"
    sql: ${TABLE}."Supply Source" ;;
  }

  dimension: pub_hq_country {
    type: string
    label: "Pub HQ Country"
    sql: ${TABLE}."Pub HQ Country" ;;
  }

  dimension: supply_integration {
    type: string
    label: "Supply Integration"
    sql: ${TABLE}."Supply Integration" ;;
  }

  dimension: publisher_integration {
    type: string
    label: "Publisher Integration"
    sql: ${TABLE}."Publisher Integration" ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}."Device Type" ;;
  }

  dimension: impression_type {
    type: string
    label: "Impression Type"
    sql: ${TABLE}."Impression Type" ;;
  }

  measure: gross_revenue {
    type: sum
    label: "Gross Revenue"
    value_format: "$#,##0.00"
    sql: ${TABLE}."Gross Revenue" ;;
  }

  measure: cost {
    type: sum
    label: "Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.Cost ;;
  }

  set: detail {
    fields: [
      event_month,
      dsp_id,
      ssp_id,
      agency_id,
      brand_id,
      demand_type,
      platform,
      demand_source,
      supply_source,
      pub_hq_country,
      supply_integration,
      publisher_integration,
      device_type,
      impression_type
    ]
  }
}
