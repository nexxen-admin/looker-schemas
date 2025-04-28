# The name of this view in Looker is "Dim Deal Personnel"
view: dim_deal_personnel {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.dim_deal_personnel ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Deal ID" in Explore.

  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }

  dimension: employee_id {
    type: string
    sql: ${TABLE}.employee_id ;;
  }

  dimension: personnel_name {
    type: string
    sql: ${TABLE}.personnel_name ;;
  }

  dimension: personnel_role {
    type: string
    sql: ${TABLE}.personnel_role ;;
  }

  dimension: personnel_id {
    type: string
    sql: ${TABLE}.personnel_id ;;
  }

  dimension: sales_region {
    type: string
    label: "Personnel Sales Region"
    sql: ${TABLE}.sales_region ;;
  }

  measure: count {
    type: count
    drill_fields: [personnel_name]
  }
}
