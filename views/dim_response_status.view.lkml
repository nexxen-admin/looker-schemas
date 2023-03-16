view: dim_response_status {
  sql_table_name: BI_New.V_Dim_Response_Status ;;

  dimension_group: db_create {
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
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
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
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: response_status {
    label: "Response Status"
    description: "The status of the bid response to the publisher.
                  Values:
                  [auction lost]- The bid given was lower then the winning bid.
                  [badadm] - Problem with the Ad-markup code provided (similar to nURL).
                  [bidpricefloor] - The bid given was lower then the publisher's bid floor.
                  [blockedadv] - The domain given is filtered by the publisher's black list.
                  [blockedapp] - The app bundle given is filtered by the publisher's black list.
                  [blockedattr] - Blocked by the creative attributes.
                  [blockedcat] - Blocked by the category passed.
                  [blockeddspseat] - The publisher blocked that DSP seat.
                  [cridblacklist] - The Creative ID is blocked (black list).
                  [cridibv] - Bid blocked because publisher does not want an 'in banner video'.
                  [cridwhitelist] - The Creative ID is not on inclusion list (white list).
                  [dealbidfloor] - The bid was below the price floor of the deal.
                  [insecureadm] - DSP appears to be sending an insecure creative to be served in a secure environment.
                  [invaliddeal] - Mismatch between the deal passed to the deal accepted to the inventory.
                  [minimummargin] - Bid was blocked because it would not have given us the minimum margin configured.
                  [noadomainbundle] - No Adomain was passed.
                  [nocrid] - No Creative ID was passed.
                  [requireadm] - No Ad-markup was passed.
                  [requireadmornurl] - No Ad-markup or NURL was passed.
                  [requiredealid] - no deal ID was passed.
                  [requireprice] - no bid price was passed.
                  [sspbidfilter] -
                  [unknown] - If this is null It's the bids that were made that were not filtered.
                  [vastinvalidvast] - The publisher had a problem with the ad tag, with the Vast environment.
                  [vastinvalidxml] - The publisher had a problem with the ad tag, with the xml environment (Vpaid)."
    type: string
    sql: ${TABLE}.Response_Status ;;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
