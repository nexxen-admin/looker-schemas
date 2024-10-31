view: dim_dsp_seat {
  sql_table_name: BI_New.V_Dim_DSP_Seat ;;

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

  dimension: dsp_id {
    type: string
    sql: ${TABLE}.DSP_ID ;;
    hidden: yes
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.DSP_Name ;;
    hidden: yes
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: Is_1st_Party_Demand {
    type: yesno
    label: "Is 1st Party Demand"
    description: "The demand is from within the company, hence Amobee or Tremor"
    sql: ${dim_revenue_type.revenue_type_name} = 'firstparty';;
  }

  dimension: 1st_Party_Demand_Desc {
    type: string
    label: "1st Party Demand Desc"
    sql: case when  ${TABLE}.Is_1st_Party_Demand=true then 'Yes' else 'No' end;;
    hidden: yes

  }

  dimension: seat_id {
    label: "Seat"
    type: string
    sql: ${TABLE}.Seat_ID ;;
    hidden: yes

  }

  dimension: seat_key {
    type: number
    sql: ${TABLE}.Seat_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [dsp_name]
    hidden: yes
  }
}
