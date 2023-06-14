view: flight_media_details_base {
  label: "Flight Media"
  sql_table_name: DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW ;;

  dimension: agency_fee {
    type:number
    label: "Agency Fee"
    description: "The percentage amount that the agency charges to the customer.  This is added to net spend to determine gross spend."
    sql: COALESCE(${TABLE}.AGENCY_FEE, 0) ;;
  }

  dimension_group: begin_datetime_local {
    type: time
    timeframes: [raw, time, hour]
    label: "FM Begin Date - Local"
    description: "The begin date of the Flight Media in the demand timezone."
    sql: ${TABLE}.BEGIN_DATETIME_LOCAL ;;
  }

  dimension_group: dst_begin_datetime_local {
    type: time
    timeframes: [raw, time, hour]
    label: "[DST] FM Begin Date - Local"
    description: "The begin date of the Flight Media in the demand timezone accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('GMT', ${timezone.timezone_name}, dateadd(h, -${timezone.utc_offset}, ${TABLE}.BEGIN_DATETIME_LOCAL))
      else ${TABLE}.BEGIN_DATETIME_LOCAL end ;;
  }

  dimension: yj_begin_datetime_local {
    type: string
    label: "YJ FM Begin Date"
    description: "The begin date of the flight media in the demand timezone formatted for YJ reporting."
    sql: TO_CHAR(${begin_datetime_local_raw}, 'MM/DD/YYYY HH12:MI AM') ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.yj_begin_datetime_local
  }

  dimension: begin_datetm {
    type: date_hour
    label: "FM Begin Date"
    description: "The begin date of the Flight Media in UTC."
    sql: ${TABLE}.BEGIN_DATETM ;;
  }

  dimension: dst_begin_datetm {
    type: date_hour
    label: "[DST] FM Begin Date"
    description: "The begin date of the Flight Media in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.BEGIN_DATETM)
      else ${TABLE}.BEGIN_DATETM end ;;
  }

  dimension: campaign_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: cdn_file_loc {
    type: string
    label: "CDN File Location"
    sql: ${TABLE}.CDN_FILE_LOC ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.cdn_file_loc
  }

  dimension: cdn_url {
    type:  string
    label: "CDN URL"
    sql: rtrim(regexp_substr(${TABLE}.CDN_FILE_LOC, 'https?://[^/]*/', 1, 1, 'i'), '/') ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.cdn_url
  }

  dimension: flight_creative_id {
    type: number
    label: "Flight Creative ID"
    sql: regexp_substr(${cdn_file_loc}, '/fcid=(\\d+)/', 1, 1, 'ie')::int ;;
    value_format_name: id
  }

  dimension: secure_cdn_file_loc {
    type: string
    hidden: no
    label: "Secure Cdn File Location"
    sql: ${TABLE}.SECURE_CDN_FILE_LOC ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.secure_cdn_file_loc
  }

  dimension: secure_cdn_url {
    type:  string
    label: "Secure CDN URL"
    sql: rtrim(regexp_substr(${TABLE}.SECURE_CDN_FILE_LOC, 'https?://[^/]*/', 1, 1, 'i'), '/') ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.secure_cdn_url
  }

  dimension: changedon {
    type: date_millisecond
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: checksum_value {
    type: string
    hidden: yes
    sql: ${TABLE}.CHECKSUM_VALUE ;;
  }

  dimension: clickurl {
    type: string
    label: "Click URL"
    description: "The URL used to measure clicks for the flight media."
    sql: ${TABLE}.CLICKURL ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.clickurl
  }

  dimension: client_tracking_id {
    type: string
    label: "Client Tracking ID"
    description: "Field available for custom tracking IDs."
    sql: ${TABLE}.CLIENT_TRACKING_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.client_tracking_id
  }

  dimension: createdby_id {
    type: string
    hidden:yes
    sql: ${TABLE}.CREATEDBY ;;
  }

  dimension: createdon {
    type: date_time
    label: "Flight Media Created"
    description: "The date the flight media was created in the system in UTC."
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: dst_createdon {
    type: date_time
    label: "[DST] Flight Media Local Created"
    description: "The date the flight media was created in the system in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.CREATEDON)
      else ${TABLE}.CREATEDON end ;;
  }

  dimension: creative_format_type {
    type: string
    label: "Creative Format"
    description: "The format type of the media.  Examples include VAST XML-VPAID, SWF, VPAID JS, XML, etc."
    sql: ${TABLE}.CREATIVE_FORMAT_TYPE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.creative_format_type
  }

  dimension: creative_format_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATIVE_FORMAT_TYPE_ID ;;
  }

  dimension: demand_utc_offset {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMAND_UTC_OFFSET ;;
  }

  dimension: demo_abbreviation {
    type: string
    sql: ${TABLE}.DEMO_ABBREVIATION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.demo_abbreviation
  }

  dimension: demoaud {
    type: number
    label: "Demo Audience Size"
    sql: ${TABLE}.DEMOAUD ;;
  }

  dimension: democomp {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMOCOMP ;;
  }

  measure: max_democomp {
    type: max
    label: "Demo Composition"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Campaign{% else %}Campaign{% endif %}"
    description: "Percent of targeted population in the geographical area particular campaign is targeted for."
    value_format_name: percent_2
    sql: CASE WHEN ${TABLE}.FLIGHT_MEDIA_ACTIVE THEN ${TABLE}.DEMOCOMP ELSE 0 END ;;
  }

  dimension: destination_url {
    type: string
    label: "Destination URL"
    description: "The address of the webpage reached when selecting the ad media."
    sql: ${TABLE}.DESTINATION_URL ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.destination_url
  }

  dimension: duration {
    type: number
    label: "Duration"
    description: "The duration of the creative, in seconds."
    sql: ${TABLE}.DURATION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.duration
  }

  dimension_group: end_datetime_local {
    type: time
    timeframes: [raw, time, hour]
    label: "FM End Date - Local"
    description: "The end date of the Flight Media in the demand timezone."
    sql: ${TABLE}.END_DATETIME_LOCAL ;;
  }

  dimension_group: dst_end_datetime_local {
    type: time
    timeframes: [raw, time, hour]
    label: "[DST] FM End Date - Local"
    description: "The end date of the Flight Media in the demand timezone accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('GMT', ${timezone.timezone_name}, dateadd(h, -${timezone.utc_offset}, ${TABLE}.END_DATETIME_LOCAL))
      else ${TABLE}.END_DATETIME_LOCAL end ;;
  }

  dimension: yj_end_datetime_local {
    type: string
    label: "YJ FM End Date"
    description: "The end date of the flight media in the demand timezone formatted for YJ reporting."
    sql: TO_CHAR(dateadd(min, -1, ${end_datetime_local_raw}), 'MM/DD/YYYY HH12:MI AM') ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.yj_end_datetime_local
  }

  dimension: end_datetm {
    type: date_hour
    label: "FM End Date"
    description: "The end date of the Flight Media in UTC."
    sql: ${TABLE}.END_DATETM ;;
  }

  dimension: dst_end_datetm {
    type: date_hour
    label: "[DST] FM End Date"
    description: "The end date of the Flight Media in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.END_DATETM)
      else ${TABLE}.END_DATETM end ;;
  }

  dimension: end_ping_tracking {
    type: string
    label: "End Ping Tracking URL"
    description: "The URL used to track the completion ping"
    sql: ${TABLE}.END_PING_TRACKING ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.end_ping_tracking
  }

  dimension: external_id {
    type: string
    label: "{% if _explore._name == 'auction_log' %}External ID{% else %}Clock Number{% endif %}"
    description: "Media external ID"
    sql: ${TABLE}.EXTERNAL_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.external_id
  }

  dimension: first_quarter_ping_tracking {
    type: string
    label: "25% Ping Tracking URL"
    description: "The URL used to track the 25% complete ping."
    sql: ${TABLE}.FIRST_QUARTER_PING_TRACKING ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.first_quarter_ping_tracking
  }

  dimension: flight_active {
    type: yesno
    label: "{% if _explore._name == 'auction_log' %}Flight Active{% else %}Flight Active - w/ Flight Media{% endif %}"
    description: "A yes/no indicator if the flight is currently active. Will return 'no' for all flights without trafficked Flight Media."
    sql: ${TABLE}.FLIGHT_ACTIVE ;;
  }

  dimension: flight_description {
    type: string
    label: "Flight Description"
    sql: ${TABLE}.FLIGHT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.flight_description
  }

  dimension: flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  dimension: flight_is_added_value {
    type: yesno
    label: "Flight Added Value"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Flight{% endif %}"
    description: "A yes/no indicator if the Flight is an added value flight."
    sql: ${TABLE}.FLIGHT_IS_ADDED_VALUE ;;
  }

  dimension: flight_is_slate {
    type: yesno
    hidden: yes
    sql: ${TABLE}.FLIGHT_IS_SLATE ;;
  }

  dimension: flight_media_active {
    type: yesno
    label: "FM Active"
    description: "A yes/no indicator if the flight media is currently active."
    sql: ${TABLE}.FLIGHT_MEDIA_ACTIVE ;;
  }

  dimension: flight_media_description {
    type: string
    label: "FM Description"
    description: "The name of the flight media."
    sql: ${TABLE}.FLIGHT_MEDIA_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.flight_media_description
  }

  dimension: flight_media_id {
    type: number
    label: "FMID"
    description: "The internal identifier of the Flight Media."
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
    value_format_name: id
  }

  measure: count_of_flight_media {
    type: number
    label: "Count of Flight Media"
    description: "The distinct count of Flight Media."
    sql: count(distinct ${flight_media_id}) ;;
  }

  measure: count_of_media {
    type: number
    label: "Count of Media"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "The distinct count of Media."
    sql: count(distinct ${media_id}) ;;
  }

  dimension: geo_and_demo_audience {
    type: string
    hidden: yes
    sql: ${TABLE}.GEO_AND_DEMO_AUDIENCE ;;
  }

  dimension: geo_only_audience {
    type: string
    hidden: yes
    sql: ${TABLE}.GEO_ONLY_AUDIENCE ;;
  }

  dimension: grp_audience_size {
    type: string
    hidden: yes
    sql: ${TABLE}.GRP_AUDIENCE_SIZE ;;
  }

  dimension: isfiller {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ISFILLER ;;
  }

  dimension: ishouse {
    type: string
    label: "Is House"
    sql: CASE WHEN ${isfiller} THEN 'true' ELSE 'false' END;;
  }

  dimension: isvideo {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ISVIDEO ;;
  }

  dimension: media_active {
    type: yesno
    label: "Media Active"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "A yes/no indicator if the media is currently active."
    sql: ${TABLE}.MEDIA_ACTIVE ;;
  }

  dimension: media_id {
    type: string
    label: "Media ID"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "The internal identifier of the Media."
    sql: ${TABLE}.MEDIA_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.media_id
  }

  dimension: media_name {
    type: string
    label: "Media"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "The name of the media."
    sql: ${TABLE}.MEDIA_NAME ;;
    drill_fields: [flight_media_id]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.media_name
  }

  dimension: media_type {
    type: string
    label: "Media Type"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "The type of media.  Examples include display, overlay, video, etc."
    sql: ${TABLE}.MEDIA_TYPE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.media_type
  }

  dimension: media_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.MEDIA_TYPE_ID ;;
  }

  dimension: media_width_height {
    type: string
    label: "Media Width and Height"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "The width and height of the media in pixels."
    sql: ${TABLE}.MEDIA_WIDTH_HEIGHT ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.media_width_height
  }

  dimension: media_width_height_id {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Media{% endif %}"
    description: "The id of media width and height."
    label: "Media Width and Height ID"
    sql: ${TABLE}.MEDIA_WIDTH_HEIGHT_ID ;;
  }

  dimension: mid_ping_tracking {
    type: string
    label: "50% Ping Tracking URL"
    description: "The URL used to track the 50% complete ping."
    sql: ${TABLE}.MID_PING_TRACKING ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.mid_ping_tracking
  }

  dimension: native_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.NATIVE_CURRENCY ;;
  }

  dimension: native_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.NATIVE_CURRENCY_ID ;;
  }

  dimension: postalcode_targeted {
    type: string
    hidden: no
    label: "Postal Code Targeted"
    view_label: "{% if _explore._name == 'auction_log' %}Buyer Flight Media{% else %}Campaign{% endif %}"
    description: "A yes/no indicator if the campaign is postal code targeted."
    sql: CASE When ${TABLE}.POSTALCODE_TARGETED = 1 then 'Yes' else 'No' end ;;
    suggestions: ["No", "Yes"]
  }

  dimension: region_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_CURRENCY ;;
  }

  dimension: region_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_CURRENCY_ID ;;
  }

  dimension: region_utc_offset {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_UTC_OFFSET ;;
  }

  dimension: start_ping_tracking {
    type: string
    label: "Impression Ping Tracking URL"
    description: "The URL used to track the start of the impression."
    sql: ${TABLE}.START_PING_TRACKING ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.start_ping_tracking
  }

  dimension: starttimezone_id {
    type: string
    hidden: yes
    sql: ${TABLE}.STARTTIMEZONE_ID ;;
  }

  dimension: third_quarter_ping_tracking {
    type: string
    label: "75% Ping Tracking URL"
    description: "The URL used to track the 75% complete ping."
    sql: ${TABLE}.THIRD_QUARTER_PING_TRACKING ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.third_quarter_ping_tracking
  }

  dimension: trp_audience_size {
    type: string
    hidden: yes
    sql: ${TABLE}.TRP_AUDIENCE_SIZE ;;
  }

  dimension: tvaud {
    type: string
    hidden: yes
    sql: ${TABLE}.TVAUD ;;
  }

  dimension: iseligible {
    type: yesno
    label: "Is Eligible"
    description: "A yes/no indicator if the flight media is eligible."
    sql: ${TABLE}.iseligible ;;
  }

  dimension: future_flight_media {
    type: yesno
    label: "Include All Flight Media"
    description: "Include this field as a filter in your Look if you want to include all relevant flight media in the Look. Without this included in your filter,
    results will include flight media with delivery only."
    sql: true ;;
  }

  measure: count_of_eligible_flight_media {
    type: count_distinct
    label: "Count of Eligible Flight Media"
    description: "The distinct count of eligible Flight Media."
    sql: CASE WHEN ${iseligible} THEN ${flight_media_id} END ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [media_name, media_type.media_type_id]
  }
}
