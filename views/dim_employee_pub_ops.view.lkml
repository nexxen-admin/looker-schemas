# The name of this view in Looker is "V Dim Employee Pub Ops"
view: v_dim_employee_pub_ops {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Employee_PubOps ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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



  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Employee ID" in Explore.

  dimension: employee_id {
  label: "PubOps ID"
   type: number
  description: "Unique identifier for employee"
    sql: ${TABLE}.Employee_ID ;;

  }
  dimension: pub_group {
    label: "Pub Group"
    type: string
    sql: case when ${employee_id} in ('64','45','37','63','60','11') then 'SAM'
          else 'LT' end;;
          hidden: yes

  }

  dimension: employee_key {
    type: number
    sql: ${TABLE}.Employee_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: employee_name {
    label: "PubOps Name"
    description: "Name of the PubOps employee"
    type: string
    sql: ${TABLE}.Employee_Name ;;
      full_suggestions: yes
    drill_fields: [v_dim_employee_pub_ops.employee_name]
    link: {
      label: "Drill To New Publishers"
      url: "https://tremor.cloud.looker.com/dashboards/560?PubOps+Name={{ value }}"
    }
    link: {
      label: "Drill To Supply Tracker"
      url: "https://tremor.cloud.looker.com/dashboards/544?PubOps+Name={{ value }}"
    }

  }

  dimension: pub_name {
    label: "Pub Ops Publisher Name"
    type: string
    sql: ${TABLE}.PUB_Name ;;
    drill_fields: [new_revenue.publisher_name]
    link: {
      label: "Drill To"
      url: "https://tremor.cloud.looker.com/dashboards/560?Publisher+Name={{ value }}"
    }
  }

  dimension: publisher_account_type_ctrl {
    label: "publisher account type ctrl"
    description: "pub with no pub ops owner is self serve"
    type: string
    sql: case when ${TABLE}.Employee_Name= 'unknown'
          OR ${TABLE}.Employee_Name= 'Self Service'
          OR ${TABLE}.Employee_Name= 'Unassigned'
          OR ${TABLE}.Employee_Name= 'Revops' then 'self serve' else 'managed' end ;;
  }

  dimension: employee_office {
    label: "PubOps Office"
    description: "PubOps office"
    type: string
    sql: ${TABLE}.Employee_Office ;;

  }

  dimension: Manager_Type {
    label: "Pub Ops Group"
    type: string
    sql: ${TABLE}.manager_type ;;
    hidden: yes
  }

  dimension: employee_region {
    type: string
    sql: ${TABLE}.Employee_Region ;;
    hidden: yes
  }

  dimension: role_source {
    type: string
    sql: ${TABLE}.Role_Source ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [employee_name]
    hidden: yes
  }

  dimension: team_unruly {
    label: "Pub Team"
    type: string
    required_access_grants: [can_view_aniview]
    sql: case when ${TABLE}.Employee_Name='Itamar Bilu' OR ${TABLE}.Employee_Name='Stav Ezer' OR
                   ${TABLE}.Employee_Name='Ashleigh Fisher'  OR
                   ${TABLE}.Employee_Name='Hanoch Melamed Cohen' then 'In App'

              when ${TABLE}.Employee_Name='Itzik Vaknin' OR ${TABLE}.Employee_Name='Yovel Modlin' OR
                   ${TABLE}.Employee_Name='Bar Wolkowiski' OR ${TABLE}.Employee_Name='Shir Elzam' then 'Web'

              when ${TABLE}.Employee_name='Mikayla Skarzynski' OR
                   ${TABLE}.Employee_name='Rachel Gargett' OR ${TABLE}.Employee_name='Hannah Quigley' OR
                   ${TABLE}.Employee_name='Raffaele Santambrogio'OR ${TABLE}.Employee_name='Andrew Styles' then 'UK'

              when ${TABLE}.Employee_Name='Gonni Kern' OR ${TABLE}.Employee_Name='Noa Krashniak' then 'SDK'

              when ${TABLE}.Employee_Name='Stav Ezer' OR ${TABLE}.Employee_Name='Sarah Herskovics' OR
                   ${TABLE}.Employee_Name='Lihi Katabi' OR ${TABLE}.Employee_Name='Dana Nahshon' OR
                   ${TABLE}.Employee_Name='Amit Mazor' OR ${TABLE}.Employee_Name='Yariv Aharon' then 'Channel Pubs'

              when ${TABLE}.Employee_Name='Omri Lender & Ellen Rogan' OR ${TABLE}.Employee_Name='Noa Karako & Francesca Esposito' OR
                   ${TABLE}.Employee_Name='Shachar Laufer & Daniel Werman' OR ${TABLE}.Employee_Name='Rom Lubianiker & Rory Brown' OR
                   ${TABLE}.Employee_Name='Niv Shema' OR ${TABLE}.Employee_Name='Shachar Laufer' OR
                   ${TABLE}.Employee_Name='Rom Lubianiker' OR ${TABLE}.Employee_Name='Omri Lender' OR
                   ${TABLE}.Employee_Name='Noa Karako' then 'Direct'

              when ${TABLE}.Employee_Name='RevOps' then 'RevOps'

              when ${TABLE}.Employee_Name='Matthew De Palo' then 'AU'

              when ${TABLE}.Employee_Name='Ally Appelbaum' OR ${TABLE}.Employee_Name='Caitlyn Murphy' OR
                   ${TABLE}.Employee_Name='Eileen Lam' OR ${TABLE}.Employee_Name='Jason Vest' then 'CTV US'

              else 'null' end
 ;;
  }
}
