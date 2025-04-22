view: partner_country {
  sql_table_name: dbo.country (NOLOCK) ;;

  dimension: country_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Publisher"
    label: "Publisher Country"
    description: "The country of the office of the publisher."
    sql: ${TABLE}.description ;;
  }
}
