view: prk_metrics {

  derived_table: {
    sql: select pb.mean as mean,
        pb.stddev as stddev,
        pb.from_utc::timestamp as from_utc,
        pb.to_utc::timestamp as to_utc,
        rct.rta_group_id as rta_group_id,
        rct.campaign_id as campaign_id,
        rct.platform_client as platform_client,
        rct.active_date as active_date
        from clarity.raw.rta_campaign_tracking rct
        inner join clarity.raw.prk_baseline pb on (rct.rta_group_id=pb.rta_group_id and rct.active_date=pb.to_utc::date)
        where pb.baseline_id=0 and pb.business_region=1

      ;;   }

  dimension_group: from_utc {
    type: time
    label: "Period Start Time"
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time the event started in UTC"
    sql: ${TABLE}.from_utc ;;
  }

  dimension_group: to_utc {
    type: time
    label: "Period End Time"
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      quarter,
      year

    ]
    convert_tz: no
    description: "The date/time the event ended in UTC"
    sql: ${TABLE}.to_utc ;;
  }


  dimension: active_date {
    type:  date
    label: "Active Date"
    description: "The day for which a campaign/rta_group was active."
    sql: ${TABLE}.active_date ;;
  }

  dimension: rta_group_id {
    description: "RTA Group Id"
    type: number
    sql: ${TABLE}.rta_group_id ;;
    value_format_name: id
  }

  dimension: campaign_id {
    description: "Campaign Id"
    type: number
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: platform_client {
    description: "Platform Client"
    type: string
    sql: ${TABLE}.platform_client ;;
  }


  measure: mean {
    description: "p_rk mean over period"
    type: average
    sql: ${TABLE}.mean::double ;;
  }
  measure: stddev {
    description: "p_rk std dev over period"
    type: average
    sql: ${TABLE}.stddev::double ;;
  }
}
