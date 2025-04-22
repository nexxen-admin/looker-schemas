view: sno_attribute_value_metrics_country {
  view_label: "Retargeting Attribute Country-Level Facets"
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
      label: "Country"
      description: "Retargeting attribute metrics country"
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
