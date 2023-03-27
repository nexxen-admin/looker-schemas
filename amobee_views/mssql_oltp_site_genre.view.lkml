view: site_genre {
  sql_table_name: dbo.site_genre (NOLOCK) ;;

  dimension: site_genre_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.site_genre_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Site Genre"
    description: "Genre associated with the Placement."
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.site_genre
  }
}
