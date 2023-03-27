view: mssql_oltp_publisher_competitive_separation_rule_exists {
  label: "Publisher Competitive Separation Rule Exists"
  derived_table: {
    sql:
      SELECT
        pcsr.partner_id,
        COUNT(pcsr.publisher_competitive_separation_rule_id) AS count_active_rules
      FROM publisher_competitive_separation_rule pcsr (NOLOCK)
      WHERE pcsr.active = 1
      GROUP BY pcsr.partner_id
    ;;
  }

  dimension: partner_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: count_active_rules {
    type: number
    hidden: yes
    sql: ${TABLE}.count_active_rules ;;
  }

  dimension: rule_exists {
    type: yesno
    label: "Competitive Separation Rules"
    sql: ${count_active_rules} > 0 ;;
  }
}
