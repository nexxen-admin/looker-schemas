view: forecast_data {
  sql_table_name: BI_DSP.Forecast_Data ;;

  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }
  dimension: has_opportunitylineitem {
    type: number
    sql: ${TABLE}.has_opportunitylineitem ;;
  }
  dimension: monthly_proposed_spend {
    value_format: "$#,##0"
    type: number
    sql:COALESCE(${TABLE}.monthly_proposed_spend,0) ;;
  }
  dimension: schedule_expected_revenue {
    value_format: "$#,##0"
    type: number
    sql: COALESCE(${TABLE}.schedule_expected_revenue,0);;
  }
  dimension: io_super_region {
    type: string
    label: "Super Region"
    sql: ${TABLE}.IO_Super_Region ;;
  }
  dimension: io_type {
    type: string
    label: "Type"
    sql: ${TABLE}.IO_Type ;;
  }

  dimension: schedule_is_free {
    type: number
    sql: ${TABLE}.schedule_is_free ;;
  }

  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
  }

  dimension: enterprise_org_classification {
    type: string
    label: "Enterprise Org Classification"
    # description:
    sql: CASE
           WHEN ${account_name} ILIKE '%Rescue Agency%'
             OR ${account_name} ILIKE '%301 Digital Media%'
             OR ${account_name} ILIKE '%Klick Health (CAN)%'
             OR ${account_name} ILIKE '%Guru%'
             THEN 'Strat Sales Accounts'
           ELSE ${new_enterprise_team}
         END ;;
  }

  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_end_date ;;
  }

  dimension_group: opportunity_closed {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_close_date ;;
  }

  dimension_group: opportunity_create {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_create_date ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.Opportunity_ID ;;
  }

  dimension: opportunity_link {
    type: string
    sql: CONCAT('https://amobee-sfv.lightning.force.com/',${TABLE}.Opportunity_ID) ;;
    html: <a href="{{ value }}"/>[SF Opportunity Link]</a> ;;
  }

  dimension: opportunity_margin {
    type: number
    sql: ${TABLE}.opportunity_Margin ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_probability {
    type: number
    sql: ${TABLE}.opportunity_probability ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
  }
  dimension: Probability_level {
    type: number
    sql: ${TABLE}.Probability_level ;;
  }
  dimension: opportunity_proposed_spend {
    type: number
    value_format: "$#,##0"
    label: "Proposed Spend"
    sql: ${TABLE}.opportunity_proposed_spend ;;
  }
  dimension: opportunity_record_type {
    type: string
    sql: ${TABLE}.opportunity_record_type ;;
  }
  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
  }
  dimension: report_month {
    type: date
    datatype: date
    sql: ${TABLE}.report_month ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension_group: schedule_revenue_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_end_date ;;
  }
  dimension_group: schedule_revenue_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_start_date ;;
  }
  dimension: snapshot_forecast_checkbox {
    type: number
    label: "Forecast Checkbox"
    sql: ${TABLE}.Snapshot_Forecast_Checkbox ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }

  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }

  # dimension: tech_services_group {
  #   type: string
  #   sql:
  #   CASE
  #     WHEN ${account_name} = 'ITV' THEN NULL
  #     WHEN ${account_name} = 'LG Electronics' THEN NULL
  #     WHEN ${account_name} LIKE '%Klick Health%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%301 Digital Media%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%Good Karma Brands%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%Guru%' THEN 'Tech Services - Strategic Sales'
  #     WHEN ${account_name} LIKE '%Rescue Agency%' THEN 'Tech Services - Strategic Sales'
  #     ELSE 'Tech Services - Enterprise Sales'
  #   END ;;
  #   label: "Enterprise Technical Services"
  # }


  dimension: tech_services_group {
    type: string
    sql:
    CASE
      WHEN ${account_name} = 'ITV' THEN NULL
      WHEN ${account_name} = 'LG Electronics' THEN NULL

      -- Enterprise Sales condition
      WHEN ${chance_team} ILIKE '%Enterprise Sales%'
      AND ${sales_team_chance_org}!='Enterprise Sales - Linear TV (Maloy)'
      THEN 'Tech Services - Enterprise Sales'

      -- Strategic Sales condition
      WHEN ${sales_team_chance_org} ILIKE '%Strategic Sales%'
      AND ${account_manager_sales_team} != NULL
      THEN 'Tech Services - Strategic Sales'

      -- Specific Account_Name mappings to Strategic Sales
      WHEN ${account_name} ILIKE '%Klick Health%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%301 Digital Media%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%Good Karma Brands%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%Guru%' THEN 'Tech Services - Strategic Sales'
      WHEN ${account_name} ILIKE '%Rescue Agency%' THEN 'Tech Services - Strategic Sales'

      ELSE NULL
      END ;;
    label: "Enterprise Technical Services"
  }


  dimension: Deal_Type {
    type: string
    sql: ${TABLE}.Deal_Type ;;
  }
  dimension: New_Vs_Existing_Customer {
    type: string
    sql: CASE ${TABLE}.Deal_Type WHEN 'New Customer' THEN 'New' WHEN 'Existing' THEN 'Existing' WHEN 'New Line of Business' THEN 'Existing' else '--' END;;
    }

  dimension: strat_sales_rvp {
    type: string
    sql: ${TABLE}.strat_sales_rvp ;;
    label: "Strat Sales RVP"
  }

  dimension: strat_sales_team {
    type: string
    sql: CASE WHEN ${TABLE}.strat_sales_team='Strat Sales - Southwast' THEN 'Strat Sales - Southwest' ELSE ${TABLE}.strat_sales_team END;;
  }

  dimension: strat_sales_cs_region {
    type: string
    sql: CASE
          WHEN ${account_name} LIKE '%Klick Health%' AND ${revenue_line} = 'DSP (Self-Service & Managed)' THEN NULL
          WHEN ${account_name} LIKE '%Guru%' AND ${revenue_line} = 'DSP (Self-Service & Managed)' THEN NULL
          WHEN ${account_name} LIKE '%301 Digital%' AND ${revenue_line} = 'DSP (Self-Service & Managed)' THEN NULL
          WHEN ${account_name} LIKE '%Rescue Agency%' AND ${revenue_line} = 'DSP (Self-Service & Managed)' THEN NULL

          WHEN ${strat_sales_rvp} LIKE '%East%' THEN 'Strat Sales CS East'
          WHEN ${strat_sales_rvp} LIKE '%West%' THEN 'Strat Sales CS West'
          WHEN ${strat_sales_rvp} LIKE '%Central%' THEN 'Strat Sales CS Central'
          WHEN ${strat_sales_rvp} LIKE '%Canada%' THEN 'Strat Sales CS Canada'
          WHEN ${strat_sales_rvp} LIKE '%South%' THEN 'Strat Sales CS South'

          WHEN ${account_manager_sales_team} LIKE 'Strat Sales % East%' THEN 'Strat Sales CS East'
          WHEN ${account_manager_sales_team} LIKE 'Strat Sales % West%' THEN 'Strat Sales CS West'
          WHEN ${account_manager_sales_team} LIKE 'Strat Sales % Central%' THEN 'Strat Sales CS Central'
          WHEN ${account_manager_sales_team} LIKE 'Strat Sales % Canada%' THEN 'Strat Sales CS Canada'
          WHEN ${account_manager_sales_team} LIKE 'Strat Sales % South%' THEN 'Strat Sales CS South'
        ELSE NULL
        END ;;
    label: "Strategic Sales CS Region"
  }

  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.opportunity_owner ;;
  }

  dimension: account_manager {
    type: string
    sql: ${TABLE}.account_manager ;;
  }

  dimension: TV_Specialist {
    type: string
    sql: ${TABLE}.TV_Specialist ;;
  }

  dimension: numbered_stage {
    type: string
    sql:  CASE ${TABLE}.stage WHEN 'Draft' THEN 'a. Draft' WHEN 'Discovery Meeting' THEN 'b. Discovery Meeting' WHEN 'LowEngage' THEN 'c. LowEngage' WHEN 'RFP/RFI Received'THEN 'd. RFP/RFI Received' WHEN 'HighEngage' THEN 'e. HighEngage' WHEN 'Proposal Discussion' THEN 'f. Proposal Discussion' WHEN 'Proposal' THEN 'g. Proposal' WHEN 'Proposal Ready' THEN 'h. Proposal Ready' WHEN 'Proposal Sent' THEN 'i. Proposal Sent' WHEN 'Verbal' THEN 'j. Verbal' WHEN 'IO Ready' THEN 'k. IO Ready' WHEN 'Final Approval' THEN 'l. Final Approval' END;;
    }


  dimension: revenue_stage_leadership {
    label: "Revenue Stage"
    type: string
    sql: CASE
          WHEN ${TABLE}.stage ILIKE '%Closed Won%' THEN 'Booked'
          WHEN ${TABLE}.stage ILIKE '%Closed Lost%' THEN 'Lost'

          WHEN ${TABLE}.stage = 'Verbal' THEN 'Committed'
          WHEN ${TABLE}.stage = 'Final Approval' THEN 'Committed'

      WHEN ${TABLE}.stage = 'Discovery Meeting' THEN 'Pre-Pipeline'
      WHEN ${TABLE}.stage = 'Draft' THEN 'Pre-Pipeline'

      ELSE 'Pipeline'
      END ;;
  }

  dimension: pmp_y_n {
    label: "PMP Y/N"
    type: string
    sql: CASE
          WHEN ${TABLE}.opportunity_name IS NULL THEN 'no'
          WHEN ${TABLE}.opportunity_name ILIKE '%PMP%' THEN 'yes'
          ELSE 'no'
        END ;;
  }

  # dimension: tv_team_y_n {
  #   label: "TV Team"
  #   type: string
  #   sql: CASE WHEN ${TABLE}.opportunity_name ILIKE '%TV%' THEN 'yes' ELSE 'no' END ;;
  # }

  dimension: tv_team_y_n {
    label: "TV Team"
    type: string
    sql: CASE WHEN revenue_line ILIKE '%TV%' THEN 'yes' ELSE 'no' END ;;
  }

  dimension: forecast {
    type: number
    hidden: yes
    sql: CASE
          WHEN ${stage} = 'Closed Lost' THEN 0
          WHEN ${Probability_level} < 50 THEN 0
          ELSE ${schedule_converted_revenue_v2} * ${Probability_level} / 100
        END ;;
  }

  dimension: booked {
    type: number
    hidden: yes
    sql: CASE
          WHEN ${stage} in ('Closed Won', 'Closed Won - EDIT', 'Closed Won - APPROVAL') THEN ${schedule_converted_revenue_v2} * ${Probability_level} / 100
          ELSE 0
        END ;;
  }

  dimension: account_manager_sales_team {
    type: string
    sql: ${TABLE}.account_manager_sales_team ;;
    description: "Sales team as listed on Salesforce User table"
  }

  dimension: legal_entity {
    label: "Legal Entity"
    type: string
    sql: ${TABLE}.legal_entity ;;

  }

  dimension: sales_team_chance_org {
    type: string
    label: "Sales Team (Chance Org)"
    sql: CASE WHEN ${new_enterprise_team} ILIKE '%Enterprise Sales%' THEN ${new_enterprise_team}
              WHEN ${new_enterprise_team} ILIKE '%Enterprise Services - National%' THEN 'Enterprise Sales'
              WHEN  ${new_enterprise_team} ILIKE '%Political%' THEN 'Enterprise Sales - Political'
              WHEN ${strat_sales_team}  ILIKE '%Barter Direct%' THEN ${strat_sales_team}
            WHEN ${strat_sales_rvp} ILIKE '%Strat Sales%' THEN ${strat_sales_rvp}
            ELSE 'Unknown' END ;;
  }

  dimension: chance_team {
    type: string
    label: "Chance Team (Consolidated)"
    sql: CASE WHEN ${sales_team_chance_org} ILIKE '%Enterprise Sales%' THEN 'Enterprise Sales'
              WHEN ${sales_team_chance_org} ILIKE '%Strat Sales%' THEN 'Strategic Sales'
              WHEN ${sales_team_chance_org} ILIKE '%Barter Direct%' THEN 'Barter Direct'
              WHEN ${sales_team_chance_org} ILIKE 'Unknown' THEN 'Unknown'
            END;;
  }

  dimension_group: opportunitylineitem_db_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.opportunitylineitem_db_update_date ;;
  }

