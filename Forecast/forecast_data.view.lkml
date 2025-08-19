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
  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
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
    sql: CONCAT('https://amobee-sfv.lightning.force.com/', ${TABLE}.Opportunity_ID) ;;
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
  dimension: opportunity_proposed_spend {
    type: number
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
    sql: ${TABLE}.strat_sales_team ;;
  }

  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.opportunity_owner ;;
  }

  dimension: account_manager {
    type: string
    sql: ${TABLE}.account_manager ;;
  }

  dimension: numbered_stage {
    type: string
    sql:  CASE ${TABLE}.stage WHEN 'Draft' THEN 'a. Draft' WHEN 'Discovery Meeting' THEN 'b. Discovery Meeting' WHEN 'LowEngage' THEN 'c. LowEngage' WHEN 'RFP/RFI Received'THEN 'd. RFP/RFI Received' WHEN 'HighEngage' THEN 'e. HighEngage' WHEN 'Proposal Discussion' THEN 'f. Proposal Discussion' WHEN 'Proposal' THEN 'g. Proposal' WHEN 'Proposal Ready' THEN 'h. Proposal Ready' WHEN 'Proposal Sent' THEN 'i. Proposal Sent' WHEN 'Verbal' THEN 'j. Verbal' WHEN 'IO Ready' THEN 'k. IO Ready' WHEN 'Final Approval' THEN 'l. Final Approval' END;;
    }

  dimension: revenue_line_v2 {
    label: "Revenue Line v2"
    type: string
    sql: CASE
          WHEN ${TABLE}.io_type = 'All - Market Expectation' THEN 'All - Market Expectation'
          WHEN ${TABLE}.io_type = 'Non-Media Reports, Services' THEN 'Non-Media Reports, Services'

      WHEN ${TABLE}.io_type IN (
      'Amobee TV Media Managed',
      'Amobee TV Platform Managed',
      'Amobee TV Platform HOK',
      'Amobee TV Platform ATD',
      'Amobee TV',
      'TV Supply',
      'TV',
      'TV Demand - Media Managed',
      'TV Demand - Platform Managed',
      'TV Demand - HOK'
      ) THEN 'TV'

      WHEN ${TABLE}.io_type = 'Media Managed' THEN 'MS'
      WHEN ${TABLE}.io_type = 'Platform Managed' THEN 'DSP (Self-Service & Managed)'
      WHEN ${TABLE}.io_type ILIKE '%Media%' THEN 'MS'
      WHEN ${TABLE}.io_type ILIKE '%MS%' THEN 'MS'

      WHEN ${TABLE}.io_type IN (
      'Platform ATD',
      'Platform MSP',
      'Platform HOK',
      'SS'
      ) THEN 'DSP (Self-Service & Managed)'
      WHEN ${TABLE}.io_type ILIKE '%Platform%' THEN 'DSP (Self-Service & Managed)'

      WHEN ${TABLE}.io_type IN (
      'Social Managed',
      'Social ATD',
      'Social MSP',
      'Social HOK'
      ) THEN 'Social'
      WHEN ${TABLE}.io_type ILIKE '%Social%' THEN 'Social'

      WHEN ${TABLE}.io_type ILIKE '%PMP%' THEN 'PMP'
      WHEN ${TABLE}.io_type ILIKE '%OMP%' THEN 'PMP'

      ELSE 'Missing'
      END ;;
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

  # dimension: probability_level {
  #   type: number
  #   label: "Probability Level"
  #   sql:
  #   CASE
  #     WHEN ${confidence_level__c} IS NOT NULL
  #         AND ${confidence_level__c} ~ '^[0-9]+(\.[0-9]+)?$' THEN CAST(${confidence_level__c} AS FLOAT)
  #     ELSE CAST(${probability} AS FLOAT)
  #   END ;;
  # }

         #####--MEASURES---####

  measure: sum_booked_full_credit {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.snapshot_Booked_Full_Credit ;;
    label: "GR Booked"
  }

  measure: sum_net_revenue_booked {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.snapshot_Net_Revenue_Booked;;
    label: "NR Booked"
  }

  measure: sum_unweighted_tl_upside_new_forecast_v2 {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
    label: "Unweighted TL Upside"
  }

  measure: sum_unweighted_nr_upside_new_forecast_v2 {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.unweighted_nr_upside_new_forecast_v2 ;;
    label: "Unweighted NR Upside"
  }

  measure: sum_weighted_nr_upside_new_forecast_v2 {
    value_format: "$#,##0.00"
    type: sum
    sql:
    ${TABLE}.Weighted_NR_Upside_New_Forecast_v2;;
    label: "Weighted NR Upside"
  }

  measure: sum_weighted_tl_upside_new_forecast_v2 {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
    label: "Weighted TL Upside"
  }

  measure: sum_gr_forecast_full_credit {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    label: "GR Forecast"
  }

  measure: sum_nr_forecast_full_credit {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.snapshot_NR_Forecast_Full_Credit ;;
    label: "NR Forecast"
  }

  measure: sum_forecast_and_upside_weighted {
    value_format: "$#,##0.00"
    type: number
    label: "NR Forecast + NR Upside (Weighted)"
    sql: ${sum_nr_forecast_full_credit}+${sum_weighted_nr_upside_new_forecast_v2} ;;
  }

  measure: sum_schedule_converted_revenue_v2 {
    value_format: "$#,##0.00"
    type: sum
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
    label: "Schedule Converted Revenue v2"
  }

  measure: unweighted_nr_pipeline {
    label: "Unweighted NR Pipeline"
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2 * ${TABLE}.opportunity_Margin / 100 ;;
  }

  measure: weighted_gr_pipeline {
    label: "Weighted GR Pipeline"
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2  * ${TABLE}.opportunity_probability / 100 ;;
  }

  measure: weighted_nr_pipeline {
    label: "Weighted NR Pipeline"
    type: number
    sql: ${unweighted_nr_pipeline} * ${TABLE}.opportunity_Margin / 100 ;;
  }

  measure: unweighted_gr_pipeline {
    label: "Unweighted GR Pipeline"
    type: sum
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
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
