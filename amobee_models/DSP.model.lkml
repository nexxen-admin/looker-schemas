connection: "snowflake"
label: "DSP Analytics"
include: "/**/*.view.lkml"
case_sensitive: no

explore: supply_qps_and_bids {
  hidden: yes
  label: "Supply QPS and Bids"
  description: "This data can be analyzed by the supply dimensions. This data is available by-day for the last 4 months
  and by-hour for one day before yesterday."
}
