# The name of this view in Looker is "V Dim Buying Channel"
view: dim_buying_channel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Buying_Channel ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Buying Channel" in Explore.

  dimension: buying_channel {
    type: string
    label: "Buying Channel"
    description: "A platform through which advertisers purchase and manage their digital advertising inventory"
    sql: ${TABLE}.Buying_Channel ;;
    drill_fields: [dim_dsp.dsp_display_name, dim_a_domain.a_domain, dim_o_domain.o_domain]
  }

  dimension: buying_channel_key {
    type: number
    sql: ${TABLE}.Buying_Channel_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_buying_channel_key {
    type: sum
    sql: ${buying_channel_key} ;;
    hidden: yes
  }

  measure: average_buying_channel_key {
    type: average
    sql: ${buying_channel_key} ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
