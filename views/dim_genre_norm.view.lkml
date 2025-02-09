view: dim_genre_norm {
  sql_table_name: BI_New.Dim_Genre_Norm ;;
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:

  dimension: Genre_Norm {
    label: "Genre"
    description: "The genre of the ad"
    type: string
    sql: split_part(btrim(${TABLE}.Genre_Norm,'[]'),',',1) ;;
    drill_fields: [dim_publisher.publisher_name]
    hidden: yes
  }

  dimension: Genre_Norm_Full_Name {
    label: "Genre"
    description: "The genre of the ad"
    type: string
    sql: CASE ${Genre_Norm} WHEN 'reality tv' THEN 'Reality TV'
        WHEN 'lgbtq' THEN 'LGBTQ'
        WHEN 'business & finance' THEN 'Business & Finance'
        WHEN 'food & cooking' THEN 'Food & Cooking'
        WHEN 'sci-fi & fantasy' THEN 'Sci-fi & Fantasy'
        ELSE CONCAT(UPPER(LEFT(${Genre_Norm}, 1)), SUBSTRING(${Genre_Norm}, 2))
        END  ;;
    drill_fields: [dim_publisher.publisher_name]
  }

  dimension: Sub_Genre {
    label: "Sub Genre"
    type: string
    sql: split_part(btrim(${TABLE}.Genre_Norm,'[]'),',',2) ;;
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
