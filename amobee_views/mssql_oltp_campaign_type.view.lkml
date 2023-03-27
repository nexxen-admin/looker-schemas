view: mssql_oltp_campaign_type {
  sql_table_name: dbo.campaign_type (NOLOCK) ;;
  label: "Campaign"

  dimension: campaign_type_id {
    type: number
    primary_key: yes
    label: "Campaign Type ID"
    sql: ${TABLE}.campaign_type_id ;;
    value_format_name: id
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
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

  dimension: description {
    type: string
    label: "Campaign Type"
    sql: ${TABLE}.description ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }
}
