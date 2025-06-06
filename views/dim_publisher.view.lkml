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
    description: "Determines whether the publisher is active or not"
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


  dimension: department {
    type: string
    description: "Specifies whether the department is BizDev or PubOps"
    label_from_parameter: department_granularity
    sql:
        {% if department_granularity._parameter_value == 'Biz_Dev' %}
                 ${v_dim_employee_biz_dev.employee_name}
        {% elsif department_granularity._parameter_value == 'Pub_Ops' %}
             ${v_dim_employee_pub_ops.employee_name}
        {% else %} NULL {% endif%};;
    drill_fields: [v_dim_employee_biz_ops.employee_name]
    link: {
      label: "Drill To"
      url: "https://tremor.cloud.looker.com/dashboards/560?Publisher+Name=&BizDev+Name={{ value }}"
    }
  }

  dimension: office {
    type: string
    label_from_parameter: department_granularity
    description: "Office of employee"
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
      hidden: yes
    }

    dimension: signup_step {
      type: string
      description: "The status of a publisher in the approval queue in CTRL.
                    values:
                    [New] - The publisher filled an online signup form and is waiting to be reviewed.
                    [Content OK] - The publishers business details have been validated by business and finance teams.
                    [Content Declined] - The publishers business details have been rejected.
                    [Payment Ready] - All publisher's payment details in the online form are complete.
                    [Payment Hold] - Some of the publisher's payment details in the online form are incomplete or the the finance
                    teams reviwed the payment details and documents and decided to reject them.
                    [Payment Approved] - The finance teams reviews the payment details and documents and decides to approve them.
                    "
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

  dimension: external_domain {
    type: string
    sql: ${TABLE}.external_domain  ;;
  }

  dimension: external_name {
    type: string
    sql: ${TABLE}.external_name  ;;
  }


    dimension: integration_type {
      label: "Integration Type"
      type: string
      sql: ${TABLE}.Integration_Type ;;
    }

    dimension: is_1st_party {
      label: "Is 1st Party - Pub"
      type: yesno
      sql: ${TABLE}.Is_1st_Party ;;
      #hidden: yes
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
      description: "The date when the publisher was first created in the CTRL"
      sql: ${TABLE}.PUB_Craeted_ON ;;

    }

    dimension: pub_id {
      label: "Pub ID"
      type: string
      description: "The identification of publisher"
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
      hidden: yes
    }

    dimension: pub_name_genre_rating {
      label: "Publisher Name for genre dashboard"
      type: string
      sql: ${TABLE}.PUB_Name;;
      drill_fields: [dim_genre_norm.Genre_Norm,
        dim_content_rating_norm.content_rating_norm]
      hidden: yes

    }

    dimension: pub_name {
      label: "Publisher Name"
      type: string
      description: "The name of the entity that operates one or more sites"
      sql: ${TABLE}.PUB_Name;;
      drill_fields: [dim_a_domain.a_domain, dim_dsp.dsp_display_name, dim_imp_type.imp_type, dim_o_domain.top_level_domain, dim_buying_channel_ctrl.buying_channel_ctrl_name, dim_device_type.device_type]
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
      description: "Specifies whether a publisher's account is being managed or is self-served"
      type: string
      sql: ${TABLE}.Publisher_Account_Type ;;
    }


    dimension: ri_info {
      type: string
      sql: ${TABLE}.RI_Info ;;
      hidden: yes
    }


  measure: count_pub {
    type: string
    sql: ${TABLE}.PUB_ID;;
    hidden: no
  }




  parameter: max_rank {
    type: number
  }

  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }
  }
