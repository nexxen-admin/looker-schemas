# The name of this view in Looker is "V Dim Deal Brand"
view: dim_deal_brand {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Deal_Brand ;;
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
  # This dimension will be called "Deal Brand ID" in Explore.

  dimension: deal_brand_id {
    type: number
    sql: ${TABLE}.Deal_Brand_ID ;;
    hidden: yes
  }

  dimension: deal_brand_key {
    type: number
    sql: ${TABLE}.Deal_Brand_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: deal_brand_name {
    type: string
    description: "The Brand that's being advertised in the ad"
    sql: ${TABLE}.Deal_Brand_Name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [deal_brand_name]
    hidden: yes
  }
}
