view: opt_country {
view_label: "RTA Rules Present"


  derived_table: {
    sql: SELECT
    country_id,
    description,
    abbreviation
    from an_main..country
        ;;
  }

dimension: country_id {
  type: number
  label: "Country ID"
  description: "The internal system id of the country."
  hidden: no
  sql: ${TABLE}.country_id ;;
  value_format_name: id
}

  dimension: country_description {
    type: string
    label: "Country Name"
    sql: ${TABLE}.description ;;
  }

  dimension: country_abbreviation {
    type: string
    label: "Country Abbreviation"
    sql: ${TABLE}.abbreviation ;;
  }

}
