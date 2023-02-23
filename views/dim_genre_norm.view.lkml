view: dim_genre_norm {
  sql_table_name: BI_New.Dim_Genre_Norm ;;
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:

  dimension: Genre_Norm {
    label: "Genre"
    type: string
    sql: split_part(btrim(${TABLE}.Genre_Norm,'[]'),',',1) ;;
  }

  dimension: Genre_Norm_key {
    type: number
    sql: ${TABLE}.Genre_Norm_Key ;;
    hidden: yes
  }

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

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
