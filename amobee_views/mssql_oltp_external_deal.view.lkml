view: mssql_oltp_external_deal {
  sql_table_name: dbo.external_deal (NOLOCK) ;;
  label: "External Deal"

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: bidder_id {
    type: number
    hidden: yes
    sql: ${TABLE}.bidder_id ;;
  }

  dimension: campaign_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
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
    hidden: yes
    sql: ${TABLE}.changedon ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
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
    hidden: yes
    sql: ${TABLE}.createdon ;;
  }

  dimension: deal_id {
    type: string
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.deal_status_id ;;
  }

  dimension: deal_term_id {
    type: number
    hidden: yes
    sql: ${TABLE}.deal_term_id ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

  dimension: platform_client_external_marketplace_connection_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_external_marketplace_connection_id ;;
  }
}
