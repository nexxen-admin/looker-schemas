view: mssql_oltp_daypart_alert {
  label: "Watershed Facets"
  derived_table: {
    sql: SELECT v.campaign_id AS CAMPAIGN_ID
    ,v.media_id AS MEDIA_ID
    ,v.watershed_timing_id AS WATERSHED_TIMING_ID
    ,v.partner_id AS PARTNER_PID_ID
    ,p.office_id AS OFFICE_ID
    ,v.LEVEL AS LEVEL
    ,v.changedon AS CHANGEDON
    ,v.external_id AS EXTERNAL_ID
    ,c.campaign_name AS CAMPAIGN_NAME
    ,t.NAME AS PARTNER_PID_NAME
    ,m.description AS MEDIA_NAME
    ,w.begin_time AS BEGIN_TIME
    ,w.end_time AS END_TIME
  FROM an_main..ssp_creative_watershed_alert_view (NOLOCK) v
  JOIN an_main..watershed_timing (NOLOCK) w ON v.watershed_timing_id = w.watershed_timing_id
  JOIN an_main..media (NOLOCK) m ON m.media_id = v.media_id
  JOIN an_main..campaign (NOLOCK) c ON c.campaign_id = v.campaign_id
  JOIN an_main..partner (NOLOCK) p ON v.partner_id = p.partner_id
  JOIN (
    SELECT placement_name AS NAME
      ,placement_id AS id
      ,'placement' AS LEVEL
    FROM an_main..placement (NOLOCK) p
    JOIN an_main..partner (NOLOCK) pt ON p.partner_id = pt.parent_id
    WHERE p.is_test_placement = 0

    UNION

    SELECT partner_name AS NAME
      ,partner_id AS id
      ,'partner' AS LEVEL
    FROM an_main..partner (NOLOCK)
    ) t ON v.partner_id = id
    AND v.LEVEL = t.LEVEL
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: campaign_id {
    label: "Campaign ID"
    type: number
    sql: ${TABLE}.CAMPAIGN_ID ;;
    value_format_name: id
  }

  dimension: media_id {
    label: "Media ID"
    type: number
    sql: ${TABLE}.MEDIA_ID ;;
    value_format_name: id
  }

  dimension: watershed_timing_id {
    label: "Watershed Timing ID"
    type: number
    sql: ${TABLE}.WATERSHED_TIMING_ID ;;
    value_format_name: id
  }

  dimension: partner_pid_id {
    label: "Publisher/Placement ID"
    type: number
    sql: ${TABLE}.PARTNER_PID_ID ;;
    value_format_name: id
  }

  dimension: office_id {
    label: "Office ID"
    type: number
    sql: ${TABLE}.OFFICE_ID ;;
    value_format_name: id
  }

  dimension: level {
    label: "Level"
    type: string
    sql: ${TABLE}.LEVEL ;;
  }

  dimension_group: changedon {
    label: "Changed"
    type: time
    timeframes: [raw, time, date, month]
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: external_id {
    label: "External ID"
    type: number
    sql: ${TABLE}.EXTERNAL_ID ;;
    value_format_name: id
  }

  dimension: campaign_name {
    label: "Campaign"
    type: string
    sql: ${TABLE}.CAMPAIGN_NAME ;;
  }

  dimension: partner_pid_name {
    label: "Publisher/Placement"
    type: string
    sql: ${TABLE}.PARTNER_PID_NAME ;;
  }

  dimension: media_name {
    label: "Media"
    type: string
    sql: ${TABLE}.MEDIA_NAME ;;
  }

  dimension_group: begin {
    label: "Begin"
    type: time
    timeframes: [raw, time, date, month]
    sql: ${TABLE}.BEGIN_TIME ;;
  }

  dimension_group: end {
    label: "End"
    type: time
    timeframes: [raw, time, date, month]
    sql: ${TABLE}.END_TIME ;;
  }


}
