# The name of this view in Looker is "V Dim Product Type"
view: v_dim_product_type {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Product_Type ;;
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
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Product Type Code" in Explore.

  dimension: product_type_code {
    type: number
    sql: ${TABLE}.Product_Type_Code ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_product_type_code {
    type: sum
    sql: ${product_type_code} ;;
  }

  measure: average_product_type_code {
    type: average
    sql: ${product_type_code} ;;
  }

  dimension: product_type_key {
    type: number
    sql: ${TABLE}.Product_Type_Key ;;
  }

  dimension: product_type_name {
    type: string
    sql: ${TABLE}.Product_Type_Name ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  measure: count {
    type: count
    drill_fields: [product_type_name]
  }
}
