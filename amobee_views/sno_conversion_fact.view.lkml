view: conversion_fact {
  sql_table_name: DEMAND.CONVERSION_FACT ;;

  measure: count {
    type: count
    hidden: yes
  }

  dimension: pk_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK_ID ;;
  }

  dimension: action_pixel_id {
    type: number
    label: "Action Pixel ID"
    view_label: "Action Pixel"
    description: "A pixel imbedded in a page to allow for tracking specific user actions while viewing that page."
    sql: ${TABLE}.ACTION_PIXEL_ID ;;
    value_format_name: id
  }

  dimension: age {
    type: string
    label: "Age"
    view_label: "Conversion Facets"
    description: "The age of the user who completed the conversion"
    sql: prod.public.f_attr_lookup(${TABLE}.AGE) ;;
  }

  dimension: aws_region {
    type: string
    label: "AWS Region"
    description: "The ad request was captured in this AWS adserver region."
    view_label: "Conversion Facets"
    sql: public.f_awsregion(${TABLE}.AWS_REGION) ;;
  }

  dimension: browser {
    type: string
    label: "Browser"
    view_label: "Conversion Facets"
    description: "The browser which was used to view the impression"
    sql: prod.public.f_attr_lookup(${TABLE}.BROWSER) ;;
  }

  dimension: cluster_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CLUSTER_ID ;;
  }

  dimension: conversion_epoch {
    type: number
    label: "Conversion Epoch"
    view_label: "Conversion Facets"
    hidden: yes
    sql: ${TABLE}.CONVERSION_EPOCH ;;
  }

  dimension: conversion_type {
    type: string
    label: "Conversion Type"
    view_label: "Conversion Facets"
    description: "Indicates whether the desired action is post impression or post click"
    sql: ${TABLE}.CONVERSION_TYPE ;;
  }

  dimension: conversion_uniqueid {
    type: string
    label: "Conversion ID"
    description: "Unique ID of the conversion event"
    view_label: "Conversion Facets"
    sql: ${TABLE}.CONVERSION_UNIQUEID ;;
  }

  dimension: conversiontime {
    type: string
    label: "Conversion Time"
    view_label: "Conversion Facets"
    description: "Time the conversion event occurred"
    sql: ${TABLE}.CONVERSIONTIME ;;
  }

  measure: count_conversiontime {
    type: number
    label: "Count Conversion Time"
    view_label: "Conversion Metrics"
    hidden: yes
    sql: count(${conversiontime}) ;;
  }

  dimension: country {
    type: string
    label: "Country"
    view_label: "Conversion Facets"
    description: "Country in which the conversion took place"
    sql: ${TABLE}.COUNTRY ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.country
  }

  dimension: daypart {
    type: number
    label: "Daypart"
    hidden: yes
    sql: ${TABLE}.DAYPART ;;
  }

  dimension_group: demand_date_conversions {
    type: time
    label: "Demand - Conversions"
    view_label: "Conversion Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the conversion, in the Demand timezone"
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension_group: exposure_date_demand {
    type: time
    label: "Demand - Exposures"
    view_label: "Conversion Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "Exposure date/time of the impression, in the demand timezone."
    sql: date_trunc('day',dateadd('h',${flight_media_details_base.demand_utc_offset},${TABLE}.exposure_time)) ;;
  }

  dimension_group: exposure_date {
    type: time
    label: "UTC - Exposures"
    view_label: "Conversion Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "Exposure date/time of the impression, in UTC"
    sql: ${TABLE}.EXPOSURE_TIME ;;
  }

  dimension: device_id {
    type: string
    label: "Device"
    view_label: "Conversion Facets"
    description: "Device of the user associaed with the conversion"
    sql: prod.public.f_attr_lookup(${TABLE}.DEVICE_ID) ;;
  }

  dimension: domain_url {
    type: string
    view_label: "Conversion Facets"
    label: "Domain URL"
    description: "The domain of the URL (xyz.com) where the conversion was seen"
    sql: ${TABLE}.DOMAIN_URL ;;
  }

  dimension_group: est_date {
    type: time
    label: "EST - Conversions"
    view_label: "Conversion Dates"
    timeframes: [time,hour, date,month,year,raw]
    description: "The date/time of the conversion, in EST timezone"
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension: exposure_epoch {
    type: number
    label: "Exposure Epoch"
    view_label: "Conversion Facets"
    description: "Add Description"
    hidden: yes
    sql: ${TABLE}.EXPOSURE_EPOCH ;;
  }

  dimension: exposure_time {
    type: string
    label: "Exposure Time"
    view_label: "Conversion Facets"
    description: "Time the user was exposed to the media"
    sql: ${TABLE}.EXPOSURE_TIME ;;
  }

  dimension: exposure_uniqueid {
    type: string
    label: "Exposure ID"
    description: "Unique ID of the conversion event"
    view_label: "Conversion Facets"
    sql: ${TABLE}.EXPOSURE_UNIQUEID ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: gender {
    type: string
    view_label: "Conversion Facets"
    description: "The gender of the user who completed the conversion"
    sql: prod.public.f_attr_lookup(${TABLE}.GENDER) ;;
  }

  dimension: geo {
    type: number
    hidden: yes
    sql: ${TABLE}.GEO ;;
  }

  dimension: inferred_age {
    type: number
    hidden: yes
    sql: ${TABLE}.INFERRED_AGE ;;
  }

  dimension: inferred_gender {
    type: number
    hidden: yes
    sql: ${TABLE}.INFERRED_GENDER ;;
  }

  dimension: is_conversion_event {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_CONVERSION_EVENT ;;
  }

  measure: count_is_conversion_event {
    type: number
    label: "Conversions"
    view_label: "Conversion Metrics"
    description: "The number of users who performed a conversion action"
    sql: SUM(${is_conversion_event}) ;;
  }

  dimension: isp {
    type: string
    label: "ISP"
    view_label: "Conversion Facets"
    description: "Internet Service Provider of the user"
    hidden: yes
    sql: prod.public.f_attr_lookup(${TABLE}.ISP) ;;
  }

  dimension_group: keydate {
    type: time
    label: "UTC - Conversions"
    view_label: "Conversion Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the conversion, in UTC timezone"
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension: language_id {
    type: number
    hidden: yes
    sql: ${TABLE}.LANGUAGE_ID ;;
  }

  dimension: language {
    type: string
    label: "Language"
    view_label: "Conversion Facets"
    description: "The language set on the browser."
    sql: prod.public.f_attr_lookup(${TABLE}.language_id)  ;;
  }

  dimension: normalized_domain {
    type: string
    label: "Action Pixel Domain"
    view_label: "Action Pixel"
    description: "The normalized domain of the URL where the conversion was made."
    sql: ${TABLE}.NORMALIZED_DOMAIN ;;
  }

  dimension: pdata1 {
    type: string
    view_label: "Conversion Facets"
    label: "PD1"
    description: "Passed Data 1 - A text field that allows the publisher to pass data back when serving the impression."
    sql: ${TABLE}.PDATA1 ;;
  }

  dimension: pdata2 {
    type: string
    view_label: "Conversion Facets"
    label: "PD2"
    description: "Passed Data 2 - A second text field that allows the publisher to pass data back when serving the impression."
    sql: ${TABLE}.PDATA2 ;;
  }

  dimension: placement_id {
    type: number
    view_label: "Conversion Facets"
    label: "Placement ID"
    description: "Internal id of the placement"
    sql: ${TABLE}.PLACEMENT_ID ;;
    value_format_name: id
  }

  dimension: placement {
    type: string
    view_label: "Conversion Facets"
    label: "Placement"
    description: "The placement name"
    sql: CASE WHEN ${placement_details_base.placement_inventory_type} IN('Private Exchange', 'Exchange') THEN ${placement_details_base.placement_name} ELSE CONCAT('Placement - ', ${TABLE}.placement_id) END ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.conversion_placement_name
  }

  dimension: platform {
    type: string
    label: "Platform"
    view_label: "Conversion Facets"
    description: "The platform where the impression was seen examples include Android, iOS, Mac, Windows, etc."
    sql: prod.public.f_attr_lookup(${TABLE}.PLATFORM)  ;;
  }

  dimension: postalcode {
    type: string
    label: "Postalcode"
    view_label: "Conversion Facets"
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: postalcode_provider {
    type: number
    hidden: yes
    sql: ${TABLE}.POSTALCODE_PROVIDER ;;
  }

  dimension: processingid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.PROCESSINGID ;;
  }

  dimension: refurl {
    type: string
    label: "Reference URL"
    view_label: "Conversion Facets"
    description: "Reference URL"
    sql: ${TABLE}.REFURL ;;
  }

  dimension_group: region_date {
    type: time
    label: "Region - Conversions"
    view_label: "Conversion Dates"
    timeframes: [time,hour,date,month,year,raw]
    description: "The date/time of the conversion, in the Regional timezone"
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: userid {
    type: string
    label: "User"
    view_label: "Conversion Facets"
    sql: ${TABLE}.USERID ;;
  }

  measure: minutes_conversion_vs_exposure {
    type: sum
    hidden: yes
    label: "Minutes conversion vs exposure"
    sql: datediff(m, ${exposure_time}, ${conversiontime}) ;;
  }

  measure: days_conversion_vs_exposure {
    type: number
    label: "days conversion vs exposure"
    hidden: yes
    sql: (${minutes_conversion_vs_exposure} / 1440)  ;;
  }

  measure: hours_conversion_vs_exposure {
    type: number
    label: "hours conversion vs exposure"
    hidden: yes
    sql: (${minutes_conversion_vs_exposure} / 60)  ;;
  }

  measure: average_elapsed_time_days {
    type: number
    label: "Average Elapsed Time (Days)"
    view_label: "Conversion Metrics"
    description: "The average amount of time in days that it took for a user exposed to the ad to perform a desired action."
    value_format_name: decimal_0
    sql: ${days_conversion_vs_exposure} / ${count_conversiontime} ;;
  }

  measure: average_elapsed_time_hours {
    type: number
    label: "Average Elapsed Time (Hours)"
    view_label: "Conversion Metrics"
    description: "The average amount of time in hours that it took for a user exposed to the ad to perform a desired action."
    value_format_name: decimal_0
    sql: ${hours_conversion_vs_exposure} / ${count_conversiontime} ;;
  }

  measure: average_elapsed_time_minutes {
    type: number
    label: "Average Elapsed Time (Minutes)"
    view_label: "Conversion Metrics"
    description: "The average amount of time in minutes that it took for a user exposed to the ad to perform a desired action"
    value_format_name: decimal_0
    sql: ${minutes_conversion_vs_exposure} / ${count_conversiontime} ;;
  }

#   measure: cost_per_conversion {
#     type: number
#     label: "Cost Per Conversion"
#     view_label: "Conversion Metrics"
#     description: "The total spend associated with delivering an ad divided by number of users who perform a desired action."
#     value_format_name: decimal_2
#     sql:   ;;
#   }

#   measure: conversion_rate {
#     type: number
#     label: "Conversion Rate"
#     view_label: "Conversion Metrics"
#     description: "The percentage of users who perform a desired action based on all who were exposed to the ad."
#     value_format_name: percent_0
#     sql:   ;;
# }

}
