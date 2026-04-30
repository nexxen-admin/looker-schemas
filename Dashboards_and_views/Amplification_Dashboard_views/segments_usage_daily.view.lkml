view: segments_usage_daily {
  derived_table: {
    sql: SELECT *
      FROM BI_NEW.dim_segment_data_apprdb s
      JOIN andromeda.segment_usage_daily sr
        on sr.export_name = s.SEGMENT_ID :: Varchar
;

      ;;

  #   # Define your dimensions and measures here, like this:
  #   dimension: SEGMENT_ID {
  #     description: "Unique ID for each syndicated segment"
  #     type: number
  #     sql: ${TABLE}.segment_id ;;
  #   }
  #
  #   dimension: segment_type_id {
  #     description: "The enum id of each segment"
  #     type: number
  #     sql: ${TABLE}.segment_type_id ;;
  #   }

  #   dimension: segment_type_name {
  #     description: "The enum name of each segment"
  #     type: string
  #     sql: ${TABLE}.segment_type_name ;;
  #   }
  #
  #   dimension_group: most_recent_purchase {
  #     description: "The date when each user last ordered"
  #     type: time
  #     timeframes: [date, week, month, year]
  #     sql: ${TABLE}.most_recent_purchase_at ;;
  #   }
  #
  #   measure: total_lifetime_orders {
  #     description: "Use this for counting lifetime orders across many users"
  #     type: sum
  #     sql: ${lifetime_orders} ;;
  #   }
  }
}
