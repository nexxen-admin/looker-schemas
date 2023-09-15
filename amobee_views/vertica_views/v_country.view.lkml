view: v_customer_country {
  sql_table_name: DIM.COUNTRY ;;

  dimension: country_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.COUNTRY_ID ;;
  }

  dimension: abbreviation {
    type: string
    hidden: yes
    sql: ${TABLE}.ABBREVIATION ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: country_description {
    type: string
    label: "Customer Country"
    description: "Name of Customer's Country."
    view_label: "Customer"
    sql: ${TABLE}.COUNTRY_DESCRIPTION ;;
  }

  dimension: culture {
    type: string
    hidden: yes
    sql: ${TABLE}.CULTURE ;;
  }

  dimension: max_min_code {
    type: string
    hidden: yes
    sql: ${TABLE}.MAX_MIN_CODE ;;
  }


}
