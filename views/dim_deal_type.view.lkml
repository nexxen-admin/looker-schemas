view: dim_deal_type {
  sql_table_name: BI_New.V_Dim_Deal_Type ;;

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

  dimension: deal_type_id {
    type: number
    sql: ${TABLE}.Deal_Type_ID ;;
    hidden: yes
  }

  dimension: deal_type_key {
    type: number
    sql: ${TABLE}.Deal_Type_Key ;;
    hidden: yes
  }

  dimension: deal_type_name {
    label: "Deal Type"
    description: "Describe the type of the deal ,when a request is not associated to a
    deal the Type Value will be Unknown "
    type: string
    sql: ${TABLE}.Deal_Type_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [deal_type_name]
    hidden: yes
  }
}
