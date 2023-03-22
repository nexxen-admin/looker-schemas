connection: "snowflake"
label: "DSP Analytics"
include: "/amobee_dsp/sno_*.view"
case_sensitive: no

access_grant: can_view_test_explores {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: supply_qps_and_bids {
  required_access_grants: [can_view_test_explores]
  hidden: yes
  label: "Supply QPS and Bids"
  description: "This data can be analyzed by the supply dimensions. This data is available by-day for the last 4 months
  and by-hour for one day before yesterday."
}
