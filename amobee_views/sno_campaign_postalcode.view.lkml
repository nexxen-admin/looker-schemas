view: campaign_postalcode {
  label: "Campaign"
  derived_table: {
    sql: SELECT
          campaign_id,
          postalcode_attribute_id,
          postalcode_attribute_name,
          LISTAGG( DISTINCT postalcode, ', ') as postalcode
         FROM dim.campaign_postalcode
         GROUP BY campaign_id, postalcode_attribute_id, postalcode_attribute_name ;;
  }


  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: postalcode_attribute_id {
    type: number
    label: "Postalcode Attribute ID"
    sql: ${TABLE}.POSTALCODE_ATTRIBUTE_ID ;;
    value_format_name: id
  }

  dimension: postalcode_attribute_name {
    type: string
    label: "Postalcode Attribute Name"
    sql: ${TABLE}.POSTALCODE_ATTRIBUTE_NAME ;;
  }

  dimension: postalcode {
    type: string
    label: "Postalcode List"
    sql: ${TABLE}.POSTALCODE ;;
  }

}
