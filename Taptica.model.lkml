connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
 explore: daily_activity_fact {
  join: advertiser_dim {
    type: left_outer
    view_label: "Advertisers"
     relationship: many_to_one
     sql_on: ${advertiser_dim.adv_id} = ${daily_activity_fact.adv_id} ;;
   }

  join: offers_dim {
    type: left_outer
    view_label: "Offers"
    relationship: many_to_one
     sql_on: ${offers_dim.offer_id} = ${daily_activity_fact.offer_id} ;;
   }

  join: pub_offers_dim {
    type: left_outer
    view_label: "Publishers Offers"
    relationship: many_to_one
    sql_on: ${pub_offers_dim.offer_id} = ${daily_activity_fact.offer_id}
    and ${pub_offers_dim.pub_id} = ${daily_activity_fact.publisher_id};;
  }

  join: publishers_dim {
    type: left_outer
    view_label: "Publishers"
    relationship: many_to_one
    sql_on: ${publishers_dim.pub_id} = ${daily_activity_fact.publisher_id}
      ;;
  }

  join: advertisers_lk {
    type: left_outer
    view_label: "Advertisers"
    relationship: one_to_one
    sql_on: ${advertisers_lk.id} = ${advertiser_dim.adv_id}
      ;;
  }
}
