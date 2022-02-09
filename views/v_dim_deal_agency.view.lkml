# The name of this view in Looker is "V Dim Deal Agency"
view: dim_deal_agency {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Deal_Agency ;;
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

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_deal_agency_key {
    type: sum
    sql: ${deal_agency_key} ;;
    hidden: yes
  }

  measure: average_deal_agency_key {
    type: average
    sql: ${deal_agency_key} ;;
    hidden: yes
  }

  dimension: deal_agency_name {
    type: string
    sql: ${TABLE}.Deal_Agency_Name ;;
    case_sensitive: no
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [deal_agency_name]
    hidden: yes
  }
}
