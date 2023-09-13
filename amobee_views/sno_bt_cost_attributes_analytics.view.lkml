view: bt_cost_attributes_analytics {

    derived_table: {
      sql: SELECT * FROM RAWDB.DAILY_ANALYTICS_BT_COST_ATTRIBUTES
          UNION ALL
          SELECT * FROM RAWDB.HOURLY_ANALYTICS_BT_COST_ATTRIBUTES;;
    }
  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: {{_explore._name}}.pk_id || ${bt_cost_attribute}|| ${bt_provider} ;;
  }

  dimension: bt_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BT_ID;;
  }

  dimension: bt_cost_attribute {
    type: number
    label: "BT Cost Attribute"
    view_label: "Supplemental Facets"
    description: "The attribute used in determining the BT Costs."
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.bt_attribute_id else bt_cost_attribute end ;;
    value_format_name: id
  }

  dimension: bt_cost_markup {
    type: number
    hidden: yes
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.demand_bt_markup / 100000 else bt_cost_markup end ;;
  }

  measure: sum_bt_cost_markup {
    type: sum
    label: "BT Cost Markup"
    description: "The total markup cost for Behavioral Targeting"
    value_format_name: decimal_2
    sql: ${bt_cost_markup} ;;
  }

  dimension: bt_data_cost {
    type: number
    hidden: yes
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.supply_bt_cost / 100000 else bt_data_cost end ;;
  }

  measure: sum_bt_data_cost {
    type: sum
    label: "BT Data Cost"
    description: "The total cost for Behavioral Targeting data"
    value_format_name: decimal_2
    sql: ${bt_data_cost} ;;
  }

  dimension: bt_data_cost_currency {
    type: string
    label: "BT Data Cost Currency"
    description: "The currency of the BT data cost"
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.supply_bt_cost_currency else bt_data_cost_currency end ;;
  }

  dimension: bt_provider {
    type: string
    view_label: "Supplemental Facets"
    hidden: yes
    description: "The Data Provider used in creating the BT data"
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.bt_provider_id else {% if _explore._name == 'raw_impression' %} bt_providerid {% elsif  _explore._name == 'hourly_analytics' or _explore._name == 'hourly_analytics_wopr_only' %} bt_provider {% endif %} end ;;
    value_format_name: id
  }

  dimension: demand_bt_provider_cost {
    type: number
    hidden: yes
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.demand_provider_cost / 100000 else demand_bt_provider_cost end ;;
  }

  measure: sum_demand_bt_provider_cost {
    type: sum
    label: "BT Data Costs - Demand Currency"
    description: "The total Behavioral Targeting costs converted from the native currency to the demand currency."
    value_format_name: decimal_2
    sql: ${demand_bt_provider_cost};;
  }

}
