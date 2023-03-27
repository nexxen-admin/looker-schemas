view: mssql_oltp_campaign_dates {
label: "Campaign"

  derived_table: {
    sql: SELECT c.campaign_id as CAMPAIGN_ID
  ,max(f.end_datetm) AS CAMPAIGN_END_DATETM
  ,max(f.end_datetime_local) AS CAMPAIGN_END_DATETM_LOCAL
  ,min(f.begin_datetm) AS CAMPAIGN_START_DATETM
  ,min(f.begin_datetime_local) AS CAMPAIGN_START_DATETM_LOCAL
FROM an_main..campaign (NOLOCK) c
JOIN an_main..flight (NOLOCK) f ON c.campaign_id = f.campaign_id
WHERE f.active = 1
GROUP BY c.campaign_id
      ;;
  }


  dimension: campaign_id {
    type: number
    label: "Campaign ID"
    hidden: yes
    description: ""
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension_group: campaign_start_datetm {
    type: time
    label: "Campaign Start"
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.CAMPAIGN_START_DATETM ;;
  }

  dimension: tapl_campaign_start_datetm {
    type: string
    label: "TAPL Campaign Start Date"
    view_label: "Custom Dimensions"
    description: "The start date of the campaing formatted for TAPL reporting."
    sql: COALESCE(CONVERT(varchar(11),${campaign_start_datetm_raw},103), '') ;;
  }

  dimension_group: campaign_end_datetm {
    type: time
    label: "Campaign End"
    timeframes: [raw,time,date,month,year]
    sql: DATEADD(minute, -1, ${TABLE}.CAMPAIGN_END_DATETM) ;;
  }

  dimension: tapl_campaign_end_datetm {
    type: string
    label: "TAPL Campaign End Date"
    view_label: "Custom Dimensions"
    description: "The end date of the campaing formatted for TAPL reporting."
    sql: COALESCE(CONVERT(varchar(11),${campaign_end_datetm_raw},103), '') ;;
  }

  dimension_group: campaign_start_datetm_local {
    type: time
    label: "Campaign Local Start "
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.CAMPAIGN_START_DATETM_LOCAL ;;
  }

  dimension_group: campaign_end_datetm_local {
    type: time
    label: "Campaign Local End"
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.CAMPAIGN_END_DATETM_LOCAL ;;
  }

}
