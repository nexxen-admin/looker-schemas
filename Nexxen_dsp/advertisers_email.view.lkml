# The name of this view in Looker is "Advertisers Email"
view: advertisers_email {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.advertisers_email ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Advertiser ID" in Explore.

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden: yes
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
    hidden: yes
  }

  dimension: email {
    type: string
    label: "Advertiser Email"
    sql: ${TABLE}.email ;;
  }
  measure: count {
    type: count
    drill_fields: [advertiser_name]
  }
}
