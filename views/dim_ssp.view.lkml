view: dim_ssp {
  sql_table_name: BI_New.V_Dim_SSP ;;

  dimension: adstxt_hash {
    type: string
    sql: ${TABLE}.ADstxt_Hash ;;
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

  dimension: gp_id {
    label: "GP ID"
    description: "A key that the RhythmOne platform reporting use to calculate fields"
    type: string
    sql: ${TABLE}.GP_ID ;;
  }

  dimension: is_1st_party {
    label: "Is 1st Party Supply"
    description: "The SSP is first party - Tremor, Unruly or Amobee"
    type: yesno
    sql: ${TABLE}.Is_1st_Party ;;
  }

  dimension: Supply_source {
    label: "Supply Source"
    description: "Specified whether the SSP source is first or third party"
    type: string
    sql: case when ${is_1st_party} = 'YES' THEN '1P'
        ELSE '3P' END;;

  }

  dimension: platform_fee_cpm {
    label: "Platform Fee CPM"
    description: "The average cost the Platform takes per 1000 impressions"
    type: number
    sql: ${TABLE}.Platform_Fee_CPM ;;
  }

  dimension: platform_fee_spend {
    label: "Platform Fee Spend%"
    type: number
    sql: ${TABLE}.Platform_Fee_Spend ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: ssp_id {
    label: "SSP ID"
    description: "The SSP identification"
    type: string
    sql: ${TABLE}.SSP_ID ;;
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
    hidden: yes
  }

  dimension: ssp_name {
    label: "RX SSP Name"
    description: "SSP name as it is written in the RX"
    type: string
    sql: ${TABLE}.SSP_Name ;;
  }

  dimension: ssp_name_display {
    type: string
    label: "SSP"
    description: "SSP name"
    sql: ${TABLE}.SSP_Name_Display ;;

  }

  measure: count {
    type: count
    drill_fields: [ssp_name]
    hidden: yes
  }
}
