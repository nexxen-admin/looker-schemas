# The name of this view in Looker is "Dim Dsp Package"
view: dim_dsp_package {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_package ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Activate" in Explore.

  dimension: activate {
    type: yesno
    sql: ${TABLE}.activate ;;
    hidden: yes
  }

  dimension: adjusted_impressions_type_id {
    type: number
    sql: ${TABLE}.adjusted_impressions_type_id ;;
  }

  dimension: adjusted_impressions_value {
    type: number
    sql: ${TABLE}.adjusted_impressions_value ;;
  }

  dimension: advanced_targeting {
    type: yesno
    sql: ${TABLE}.advanced_targeting ;;
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden: yes
  }

  dimension: bid_strategy {
    type: number
    sql: ${TABLE}.bid_strategy ;;
  }

  dimension: billing_basis_id {
    type: number
    sql: ${TABLE}.billing_basis_id ;;
  }

  dimension: billing_percent {
    type: number
    sql: ${TABLE}.billing_percent ;;
  }

  dimension: budget_allocated {
    type: number
    sql: ${TABLE}.budget_allocated ;;
    }

  dimension_group: budget_attr_lmd {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.budget_attr_lmd ;;
    hidden: yes
  }

  dimension: budget_remaining {
    type: number
    sql: ${TABLE}.budget_remaining ;;
  }

  dimension: budget_remainingl {
    type: number
    sql: ${TABLE}.budget_remainingl ;;
    hidden: yes
  }

  dimension: budget_used {
    type: number
    sql: ${TABLE}.budget_used ;;
    hidden: yes
  }

  dimension: budget_used_through_yesterday {
    type: number
    sql: ${TABLE}.budget_used_through_yesterday ;;
  }

  dimension: budget_used_through_yesterdayl {
    type: number
    sql: ${TABLE}.budget_used_through_yesterdayl ;;
    hidden: yes
  }

  dimension: budget_usedl {
    type: number
    sql: ${TABLE}.budget_usedl ;;
    hidden: yes
  }

  dimension: budgeted_days {
    type: number
    sql: ${TABLE}.budgeted_days ;;
  }

  dimension: client_status_id {
    type: number
    sql: ${TABLE}.client_status_id ;;
  }

  dimension: consolidated_line_items {
    type: yesno
    sql: ${TABLE}.consolidated_line_items ;;
  }

  dimension_group: created_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_date ;;
    hidden: yes
  }

  dimension: cross_device {
    type: number
    sql: ${TABLE}.cross_device ;;
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: default_package {
    type: yesno
    sql: ${TABLE}.default_package ;;
  }

  dimension: ecal {
    type: number
    sql: ${TABLE}.ecal ;;
  }

  dimension: ecpa {
    type: number
    sql: ${TABLE}.ecpa ;;
  }

  dimension: ecpc {
    type: number
    sql: ${TABLE}.ecpc ;;
  }

  dimension: ecpl {
    type: number
    sql: ${TABLE}.ecpl ;;
  }

  dimension: effective_daily_target {
    type: number
    sql: ${TABLE}.effective_daily_target ;;
  }

  dimension: effective_daily_targetl {
    type: number
    sql: ${TABLE}.effective_daily_targetl ;;
    hidden: yes
  }

  dimension: effective_impression_cap {
    type: number
    sql: ${TABLE}.effective_impression_cap ;;
  }

  dimension_group: end_date_backup {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.end_date_backup ;;
    hidden: yes
  }

  dimension: experiment_id {
    type: number
    sql: ${TABLE}.experiment_id ;;
  }

  dimension: experiment_tag {
    type: string
    sql: ${TABLE}.experiment_tag ;;
  }

  dimension: external_packag_id {
    type: string
    sql: ${TABLE}.external_packag_id ;;
  }

  dimension: financial_sor_id {
    type: number
    sql: ${TABLE}.financial_sor_id ;;
  }

  dimension_group: first_impression {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_impression_date ;;
  }

  dimension: grp {
    type: yesno
    sql: ${TABLE}.grp ;;
  }

  dimension: hard_budget {
    type: yesno
    sql: ${TABLE}.hard_budget ;;
  }

  dimension: hh_impression_cap_period {
    type: number
    sql: ${TABLE}.hh_impression_cap_period ;;
  }

  dimension: hh_impression_cap_value {
    type: number
    sql: ${TABLE}.hh_impression_cap_value ;;
  }

  dimension: implied_daily_target {
    type: number
    sql: ${TABLE}.implied_daily_target ;;
  }

  dimension: implied_daily_targetl {
    type: number
    sql: ${TABLE}.implied_daily_targetl ;;
    hidden: yes
  }

  dimension: impression_cap_period {
    type: number
    sql: ${TABLE}.impression_cap_period ;;
  }

  dimension: impression_cap_value {
    type: number
    sql: ${TABLE}.impression_cap_value ;;
  }

  dimension: impression_pacing {
    type: yesno
    sql: ${TABLE}.impression_pacing ;;
  }

  dimension: impression_remaining {
    type: number
    sql: ${TABLE}.impression_remaining ;;
  }

  dimension: impression_through_yesterday {
    type: number
    sql: ${TABLE}.impression_through_yesterday ;;
  }

  dimension: impression_used {
    type: number
    sql: ${TABLE}.impression_used ;;
  }

  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }

  dimension: inventory_type_id {
    type: number
    sql: ${TABLE}.inventory_type_id ;;
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
  dimension: io_number {
    type: string
    sql: ${TABLE}.io_number ;;
  }

  dimension_group: last_dist {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_dist_time ;;
    hidden: yes
  }

  dimension_group: last_modified_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }

  dimension: locked {
    type: yesno
    sql: ${TABLE}.locked ;;
  }

  dimension: max_markup_percent {
    type: number
    sql: ${TABLE}.max_markup_percent ;;
  }

  dimension: media_channel_id {
    type: number
    sql: ${TABLE}.media_channel_id ;;
  }

  dimension: min_markup_percent {
    type: number
    sql: ${TABLE}.min_markup_percent ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
    drill_fields: [dim_sfdb_opportunitylineitem.tactic]
  }

  dimension: optimization_strategy {
    type: number
    sql: ${TABLE}.optimization_strategy ;;
  }

  dimension: optimized_budget {
    type: yesno
    sql: ${TABLE}.optimized_budget ;;
  }

  dimension: original_packag_id {
    type: number
    sql: ${TABLE}.original_packag_id ;;
  }

  dimension: pacing_factor {
    type: number
    sql: ${TABLE}.pacing_factor ;;
  }

  dimension: pacing_type_id {
    type: number
    sql: ${TABLE}.pacing_type_id ;;
  }

  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }

  dimension: package_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.package_id_key ;;
    hidden: yes
  }

  dimension: preventative_frequency_cap {
    type: yesno
    sql: ${TABLE}.preventative_frequency_cap ;;
  }

  dimension: remaining_days {
    type: number
    sql: ${TABLE}.remaining_days ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: rpm {
    type: number
    sql: ${TABLE}.rpm ;;
  }

  dimension: rpml {
    type: number
    sql: ${TABLE}.rpml ;;
    hidden: yes
  }

  dimension: spend_rate {
    type: number
    sql: ${TABLE}.spend_rate ;;
  }

  dimension: spend_ratel {
    type: number
    sql: ${TABLE}.spend_ratel ;;
    hidden: yes
  }

  dimension: spending_cap_backup {
    type: number
    sql: ${TABLE}.spending_cap_backup ;;
  }

  dimension_group: start_date_backup {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_date_backup ;;
    hidden: yes
  }

  dimension: strict_frequency_cap {
    type: yesno
    sql: ${TABLE}.strict_frequency_cap ;;
  }

  dimension: tpa_ecpa {
    type: number
    sql: ${TABLE}.tpa_ecpa ;;
  }

  dimension: tpa_ecpal {
    type: number
    sql: ${TABLE}.tpa_ecpal ;;
    hidden: yes
  }

  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }

  dimension_group: version_last_modified {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.version_last_modified_date ;;
    hidden: yes
  }

  dimension: viewability_enabled {
    type: yesno
    sql: ${TABLE}.viewability_enabled ;;
  }

  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
  }

  dimension:  package_nickname {
    type: string
    sql: ${TABLE}.package_nickname ;;
  }

  dimension:  package_group_b {
    type: string
    sql: ${TABLE}.package_group_b ;;
  }

  dimension:  package_group_c {
    type: string
    sql: ${TABLE}.package_group_c ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
