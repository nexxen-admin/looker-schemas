view: converged_fox_deal_staging {
  sql_table_name: AN_SMART..converged_FOX_deal_staging (NOLOCK);;
  label: "Deal"

  dimension: campaign_id {
    type: number
    label: "Videology Campaign ID"
    description: "Videology Campagin ID"
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension_group: create {
    type: time
    hidden: yes
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.createDate ;;
  }

  dimension: deal_id {
    type: number
    label: "Deal ID"
    value_format_name: id
    description: "FNG Deal ID"
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_name {
    type: string
    label: "Deal Name"
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_no {
    type: number
    label: "Deal Number"
    description: "FNG Deal Number; Deal Identification"
    value_format_name: id
    sql: ${TABLE}.dealNo ;;
  }

  dimension: deal_year {
    type: string
    label: "Deal Year"
    sql: ${TABLE}.dealYear ;;
  }

  dimension: demo_index {
    type: number
    label: "Deal Demo Index"
    sql: ${TABLE}.demo_index ;;
  }

  dimension: equivalized {
    type: string
    label: "Measurement Equivalized (Yes/No)"
    sql: ${TABLE}.equivalized ;;
  }

  dimension: flight_end {
    type: date
    label: "Flight End Date"
    sql: ${TABLE}.flightEnd ;;
  }

  dimension: flight_start {
    type: date
    label: "Flight Start Date"
    sql: ${TABLE}.flightStart ;;
  }

  dimension: guar_cpm {
    type: number
    label: "Deal CPM"
    sql: ${TABLE}.guarCPM ;;
  }

  dimension: keydate {
    type: date
    label: "Data Pull Date"
    description: "Date of Data Pull"
    sql: ${TABLE}.keydate ;;
  }

  dimension_group: last_modified {
    type: time
    hidden: yes
    timeframes: [ raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastModified ;;
  }

  dimension: master_advertiser {
    type: string
    label: "Master Advertiser"
    sql: ${TABLE}.masterAdvertiser ;;
  }

  dimension: master_advertiser_no {
    type: number
    label: "Advertiser Number"
    value_format_name: id
    sql: ${TABLE}.masterAdvertiserNo ;;
  }

  dimension: master_agency {
    type: string
    label: "Master Agency"
    sql: ${TABLE}.masterAgency ;;
  }

  dimension: master_agency_no {
    type: number
    label: "Master Agency Number"
    value_format_name: id
    sql: ${TABLE}.masterAgencyNo ;;
  }

  dimension: master_demo {
    type: string
    label: "Demographic"
    sql: ${TABLE}.masterDemo ;;
  }

  dimension: master_sales_rep {
    type: string
    label: "Master Sales Rep"
    sql: ${TABLE}.masterSalesRep ;;
  }

  dimension: master_sales_rep_no {
    type: number
    label: "Master Sales Rep Number"
    sql: ${TABLE}.masterSalesRepNo ;;
    value_format_name: id
  }

  dimension: media_dollars {
    type: number
    label: "Media Dollars"
    hidden: yes
    sql: ${TABLE}.mediaDollars ;;
  }

  measure: sum_media_dollars {
    type: sum
    label: "Media Dollars"
    sql: ${media_dollars} ;;
  }

  dimension: mode {
    type: string
    sql: ${TABLE}.mode ;;
  }

  dimension: pull_type {
    type: string
    label: "Pull Type"
    description: "Pull-Type = Adhoc for this explore"
    sql: ${TABLE}.pull_type ;;
  }

  dimension: season_id {
    type: string
    label: "Season ID"
    description: "For STBS, Deals are identified as Deal Number-Season ID"
    sql: ${TABLE}.season_id ;;
  }

  dimension: status {
    type: string
    label: "Deal Status"
    description: "Status of the Deal; eg Order, Hold, Speculation, Working."
    sql: ${TABLE}.status ;;
  }

  dimension: version {
    type: number
    label: "Deal Version"
    value_format_name: id
    sql: ${TABLE}.version ;;
  }

}
