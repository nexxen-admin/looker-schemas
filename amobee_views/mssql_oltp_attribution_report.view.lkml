view: mssql_oltp_attribution_report {

  sql_table_name: dbo.attribution_report (NOLOCK) ;;

  dimension: attribution_report_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.attribution_report_id ;;
    value_format_name: id
  }

  dimension: entity_id {
    type: number
    hidden: yes
    sql: ${TABLE}.entity_id ;;
  }

  dimension: status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.status_id ;;
  }

  dimension: attribution_enabled {
    type: string
    label: "Attribution Generated"
    view_label: "Campaign"
    sql: case when ${TABLE}.attribution_report_id is not null then 'Yes' else 'No' end ;;
  }
}
