view: action_pixel {
  sql_table_name: DIM.ACTION_PIXEL ;;

  dimension: action_pixel_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.ACTION_PIXEL_ID ;;
  }

  dimension: active {
    type: yesno
    label: "Action Pixel Active"
    description: "A yes/no indicator of whether the action pixel is active."
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGE_SOURCE ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOMER_ID ;;
  }

  dimension: lookback_hours {
    type: number
    label: "Lookback Hours"
    description: "Conversions for users who were exposed to an ad are only counted if desired action falls within a specified time period since ad exposure."
    sql: ${TABLE}.LOOKBACK_HOURS ;;
  }

  dimension: pixel_description {
    type: string
    label: "Action Pixel Description"
    description: "Extended details of the action pixel."
    sql: ${TABLE}.PIXEL_DESCRIPTION ;;
  }

  dimension: pixel_name {
    type: string
    label: "Action Pixel"
    description: "Name of the Action Pixel"
    sql: ${TABLE}.PIXEL_NAME ;;
  }

  dimension: pixel_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PIXEL_TYPE_ID ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [action_pixel_id, pixel_name]
  }
}
