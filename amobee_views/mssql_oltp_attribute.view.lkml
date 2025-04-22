view: mssql_oltp_attribute {
  sql_table_name: dbo.attribute (NOLOCK) ;;

  dimension: attribute_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.attribute_id ;;
  }

  dimension: description {
    type: string
    view_label: "Campaign"
    label: "Targeting Type"
    sql: CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN COALESCE(REPLACE(${mssql_oltp_expression_document_plain.expression_group_type},'_',' '), '')
    ELSE COALESCE( ${TABLE}.description, '') END ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
