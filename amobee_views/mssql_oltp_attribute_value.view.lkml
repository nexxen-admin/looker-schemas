view: mssql_oltp_attribute_value {
  sql_table_name: dbo.attribute_value (NOLOCK) ;;

  dimension: attribute_value_id {
    type: number
    primary_key: yes
    view_label: "Campaign"
    label: "Segment ID"
    sql: CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN COALESCE(${TABLE}.attribute_value_id, ${mssql_oltp_expression.expression_value_id})
    ELSE ${TABLE}.attribute_value_id END ;;
    value_format_name: id
  }

  dimension: attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_id ;;
  }

  dimension: description {
    type: string
    view_label: "Campaign"
    label: "Segment Name"
    sql: CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN COALESCE(${TABLE}.description, ${mssql_oltp_expression_document_plain.expression_group_item}, '')
    ELSE COALESCE( ${TABLE}.description, '') END ;;
  }

  dimension: platform {
    type: string
    view_label: "Campaign"
    label: "Platform"
    description: "Platform(s) selected in the Campaign > Targeting > Technology for targeting in the campaign."
    sql: CASE WHEN ${attribute_id} = 8 THEN ${TABLE}.description ELSE '' END ;;
  }

  dimension: max_range {
    type: number
    hidden: yes
    sql: ${TABLE}.max_range ;;
  }

  dimension: code {
    type: string
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
