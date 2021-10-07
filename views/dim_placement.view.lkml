view: dim_placement {
  sql_table_name: BI_New.v_Dim_Placement ;;

  dimension: bcat {
    type: string
    sql: ${TABLE}.Bcat ;;
    hidden: yes
  }

  dimension: bidfloor_opti {
    type: number
    sql: ${TABLE}.Bidfloor_Opti ;;
    hidden: yes
  }

  dimension: cat {
    type: string
    sql: ${TABLE}.Cat ;;
    hidden: yes
  }

  dimension: commission_opti {
    type: number
    sql: ${TABLE}.Commission_Opti ;;
    hidden: yes
  }

  dimension: coppa {
    label: "Coppa"
    type: number
    sql: ${TABLE}.Coppa ;;
  }

  dimension_group: created {
    label: "Crated at"
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
    sql: ${TABLE}.Created_At ;;

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

  dimension: default_app_name {
    type: string
    sql: ${TABLE}.Default_App_Name ;;
    hidden: yes
  }

  dimension: default_domain_bundle {
    type: string
    sql: ${TABLE}.Default_Domain_Bundle ;;
    hidden: yes
  }

  dimension: external_source_id {
    type: string
    sql: ${TABLE}.External_Source_ID ;;
    hidden: yes
  }

  dimension: filter_domain_bundle {
    label: "Filter Domain"
    type: string
    sql: ${TABLE}.Filter_Domain_Bundle ;;
  }

  dimension: is_1st_party {
    label: "Is 1st Party"
    type: yesno
    sql: ${TABLE}.Is_1st_Party ;;
  }

  dimension: lda {
    label: "Ida"
    type: number
    sql: ${TABLE}.Lda ;;
  }

  dimension: media_type {
    label: "Media Type"
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: placement_id {
    label: "Placement ID"
    type: string
    sql: ${TABLE}.Placement_ID ;;
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
    hidden: yes
  }

  dimension: placement_name {
    label: "Placement Name"
    type: string
    sql: ${TABLE}.Placement_Name ;;
  }

  dimension: pub_ts_id {
    type: string
    sql: ${TABLE}.PUB_TS_ID ;;
    hidden: yes
  }

  dimension: pub_ts_key {
    type: number
    sql: ${TABLE}.PUB_TS_Key ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension_group: snapshot_time_utc {
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
    sql: ${TABLE}.Snapshot_Time_UTC ;;
    hidden: yes
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: tmax {
    label: "Tmax"
    type: number
    sql: ${TABLE}.Tmax ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.Updated_At ;;
    hidden: yes
  }

  dimension: vpaid_support {
    type: number
    sql: ${TABLE}.Vpaid_Support ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [placement_name, default_app_name]
    hidden: yes
  }
}
