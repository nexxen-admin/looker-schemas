view: mediaplanner_allocation_yesterday {
  label: "Media Planner Allocation"
  derived_table: {
    sql:
      SELECT
        fmd.FLIGHT_MEDIA_ID,
        SUM(mav.X_ALLOCATION) AS X_ALLOCATION,
        SUM(mav.Y_ALLOCATION) AS Y_ALLOCATION,
        AVG
        (
          CASE
            WHEN mav.X_ALLOCATION + mav.Y_ALLOCATION > 0 THEN
              mav.WIN_RATE
            ELSE
              0
          END
        ) AS WIN_RATE,
        AVG
        (
          CASE
            WHEN mav.X_ALLOCATION + mav.Y_ALLOCATION > 0 THEN
              mav.PAY_RATE
            ELSE
              0
          END
        ) AS PAY_RATE
      FROM
        OPT.MEDIAPLANNER_ALLOCATION_VIEW mav
          JOIN DIM.FLIGHT_MEDIA_DETAILS fmd
            ON mav.FLIGHT_MEDIA_ID = fmd.FLIGHT_MEDIA_ID
          JOIN
          (
            SELECT
              t.TIMEZONE_ID,
              DATE_TRUNC(d, DATEADD(h, t.UTC_OFFSET - 24, CURRENT_TIMESTAMP())) AS YESTERDAY
            FROM
              DIM.TIMEZONE t
          ) t2
            ON fmd.STARTTIMEZONE_ID = t2.TIMEZONE_ID
      WHERE
        mav.ALLOCATION_DATE = t2.YESTERDAY AND
        mav.ALLOCATION_DATE = mav.RUNDATE
      GROUP BY
        fmd.FLIGHT_MEDIA_ID
      ;;
  }

  dimension: flight_media_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: x_allocation_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.X_ALLOCATION ;;
  }

  dimension: y_allocation_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.Y_ALLOCATION ;;
  }

  dimension: win_rate_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.WIN_RATE ;;
  }

  dimension: pay_rate_yesterday {
    type: number
    hidden: yes
    sql: ${TABLE}.PAY_RATE ;;
  }

  measure: impressions_yesterday {
    type: sum
    label: "Allocation Impressions Yesterday"
    view_label: "Allocation Metrics"
    description: "Update"
    value_format_name: decimal_0
    sql: coalesce((${x_allocation_yesterday}::float + ${y_allocation_yesterday}::float),0) * coalesce(${win_rate_yesterday}::float, 0) ;;
  }

  measure: spend_yesterday {
    type: sum
    label: "Allocation Spend Yesterday"
    view_label: "Allocation Metrics"
    description: "Update"
    value_format_name: decimal_2
    sql: coalesce(${x_allocation_yesterday}::float, 0) * coalesce(${win_rate_yesterday}::float,0) * coalesce(${pay_rate_yesterday}::float,0) ;;
  }

  measure: units_yesterday {
    type: sum
    label: "Allocation Units Yesterday"
    view_label: "Allocation Metrics"
    description: "Update"
    value_format_name: decimal_0
    sql: coalesce(${x_allocation_yesterday}::float,0) * coalesce(${win_rate_yesterday}::float,0) * coalesce(${pay_rate_yesterday}::float,0) ;;
  }

  measure: count {
    type: count
    hidden: yes
    label: "Count"
    drill_fields: []
  }
}
