view: mssql_oltp_campaign_placement_constraint_spreader {
  sql_table_name: AN_MAIN..campaign_placement_constraint (NOLOCK) ;;
  view_label: "Spreader Control"

  dimension: campaign_placement_constraint_id {
    type: number
    hidden: yes
    value_format_name: id
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: constraint_id {
    type: number
    hidden: yes
    sql: ${TABLE}.constraint_id ;;
  }

  dimension: constraint_type {
    type: string
    label: "Constraint Type"
    sql: {% if mssql_oltp_campaign_placement_constraint_history.spreader_date._in_query %}
            CASE WHEN {% parameter mssql_oltp_campaign_placement_constraint_history.spreader_date %} < GETDATE() THEN ${mssql_oltp_campaign_placement_constraint_history.constraint_type}
                WHEN ${TABLE}.allow_shortfall = 0 THEN 'Hard'
              ELSE 'Soft' END
        {% else %}
            CASE WHEN ${TABLE}.allow_shortfall = 0 THEN 'Hard' ELSE 'Soft' END
        {% endif %} ;;
    suggestions: ["Soft", "Hard"]
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
