view: quarterly_viewer_rta_group {
  derived_table: {
    sql: select rta_group_id,
        timeperiod_type,
        viewer_key,
        timeperiod_start_datetime,
        timeperiod_end_datetime,
        effective_weight,
        timeperiod_date_key
      from VIEWERSHIP.viewer_rta_group
      where timeperiod_type = 'q';;}

      dimension: effective_weight {
        type: number
        view_label: "Viewer"
        hidden: no
        sql: ${TABLE}.EFFECTIVE_WEIGHT ;;
      }

      measure: quarterly_effective_weight {
        label: "Quarterly RTA Effective Weight"
        view_label: "Viewer"
        type: sum
        sql: ${effective_weight} ;;
      }


      dimension: rta_group_id {
        type: number
        label: "RTA Group ID"
        description: "RTA group to identify viewers for a quarter"
        view_label: "Viewer"
        sql: ${TABLE}.RTA_GROUP_ID ;;
        value_format_name: id
      }

  dimension: timeperiod_date_key {
    type: number
    #hidden: yes
    label: "RTA Group Quarter"
    view_label: "Viewer"
    description: "The timeperiod for which the viewer had the rta group. Eg. For 2017Q2 enter 201702."
    sql: ${TABLE}.TIMEPERIOD_DATE_KEY ;;
    value_format_name: id
  }

      dimension_group: end_effective {
        type: time
        label: "Quarterly RTA Effective End Date"
        view_label: "Dates"
        hidden: yes
        timeframes: [
          raw,
          date,
          week,
          month,
          quarter,
          year
        ]
        convert_tz: no
        sql: ${TABLE}.TIMEPERIOD_END_DATETIME;;
      }


      dimension_group: start_effective {
        type: time
        label: "Quarterly RTA Effective Start Date"
        view_label: "Dates"
        hidden: yes
        timeframes: [
          raw,
          date,
          week,
          month,
          quarter,
          year
        ]
        convert_tz: no
        sql: ${TABLE}.TIMEPERIOD_START_DATETIME;;
      }


      dimension: timeperiod_type {
        type: string
        hidden: yes
        sql: ${TABLE}.TIMEPERIOD_TYPE ;;
      }

      dimension: viewer_key {
        type: string
        hidden: yes
        sql: ${TABLE}.VIEWER_KEY ;;
      }

      measure: count {
        type: count
        drill_fields: []
      }
    }
