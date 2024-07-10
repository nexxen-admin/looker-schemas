# The name of this view in Looker is "Dim Dsp Market"
view: dim_dsp_market {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_market ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
    hidden: yes
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Eula Accepted" in Explore.

  dimension: eula_accepted {
    type: number
    label: "Eula Accepted"
    sql: ${TABLE}.eula_accepted ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }

  dimension: market_id {
    type: number
    label: "Market ID"
    sql: ${TABLE}.market_id ;;
    description: "DSP market"

  }

  dimension: market_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.market_id_key ;;
    hidden: yes
  }

  dimension: market_name {
    type: string
    label: "Market Name"
    sql: ${TABLE}.market_name ;;
    description: "DSP market name"

  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: time_zone_code {
    type: string
    label: "Market Timezone"
    sql: ${TABLE}.time_zone_code ;;
    description: "Timezone the market is running at"
  }

  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [market_name]
    hidden: yes
  }
}
