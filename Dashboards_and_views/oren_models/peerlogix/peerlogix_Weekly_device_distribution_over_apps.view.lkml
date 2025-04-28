view: peerlogix_Weekly_device_distribution_over_apps {
    derived_table: {
      sql:


select week,split_into_rows,count_device
from bi_new.device_app_by_weekly


         ;;
    }


    dimension: week {
      type: date_week
      sql: ${TABLE}."week" ;;
    }

  dimension: split_into_rows {
    label: "App name"
    type: string
    sql: ${TABLE}."split_into_rows" ;;
  }



    measure: count_device {
      label: "Device count"
      type: average
      sql: ${TABLE}."count_device" ;;
    }

    set: detail {
      fields: [week, split_into_rows,count_device]
    }
  }
