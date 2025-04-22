view: mssql_oltp_constraint_spreader {
  sql_table_name: AN_MAIN.."constraint" (NOLOCK) ;;
  view_label: "Spreader Control"

  dimension: constraint_id {
    type: number
    hidden: yes
    sql: ${TABLE}.constraint_id ;;
  }

  dimension: constraint_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.constraint_type_id ;;
  }

  dimension: min_value {
    type: number
    label: "Spreader"
    sql: {% if mssql_oltp_campaign_placement_constraint_history.spreader_date._in_query %}
            CASE WHEN {% parameter mssql_oltp_campaign_placement_constraint_history.spreader_date %} < GETDATE() THEN ${mssql_oltp_campaign_placement_constraint_history.min_value}
                ELSE COALESCE(${TABLE}.min_value, CAST(${mssql_oltp_platform_client_preference.preference_value} AS FLOAT)/100, CAST(${mssql_oltp_global_settings.setting_value} AS FLOAT)/100) END
        {% else %}
            COALESCE(${TABLE}.min_value, CAST(${mssql_oltp_platform_client_preference.preference_value} AS FLOAT)/100, CAST(${mssql_oltp_global_settings.setting_value} AS FLOAT)/100)
        {% endif %} ;;
    value_format_name: percent_2
  }

  dimension: active {
    type: yesno
    label: "Active"
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: is_enabled {
    type: yesno
    label: "Is Enabled"
    hidden: yes
    sql: ${TABLE}.is_enabled = 1 ;;
  }
}
