view: campaign_sitelist {
  sql_table_name: DIM.CAMPAIGN_SITELIST;;
  label: "Target Inventory"

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: createdon {
    hidden: yes
    type: string
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: is_targeted {
    hidden: yes
    type: yesno
    sql: ${TABLE}.IS_TARGETED ;;
  }

  dimension: placement_id {
    type: number
    label: "Target Placement ID"
    sql: ${TABLE}.PLACEMENT_ID ;;
    value_format_name: id
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }

  measure: count_of_campaigns {
    type:  number
    label: "Count of Campaigns"
    description: "The distinct count of Campaigns."
    sql:  count (distinct ${campaign_id}) ;;
  }
}
