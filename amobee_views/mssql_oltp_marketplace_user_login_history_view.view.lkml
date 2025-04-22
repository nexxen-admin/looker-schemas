view: marketplace_user_login_history_view {
  sql_table_name: dbo.marketplace_user_login_history_view (NOLOCK) ;;

  dimension: buyer_platform_client_id {
    type: number
    label: "Buyer Platform Client"
    description: "ID of the Buyer Platform Client"
    sql: ${TABLE}.buyer_platform_client_id ;;
    value_format_name: id
  }

  dimension: firstname {
    type: string
    label: "First Name"
    description: "First Name of the user"
    sql: ${TABLE}.firstname ;;
  }

  dimension: lastname {
    type: string
    label: "Last Name"
    description: "Last Name of the user"
    sql: ${TABLE}.lastname ;;
  }

 dimension: fullname {
  type: string
  label: "Full Name"
  description: "Full Name of the user"
  sql: ${TABLE}.firstname + ' ' + ${TABLE}.lastname ;;
 }

  dimension_group: login {
    type: time
    label: "Login Date"
    description: "The login date for the user"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.login_date ;;
  }

  dimension: seller_platform_client_id {
    type: number
    label: "Seller Platform Client"
    description: "The ID of the seller platform client"
    sql: ${TABLE}.seller_platform_client_id ;;
    value_format_name: id
  }

  dimension: username {
    type: string
    label: "Username"
    description: "The login name for the user"
    sql: ${TABLE}.username ;;
  }

  dimension: buyerclient {
    type:string
    label: "Buyer Platform Name"
    description: "The name of the allowed Buyer Platforms the user"
    sql: ${TABLE}.buyerplatform ;;
  }
  dimension: sellerclient {
    type:string
    label: "Seller Platform Name"
    description: "The name of the allowed Seller Platforms the user"
    sql: ${TABLE}.sellerplatform ;;
  }
  measure: count {
    type: count
    label: "Count"
    description: "The count of rows in the results"
    drill_fields: [username, firstname, lastname]
  }
}
