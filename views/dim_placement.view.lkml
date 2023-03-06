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
    label: "COPPA"
    type: number
    description: "Flag indicating if this request is subject to the COPPA (Children’s Online Privacy Protection Act) regulations established by the USA FTC,
                  where 0 = no, 1 = yes"
    sql: ${TABLE}.Coppa ;;
  }

  dimension: created {
    label: "Create Date"
    type: date
    description: "Date when the placement was created"
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
    description: "Determines whether the placement belongs to a first party SSP"
    type: yesno
    sql: ${TABLE}.Is_1st_Party ;;
  }

  dimension: lda {
    label: "LDA"
    type: number
    sql: ${TABLE}.Lda ;;
  }

  dimension: media_type {
    label: "Media Type"
    description: "Specifies where the placement is located - app or site"
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: placement_id {
    label: "Placement ID"
    description: "Identification for a placement"
    type: string
    sql: ${TABLE}.Placement_ID ;;
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
    hidden: yes
  }

  dimension: placement_name {
    label: "Placement"
    description: "A position of an ad inside a domain"
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
    description: "Maximum time in milliseconds the exchange allows for bids to be received to avoid timeout. "
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
