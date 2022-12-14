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
}

explore: daily_publisher_report_pluto {
  required_access_grants: [can_view_pub_come_looker]
  label: "Daily_Publisher_Reports"
}

explore: temp_di_pub_com_looker_test {
  required_access_grants: [can_view_pub_come_looker]
}

explore: TaxAct_Hourly_Test {
  required_access_grants: [can_view_pub_come_looker]
  label: "TaxAct_Hourly_Test"
}

explore: audigent_kroger_deal_data {
  required_access_grants: [can_view_pub_come_looker]
  label: "Audigent Kroger Data - UTC"
}

explore: taxact_daily_report {
  required_access_grants: [can_view_pub_come_looker]
  label: "taxact_daily_report"
}

explore: mazda_fy157_ntl_as_video {
  required_access_grants: [can_view_pub_come_looker]
  label: "Mazda FY157_NTL_AS_Video"
}

explore: pointsbet_february {
  required_access_grants: [can_view_pub_come_looker]
  label: "pointsbet_february"
}

explore: swift_meats_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Swift Meats"
}
explore: 14848__international_leadership_summit_ott_11_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "[14849] - International Leadership Summit - OTT"
}

explore: duncan_channon_covered_ca_oe23_daily_11_10_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Duncan Channon Covered CA OE23"
}

explore: duncan_channon_ctcp_cessation_daily_12_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Duncan Channon - CTCP Cessation"
}

explore: just_bare_chicken_case_ready_11_23_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Just Bare Chicken Case Ready"
}

explore: just_bare_chicken_prepared_foods_11_23_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Just Bare Chicken Prepared Foods"
}

explore: ctv_frequency_by_month {
  required_access_grants: [can_view_pub_come_looker]
  label: "CTV Frequency by Week"
}

explore: the_north_face_phase_1_bi_weekly_11_04_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "The North Face bi-weekly Phase 1"
}

explore: best_western_daily_reporting_10_21_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Best Western"
}

explore: priority_health_daily_09_19_11 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Priority Health"
}

explore: uchealth_campaignid__4452586_daily_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "UC Health Campaign ID: 4452586 Daily"
}

explore: uchealth_campaignid_4459456_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "UC Health Campaign ID: 4459456 Daily"
}

explore: amherst_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Amherst"
}

explore: msu_admissions_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "MSU Admissions"
}

explore: msu_brands_daily_09_19_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "MSU Brands"
}

explore: woman_thou_art_loosed_06_28_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Woman Thou Art Loosed"
}

explore: rust_oleum_fy23_walmart_video_10_04_16 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Rust Oleum FY23 Walmart Video"
}

explore: choctaw_casinos___resorts_10_17_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Choctaw Casinos & Resorts"
}


explore: altamed_health_services_06_16_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "AltaMed Health Services"
}


explore: california_tobacco_control_program_06_01_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "California Tobacco Control Program"
}

explore: just_bare_chicken_5_27_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Just Bare Chicken"
}

explore: oerb_daily_08_05_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "OERB"
}


explore: biltmore_daily_08_05_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Biltmore"
}

explore: habush_daily_report_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Habush"
}

explore: wisconsin_tourism_board_chicago_07_26_25 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Wisconsin Tourism Board Chicago"
}

explore: wisconsin_tourism_board_non_chicago_07_26_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Wisconsin Tourism Board Non-Chicago"
}

explore: mattress_firm_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Mattress Firm"
}

explore: moe_s_southwest_grill_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Moe's Southwest Grill"
}

explore: kiolbassa_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Kiolbassa"
}

explore: jbs_adaptable_4_13_2022 {
  required_access_grants: [can_view_pub_come_looker]
  label: "JBS Adaptable"
}

explore: planterra_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Planterra"
}

explore: purple_mattress_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  label: "Purple Mattress"
}


explore: covered_ca {
  required_access_grants: [can_view_pub_come_looker]
  label: "covered_ca "
}


explore: pilgrim_s_pride_report {
  required_access_grants: [can_view_pub_come_looker]
  label: "Pilgrim's Pride Report"
}

explore: QPSxRPM {
  required_access_grants: [can_view_pub_come_looker]
  label: "QPSxRPM Supply"
}
