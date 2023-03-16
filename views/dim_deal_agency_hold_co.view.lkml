# The name of this view in Looker is "Dim Deal Agency Hold Co"
view: dim_deal_agency_hold_co {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Dim_Deal_Agency_HoldCo ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Deal Agency ID" in Explore.

  dimension: deal_agency_id {
    type: number
    sql: ${TABLE}.Deal_Agency_ID ;;
    hidden: yes
  }

  dimension: deal_agency_key {
    type: number
    sql: ${TABLE}.Deal_Agency_Key ;;
    hidden: yes
  }

  dimension: hold_co {
    type: string
    sql: ${TABLE}.HoldCo ;;
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
