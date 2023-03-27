connection: "snowflake"
label: "Clarity"
# include all the views
include: "clar_*.view"

# include all the dashboards
#include: "*.dashboard"


explore: process_message {
  #hidden: yes
  view_label: "Clarity"
  label: "Clarity Process Message"
}

explore: prk_metrics {
  view_label: "Clarity"
  label: "RTA p_rk Metrics"


}
