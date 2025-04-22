view: user_access_changes {
  label: "Platform Client Access Changes"
  derived_table: {
    sql: SELECT a.[__$operation] AS operation_order
        ,CASE
          WHEN a.__$operation = 1
            THEN 'delete'
          WHEN a.__$operation = 2
            THEN 'new'
          WHEN a.__$operation = 3
            THEN 'before'
          ELSE 'After'
          END AS Operation_Type
        ,a.tran_time AS tran_time
        ,pc.platform_client_id AS platform_client_id
        ,pc.description AS platform_client
        ,c.id AS user_id
        ,c.LastName + ', ' + c.FirstName AS user_name
        ,c.email AS user_email
        ,ur.RoleId AS role_id
        ,r.NAME AS role_description
        ,c.office_id AS office_id
        ,o.office_name AS office
        ,br.description AS business_region
      FROM an_hist..dbo_customer_user_access3_CT (NOLOCK) a
      JOIN an_main..users (NOLOCK) b ON a.userid = b.Id
      JOIN an_main..userprofile (NOLOCK) c ON b.id = c.Id
      JOIN an_main..platform_client (NOLOCK) pc ON a.platform_client_id = pc.platform_client_id
      JOIN an_main..userrole (NOLOCK) ur ON c.id = ur.UserId
      JOIN an_main..role (NOLOCK) r ON ur.RoleID = r.id
      JOIN an_main..office (NOLOCK) o ON c.office_id = o.office_id
      JOIN an_main..business_region (NOLOCK) br ON pc.business_region_id = br.business_region_id ;;

    }

    dimension: operation_order {
      type: number
      label: "Operation Order ID"
      description: "The ID type of history operation."
      sql: ${TABLE}.Operation_Order ;;
      value_format_name: id
    }

    dimension: operation_type {
      type: string
      label: "Operation Type"
      description: "New Or Delete, Before or After"
      sql: ${TABLE}.operation_type ;;
    }

  dimension_group: begin_datetm {
    type: time
    label: "Transaction"
    timeframes: [raw,time,date,month]
    description: "Time of the access update."
    sql: ${TABLE}.tran_time ;;
  }


    dimension: platform_client_id {
      type: number
      label: "Platform Client ID"
      description: "The ID of the platform client that the user has access to."
      sql: ${TABLE}.platform_client_id ;;
      value_format_name: id
    }

    dimension: platform_client_description {
      type: string
      label: "Platform Client Description"
      description: "The name of the platform client that the user has access to."
      sql: ${TABLE}.platform_client ;;
      suggest_explore: mssql_oltp_suggest_demand_ref
      suggest_dimension: mssql_oltp_suggest_demand_ref.demand_platform_client
    }

    dimension: user_id {
      type: string
      label: "User ID"
      description: "The unique ID of the user (GUID)"
      sql: ${TABLE}.user_id;;
    }

    dimension: user_name {
      type: string
      label: "User Name"
      description: "The full name (last, first) of the user."
      sql: ${TABLE}.user_name;;
    }

    dimension: user_email {
      type: string
      label: "User E-Mail"
      description: "The e-mail address of the user."
      sql: ${TABLE}.user_email;;
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

    dimension: office_id {
      type: number
      label: "Office ID"
      description: "The unique ID of the office of the user"
      sql: ${TABLE}.office_id;;
      value_format_name: id
    }

    dimension: office_name {
      type: string
      label: "Office Name"
      description: "The description of the office of the user."
      sql: ${TABLE}.office;;
      suggest_explore: mssql_oltp_suggest_demand_ref
      suggest_dimension: mssql_oltp_suggest_demand_ref.office_name
    }

    dimension: platform_client_business_region {
      type: string
      label: "Platform Client Business Region"
      description: "The business region of the Platform Client."
      sql: ${TABLE}.business_region ;;
      suggest_explore: mssql_oltp_suggest_demand_ref
      suggest_dimension: mssql_oltp_suggest_demand_ref.business_region
    }


  }
