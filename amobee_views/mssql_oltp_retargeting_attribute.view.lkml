view: mssql_oltp_retargeting_attribute {
  label: "Retargeting Attribute"
  sql_table_name: dbo.retargeting_attribute (NOLOCK) ;;

  dimension: retargeting_attribute_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.retargeting_attribute_id ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.retargeting_attribute_description ;;
  }

  dimension: behavioral_category_id {
    type: number
    hidden: yes
    sql: ${TABLE}.behavioral_category_id ;;
  }
}
