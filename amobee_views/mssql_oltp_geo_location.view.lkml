view: mssql_oltp_geo_location {
  sql_table_name: dbo.geo_location (NOLOCK) ;;

  dimension: geo_location_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.geo_location_id ;;
  }

  dimension: region {
    type: string
    label: "Region"
    view_label: "Campaign"
    sql: COALESCE(${TABLE}.region, '') ;;
  }

}
