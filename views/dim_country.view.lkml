view: dim_country {
  sql_table_name: BI_New.Dim_Country ;;

  dimension: continent {
    type: string
    sql: ${TABLE}.Continent ;;
  }

  dimension: country_code {
    label: "Country Code"
    type: string
    sql: ${TABLE}.Country_Code ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: country_name {
    label: "Country Name"
    type: string
    sql: ${TABLE}.Country_Name ;;
  }

  dimension_group: db_create {
    hidden: yes
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
    hidden: yes
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

  dimension: region {
    label: "Region"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: ri_info {
    hidden: yes
    type: string
    sql: ${TABLE}.RI_Info ;;
  }


}
