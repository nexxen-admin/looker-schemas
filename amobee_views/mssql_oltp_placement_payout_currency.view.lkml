view: placement_payout_currency {
  sql_table_name: dbo.currency (NOLOCK) ;;

  dimension: currency_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.currency_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: currency_abbreviation {
    type: string
    view_label: "Placement Payout Schedule"
    label: "Payout Currency"
    description: "The Publisher's (supply) currency."
    sql: ${TABLE}.currency_abbreviation ;;
  }
}
