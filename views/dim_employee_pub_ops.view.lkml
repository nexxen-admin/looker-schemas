# The name of this view in Looker is "V Dim Employee Pub Ops"
view: v_dim_employee_pub_ops {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Employee_PubOps ;;
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
  # This dimension will be called "Employee ID" in Explore.

  dimension: employee_id {
    type: number
    sql: ${TABLE}.Employee_ID ;;
    hidden: yes
  }

  dimension: employee_key {
    type: number
    sql: ${TABLE}.Employee_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_employee_key {
    type: sum
    sql: ${employee_key} ;;
    hidden: yes
  }

  measure: average_employee_key {
    type: average
    sql: ${employee_key} ;;
    hidden: yes
  }

  dimension: employee_name {
    label: "PubOps Name"
    type: string
    sql: ${TABLE}.Employee_Name ;;
  }

  dimension: employee_office {
    type: string
    sql: ${TABLE}.Employee_Office ;;
    hidden: yes
  }

  dimension: employee_region {
    type: string
    sql: ${TABLE}.Employee_Region ;;
    hidden: yes
  }

  dimension: role_source {
    type: string
    sql: ${TABLE}.Role_Source ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [employee_name]
    hidden: yes
  }
}
