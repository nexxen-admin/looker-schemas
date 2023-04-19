# The name of this view in Looker is "V Dim Deal Priority"
view: dim_deal_priority {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Deal_Priority ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Deal Priority ID" in Explore.

  dimension: deal_priority_id {
    type: number
    sql: ${TABLE}.Deal_Priority_ID ;;
    hidden: yes
  }

  dimension: deal_priority_key {
    type: number
    sql: ${TABLE}.Deal_Priority_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_deal_priority_key {
    type: sum
    sql: ${deal_priority_key} ;;
    hidden: yes
  }

  measure: average_deal_priority_key {
    type: average
    sql: ${deal_priority_key} ;;
    hidden: yes
  }

  dimension: deal_priority_name {
    type: string
    label: "Deal Priority"
    description: "Priority of the deal"
    sql: ${TABLE}.Deal_Priority_Name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: weight {
    label: "Deal Priority Weight"
    description: "Weight according to priority:
                  Low - 25, medium - 50, High - 75, Programmatic Guaranteed - 100, Open Market - 0"
    type: number
    sql: ${TABLE}.Weight ;;
  }

  measure: count {
    type: count
    drill_fields: [deal_priority_name]
    hidden: yes
  }
}
