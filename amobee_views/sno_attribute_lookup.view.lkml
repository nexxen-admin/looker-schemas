view: attribute_lookup_platformid {
  sql_table_name: RAWDB.ATTRIBUTE_LOOKUP;;


  dimension: attr_id {
  type: number
  hidden: yes
  primary_key: yes
  sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
}

dimension: description {
  type: string
  hidden: yes
  sql: ${TABLE}.description ;;
}

}

view: attribute_lookup_ageid {
  sql_table_name: RAWDB.ATTRIBUTE_LOOKUP;;


  dimension: attr_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

}

view: attribute_lookup_browserid {
  sql_table_name: RAWDB.ATTRIBUTE_LOOKUP;;


  dimension: attr_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

}

view: attribute_lookup_deviceid {
  sql_table_name: RAWDB.ATTRIBUTE_LOOKUP;;


  dimension: attr_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

}

view: attribute_lookup_languageid {
  sql_table_name: RAWDB.ATTRIBUTE_LOOKUP;;


  dimension: attr_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

}

view: attribute_lookup_genderid {
  sql_table_name: RAWDB.ATTRIBUTE_LOOKUP;;


  dimension: attr_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ATTRIBUTE_VALUE_ID ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

}
