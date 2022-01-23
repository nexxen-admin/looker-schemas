view: dim_publisher {
  sql_table_name: BI_New.V_Dim_Publisher ;;

  dimension: bizdev_owner_id {
    type: number
    sql: ${TABLE}.Bizdev_Owner_ID ;;
    hidden: yes
  }

  dimension: bizdev_owner_key {
    type: number
    sql: ${TABLE}.Bizdev_Owner_Key ;;
    hidden: yes
  }

  dimension: cogs_type {
    type: string
    sql: ${TABLE}.COGS_Type ;;

  }

  dimension: company {
    type: string
    sql: ${TABLE}.Company ;;

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
  dimension: seller_type {
    type: string
    sql: ${TABLE}.seller_type ;;
  }

  dimension: signup_step {
    type: string
    sql: ${TABLE}.signup_step ;;
  }

  dimension: unruly_seller_id {
    type: string
    sql: ${TABLE}.unruly_seller_id ;;
  }
  dimension: r1_seller_id {
    type: string
    sql: ${TABLE}.r1_seller_id ;;
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

  dimension: integration_type {
    label: "Integration Type"
    type: string
    sql: ${TABLE}.Integration_Type ;;
  }

  dimension: is_1st_party {
    label: "Is 1st Party"
    type: yesno
    sql: ${TABLE}.Is_1st_Party ;;
    hidden: yes
  }

  dimension: is_network {
    type: yesno
    sql: ${TABLE}.Is_Network ;;
    hidden: yes
  }

  dimension: ops_owner_id {
    type: number
    sql: ${TABLE}.OPS_Owner_ID ;;
    hidden: yes
  }

  dimension: ops_owner_key {
    type: number
    sql: ${TABLE}.OPS_Owner_Key ;;
    hidden: yes
  }

  dimension: pub_cat_list {
    type: string
    sql: ${TABLE}.PUB_Cat_list ;;
    hidden: yes
  }

  dimension_group: pub_craeted {
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
    sql: ${TABLE}.PUB_Craeted_ON ;;
    hidden: yes
  }

  dimension: pub_id {
    label: "Pub ID"
    type: string
    sql: ${TABLE}.PUB_ID ;;
  }

  dimension: pub_key {
    type: number
    sql: ${TABLE}.PUB_Key ;;
    hidden: yes
  }

  dimension: pub_name {
    label: "Publisher Name"
    type: string
    sql: ${TABLE}.PUB_Name ;;
  }

  dimension_group: pub_updated {
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
    sql: ${TABLE}.PUB_Updated_ON ;;
    hidden: yes
  }

  dimension: publisher_account_type {
    label: "Publisher Account Type"
    type: string
    sql: ${TABLE}.Publisher_Account_Type ;;
  }


  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [pub_name]
    hidden: yes
  }
}
