view: geodata {
  sql_table_name: DIM.GEODATA ;;

  dimension: country {
    type: string
    label: "Country"
    description: "The abbreviation of the country where the impression was served."
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: country_description {
    type: string
    label: "Country Description"
    description: "The description (long name) of the country where the impression was served."
    sql: ${TABLE}.COUNTRY_DESCRIPTION ;;
  }

  dimension: country_id {
    type: string
    hidden: yes
    sql: ${TABLE}.COUNTRY_ID ;;
  }

  dimension: dma {
    type: string
    hidden: yes
    sql: ${TABLE}.DMA ;;
  }

  dimension: dma_description {
    type: string
    label: "DMA"
    description: "The DMA where the impression was served."
    sql: ${TABLE}.DMA_DESCRIPTION ;;
  }

  dimension: geoid {
    type: string
    hidden: yes
    sql: ${TABLE}.GEOID ;;
  }

  dimension: iso_country {
    type: string
    hidden: yes
    sql: ${TABLE}.ISO_COUNTRY ;;
  }

  dimension: iso_region {
    type: string
    hidden: yes
    sql: ${TABLE}.ISO_REGION ;;
  }

  dimension: region {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION ;;
  }

  dimension: region_description {
    type: string
    label: "Region"
    description: "The region where the impression was served."
    sql: ${TABLE}.REGION_DESCRIPTION ;;
  }

  dimension: utcoffset {
    type: string
    hidden: yes
    sql: ${TABLE}.UTCOFFSET ;;
  }

  measure: count {
    type: count
    drill_fields: [country.country_id]
  }
}
