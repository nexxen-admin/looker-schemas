# The name of this view in Looker is "Dim Buying Channel Ctrl"
view: dim_buying_channel_ctrl {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.dim_Buying_Channel_ctrl ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Buying Channel Ctrl Key" in Explore.

  dimension: buying_channel_ctrl_key {
    type: number
    sql: ${TABLE}.Buying_Channel_ctrl_key ;;
    hidden: yes
  }

  dimension: buying_channel_ctrl_name {
    type: string
    sql: ${TABLE}.Buying_Channel_ctrl_name ;;
    label: "Demand Buying Channel"
    description: "Classification that defines if advertisers are purchasing inventory from high-quality publishers or specific demand sources via invitation-only or curated setups, ensuring brand-safe environments, advanced targeting capabilities, and enhanced transparency, or direct from the open market.  Logic aligns with definitions in CTRL"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_create {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_create_date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_update_date ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [buying_channel_ctrl_name]
  }
}
