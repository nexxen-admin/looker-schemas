view: lm_serendipity {
  sql_table_name: sbx.public.LUCY_INVENTORY ;;

  dimension: ad_position {
    type: string
    view_label: "Facets"
    label: "Ad Position"
    sql: ${TABLE}.ad_position ;;
  }

  dimension: ad_size {
    type: string
    view_label: "Facets"
    label: "Ad Size"
    sql: ${TABLE}.ad_size ;;
  }

  dimension: alexa_group {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.alexa_group ;;
  }

  dimension: alexa_rank {
    type: number
    hidden: yes
    sql: ${TABLE}.alexa_rank ;;
  }

  dimension: app {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.app ;;
  }

  dimension: browser {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.browser ;;
  }

  dimension: browser_lang {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.browser_lang ;;
  }

  dimension: category_level_0 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_0 ;;
  }

  dimension: category_level_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_1 ;;
  }

  dimension: category_level_10 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_10 ;;
  }

  dimension: category_level_11 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_11 ;;
  }

  dimension: category_level_12 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_12 ;;
  }

  dimension: category_level_13 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_13 ;;
  }

  dimension: category_level_14 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_14 ;;
  }

  dimension: category_level_15 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_15 ;;
  }

  dimension: category_level_16 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_16 ;;
  }

  dimension: category_level_17 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_17 ;;
  }

  dimension: category_level_18 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_18 ;;
  }

  dimension: category_level_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_2 ;;
  }

  dimension: category_level_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_3 ;;
  }

  dimension: category_level_4 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_4 ;;
  }

  dimension: category_level_5 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_5 ;;
  }

  dimension: category_level_6 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_6 ;;
  }

  dimension: category_level_7 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_7 ;;
  }

  dimension: category_level_8 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_8 ;;
  }

  dimension: category_level_9 {
    type: string
    hidden: yes
    sql: ${TABLE}.category_level_9 ;;
  }

  dimension: category {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.category_level_0 ;;
    drill_fields: [category_level_0, category_level_1, category_level_2, category_level_3, category_level_4, category_level_5, category_level_6, category_level_7, category_level_8, category_level_9, category_level_10, category_level_11, category_level_12, category_level_13, category_level_14, category_level_15, category_level_16, category_level_17, category_level_18]
  }

  dimension: channel {
    type: string
    view_label: "Facets"
    description: "The format type of the request."
    sql: ${TABLE}.channel ;;
  }

  dimension: cluster_id {
    type: string
    view_label: "Facets"
    label: "Cluster ID"
    sql: ${TABLE}.cluster ;;
  }

  dimension: comscore_group {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.comscore_group ;;
  }

  dimension: comscore_rank {
    type: number
    hidden: yes
    sql: ${TABLE}.comscore_rank ;;
  }

  dimension: content_lang {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.content_lang ;;
  }

  dimension_group: date {
    type: time
    view_label: "Facets"
    label: ""
    timeframes: [
      date
    ]
    convert_tz: no
    sql: ${TABLE}.date ;;
  }

  dimension: device {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.device ;;
  }

  dimension: domains {
    type: string
    label: "Domain"
    view_label: "Facets"
    sql: ${TABLE}.normalized_domain ;;
    drill_fields: [normalized_domain, domain]
  }

  dimension: domain {
    type: string
    hidden: yes
    sql: ${TABLE}.domain ;;
  }

  dimension: expandable {
    type: string
    hidden: yes
    sql: ${TABLE}.expandable ;;
  }

  dimension: geo_location_dma {
    type: string
    label: "Location by DMAs"
    view_label: "Facets"
    sql: ${TABLE}.geo_country ;;
    drill_fields: [geo_country, geo_city]
  }

  dimension: geo_location {
    type: string
    label: "Location by State"
    view_label: "Facets"
    sql: ${TABLE}.geo_country ;;
    drill_fields: [geo_country, geo_state]
  }

  dimension: geo_city {
    type: string
    hidden: yes
    sql: ${TABLE}.geo_city ;;
  }

  dimension: geo_country {
    type: string
    hidden: yes
    sql: ${TABLE}.geo_country ;;
  }

  dimension: geo_state {
    type: string
    hidden: yes
    sql: ${TABLE}.geo_state ;;
  }

  dimension: impression {
    type: number
    hidden: yes
    sql: ${TABLE}.impressions ;;
  }

  measure: sum_impression {
    type: sum
    label: "Requests"
    sql: ${TABLE}.impressions ;;
  }

  dimension: media_class {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.media_class_a_level_1 ;;
    drill_fields: [media_class_a_level_1, media_class_a_level_2, media_class_a_level_3, media_class_a_level_4, media_class_a_level_5]
  }

  dimension: inventory_source_level_1 {
    type: string
    hidden: yes
    label: "Publisher"
    sql: ${TABLE}.inventory_source_level_1 ;;
  }

  dimension: source {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.inventory_source_level_1 ;;
    drill_fields: [inventory_source_level_1, inventory_source_level_2, inventory_source_level_3 ]
  }

  dimension: inventory_source_level_2 {
    type: string
    hidden: yes
    label: "Inventory Source"
    sql: ${TABLE}.inventory_source_level_2 ;;
  }

  dimension: inventory_source_level_3 {
    type: string
    hidden: yes
    label: "Network Source"
    sql: ${TABLE}.inventory_source_level_3 ;;
  }

  dimension: media_class_a_level_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.media_class_a_level_1 ;;
  }

  dimension: media_class_a_level_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.media_class_a_level_2 ;;
  }

  dimension: media_class_a_level_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.media_class_a_level_3 ;;
  }

  dimension: media_class_a_level_4 {
    type: string
    hidden: yes
    sql: ${TABLE}.media_class_a_level_4 ;;
  }

  dimension: media_class_a_level_5 {
    type: string
    hidden: yes
    sql: ${TABLE}.media_class_a_level_5 ;;
  }

  dimension: normalized_domain {
    type: string
    hidden: yes
    sql: ${TABLE}.normalized_domain ;;
  }

  dimension: os {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.os ;;
  }

  dimension: pids {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.pids ;;
  }

  dimension: quantcast_group {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.quantcast_group ;;
  }

  dimension: quantcast_rank {
    type: number
    hidden: yes
    sql: ${TABLE}.quantcast_rank ;;
  }

  dimension: video {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.video ;;
  }

  dimension: aws_region {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.aws_region ;;
  }

  dimension: deal_ids {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.deals ;;
  }

  dimension: whitelisted_seat_ids {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.seats ;;
  }

  dimension: day_of_week {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.day_of_week ;;
  }

  dimension: business_region {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.business_region ;;
  }

  dimension: gdpr_reason {
    type: string
    view_label: "Facets"
    sql: ${TABLE}.gdpr ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
