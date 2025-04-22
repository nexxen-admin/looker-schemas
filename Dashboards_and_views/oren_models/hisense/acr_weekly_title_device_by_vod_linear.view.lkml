
view: acr_weekly_title_device_by_vod_linear {
    derived_table: {
      sql: SELECT week_date,
              title,
              source,
              country,
              count_devices
        FROM bi_new.acr_weekly_title_device_by_vod_linear

         ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: week_date {
      type: date_week
      sql: ${TABLE}.week_date ;;
    }


    dimension: title {
      type: string
      sql: ${TABLE}.title ;;
    }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

    measure: count_devices {
      type: average
      sql: ${TABLE}.count_devices ;;
    }

    set: detail {
      fields: [week_date, title,country, count_devices,source]
    }
  }
