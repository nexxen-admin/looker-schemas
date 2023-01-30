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
  parameter: department_granularity {

    label: "Choose Department"
    description: "For dynamic Department Role."
    type: string
    allowed_value: {value:"Biz Dev"}
    allowed_value: {value:"Pub Ops"}
  }

  filter: department {
    type: string
    #view_label: "PoP"
    label:  "Choose Department"
    description: "For dynamic Department Role."
    sql: ${role_source} ;;


  }

  dimension: dapartment {
    #group_label: "{{_filters['department_granularity']}}"
    label: "{{_filters['department']}}"
    #value_format: "%m/%d"
    sql:  CASE
      WHEN ${department} = 'Biz Dev'
        THEN ${employee_name}
      When ${department} ='Pub Ops'
        THEN ${employee_name}
      ELSE NULL
    END ;;
  }

  dimension: employee_name {
    label: "Employee"
    type: string
    sql: ${TABLE}.Employee_Name ;;
    hidden: yes
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
    sql: case when ${TABLE}.Role_Source = 'pubops' then 'Pub Ops'
              when ${TABLE}.Role_Source = 'bizdev' then'Biz Dev' end;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [employee_name]
    hidden: yes
  }
}
