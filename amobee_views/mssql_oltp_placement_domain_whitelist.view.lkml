view: placement_domain_whitelist {
  sql_table_name: dbo.placement_domain_whitelist (NOLOCK) ;;
  label: "Placement Domain Whitelist"

  dimension: placement_domain_whitelist_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_domain_whitelist_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: domain_attribute_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.domain_attribute_type_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: url_expression {
    type: string
    label: "Domain"
    description: "Domain which is contained in the placement whitelist."
    sql: ${TABLE}.url_expression ;;
  }

  measure: count {
    type: count_distinct
    label: "Count of Placement Domains"
    description: "The distinct count of placement domains."
    sql: ${placement_domain_whitelist_id} ;;
  }
}
