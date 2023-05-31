# The name of this view in Looker is "New Money Unruly Player Aniview"
view: new_money_unruly_player_aniview {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.New_Money_Unruly_Player_aniview ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Av Impressions" in Explore.

  measure: av_impressions {
    type: sum
    sql: ${TABLE}.AV_Impressions ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: av_mp_10_cut {
    type: sum
    sql: ${TABLE}.AV_MP_10_cut ;;
  }

  measure: av_mp_total_rev {
    type: sum
    sql: ${TABLE}.AV_MP_total_rev ;;
  }

  measure: av_sf {
    type: sum
    sql: ${TABLE}.AV_SF ;;
  }

  dimension: month_year {
    type: string
    sql: ${TABLE}.month_year ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: pubs_mp {
    type: number
    sql: ${TABLE}.PUbs_MP ;;
  }

  measure: unruly_5_from_pub_mp {
    type: sum
    sql: ${TABLE}.Unruly_5_from_pub_MP ;;
  }

  measure: count {
    type: count
    drill_fields: [publisher_name]
  }
}
