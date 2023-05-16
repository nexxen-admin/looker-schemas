view: dim_a_domain {
  sql_table_name: BI_New.V_Dim_A_Domain ;;

  dimension: a_domain {
    label: "A Domain"
    description: "Advertiser domain who sent the Creative "
    type: string
    sql: ${TABLE}.A_Domain ;;
  }

  dimension: advertiser_image {
    type: string
    sql: ${a_domain} ;;
    html:
              {% if a_domain._value == "apple.com" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/0/01/Flag_of_California.svg" height="170" width="255">
              {% elsif a_domain._value == "expedia.com" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_New_York.svg/1200px-Flag_of_New_York.svg.png" height="170" width="255">
              {% elsif a_domain._value == "amazon.com" %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Flag_of_Colorado.svg/255px-Flag_of_Colorado.svg.png" height="170" width="255">
              {% elsif a_domain._value == "mcdonalds"%}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Illinois.svg/1200px-Flag_of_Illinois.svg.png" height="170" width="255">
              {% else %}
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png" height="170" width="170">
              {% endif %} ;;
  }

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
    hidden: yes
  }

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
