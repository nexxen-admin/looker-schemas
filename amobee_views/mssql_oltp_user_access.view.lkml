view: user_access {


  derived_table: {
    sql: SELECT DISTINCT pc.platform_client_id AS platform_client_id
  ,pc.description AS platform_client_description
  ,br.description AS business_region
  ,c.id AS User_ID
  ,(c.LastName + ', ' + c.FirstName) AS UserName
  ,c.email AS user_email
  ,ur.roleId AS role_id
  ,r.NAME AS role_description
  ,o.office_id AS office_id
  ,o.office_name AS office_name
  ,b.Active AS user_active
  ,b.createdon
FROM an_main.dbo.customer_user_access3 (NOLOCK) a
JOIN an_main..Users (NOLOCK) b ON (a.userid = b.id)
JOIN an_main..UserProfile (NOLOCK) c ON (b.id = c.Id)
JOIN an_main..platform_client (NOLOCK) pc ON a.platform_client_id = pc.platform_client_id
JOIN an_main..UserRole (NOLOCK) ur ON c.id = ur.UserId
JOIN an_main..ROLE (NOLOCK) r ON ur.RoleID = r.id
JOIN an_main..Office (NOLOCK) o ON c.office_id = o.office_id
JOIN an_main..business_region (NOLOCK) br ON pc.business_region_id = br.business_region_id ;;

  }

  dimension: platform_client_id {
    type: number
    view_label: "User Access"
    label: "Platform Client ID"
    description: "The ID of the platform client that the user has access to."
    sql: ${TABLE}.platform_client_id ;;
    value_format_name: id
  }

  dimension: platform_client_description {
    type: string
    view_label: "User Access"
    label: "Platform Client Description"
    description: "The name of the platform client that the user has access to."
    sql: ${TABLE}.platform_client_description ;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.demand_platform_client
  }

  dimension: platform_client_business_region {
    type: string
    view_label: "User Access"
    label: "Platform Client Business Region"
    description: "The business region of the Platform Client."
    sql: ${TABLE}.business_region ;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.business_region
  }

  dimension: user_id {
    type: string
    view_label: "User Access"
    label: "User ID"
    description: "The unique ID of the user (GUID)"
    sql: ${TABLE}.user_id;;
  }

  dimension: user_name {
    type: string
    view_label: "User Access"
    label: "User Name"
    description: "The full name (last, first) of the user."
    sql: ${TABLE}.UserName;;
  }

  dimension: user_email {
    type: string
    view_label: "User Access"
    label: "User E-Mail"
    description: "The e-mail address of the user."
    sql: ${TABLE}.user_email;;
  }

  dimension: user_active {
    type: yesno
    view_label: "User Access"
    label: "User Active"
    description: "A yes/no indicator if the user is active."
    sql: ${TABLE}.user_active = 1;;
  }

  dimension: role_id {
    type: string
    view_label: "User Access"
    label: "Role ID"
    description: "The unique ID of the role (GUID)"
    sql: ${TABLE}.role_id;;
  }

  dimension: role_name {
    type: string
    view_label: "User Access"
    label: "Role Name"
    description: "The description of the role within the system."
    sql: ${TABLE}.role_description;;
  }

  dimension: office_id {
    type: number
    view_label: "User Access"
    label: "Office ID"
    description: "The unique ID of the office of the user"
    sql: ${TABLE}.office_id;;
    value_format_name: id
  }

  dimension: office_name {
    type: string
    view_label: "User Access"
    label: "Office Name"
    description: "The description of the office of the user."
    sql: ${TABLE}.office_name;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.office_name
  }

  dimension_group: createdon {
    type: time
    description: "Creation date of the user."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

}
