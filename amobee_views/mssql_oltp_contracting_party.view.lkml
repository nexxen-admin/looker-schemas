view: contracting_party {
  sql_table_name: dbo.contracting_party (NOLOCK) ;;

  dimension: contracting_party_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.contracting_party_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Publisher"
    label: "Contracting Party"
    description: "The name of the entity which contracted with the publisher."
    sql: ${TABLE}.description ;;
  }
}
