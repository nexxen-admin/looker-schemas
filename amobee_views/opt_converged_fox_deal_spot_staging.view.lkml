view: converged_fox_deal_spot_staging {
  sql_table_name: AN_SMART..converged_FOX_deal_spot_staging (NOLOCK) ;;
  label: "Spot"

  dimension: air_time {
    type: string
    label: "Air Time"
    sql: ${TABLE}.airTime ;;
  }

  dimension: brand {
    type: string
    label: "Brand"
    sql: ${TABLE}.brand ;;
  }

  dimension: campaign_id {
    type: number
    label: "Videology Campaign ID"
    description: "Videology Campagin ID"
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: channel {
    type: string
    label: "Channel"
    sql: ${TABLE}.channel ;;
  }

  dimension: conflict_code {
    type: number
    label: "Conflict Code"
    value_format_name: id
    sql: ${TABLE}.conflictCode ;;
  }

  dimension: day_part {
    type: string
    label: "Daypart"
    sql: ${TABLE}.dayPart ;;
  }

  dimension: deal_id {
    type: number
    label: "Deal ID"
    value_format_name: id
    view_label: "Deal"
    description: "FNG Deal ID"
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_no {
    type: number
    label: "Deal Number"
    description: "FNG Deal Number; Deal Identification"
    view_label: "Deal"
    value_format_name: id
    sql: ${TABLE}.dealNo ;;
  }

  dimension: deal_year {
    type: string
    label: "Deal Year"
    view_label: "Deal"
    sql: ${TABLE}.dealYear ;;
  }

  dimension: guar_cpm {
    type: number
    label: "Buy Demo CPM"
    value_format_name: decimal_3
    sql: ${TABLE}.guarCPM ;;
  }

  dimension: guar_impressions {
    type: number
    label: "Spot Guaranteed Impressions"
    description: "Buy Demo Impressions guaranteed"
    sql: ${TABLE}.guarImpressions ;;
  }

  measure: sum_guar_impressions {
    type: sum
    label: "Guaranteed Impressions"
    description: "Buy Demo Impressions guaranteed"
    sql: ${guar_impressions} ;;
  }

  dimension: guar_rating {
    type: number
    label: "Guaranteed Rating"
    value_format_name: decimal_2
    sql: ${TABLE}.guarRating ;;
  }

  dimension: guar_universe {
    type: number
    label: "Guaranteed Universe"
    sql: ${TABLE}.guarUniverse ;;
  }

  dimension: guar_vpvh {
    type: number
    label: "Guaranteed VPVH"
    value_format_name: decimal_2
    sql: ${TABLE}.guarVPVH ;;
  }

  dimension: keydate {
    type: date
    label: "Data Pull Date"
    description: "Date of Data Pull"
    sql: ${TABLE}.keydate ;;
  }

  dimension: mode {
    type: string
    label: "Deal Mode"
    sql: ${TABLE}.mode ;;
  }

  dimension: pull_type {
    type: string
    label: "Pull Type"
    description: "Pull-Type = Adhoc for this explore"
    sql: ${TABLE}.pull_type ;;
  }

  dimension: quarter {
    type: string
    label: "TV Quarter"
    sql: ${TABLE}.quarter ;;
  }

  dimension: ratecard_no {
    type: number
    label: "Rate Card Number"
    value_format_name: id
    sql: ${TABLE}.ratecardNo ;;
  }

  dimension: season_id {
    type: string
    label: "Season ID"
    view_label: "Deal"
    sql: ${TABLE}.season_id ;;
  }

  dimension: selling_title {
    type: string
    label: "Selling Title Name"
    sql: ${TABLE}.sellingTitle ;;
  }

  dimension: selling_title_no {
    type: number
    label: "Selling Title Number"
    value_format_name: id
    sql: ${TABLE}.sellingTitleNo ;;
  }

  dimension: spot_fee {
    type: number
    label: "Spot Fee"
    sql: ${TABLE}.spotFee ;;
  }

  measure: sum_spot_fee {
    type: sum
    label: "Fee"
    sql: ${spot_fee} ;;
  }

  dimension: spot_id {
    type: number
    label: "Spot ID"
    value_format_name: id
    sql: ${TABLE}.spotID ;;
  }

  dimension: spot_length {
    type: number
    label: "Spot Length"
    sql: ${TABLE}.spotLength ;;
  }

  dimension: spot_type {
    type: string
    label: "Spot Type"
    sql: ${TABLE}.spotType ;;
  }

  dimension: status {
    type: string
    label: "Deal Status"
    view_label: "Deal"
    sql: ${TABLE}.status ;;
  }

  dimension: stream {
    type: string
    label: "Rating Stream"
    sql: ${TABLE}.stream ;;
  }

  dimension: units {
    type: number
    label: "Spot Units"
    sql: ${TABLE}.units ;;
  }

  dimension: version {
    type: number
    label: "Deal Version"
    view_label: "Deal"
    sql: ${TABLE}.version ;;
    value_format_name: id
  }

}
