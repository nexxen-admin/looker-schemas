view: account_exec {
  sql_table_name: DIM.USER_PROFILE_VIEW ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.USERID ;;
  }

  dimension: firstname {
    type: string
    hidden: yes
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    hidden: yes
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: account_exec_name {
    type: string
    label: "Account Manager Name"
    view_label: "Insertion Order"
    description: "The name of the Account Manager associated with the Insertion Order.
    Supports accounts alongside Account Executives and Delivery, running point on things like overall Account Coordination, Campaign Trafficking/Reporting, and Billing"
    sql: ${lastname} || ', ' || ${firstname} ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.account_exec_name
  }

}

view: launched_by_userprofile {
  sql_table_name: DIM.USER_PROFILE_VIEW ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.USERID ;;
  }

  dimension: firstname {
    type: string
    hidden: yes
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    hidden: yes
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: launched_by {
    type: string
    label: "Launched By"
    view_label: "Campaign"
    description: "Name of the platform user who launched the campaign."
    sql: ${lastname} || ', ' || ${firstname} ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.launched_by
  }

}

view: fm_createdby_userprofile {
  sql_table_name: DIM.USER_PROFILE_VIEW ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.USERID ;;
  }

  dimension: firstname {
    type: string
    hidden: yes
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    hidden: yes
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: fm_createdby {
    type: string
    label: "Created By"
    view_label: "Flight Media"
    description: "Name of the platform user who created the Flight Media"
    sql: ${lastname} || ', ' || ${firstname} ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.fm_createdby
  }

}
