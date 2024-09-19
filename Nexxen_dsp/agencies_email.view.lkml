# The name of this view in Looker is "Agencies Email"
view: agencies_email {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.agencies_email ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: email {
    type: string
    label: "Agency User Email"
    sql: ${TABLE}.email ;;
  }


  dimension: first_name {
    type: string
    label: "Agency User First Name"
    sql: ${TABLE}.First_Name ;;
  }

  dimension: last_name {
    type: string
    label: "Agency User Last Name"
    sql: ${TABLE}.Last_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [account_name]
  }
}
