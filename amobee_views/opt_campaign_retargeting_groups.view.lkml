view: campaign_retargeting_groups {


  derived_table: {
    sql: SELECT DISTINCT
  rgfm.rta_group_id,
  c.campaign_id,
  c.campaign_name,
  f.begin_datetm,
  f.end_datetm,
  fm.flight_media_id,
  rgv.attribute_value_id
FROM AN_MAIN..flight_media fm
JOIN AN_MAIN..FLIGHT f ON fm.flight_id = f.flight_id
JOIN AN_MAIN..CAMPAIGN c   ON f.campaign_id = c.campaign_id
     AND c.campaign_status_id IN (1, 2, 3, 6)
     AND f.begin_datetm <= DATEADD(DAY, 5, CAST(GETDATE() AS DATE))
     AND f.end_datetm >= DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
     AND c.active=1
     AND f.active=1
     AND fm.active=1
     AND f.delivery_units > 0
JOIN AN_SMART..rta_group_flight_medias rgfm on rgfm.flight_media_id = fm.flight_media_id
JOIN AN_SMART..rta_group_attribute_values rgv ON rgfm.rta_group_id = rgv.rta_group_id;;
  }


  dimension: rta_group_id {
    type: string
    hidden: yes
    sql: ${TABLE}.rta_group_id ;;
  }

  dimension: campaign_id {
    type: string
    label: "Campaign ID"
    description: "The internal system identifier for the campaign"
    sql: ${TABLE}.campaign_id;;

  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    description: "The name of the campaign"
    sql: ${TABLE}.campaign_name;;

  }


  dimension_group: campaign_begin_date {
    type: time
    label: "Campaign Begin"
    view_label: "Dates"
    timeframes: [time,date,month,year,raw]
    description: "The starting date of the campaign"
    sql: ${TABLE}.begin_datetm ;;
  }

  dimension_group: campaign_end_date {
    type: time
    label: "Campaign End"
    view_label: "Dates"
    timeframes: [time,date,month,year,raw]
    description: "The starting date of the campaign"
    sql: ${TABLE}.end_datetm ;;
  }

  dimension: flight_media_id {
    type: string
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension: attribute_value_id {
    type: string
    hidden: yes
    sql: ${TABLE}.attribute_value_id ;;
  }

}
