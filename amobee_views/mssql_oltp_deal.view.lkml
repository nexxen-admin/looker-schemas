view: mssql_oltp_deal {
  label: "Deal"
  sql_table_name: dbo.deal (NOLOCK) ;;

  dimension: id {
    type: number
    primary_key: yes
    label: "Deal ID"
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: seller_campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.seller_campaign_id ;;
  }

  dimension: buyer_campaign_id {
    type: number
    label: "Buyer Campaign ID"
    sql: ${TABLE}.buyer_campaign_id ;;
    value_format_name: id
  }

  dimension: deal_status_id {
    type: number
    hidden: yes
    label: "Deal Status ID"
    sql: ${TABLE}.deal_status_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    label: "Active"
    sql: ${TABLE}.active = 1 ;;
  }
}
