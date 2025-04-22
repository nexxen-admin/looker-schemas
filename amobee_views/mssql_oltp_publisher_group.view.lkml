view: publisher_group {
  sql_table_name: dbo.publisher_group (NOLOCK) ;;

  dimension: publisher_group_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_group_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Publisher"
    label: "Publisher Group"
    description: "A grouping of publisher that are the same entity but have different publishers in the system."
    sql: ${TABLE}.description ;;
  }
}
