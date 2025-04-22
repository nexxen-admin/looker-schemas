view: daily_bt_acquisition {
  sql_table_name: DATAOPS.DAILY_BT_ACQUISITION ;;

  dimension: pk_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.PK_ID ;;
  }

  dimension: cookies {
    type: number
    hidden: yes
    sql: ${TABLE}.COOKIES ;;
  }

  measure: sum_cookies {
    type: sum
    label: "Cookies"
    description: "The total number of cookies associated with a BT segment."
    view_label: "Acquisition Metrics"
    sql: ${cookies} ;;
  }

  dimension: is_s2s {
    type: number
    hidden: no
    label: "Is Server to Server"
    description: "A yes/no indicator if the integration with the data provider is server to server."
    view_label: "Acquisition Facets"
    sql: ${TABLE}.IS_S2S ;;
  }
  dimension_group: acqdate{
    type: time
    label: "Acquisition"
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time of the data acquisition event"
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension: keydate {
    type: date
    view_label: "Dates"
    label: "UTC Date"
    description: "The date of the BT acquisition in UTC."
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension: processingid {
    type: string
    hidden: yes
    sql: ${TABLE}.PROCESSINGID ;;
  }

  dimension: operation {
    type: string
    label: "Data Vendor Operation"
    hidden: yes
    view_label: "Acquisition Facets"
    sql: ${TABLE}.OPERATION ;;
  }

  dimension: id_type {
    type: string
    label: "User ID Type"
    hidden: yes
    view_label: "Acquisition Facets"
    sql: ${TABLE}.ID_TYPE ;;
  }

  dimension: aws_region {
    type: string
    label: "AWS Region"
    description: "Data was ingested in this AWS region."
    view_label: "Acquisition Facets"
    sql: public.f_awsregion(${TABLE}.AWSREGION) ;;
  }

  dimension: reach {
    type: number
    hidden: yes
    sql: ${TABLE}.REACH ;;
  }

  measure: sum_reach {
    type: sum
    label: "Reach"
    description: "The total number of unique users within a BT segment."
    view_label: "Acquisition Metrics"
    sql: ${reach};;
  }


  dimension: retargeting_attribute_id {
    type: string
    label: "Retargeting Attribute ID - BT Acquisition"
    hidden: yes
    sql: ${TABLE}.RETARGETING_ATTRIBUTE_ID ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
