# The name of this view in Looker is "V Dim Ad Size Height"
view: dim_ad_size_height {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Ad_Size_Height ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Size Exact Height" in Explore.

  dimension: ad_size_exact_height {
    label: "Ad Size Exact Height"
    description: "Permitted and recommended height size for ad ,
                  this information is provided with the request
                  and does not indicate the final size of the ad returned in
                  the bid."
    type: number
    sql: ${TABLE}.Ad_Size_Exact_Height ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: ad_size_height_key {
    type: number
    sql: ${TABLE}.Ad_Size_Height_Key ;;
    hidden: yes
  }

  dimension: ad_size_height_range {
    label: "Ad Size Height Range"
    description: "The high hirarchy of Ad height size.
                  support you collect all ads between sizes ranges ,
                  e.g : ads height between 1-100 "
    type: string
    sql: ${TABLE}.Ad_Size_Height_Range ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.


  dimension: range_sort_column {
    type: number
    sql: ${TABLE}.Range_Sort_Column ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
