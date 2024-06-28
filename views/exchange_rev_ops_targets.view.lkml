# The name of this view in Looker is "Exchange Rev Ops Targets"
view: exchange_rev_ops_targets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Exchange_RevOps_Targets ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.


  # This table had been created by Roni and ran one time for the targets, not located in an ETL process.

  dimension_group: date_key {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }
  dimension: date_pk  {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${date_key_date} ;;
  }

  measure: target_1party {
    type: sum
    sql: ${TABLE}.target_1party ;;
    value_format: "#,##0"
    hidden: yes
  }


  measure: target_3party {
    type: sum
    sql: ${TABLE}.target_3party ;;
    value_format: "#,##0"
    hidden: yes
  }

  dimension_group: current_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: current_date ;;
  }

  #dimension: is_current_month {
  # type: string
  #sql: case when month(${activity_month}) = month(current_date)
  #and year(${activity_year}) = year(current_date) then 'Yes' else 'No' end;;
  #}

  dimension: is_current_month {
    type: string
    sql: case when ${date_key_month} = ${current_date_month}
      then 'Yes' else 'No' end;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
