# The name of this view in Looker is "Dim Dsp Seat Hold Co"
view: dim_dsp_seat_hold_co {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Dim_DSP_Seat_HoldCo ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Dsp Account ID" in Explore.

  dimension: dsp_account_id {
    type: number
    sql: ${TABLE}.dsp_account_id ;;
    hidden: yes
  }

  dimension: hold_co {
    type: string
    sql: ${TABLE}.HoldCo ;;

  }

  dimension: seat_id {
    type: string
    sql: ${TABLE}.seat_id ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
