view:  mssql_oltp_currency {
  view_label: "Currency"
  sql_table_name: dbo.currency (NOLOCK) ;;

  dimension: currency_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.currency_id ;;
  }

  dimension: currency_name {
    type: string
    label: "Currency"
    sql: ${TABLE}.currency_name ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.partner_currency
  }

  dimension: currency_abbreviation {
    type: string
    label: "Currency Abbreviation"
    sql: ${TABLE}.currency_abbreviation ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.partner_currency_abbreviation
  }
}
