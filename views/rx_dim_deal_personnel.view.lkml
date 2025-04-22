# The name of this view in Looker is "Rx Dim Deal Personnel"
view: rx_dim_deal_personnel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: Andromeda.rx_dim_deal_personnel ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Employee ID" in Explore.

  dimension: employee_id {
    type: string
    sql: ${TABLE}.employee_id ;;
   # hidden: yes
  }

  dimension: rx_deal_id {
    type: number
    sql: ${TABLE}.rx_deal_id ;;
    #hidden: yes
  }

  dimension: rx_personnel_id {
    type: number
    sql: ${TABLE}.rx_personnel_id ;;
    #hidden: yes
  }

  dimension: rx_personnel_name {
    type: string
    sql: ${TABLE}.rx_personnel_name ;;
   # hidden: yes
  }

  dimension: rx_personnel_role {
    type: string
    sql: ${TABLE}.rx_personnel_role ;;
    #hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: snapshot_time_utc {
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
    sql: ${TABLE}.snapshot_time_utc ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [rx_personnel_name]
    hidden: yes
  }
}
