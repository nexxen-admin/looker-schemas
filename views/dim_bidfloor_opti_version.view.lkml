# The name of this view in Looker is "Dim Bidfloor Opti Version"
view: dim_bidfloor_opti_version {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.dim_Bidfloor_Opti_Version ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Bidfloor Opti Version" in Explore.

  dimension: bidfloor_opti_version {
    type: string
    sql: ${TABLE}.Bidfloor_Opti_Version ;;
  }

  dimension: bidfloor_opti_status {
    type: string
    sql: case when ${TABLE}.Bidfloor_Opti_Version != 'no_opti' then 'opti' else ${TABLE}.Bidfloor_Opti_Version end ;;
  }

  dimension: bidfloor_opti_version_key {
    type: number
    sql: ${TABLE}.Bidfloor_Opti_Version_key ;;
    hidden: yes
  }

  dimension_group: db_create {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }
  measure: count {
    type: count
  }
}
