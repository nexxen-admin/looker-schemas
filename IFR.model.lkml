connection: "ifr"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

#access_grant: can_view_pub_come_looker {
#  user_attribute: admins
#  allowed_values: ["Looker_Admins"]
#}

 access_grant: ifr_data {
   user_attribute: ifr_data
   allowed_values: ["ifr_data_by_date"]
 }


# explore: ifr_data{
#   label: "IFR Data"
#   required_access_grants: [ifr_dataa]
# }

explore: ifr_data_by_date{
  label: "IFR By Date"
   required_access_grants: [ifr_data]
  hidden: yes
}

explore: ifr_data_margin{
  label: "IFR Data Margin"
  required_access_grants: [ifr_data]
  always_filter: {
    filters: [ifr_data_margin.impression_date_date: "1 day ago for 1 day"]
  }
  #hidden: yes
}
