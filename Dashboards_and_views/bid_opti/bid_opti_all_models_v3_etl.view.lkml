view: bid_opti_all_models_v3_etl {
    derived_table: {
      sql: SELECT source,count(*) as county
FROM bi.oren_test_viewership_content_sessions_combined_daily
group by 1;;


    }





    dimension: source {
      type: string
      sql: ${TABLE}.source ;;
      label: "source"}



# measu


    measure: county {
      type: sum
      sql: ${TABLE}.county ;;
      value_format: "#,##0"
    }




    set: detail {
      fields: [
        source,
        county,
      ]
    }

  }
