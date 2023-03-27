view: mssql_oltp_advertiser {
  sql_table_name: dbo.advertiser (NOLOCK) ;;
  label: "Advertiser"

  dimension: adveriser_id {
    primary_key: yes
    type: number
    description: "The system ID of the Advertiser."
    sql: ${TABLE}.advertiser_id ;;
    value_format_name: id
  }

  dimension: advertiser_name {
    type: string
    label: "Advertiser"
    description: "The name of the Advertiser."
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: active {
    type: yesno
    description: "A yes/no indicator if the Advertiser is currently active."
    sql: ${TABLE}.actve = 1 ;;
  }

  dimension_group: advertiser_createdon {
    type: time
    label: "Advertiser Created Date"
    description: "The date the advertiser was created in the system."
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.createdon ;;
  }

  dimension: customer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }
}
