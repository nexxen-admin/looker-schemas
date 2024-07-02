# The name of this view in Looker is "Dim Sfdb User Opportunity Owner"
view: dim_sfdb_user_opportunity_owner {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_user_opportunity_owner ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Opp Owner Company Name" in Explore.

  dimension: opp_owner_company_name {
    type: string
    sql: ${TABLE}.opp_owner_company_name ;;
    hidden: yes
  }

  dimension: opp_owner_division {
    type: string
    sql: ${TABLE}.opp_owner_division ;;
    hidden: yes
  }

  dimension: opp_owner_full_name {
    type: string
    label: "Opportunity Owner Name"
    sql: ${TABLE}.opp_owner_full_name ;;
  }

  dimension: opp_owner_id {
    type: string
    sql: ${TABLE}.opp_owner_id ;;
    hidden: yes
  }

  dimension: opp_owner_user_name {
    type: string
    sql: ${TABLE}.opp_owner_user_name ;;
    hidden: yes
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [opp_owner_full_name, opp_owner_user_name, opp_owner_company_name]
  }
}