# Convert the full timestamp to a sortable number (Unix seconds)
  dimension: db_updated_number_opportunitylineitem {
    type: number
    sql: EXTRACT(EPOCH FROM ${opportunitylineitem_db_update_date_raw}) ;;
    label: "DB Updated Unix Time"
    hidden: yes
  }

  measure: max_database_update_timestamp_opportunitylineitem {
    type: max
    sql: ${db_updated_number_opportunitylineitem} ;;
    label: "Max DB Update"
    hidden: yes
  }

  measure: final_database_last_update_opportunitylineitem {
    type: string
    sql: TO_CHAR(TO_TIMESTAMP(${max_database_update_timestamp_opportunitylineitem}), 'YYYY-MM-DD HH24:MI:SS') ;;
    label: "Opportunity Line Item DB update date"
    html:
    <div style="font-family: Arial, sans-serif; font-size: 11px; line-height: 1.5; text-align: center; color: #000000;">
      <span style="font-weight: normal; word-spacing: 4px;">Opportunity Line Item DB update date (UTC)</span><br>
      <span style="word-spacing: 15px;">{{ rendered_value }}</span>
    </div> ;;}

  # dimension: full_pipeline {
  #   value_format: "$#,##0"
  #   type: number
  #   sql:
  #   (CASE
  #     WHEN ${has_opportunitylineitem} = 0 THEN ${monthly_proposed_spend}
  #     ELSE 0
  #   END) + ${schedule_expected_revenue} ;;
  # }

  dimension: full_pipeline {
    value_format: "$#,##0"
    type: number
    sql:
    (CASE
      WHEN ${has_opportunitylineitem} = 0 THEN ${opportunity_proposed_spend}
      ELSE 0
    END) + ${schedule_converted_revenue_v2} ;;
  }

  measure: weighted_pipeline {
    value_format: "$#,##0"
    type: sum
    sql: (${Probability_level} * ${full_pipeline}) / 100 ;;
    label: "Weighted Pipeline"
  }


    ####----MEASURES----####
  measure: sum_booked_full_credit {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.snapshot_Booked_Full_Credit ;;
    label: "GR Booked"
  }

  measure: sum_net_revenue_booked {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.snapshot_Net_Revenue_Booked;;
    label: "NR Booked"
  }

  measure: sum_unweighted_tl_upside_new_forecast_v2 {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
    label: "Unweighted TL Upside"
  }

  measure: sum_unweighted_nr_upside_new_forecast_v2 {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.unweighted_nr_upside_new_forecast_v2 ;;
    label: "Unweighted NR Upside"
  }

  measure: sum_weighted_nr_upside_new_forecast_v2 {
    value_format: "$#,##0"
    type: sum
    sql:
    ${TABLE}.Weighted_NR_Upside_New_Forecast_v2;;
    label: "Weighted NR Upside"
  }

  measure: sum_weighted_tl_upside_new_forecast_v2 {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
    label: "Weighted TL Upside"
  }

  measure: sum_gr_forecast_full_credit {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    label: "GR Forecast"
  }

  measure: sum_nr_forecast_full_credit {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.snapshot_NR_Forecast_Full_Credit ;;
    label: "NR Forecast"
  }

  measure: sum_forecast_and_upside_weighted {
    value_format: "$#,##0"
    type: number
    label: "NR Forecast + NR Upside (Weighted)"
    sql: ${sum_nr_forecast_full_credit}+${sum_weighted_nr_upside_new_forecast_v2} ;;
  }

  measure: sum_schedule_converted_revenue_v2 {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
    label: "Schedule Converted Revenue v2"
  }

  measure: unweighted_nr_pipeline {
    label: "Unweighted NR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: COALESCE(${TABLE}.schedule_converted_revenue_v2 * ${TABLE}.opportunity_Margin / 100,0) ;;
  }

  measure: weighted_gr_pipeline {
    label: "Weighted GR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: COALESCE(${TABLE}.schedule_converted_revenue_v2  * ${TABLE}.Probability_level / 100,0) ;;
  }

  measure: weighted_nr_pipeline {
    label: "Weighted NR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: COALESCE(${TABLE}.schedule_converted_revenue_v2  * ${TABLE}.opportunity_Margin / 100)* ${TABLE}.Probability_level /100;;
  }


  measure: unweighted_gr_pipeline {
    label: "Unweighted GR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: COALESCE(${TABLE}.schedule_converted_revenue_v2, 0) ;;
}

  measure: sum_gr_forecast_factored {
    value_format: "$#,##0"
    type: sum
    sql: CASE
          WHEN ${strat_sales_team} LIKE '%Strat Sales%' AND (
            ${io_type} IN ('Platform HOK', 'Platform Managed') OR ${revenue_line} IN ('PMP', 'Hybrid/Transparent', 'SS'))
          THEN ${forecast} * 0.7
          ELSE ${forecast}
         END ;;
    label: "GR Forecast (Factored)"
  }

  measure: sum_gr_booked_factored {
    value_format: "$#,##0"
    type: sum
    sql: CASE
          WHEN ${strat_sales_team} LIKE '%Strat Sales%' AND (
            ${io_type} IN ('Platform HOK', 'Platform Managed') OR ${revenue_line} IN ('PMP', 'Hybrid/Transparent', 'SS'))
          THEN ${booked} * 0.7
          ELSE ${booked}
        END ;;
    label: "GR Booked (Factored)"
  }

  measure: delta_gr_booked_to_forecast {
    value_format: "$#,##0"
    type: number
    sql: ${sum_booked_full_credit}-${sum_gr_forecast_full_credit};;
    label: "GR Booked to Forecast (Delta)"
  }

  measure: delta_nr_booked_to_forecast {
    value_format: "$#,##0"
    type: number
    sql: ${sum_net_revenue_booked}-${sum_nr_forecast_full_credit};;
    label: "NR Booked to Forecast (Delta)"
  }

  measure: p_of_gr_booked_to_forecast {
    type: number
    sql: CASE
          WHEN ${sum_gr_forecast_full_credit} = 0 THEN 0
          ELSE ${sum_booked_full_credit}
          / NULLIF(${sum_gr_forecast_full_credit}, 0)
          END ;;
    value_format: "0%"
    label: " % GR Booked to Forecast"
  }

  measure: p_of_nr_booked_to_forecast {
    type: number
    sql: CASE
          WHEN ${sum_nr_forecast_full_credit} = 0 THEN 0
          ELSE ${sum_net_revenue_booked}
          / NULLIF(${sum_nr_forecast_full_credit}, 0)
          END ;;
    value_format: "0%"
    label: " % NR Booked to Forecast"
  }


  measure: count_of_opps {
    type: count_distinct
    label: "# of Opps"
    sql: ${TABLE}.opportunity_id;;
  }



  measure: count {
    type: count
    drill_fields: [opportunity_name]
    hidden: yes
  }
}
