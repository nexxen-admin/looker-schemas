# The name of this view in Looker is "Datorama Dsp Third Party"
view: datorama_dsp_third_party {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.datorama_dsp_third_party ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Console Advertiser Name" in Explore.

  dimension: console_advertiser_name {
    type: string
    sql: ${TABLE}.console_advertiser_name ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    hidden: yes
  }

  dimension: media_buy_key {
    type: string
    sql: ${TABLE}.media_buy_key ;;
    #hidden: yes
  }

  dimension: reporting {
    type: string
    sql: ${TABLE}.reporting ;;
  }

  dimension: third_party_key {
    type: number
    sql: ${TABLE}.third_party_key ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [console_advertiser_name]
  }
}
