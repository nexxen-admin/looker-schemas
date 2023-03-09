connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: publishers_report_monthly_for_finance {
  required_access_grants: [can_view_pub_come_looker]
  label: "publishers report monthly for finance"
  hidden: yes
}

explore: daily_publisher_report_pluto {
  required_access_grants: [can_view_pub_come_looker]
  label: "Daily_Publisher_Reports"
  hidden: yes
}

explore: temp_di_pub_com_looker_test {
  required_access_grants: [can_view_pub_come_looker]
  hidden: yes
}

explore: TaxAct_Hourly_Test {
  required_access_grants: [can_view_pub_come_looker]
  label: "TaxAct_Hourly_Test"
  hidden: yes
}

explore: audigent_kroger_deal_data {
  required_access_grants: [can_view_pub_come_looker]
  label: "Audigent Kroger Data - UTC"
  hidden: yes
}

explore: taxact_daily_report {
  required_access_grants: [can_view_pub_come_looker]
  label: "taxact_daily_report"
  hidden: yes
}

explore: mazda_fy157_ntl_as_video {
  required_access_grants: [can_view_pub_come_looker]
  label: "Mazda FY157_NTL_AS_Video"
  hidden: yes
}

explore: pointsbet_february {
  required_access_grants: [can_view_pub_come_looker]
  label: "pointsbet_february"
  hidden: yes
}

explore: swift_meats_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Swift Meats"
  hidden: yes
}
explore: 14848__international_leadership_summit_ott_11_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "[14849] - International Leadership Summit - OTT"
  hidden: yes
}

explore: duncan_channon_covered_ca_oe23_daily_11_10_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Duncan Channon Covered CA OE23"
  hidden: yes
}

explore: duncan_channon_ctcp_cessation_daily_12_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Duncan Channon - CTCP Cessation"
  hidden: yes
}

explore: uc_health_campaign_id_4561986_daily_02_08_23 {
  required_access_grants: [can_view_pub_come_looker]
  label: "UC Health Campaign ID 4561986"
  hidden: yes
}

explore: world_s_best_cat_litter_daily_03_01_23 {
  required_access_grants: [can_view_pub_come_looker]
  label: "World's Best Cat Litter"
  hidden: yes
}

explore: tremor_forecasting_data_daily {
  required_access_grants: [can_view_pub_come_looker]
  label: "Tremor Current Quarter Forecasting Report"
  hidden: yes
}

explore: just_bare_chicken_case_ready_11_23_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Just Bare Chicken Case Ready"
  hidden: yes
}

explore: just_bare_chicken_prepared_foods_11_23_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Just Bare Chicken Prepared Foods"
  hidden: yes
}

explore: cache_creek_casino_resort_daily_02_08_23 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Cache Creek Casino Resort"
  hidden: yes
}


explore: duncan_channon_covd_01_31_23 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Duncan Channon - COVD T Digital '23"
  hidden: yes
}

explore: omp_gross_net_by_month {
  #required_access_grants: [can_view_pub_come_looker]
  label: "OMP Gross & Net by Month (2023)"
  hidden: yes
}

explore: ctv_frequency_by_month {
  required_access_grants: [can_view_pub_come_looker]
  label: "CTV Frequency by Week"
  hidden: yes
}

explore: the_north_face_phase_1_bi_weekly_11_04_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "The North Face bi-weekly Phase 1"
  hidden: yes
}

explore: progops_tvdsp_pacing_file {
  required_access_grants: [can_view_pub_come_looker]
  label: "ProgOps TVDSP Pacing File"
  hidden: yes
}

explore: best_western_daily_reporting_10_21_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Best Western"
  hidden: yes
}

explore: international_leadership_summit_01_23_23 {
  required_access_grants: [can_view_pub_come_looker]
  label: "International Leadership Summit (AI Media Group, New York): ILS P2 Campaign :: 1.19.23-4.20.23"
  hidden: yes
}

explore: priority_health_daily_09_19_11 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Priority Health"
  hidden: yes
}

explore: uchealth_campaignid__4452586_daily_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "UC Health Campaign ID: 4452586 Daily"
  hidden: yes
}

explore: uchealth_campaignid_4459456_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "UC Health Campaign ID: 4459456 Daily"
  hidden: yes
}

explore: amherst_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Amherst"
  hidden: yes
}

explore: msu_admissions_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "MSU Admissions"
  hidden: yes
}

explore: msu_brands_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "MSU Brands"
  hidden: yes
}

explore: woman_thou_art_loosed_06_28_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Woman Thou Art Loosed"
  hidden: yes
}

explore: rust_oleum_fy23_walmart_video_10_04_16 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Rust Oleum FY23 Walmart Video"
  hidden: yes
}

explore: choctaw_casinos___resorts_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Choctaw Casinos & Resorts"
  hidden: yes
}


explore: altamed_health_services_06_16_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "AltaMed Health Services"
  hidden: yes
}


explore: california_tobacco_control_program_06_01_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "California Tobacco Control Program"
  hidden: yes
}

explore: just_bare_chicken_5_27_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Just Bare Chicken"
  hidden: yes
}

explore: oerb_daily_08_05_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "OERB"
  hidden: yes
}


explore: biltmore_daily_08_05_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Biltmore"
  hidden: yes
}

explore: habush_daily_report_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Habush"
  hidden: yes
}

explore: wisconsin_tourism_board_chicago_07_26_25 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Wisconsin Tourism Board Chicago"
  hidden: yes
}

explore: wisconsin_tourism_board_non_chicago_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Wisconsin Tourism Board Non-Chicago"
  hidden: yes
}

explore: mattress_firm_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Mattress Firm"
  hidden: yes
}

explore: moe_s_southwest_grill_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Moe's Southwest Grill"
  hidden: yes
}

explore: kiolbassa_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Kiolbassa"
  hidden: yes
}

explore: jbs_adaptable_4_13_2022 {
  required_access_grants: [can_view_pub_come_looker]
  label: "JBS Adaptable"
  hidden: yes
}

explore: planterra_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Planterra"
  hidden: yes
}

explore: purple_mattress_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Purple Mattress"
  hidden: yes
}


explore: covered_ca {
  required_access_grants: [can_view_pub_come_looker]
  label: "covered_ca "
  hidden: yes
}


explore: pilgrim_s_pride_report {
  required_access_grants: [can_view_pub_come_looker]
  label: "Pilgrim's Pride Report"
  hidden: yes
}

explore: QPSxRPM {
  required_access_grants: [can_view_pub_come_looker]
  label: "QPSxRPM Supply"
  hidden: yes
}
