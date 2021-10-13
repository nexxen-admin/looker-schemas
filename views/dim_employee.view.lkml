view: dim_employee {
  sql_table_name: BI_New.V_Dim_Employee ;;

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

  dimension: employee_id {
    type: number
    sql: ${TABLE}.Employee_ID ;;
    hidden: yes
  }

  dimension: employee_key {
    type: number
    sql: ${TABLE}.Employee_Key ;;
    hidden: yes
  }

  dimension: employee_name {
    label: "Employee"
    type: string
    sql: ${TABLE}.Employee_Name ;;
  }

  dimension: employee_office {
    label: "Employee Office"
    type: string
    sql: ${TABLE}.Employee_Office ;;
  }

  dimension: employee_region {
    label: "Employee Region"
    type: string
    sql: ${TABLE}.Employee_Region ;;
  }

  dimension: role_source {
    label: "Employee Role"
    type: string
    sql: ${TABLE}.Role_Source ;;
  }

  measure: count {
    type: count
    drill_fields: [employee_name]
    hidden: yes
  }
}
