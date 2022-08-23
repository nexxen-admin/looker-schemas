# The name of this view in Looker is "Impression R"
view: impression_r {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: Andromeda.impression_r ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Adomain" in Explore.

  dimension: adomain {
    type: string
    sql: ${TABLE}.adomain ;;
  }

  dimension: adsize {
    type: string
    sql: ${TABLE}.adsize ;;
  }

  dimension: api {
    type: string
    sql: ${TABLE}.api ;;
  }

  dimension: appbundle {
    type: string
    sql: ${TABLE}.appbundle ;;
  }

  dimension: appexid {
    type: string
    sql: ${TABLE}.appexid ;;
  }

  dimension: appid {
    type: string
    sql: ${TABLE}.appid ;;
  }

  dimension: appname {
    type: string
    sql: ${TABLE}.appname ;;
  }

  dimension: auctionprice {
    type: number
    sql: ${TABLE}.auctionprice ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_auctionprice {
    type: sum
    sql: ${auctionprice} ;;
    hidden: yes
  }

  measure: average_auctionprice {
    type: average
    sql: ${auctionprice} ;;
    hidden: yes
  }

  dimension: battr {
    type: string
    sql: ${TABLE}.battr ;;
    hidden: yes
  }

  measure: bidfloor {
    type: sum
    label: "Bid Floor"
    sql: ${TABLE}.bidfloor ;;
  }

  measure: bidfloorconfig_mean {
    type: sum
    label: "Bid FloorConfig Mean"
    sql: ${TABLE}.bidfloorconfig_mean ;;
  }

  dimension: bidfloorconfig_method {
    type: string
    label: "Bid FloorConfig Method"
    sql: ${TABLE}.bidfloorconfig_method ;;
  }

  dimension: bidfloorconfig_name {
    type: string
    label: "Bid FloorConfig Name"
    sql: ${TABLE}.bidfloorconfig_name ;;
  }

  dimension: bidfloorconfig_stddev {
    type: number
    sql: ${TABLE}.bidfloorconfig_stddev ;;
  }

  measure: bidfloorconfig_weight {
    type: average
    sql: (${TABLE}.bidfloorconfig_weight)/100 ;;

  }

  dimension: bidkey {
    type: string
    sql: ${TABLE}.bidkey ;;
    hidden: yes
  }

  measure: bidprice {
    type: sum
    sql: ${TABLE}.bidprice ;;
  }

  dimension: buyeruid {
    type: string
    label: "Buyer UID"
    sql: ${TABLE}.buyeruid ;;
  }

  dimension: cid {
    type: string
    sql: ${TABLE}.cid ;;
    hidden: yes
  }

  dimension: cntcat {
    type: string
    sql: ${TABLE}.cntcat ;;
    hidden: yes
  }

  dimension: cntcontentrating {
    type: string
    sql: ${TABLE}.cntcontentrating ;;
    hidden: yes
  }

  dimension: cntepisode {
    type: number
    sql: ${TABLE}.cntepisode ;;
    hidden: yes
  }

  dimension: cntgenre {
    type: string
    sql: ${TABLE}.cntgenre ;;
    hidden: yes
  }

  dimension: cntlanguage {
    type: string
    sql: ${TABLE}.cntlanguage ;;
    hidden: yes
  }

  dimension: cntlanguagenorm {
    type: string
    sql: ${TABLE}.cntlanguagenorm ;;
    hidden: yes
  }

  dimension: cntlivestream {
    type: yesno
    sql: ${TABLE}.cntlivestream ;;
    hidden: yes
  }

  dimension: cntnetwork {
    type: string
    sql: ${TABLE}.cntnetwork ;;
    hidden: yes
  }

  dimension: cntseason {
    type: string
    sql: ${TABLE}.cntseason ;;
    hidden: yes
  }

  dimension: cntseries {
    type: string
    sql: ${TABLE}.cntseries ;;
    hidden: yes
  }

  dimension: cnttitle {
    type: string
    sql: ${TABLE}.cnttitle ;;
    hidden: yes
  }

  measure: commissionconfig_mean {
    type: number
    sql: ${TABLE}.commissionconfig_mean ;;
    hidden: yes
  }

  dimension: commissionconfig_method {
    type: string
    label: "CommissionConfig Method"
    sql: ${TABLE}.commissionconfig_method ;;
  }

  dimension: commissionconfig_name {
    type: string
    label: "CommissionConfig Name"
    sql: ${TABLE}.commissionconfig_name ;;
  }

  measure: commissionconfig_weight {
    type: average
    sql: (${TABLE}.commissionconfig_weight)/100 ;;

  }

  dimension: contentratingnorm {
    type: string
    sql: ${TABLE}.contentratingnorm ;;
    hidden: yes
  }

  dimension: country {
    type: string
    label: "Country"
    map_layer_name: countries
    sql: ${TABLE}.country ;;

  }

  dimension: crid {
    type: string
    sql: ${TABLE}.crid ;;
    hidden: yes
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
    hidden: yes
  }

  dimension: dealauctiontype {
    type: string
    label: "Deal Auction Type"
    sql: ${TABLE}.dealauctiontype ;;
  }

  measure: dealbidfloor {
    type: sum
    label: "Deal Bid Floor"
    sql: ${TABLE}.dealbidfloor ;;
  }

  dimension: dealdatafee {
    type: number
    sql: ${TABLE}.dealdatafee ;;
    hidden: yes
  }

  dimension: device {
    type: string
    label: "Device"
    sql: ${TABLE}.device ;;
  }

  dimension: devicetype {
    type: number
    label: "Device Type"
    sql: ${TABLE}.devicetype ;;
  }

  dimension: doc_version {
    type: number
    sql: ${TABLE}.doc_version ;;
    hidden: yes
  }

  measure: dspbidfloor {
    type: sum
    label: "DSP Bid Floor"
    sql: ${TABLE}.dspbidfloor ;;
  }

  dimension: dspbidid {
    type: string
    sql: ${TABLE}.dspbidid ;;
    hidden: yes
  }

  measure: dspbidprice {
    type: sum
    label: "DSP Bid Price"
    sql: ${TABLE}.dspbidprice ;;
  }

  dimension: dspcloseprice {
    type: number
    sql: ${TABLE}.dspcloseprice ;;
    hidden: yes
  }

  dimension: dspdealid {
    type: string
    label: "Dsp Deal ID"
    sql: ${TABLE}.dspdealid ;;

  }

  dimension: dspdealtype {
    type: string
    sql: ${TABLE}.dspdealtype ;;
    hidden: yes
  }

  dimension: dspid {
    type: string
    sql: ${TABLE}.dspid ;;
    hidden: yes
  }

  dimension: dspreqhasdeal {
    type: number
    sql: ${TABLE}.dspreqhasdeal ;;
    hidden: yes
  }

  dimension: dspseat {
    type: string
    sql: ${TABLE}.dspseat ;;
    hidden: yes
  }

  dimension: dspseat_old {
    type: number
    sql: ${TABLE}.dspseat_old ;;
    hidden: yes
  }

  dimension: dvabssegmentid {
    type: string
    sql: ${TABLE}.dvabssegmentid ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.event_time ;;
  }

  dimension: genrenorm {
    type: string
    sql: ${TABLE}.genrenorm ;;
    hidden: yes
  }

  dimension: ifa {
    type: string
    sql: ${TABLE}.ifa ;;
    hidden: yes
  }

  dimension: impsubtype {
    type: string
    sql: ${TABLE}.impsubtype ;;
    hidden: yes
  }

  dimension: imptype {
    type: string
    sql: ${TABLE}.imptype ;;
    hidden: yes
  }

  dimension: inview {
    type: string
    sql: ${TABLE}.inview ;;
    hidden: yes
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
    hidden: yes
  }

  dimension: isbillable {
    type: number
    sql: ${TABLE}.isbillable ;;
  }

  dimension: iscost {
    type: number
    sql: ${TABLE}.iscost ;;
  }

  dimension: issample {
    type: number
    sql: ${TABLE}.issample ;;
  }

  dimension_group: loaded {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.loaded ;;
    hidden: yes
  }

  dimension: markdownconfig_mean {
    type: number
    sql: ${TABLE}.markdownconfig_mean ;;
    hidden: yes
  }

  dimension: markdownconfig_name {
    type: string
    sql: ${TABLE}.markdownconfig_name ;;
    hidden: yes
  }

  dimension: markdownconfig_stddev {
    type: number
    sql: ${TABLE}.markdownconfig_stddev ;;
    hidden: yes
  }

  dimension: markdownconfig_weight {
    type: number
    sql: ${TABLE}.markdownconfig_weight ;;
    hidden: yes
  }

  dimension: mediatype {
    type: string
    sql: ${TABLE}.mediatype ;;
    hidden: yes
  }

  dimension: mlinfo_aud_exp_labels {
    type: string
    sql: ${TABLE}.mlinfo_aud_exp_labels ;;
    hidden: yes
  }

  dimension: mlinfo_aud_exp_scales {
    type: string
    sql: ${TABLE}.mlinfo_aud_exp_scales ;;
    hidden: yes
  }

  dimension: mlinfo_clickthrough {
    type: number
    sql: ${TABLE}.mlinfo_clickthrough ;;
    hidden: yes
  }

  dimension: mlinfo_dv_viewability {
    type: number
    sql: ${TABLE}.mlinfo_dv_viewability ;;
    hidden: yes
  }

  dimension: mlinfo_ias_groupm_viewability {
    type: number
    sql: ${TABLE}.mlinfo_ias_groupm_viewability ;;
    hidden: yes
  }

  dimension: mlinfo_ias_iewability {
    type: number
    sql: ${TABLE}.mlinfo_ias_iewability ;;
    hidden: yes
  }

  dimension: mlinfo_ias_ivt {
    type: number
    sql: ${TABLE}.mlinfo_ias_ivt ;;
    hidden: yes
  }

  dimension: mlinfo_listen_through_rate {
    type: number
    sql: ${TABLE}.mlinfo_listen_through_rate ;;
    hidden: yes
  }

  dimension: mlinfo_moat_viewability {
    type: number
    sql: ${TABLE}.mlinfo_moat_viewability ;;
    hidden: yes
  }

  dimension: mlinfo_sampling {
    type: number
    sql: ${TABLE}.mlinfo_sampling ;;
    hidden: yes
  }

  dimension: mlinfo_tremor_viewability {
    type: number
    sql: ${TABLE}.mlinfo_tremor_viewability ;;
    hidden: yes
  }

  dimension: mlinfo_version {
    type: string
    sql: ${TABLE}.mlinfo_version ;;
    hidden: yes
  }

  dimension: mlinfo_video_completion {
    type: number
    sql: ${TABLE}.mlinfo_video_completion ;;
    hidden: yes
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
    hidden: yes
  }

  dimension: origdomain {
    type: string
    sql: ${TABLE}.origdomain ;;
    hidden: yes
  }

  dimension: origuserid {
    type: string
    label: "Orig User ID"
    sql: ${TABLE}.origuserid ;;
  }

  dimension: os {
    type: string
    label: "OS"
    sql: ${TABLE}.os ;;
  }

  dimension: osv {
    type: string
    label: "OS Version"
    sql: ${TABLE}.osv ;;
  }

  dimension: padamount {
    type: number
    sql: ${TABLE}.padamount ;;
    hidden: yes
  }

  dimension: player {
    type: string
    sql: ${TABLE}.player ;;
    hidden: yes
  }

  dimension: pos {
    type: number
    sql: ${TABLE}.pos ;;
    hidden: yes
  }

  dimension: profile {
    type: string
    sql: ${TABLE}."profile" ;;
    hidden: yes
  }

  dimension: profileid {
    type: string
    sql: ${TABLE}.profileid ;;
    hidden: yes
  }

  dimension: pubexid {
    type: string
    sql: ${TABLE}.pubexid ;;
    hidden: yes
  }

  dimension: pubid {
    type: string
    sql: ${TABLE}.pubid ;;
    hidden: yes
  }

  measure: publishercost {
    type: sum
    label: "Pub Cost"
    sql: ${TABLE}.publishercost ;;
  }

  dimension: pubplatformfee {
    type: number
    sql: ${TABLE}.pubplatformfee ;;
    hidden: yes
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    hidden: yes
  }

  dimension: requestid {
    type: string
    label: "Request ID"
    sql: ${TABLE}.requestid ;;
  }

  dimension: revenuetype {
    type: string
    label: "Revenue Type"
    sql: ${TABLE}.revenuetype ;;
  }

  dimension: rgblocked {
    type: string
    sql: ${TABLE}.rgblocked ;;
    hidden: yes
  }

  dimension: rgblockedreason {
    type: string
    sql: ${TABLE}.rgblockedreason ;;
    hidden: yes
  }

  dimension: secure {
    type: string
    sql: ${TABLE}.secure ;;
    hidden: yes
  }

  dimension: siteexid {
    type: string
    sql: ${TABLE}.siteexid ;;
    hidden: yes
  }

  dimension: siteid {
    type: string
    sql: ${TABLE}.siteid ;;
    hidden: yes
  }

  dimension: placement_id {
    type: string
    sql: coalesce(${TABLE}.siteid ,${TABLE}.appid);;
   # hidden: yes
  }


  dimension: sitename {
    type: string
    sql: ${TABLE}.sitename ;;
    hidden: yes
  }

  dimension: source {
    type: string
    label: "Source"
    sql: ${TABLE}."source" ;;

  }
  measure: weigted_profit  {
    type: sum
    label: "Impbeacon BidFloor Weighted Profit"
    sql: case when ${source} = 'impbeacon' then ((${TABLE}.winprice-${TABLE}.publishercost)/${TABLE}.bidfloorconfig_weight)/10 end;;

  }


  measure: weigted_profit_comm  {
    type: sum
    label: "Impbeacon Comm Weighted Profit"
    sql: case when ${source} = 'impbeacon' then ((${TABLE}.winprice-${TABLE}.publishercost)/${TABLE}.commissionconfig_weight)/10 end;;

  }

  measure: weigted_revenue  {
    type: sum
    label: "Impbeacon BidFloor Weighted Revenue"
    sql: case when ${source} = 'impbeacon' then ((${TABLE}.publishercost)/${TABLE}.bidfloorconfig_weight)/10 end;;

  }


  measure: weigted_revenue_comm  {
    type: sum
    label: "Impbeacon Comm Weighted Revenue"
    sql: case when ${source} = 'impbeacon' then ((${TABLE}.publishercost)/${TABLE}.commissionconfig_weight)/10 end;;

  }

  measure: sspbidfloor {
    type: sum
    label: "SSP Bid Floor"
    sql: ${TABLE}.sspbidfloor ;;
  }

  measure: sspbidprice {
    type: sum
    label: "SSP Bid Price"
    sql: ${TABLE}.sspbidprice ;;
  }

  dimension: sspcid {
    type: string
    sql: ${TABLE}.sspcid ;;
    hidden: yes
  }

  dimension: sspcrid {
    type: string
    sql: ${TABLE}.sspcrid ;;
    hidden: yes
  }

  dimension: sspdealid {
    type: string
    label: "SSP Deal ID"
    sql: ${TABLE}.sspdealid ;;
  }

  dimension: sspdealtype {
    type: string
    sql: ${TABLE}.sspdealtype ;;
    hidden: yes
  }

  dimension: sspid {
    type: string
    label: "ssp id"
    sql: ${TABLE}.sspid ;;

  }

  dimension: ssprevshare {
    type: number
    sql: ${TABLE}.ssprevshare ;;
    hidden: yes
  }

  dimension: sspwinprice {
    type: number
    sql: ${TABLE}.sspwinprice ;;
    hidden: yes
  }

  dimension: subjecttogdpr {
    type: number
    sql: ${TABLE}.subjecttogdpr ;;
    hidden: yes
  }

  dimension: tagid {
    type: string
    sql: ${TABLE}.tagid ;;
    hidden: yes
  }

  dimension: tldomainorig {
    type: string
    sql: ${TABLE}.tldomainorig ;;
    hidden: yes
  }

  dimension: ua {
    type: string
    sql: ${TABLE}.ua ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    label: "USER ID"
    sql: ${TABLE}.userid ;;
  }

  dimension: vastservemethod {
    type: string
    sql: ${TABLE}.vastservemethod ;;
    hidden: yes
  }

  dimension: videoapi {
    type: string
    sql: ${TABLE}.videoapi ;;
    hidden: yes
  }

  measure : videolinearity {
    type: sum
    sql: ${TABLE}.videolinearity ;;
    hidden: yes
  }

  dimension: videomimes {
    type: string
    sql: ${TABLE}.videomimes ;;
    hidden: yes
  }

  dimension: videosimplesize {
    type: string
    sql: ${TABLE}.videosimplesize ;;
    hidden: yes
  }

  dimension: viewable {
    type: string
    sql: ${TABLE}.viewable ;;
    hidden: yes
  }

  measure: winprice {
    type: sum
    label: "Win Price"
    sql: ${TABLE}.winprice ;;

  }

  dimension: hour {
    type: number
    label: "Hour"
    sql: hour(${TABLE}.event_time) ;;

  }


  measure: count {
    type: count
    drill_fields: [bidfloorconfig_name, appname, markdownconfig_name, sitename, commissionconfig_name]
    hidden: yes
  }
}
