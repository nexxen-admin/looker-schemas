# The name of this view in Looker is "Advertiser Dim"
view: advertiser_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: bi.AdvertiserDim ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Adv ID" in Explore.

  dimension: adv_id {
    type: number
    sql: ${TABLE}.AdvId ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.AdvertiserName ;;
  }

  dimension: csm {
    type: string
    sql: ${TABLE}.CSM ;;
  }

  dimension: csmteam {
    type: string
    sql: ${TABLE}.CSMTeam ;;
  }

  dimension: managing_office_name {
    type: string
    sql: ${TABLE}.ManagingOfficeName ;;
  }

  measure: count {
    type: count
    drill_fields: [managing_office_name, advertiser_name]
  }
}
