view: dim_request_status {
  sql_table_name: BI_New.V_Dim_Request_Status ;;

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

  dimension:  is_valid_requests {
    label: "Is Valid Requests"
    description: "There was no problem with the requests"
    sql: case
    when ${TABLE}.Request_Status in ('nodsp','nodspbids','bidresponse','pass','unknown')
    then 'True' else 'False'
    end
    ;;
  }

  dimension: request_status {
    label: "Request Status"
    description: "The Status of the bid request sent by the publisher.
                  Values:
                  nodspbids - we sent the request to dsp, but the dsp didn’t bid.
                  nodsp - we don’t have any dsps that we could send this request to.
                  sspreqthrottled - indicates an internal config problem.
                  rg-block-user - Rhythm Guard blocked this request.
                  rg-block-source - Rhythm Guard blocked this request.
                  bidresponse - we received a response from one or more dsps, but we filtered out the bids due to a bad crid (either not in the whitelist if that DSP has a crid whitelist or in the blacklist) or secure reasons (impression is secure, but the bidresponse adm has 'http' urls instead of 'https'.
                  blacklist-domainglobal - url blocked due to appearance in global blacklist.
                  requestdata - the request came from an SSP that’s not active in the system.
                  rg-block-source-user - Rhythm Guard blocked this request .
                  buildrequest-missingua - No User Agent.
                  buildrequest-missingdeviceip - device object needs an ip or ipv6 field.
                  buildrequest-badpmpreq - a deal that is a private auction but non of the deals in it were set up in our system.
                  buildrequest-missingsitepage - we require a page in the site object.
                  buildrequest-blockedglobalcountry - a business decision to excluded inventory from several countries.
                  buildrequest-impbannernodimensions - Banner inventory requires dimensions like 728x90 or 300x600.
                  buildrequest-impinvaliddimensions - 0/not a number/out of boundaries dimensions.
                  buildrequest-impnativenonativerequest - request without video, banner or native object.
                  buildrequest-impvideonomimes - Mimes is a required field for video (at least for CTRL)."
    type: string
    sql: case
    when ${TABLE}.Request_Status in ('unknown','nodsp','nodspbids','bidresponse','pass') then 'Admissible'
    else ${TABLE}.Request_Status
    end;;
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
