view: mssql_oltp_partner_data_controls {
  sql_table_name: dbo.partner_data_controls (NOLOCK) ;;
  label: "Publisher Data Controls"

  dimension: partner_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: explicit_geo {
    type: yesno
    label: "Explicit Geo"
    sql: ${TABLE}.explicit_geo = 1 ;;
  }

  dimension: use_cookies {
    type: yesno
    label: "Use Cookies"
    sql: ${TABLE}.use_cookies = 1 ;;
  }

  dimension: add_trackers {
    type: yesno
    label: "Add Trackers"
    sql: ${TABLE}.add_trackers = 1 ;;
  }

  dimension: permit_third_party_sync {
    type: yesno
    label: "Permit Third Party Sync"
    sql: ${TABLE}.permit_third_party_sync = 1 ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
