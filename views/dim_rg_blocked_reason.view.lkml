# The name of this view in Looker is "V Dim Rg Blocked Reason"
view: dim_rg_blocked_reason {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_RG_Blocked_Reason ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.



  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Rg Blocked Reason" in Explore.

  dimension: rg_blocked_reason {
    label: "RG Blocked Reason"
    description: "Describes the reason why the Rhythm guard system decided to block a request - it happens in real time."
    type: string
    sql: ${TABLE}.RG_Blocked_Reason ;;
  }

  dimension: rg_blocked_reason_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Reason_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_rg_blocked_reason_key {
    type: sum
    sql: ${rg_blocked_reason_key} ;;
    hidden: yes
  }

  measure: average_rg_blocked_reason_key {
    type: average
    sql: ${rg_blocked_reason_key} ;;
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
