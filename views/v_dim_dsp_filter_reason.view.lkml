# The name of this view in Looker is "V Dim Dsp Filter Reason"
view: v_dim_dsp_filter_reason {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_DSP_Filter_Reason ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Dsp Filter Reason" in Explore.

  dimension: dsp_filter_reason {
    type: string
    label: "DSP Filter Reason"
    description: "⁃ displayFilter = DSP isn't configured for Display Traffic
⁃ videoFilter = DSP isn't configured for Video Traffic
⁃ sspExclude = SSP is in that DSPs exclude list
⁃ trafficMgt = DSP is currently exceeding QPS configured limits, not current accepting requests
⁃ sspInclude = SSP isn't in that DSPs include list
⁃ isSiteFilter = Site is in that DSPs blacklist
⁃ trafficUserMatch = RX does not have DSPs UserID
⁃ trafficMgt = DSP is currently exceeding QPS configured limits, not current accepting requests
⁃ siteIDBlacklist = SiteID is in that DSPs blacklist
⁃ countryInclude = Country isn't on the DSPs Country Include List
⁃ rgUserSuspicious = RG is blacklisting that UserID
⁃ videoSizeExclude = Video Size is on the DSPs exclude list
⁃ rgSourceRating = DSP is configured for a higher SourceRating than RG noted for that BidRequest
⁃ blacklist = Global Black list
⁃ trafficMgmtListLowRPM = QPS by RPM algorithm is throttling that supply bucket to that DSP because of low performance (in order to not exceed QPS limits overall)

"
    sql: ${TABLE}.DSP_Filter_Reason ;;
  }

  dimension: is_valid_request {
    label: "Is Valid Requests"
    sql: case when ${TABLE}.DSP_Filter_Reason = 'not-filtered'
     then 'True' else 'False' End ;;


  }

  dimension: dsp_filter_reason_key {
    type: number
    sql: ${TABLE}.DSP_Filter_Reason_Key ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_dsp_filter_reason_key {
    type: sum
    sql: ${dsp_filter_reason_key} ;;
    hidden: yes
  }

  measure: average_dsp_filter_reason_key {
    type: average
    sql: ${dsp_filter_reason_key} ;;
    hidden: yes
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
