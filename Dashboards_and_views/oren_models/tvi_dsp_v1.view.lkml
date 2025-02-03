view: tvi_dsp_v1 {
    derived_table: {
      sql: select date,
                  country,
                  attribution_contract_name,
                  attribution_category_id,
                  attribution_data_provider_name,
                  SUM(adjusted_publisher_cost) as adjusted_publisher_cost,
                  SUM(adjusted_total_billable) as adjusted_total_billable,
                  SUM(data_cost) as data_cost,
                  SUM(adjusted_inventory_cost) as adjusted_inventory_cost,
                  SUM(impressions_adjusted) as impressions_adjusted,
                  SUM(impressions) as impressions
        from bi.tvi_report_dsp
        group by 1,2,3,4,5;;

    }


    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: date {
      type: date
      sql: ${TABLE}.date ;;
    }


    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    dimension: attribution_contract_name {
      type: string
      sql: ${TABLE}.attribution_contract_name ;;
      label: "Data Contract Name"
    }

  dimension: attribution_category_id {
    type: string
    sql: ${TABLE}.attribution_category_id ;;
    label: "Data Category Id"
  }

    dimension: attribution_data_provider_name {
      type: string
      sql: ${TABLE}.attribution_data_provider_name ;;
      label: "Data Provider Name"
    }





# measu



    measure: adjusted_publisher_cost {
      type: sum
      sql: ${TABLE}.adjusted_publisher_cost ;;
      value_format: "$#,##0"
      label: "Adjusted Publisher Cost"
    }

    measure: adjusted_total_billable {
      type: sum
      sql: ${TABLE}.adjusted_total_billable ;;
      value_format: "$#,##0"
      label: "Adjusted Total Billable*"
    }

    measure: data_cost {
      type: sum
      sql: ${TABLE}.data_cost ;;
      value_format: "$#,##0"
      label: "Data Cost"
    }

    measure: adjusted_inventory_cost {
      type: sum
      sql: ${TABLE}.adjusted_inventory_cost ;;
      value_format: "$#,##0"
      label: "Inventory Cost Adjusted*"
    }

  measure: impressions_adjusted {
    type: sum
    sql: ${TABLE}.impressions_adjusted ;;
    value_format: "#,##0"
    label: "Impressions Adjusted*"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
    label: "Impressions"
  }




    set: detail {
      fields: [
                  date,
                  country,
                  attribution_contract_name,
                  attribution_category_id,
                  attribution_data_provider_name,
                  adjusted_publisher_cost,
                  adjusted_total_billable,
                  data_cost,
                  adjusted_inventory_cost,
                  impressions_adjusted,
                  impressions

      ]
    }

  }
