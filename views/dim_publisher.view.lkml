view: dim_publisher {
  sql_table_name: BI_New.V_Dim_Publisher ;;

  dimension: bizdev_owner_id {
    type: number
    sql: ${TABLE}.Bizdev_Owner_ID ;;
    hidden: yes
  }

  dimension: bizdev_owner_key {
    type: number
    sql: ${TABLE}.Bizdev_Owner_Key ;;
    hidden: yes
  }

  dimension: cogs_type {
    type: string
    sql: ${TABLE}.COGS_Type ;;

  }

  dimension: company {
    type: string
    sql: ${TABLE}.Company ;;

  }
  dimension: accounting_ID{
    label: "Accounting ID"
    type: string
    sql: ${TABLE}.Accounting_ID ;;

  }
  dimension: status {
    label: "Is Active"
    sql: case when ${TABLE}.status in ('active') then 'True'
             when ${TABLE}.status in ('inactive') then 'False' else 'unknown staus'
             end;;

    }

  parameter: department_granularity {
    label: "Choose Department"
    description: "For dynamic Department Role."
    type: unquoted
    allowed_value: {value:"Biz_Dev"}
    allowed_value: {value:"Pub_Ops"}
  }


  dimension: dapartment {
    type: string
    label_from_parameter: department_granularity
    sql:
        {% if department_granularity._parameter_value == 'Biz_Dev' %}
                 ${v_dim_employee_biz_dev.employee_name}
        {% elsif department_granularity._parameter_value == 'Pub_Ops' %}
             ${v_dim_employee_pub_ops.employee_name}
        {% else %} NULL {% endif%};;
    drill_fields: [v_dim_employee_pub_ops.employee_name]
    link: {
      label: "Drill To"
      url: "https://tremor.cloud.looker.com/dashboards/560?PubOps+Name={{ value }}"
    }
  }

  dimension: office {
    type: string
    label_from_parameter: department_granularity
    sql:
        {% if department_granularity._parameter_value == 'Biz_Dev' %}
                 ${v_dim_employee_biz_dev.employee_office}
        {% elsif department_granularity._parameter_value == 'Pub_Ops' %}
             ${v_dim_employee_pub_ops.employee_office}
        {% else %} NULL {% endif%};;

  }



    parameter: insert_publisher {
        type: string
        allowed_value: {value: "insert"}
    }
  parameter: exclude_publisher {
    type: string
    allowed_value: {value: "exclude"}
  }

  dimension: publisher_to_insert {
     label_from_parameter: insert_publisher
    sql:
      {% if insert_publisher._parameter_value == "'insert'" %}
          ${pub_id}
      {% else %}
             1
      {% endif %};;
  }
  dimension: publisher_to_exclude {
    label_from_parameter: insert_publisher
    sql:
      {% if insert_publisher._parameter_value == "'exclude'" %}
          ${pub_id_to_exclude_parameter}
      {% else %}
           1
      {% endif %};;
  }



    dimension_group: db_create {
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
      sql: ${TABLE}.DB_Create_Date ;;
      hidden: yes
    }
    dimension: seller_type {
      type: string
      sql: ${TABLE}.seller_type ;;
    }

    dimension: signup_step {
      type: string
      sql: ${TABLE}.signup_step ;;
    }

    dimension: unruly_seller_id {
      type: string
      sql: ${TABLE}.unruly_seller_id ;;
    }
    dimension: r1_seller_id {
      type: string
      sql: ${TABLE}.r1_seller_id ;;
    }

    dimension_group: db_update {
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
      sql: ${TABLE}.DB_Update_Date ;;
      hidden: yes
    }

    dimension: integration_type {
      label: "Integration Type"
      type: string
      sql: ${TABLE}.Integration_Type ;;
    }

    dimension: is_1st_party {
      label: "Is 1st Party"
      type: yesno
      sql: ${TABLE}.Is_1st_Party ;;
      hidden: yes
    }

    dimension: is_network {
      type: yesno
      sql: ${TABLE}.Is_Network ;;
      hidden: yes
    }

    dimension: ops_owner_id {
      type: number
      sql: ${TABLE}.OPS_Owner_ID ;;
      hidden: yes
    }

    dimension: ops_owner_key {
      type: number
      sql: ${TABLE}.OPS_Owner_Key ;;
      hidden: yes
    }

    dimension: pub_cat_list {
      type: string
      sql: ${TABLE}.PUB_Cat_list ;;
      hidden: yes
    }

    dimension: pub_craeted {
      type: date
      label: "Create Date"
      sql: ${TABLE}.PUB_Craeted_ON ;;

    }

    dimension: pub_id {
      label: "Pub ID"
      type: string
      sql: ${TABLE}.PUB_ID ;;
    }

  dimension: pub_id_to_exclude_parameter{
    label: "Pub ID exclude parameter"
    type: string
    sql: ${TABLE}.PUB_ID ;;
  }

    dimension: pub_key {
      type: number
      sql: ${TABLE}.PUB_Key ;;
      #hidden: yes
    }

    dimension: pub_name {
      label: "Publisher Name"
      type: string
      sql: ${TABLE}.PUB_Name ;;
      drill_fields: [new_revenue.publisher_name]
      link: {
        label: "Drill To"
        url: "https://tremor.cloud.looker.com/dashboards/560?Publisher+Name={{ value }}"
      }
    }

    dimension_group: pub_updated {
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
      sql: ${TABLE}.PUB_Updated_ON ;;
      hidden: yes
    }

    dimension: publisher_account_type {
      label: "Publisher Account Type"
      type: string
      sql: ${TABLE}.Publisher_Account_Type ;;
    }


    dimension: ri_info {
      type: string
      sql: ${TABLE}.RI_Info ;;
      hidden: yes
    }



  parameter: max_rank {
    type: number
  }

  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }
  }
