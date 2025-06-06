view: Molson_Core_HEM_Statistics {
  derived_table: {
    sql:
    select HEM_File_Version,
       Graph_Run_Date,
       Is_Reportable,
       Create_Time,
       Update_Time,

       File_HEMS,
       Distinct_File_Hems,
       Device_Matched_HEMs,
       Household_Matched_HEMs,
       Person_Matched_HEMs,
       Cookie_Count,
       Cookie_Persons,
       Cookie_Households,
       Device_Count,
       Device_Persons,
       Device_Households,
       RampID_Count,
       RampID_Persons,
       RampID_Households,
       IP_Count,
       IP_Persons,
       IP_Households,
       UID_Count,
       UID_Persons,
       UID_Households,
       Total_Graph_HEMs

    from BI.SVC_HEMs_Match_Statistics
       ;;
  }


  dimension: HEM_File_Version {
    type: string
    sql: ${TABLE}."HEM_File_Version" ;;
  }

  dimension: Graph_Run_Date {
    type: string
    sql: ${TABLE}."Graph_Run_Date" ;;
  }

  dimension: Is_Reportable {
    type: string
    sql: ${TABLE}."Is_Reportable" ;;
  }

  dimension: Create_Time {
    type: string
    sql: ${TABLE}."Create_Time" ;;
  }

  dimension: Update_Time {
    type: string
    sql: ${TABLE}."Update_Time" ;;
  }


  # measures

  measure: File_HEMS {
    type: sum
    sql: ${TABLE}."File_HEMS";;
    value_format: "#,##0"
  }

  measure: Distinct_File_Hems {
    type: average
    sql: ${TABLE}.Distinct_File_Hems ;;
    value_format: "#,##0"
    label: "Distinct_File_Hems"
  }

  measure: Device_Matched_HEMs {
    type: average
    sql: ${TABLE}.Device_Matched_HEMs ;;
    value_format: "#,##0"
  }

  measure: Household_Matched_HEMs {
    type: average
    sql: ${TABLE}.Household_Matched_HEMs ;;
    value_format: "#,##0"
  }

  measure: Person_Matched_HEMs {
    type: average
    sql: ${TABLE}.Person_Matched_HEMs ;;
    value_format: "#,##0"
  }

  measure: Cookie_Count {
    type: average
    sql: ${TABLE}.Cookie_Count ;;
    value_format: "#,##0"
  }

  measure: Cookie_Persons {
    type: average
    sql: ${TABLE}.Cookie_Persons ;;
    value_format: "#,##0"
  }
  measure: Cookie_Households {
    type: average
    sql: ${TABLE}.Cookie_Households ;;
    value_format: "#,##0"
  }
  measure: Device_Count {
    type: average
    sql: ${TABLE}.Device_Count ;;
    value_format: "#,##0"
  }
  measure: Device_Persons {
    type: average
    sql: ${TABLE}.Device_Persons ;;
    value_format: "#,##0"
  }
  measure: Device_Households {
    type: average
    sql: ${TABLE}.Device_Households ;;
    value_format: "#,##0"
  }
  measure: RampID_Count {
    type: average
    sql: ${TABLE}.RampID_Count ;;
    value_format: "#,##0"
  }
  measure: RampID_Persons {
    type: average
    sql: ${TABLE}.RampID_Persons ;;
    value_format: "#,##0"
  }
  measure: RampID_Households {
    type: average
    sql: ${TABLE}.RampID_Households ;;
    value_format: "#,##0"
  }
  measure: IP_Count {
    type: average
    sql: ${TABLE}.IP_Count ;;
    value_format: "#,##0"
  }
  measure: IP_Persons {
    type: average
    sql: ${TABLE}.IP_Persons ;;
    value_format: "#,##0"
  }

  measure: IP_Households {
    type: average
    sql: ${TABLE}.IP_Households ;;
    value_format: "#,##0"
  }
  measure: UID_Count {
    type: average
    sql: ${TABLE}.UID_Count ;;
    value_format: "#,##0"
  }
  measure: UID_Persons {
    type: average
    sql: ${TABLE}.UID_Persons ;;
    value_format: "#,##0"
  }
  measure: UID_Households {
    type: average
    sql: ${TABLE}.UID_Households ;;
    value_format: "#,##0"
  }
  measure: Total_Graph_HEMs {
    type: average
    sql: ${TABLE}.Total_Graph_HEMs ;;
    value_format: "#,##0"
  }



  set: detail {
    fields: [
      HEM_File_Version,
       Graph_Run_Date,
       Is_Reportable,
       Create_Time,
       Update_Time,

       File_HEMS,
       Distinct_File_Hems,
       Device_Matched_HEMs,
       Household_Matched_HEMs,
       Person_Matched_HEMs,
       Cookie_Count,
       Cookie_Persons,
       Cookie_Households,
       Device_Count,
       Device_Persons,
       Device_Households,
       RampID_Count,
       RampID_Persons,
       RampID_Households,
       IP_Count,
       IP_Persons,
       IP_Households,
       UID_Count,
       UID_Persons,
       UID_Households,
       Total_Graph_HEMs
    ]
  }
}
