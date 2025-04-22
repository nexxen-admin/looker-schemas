view: mssql_oltp_campaign_sitelist {
  label: "Campaign"
  sql_table_name: dbo.campaign_sitelist (NOLOCK) ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension_group: changedon {
    type: time
    timeframes: [raw]
    hidden: yes
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: createdon {
    type: time
    timeframes: [raw]
    hidden: yes
    sql: ${TABLE}.createdon ;;
  }

  dimension: is_targeted {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_targeted = 1 ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
