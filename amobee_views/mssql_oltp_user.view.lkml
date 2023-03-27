view: mssql_oltp_user {
  label: "User"
  derived_table: {
    sql: SELECT
           c.id AS user_id
           ,(c.LastName + ', ' + c.FirstName) AS UserName
           ,c.email AS user_email
           ,ur.roleId AS role_id
           ,r.NAME AS role_description
           ,b.Active AS user_active
           ,b.createdon
         FROM an_main..Users (NOLOCK) b
         JOIN an_main..UserProfile (NOLOCK) c ON (b.id = c.Id)
         JOIN an_main..UserRole (NOLOCK) ur ON c.id = ur.UserId
         JOIN an_main..ROLE (NOLOCK) r ON ur.RoleID = r.id ;;
  }

  dimension: user_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_name {
    type: string
    label: "User Name"
    description: "The full name (last, first) of the user."
    sql: ${TABLE}.UserName;;
  }

  dimension: user_email {
    type: string
    label: "User E-Mail"
    description: "The e-mail address of the user."
    sql: ${TABLE}.user_email;;
  }

  dimension: user_active {
    type: yesno
    label: "User Active"
    description: "A yes/no indicator if the user is active."
    sql: ${TABLE}.user_active = 1;;
  }

  dimension: role_id {
    type: string
    label: "Role ID"
    description: "The unique ID of the role (GUID)"
    sql: ${TABLE}.role_id;;
  }

  dimension: role_name {
    type: string
    label: "Role Name"
    description: "The description of the role within the system."
    sql: ${TABLE}.role_description;;
  }

  dimension_group: createdon {
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
    sql: ${TABLE}.createdon ;;
  }
}
