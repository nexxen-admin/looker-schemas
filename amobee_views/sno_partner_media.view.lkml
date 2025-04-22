view: partner_media {
  sql_table_name: DIM.PARTNER_MEDIA ;;

  dimension: partner_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.media_id ;;
  }

  dimension: categories {
    type: string
    label: "CLACAT Category ID(s)"
    description: "For ITV inventory only"
    sql: ${TABLE}.categories ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active ;;
  }

}
