view: suggest_demand_ref {
  derived_table: {
    sql:  select
            cd.audit_vendor,
            cd.begin_datetime_local as campaign_begin_datetime_local,
            cd.end_datetime_local as campaign_end_datetime_local,
            cd.business_region_description,
            cd.campaign_name,
            cd.campaign_objective,
            cd.campaign_status_description,
            cd.campaign_targeting_type,
            cd.campaign_type_description,
            cd.cpu_type_description,
            cd.customer_io_number,
            cd.demo_composition_vendor_id,
            cd.demo_segment_group_description,
            cd.device_type_description,
            cd.format_type_description,
            cd.format_type_id,
            cd.misc_data,
            cd.office_name,
            cd.pl_plan_name,
            cd.platform_client_id,
            cd.platform_client_description,
            cd.platform_client_group_description,
            cd.pricing_vendor_id,
            cd.reporting_business_unit_description,
            fd.cpu,
            fd.flight_description,
            fd.begin_datetime_local as flight_begin_datetime_local,
            fd.end_datetime_local as flight_end_datetime_local,
            fmd.begin_datetime_local,
            fmd.end_datetime_local,
            fmd.cdn_file_loc,
            fmd.clickurl,
            fmd.client_tracking_id,
            fmd.creative_format_type,
            fmd.demo_abbreviation,
            fmd.demoaud,
            fmd.destination_url,
            fmd.duration,
            fmd.end_ping_tracking,
            fmd.external_id,
            fmd.first_quarter_ping_tracking,
            -- fmd.flight_description,
            fmd.flight_media_description,
            fmd.media_id,
            fmd.media_name,
            fmd.media_type,
            fmd.media_width_height,
            fmd.mid_ping_tracking,
            fmd.secure_cdn_file_loc,
            fmd.start_ping_tracking,
            fmd.third_quarter_ping_tracking,
            co.primary_objective,
            co.secondary_objective,
            ctd.campaigndemos,
            ctd.dayparttargets,
            ctd.geotargets,
            pp.account_executive,
            pp.account_manager,
            pp.custom_field_1,
            pp.custom_field_2,
            cd2.addr_line1,
            cd2.addr_line2,
            cd2.ahc_description,
            cd2.city,
            cd2.country_id,
            cd2.customer_group_name,
            cd2.customer_id,
            cd2.customer_name,
            cd2.customer_office_description,
            cd2.customer_type_description,
            cd2.postalcode,
            cd2.stateprovince,
            abd.advertiser_name,
            abd.brand_name,
            abd.industry_segment_description,
            abd.industry_segment_id,
            abd.industry_segment_type_description,
            io.contract_number,
            io.currency_abbreviation,
            io.insertion_order_name,
            io.insertion_order_status_description,
            io.reporting_business_unit_description as io_reporting_business_unit_description,
            io.salesperson_name,
            account_exec.firstname as account_exec_firstname,
            account_exec.lastname as account_exec_lastname,
            launched_by_userprofile.firstname as launched_by_userprofile_firstname,
            launched_by_userprofile.lastname as launched_by_userprofile_lastname,
            fm_createdby_userprofile.firstname as fm_createdby_userprofile_firstname,
            fm_createdby_userprofile.lastname as fm_createdby_userprofile_lastname,
            pc.office_name as pc_office_name,
            dc.abbreviation as country
            from
            dim.campaign_details_base cd
              left join dim.flight_details fd
                on cd.campaign_id = fd.campaign_id
              left join dim.flight_media_details_base fmd
                on fd.flight_id = fmd.flight_id
              left join
              (
                select
                  co.campaign_id,
                  max(
                    case
                      when co.is_primary = 1 then co.advertiser_objective_description
                    end
                  ) as primary_objective,
                  max(
                    case
                      when co.is_primary = 0 then co.advertiser_objective_description
                    end
                  ) as secondary_objective
                from
                  dim.campaign_objective co
                group by
                  co.campaign_id
              ) co
                on cd.campaign_id = co.campaign_id
              left join dim.campaign_target_description ctd
                on cd.campaign_id = ctd.campaign_id
              left join dim.pl_plan pp
                on cd.pl_plan_id = pp.pl_plan_id
              left join dim.customer_details cd2
                on cd.customer_id = cd2.customer_id
              left join dim.advertiser_brand_details abd
                on cd.advertiser_brand_id = abd.advertiser_brand_id
              left join dim.insertion_order_details io
                on cd.insertion_order_id = io.insertion_order_id
              left join dim.user_profile account_exec
                on io.account_rep = account_exec.userid
              left join dim.user_profile launched_by_userprofile
                on cd.launchedby = launched_by_userprofile.userid
              left join dim.user_profile fm_createdby_userprofile
                on fmd.createdby = fm_createdby_userprofile.userid
              left join dim.platform_client pc
                on cd.platform_client_id = pc.platform_client_id
              left join dim.country dc
                on dc.country_id = cd2.country_id ;;

  }

  dimension: audit_vendor {
    type: string
    sql: ${TABLE}.AUDIT_VENDOR ;;
  }

  dimension_group: campaign_begin_datetime_local {
    type: time
    timeframes: [date]
    sql: ${TABLE}.CAMPAIGN_BEGIN_DATETIME_LOCAL ;;
  }

  dimension_group: campaign_end_datetime_local {
    type: time
    timeframes: [date]
    sql: DATEADD('M', -1, ${TABLE}.CAMPAIGN_END_DATETIME_LOCAL) ;;
  }

  dimension: business_region_description {
    type: string
    sql: ${TABLE}.BUSINESS_REGION_DESCRIPTION ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.CAMPAIGN_NAME ;;
  }

  dimension: campaign_name_custom {
    type: string
    sql: IFF(substring(${campaign_name},0,(position('#',${campaign_name}))-1) = '',${campaign_name},
        substring(${campaign_name},0,(position('#',${campaign_name}))-1)) ;;
  }

  dimension: campaign_objective {
    type: string
    sql: ${TABLE}.CAMPAIGN_OBJECTIVE ;;
  }

  dimension: campaign_status_description {
    type: string
    sql: COALESCE(${TABLE}.misc_data_description, ${TABLE}.CAMPAIGN_STATUS_DESCRIPTION) ;;
  }

  dimension: campaign_info {
    type: string
    sql: COALESCE(${TABLE}.misc_campaign_info, '') ;;
  }

  dimension: campaign_targeting_type {
    type: string
    sql: ${TABLE}.CAMPAIGN_TARGETING_TYPE ;;
  }

  dimension: campaign_type_description {
    type: string
    sql: ${TABLE}.CAMPAIGN_TYPE_DESCRIPTION ;;
  }

  dimension: cpu_type_description {
    type: string
    sql: ${TABLE}.CPU_TYPE_DESCRIPTION ;;
  }

  dimension: customer_io_number {
    type: string
    sql: ${TABLE}.CUSTOMER_IO_NUMBER ;;
  }

  dimension: demo_composition_vendor_id {
    type: string
    sql: ${TABLE}.DEMO_COMPOSITION_VENDOR_ID ;;
  }

  dimension: demo_composition_vendor {
    type: string
    sql: CASE WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 1 then 'Comscore Media Matrix'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 2 then 'Nielsen OCR'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 3 then 'Comscore VCE'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 4 then 'AT&T Linear'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 5 then 'AT&T Addressable'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 6 then 'Bell'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 7 then 'Rogers'
              ELSE 'OTHER' END ;;
  }

  dimension: demo_segment_group_description {
    type: string
    sql: ${TABLE}.DEMO_SEGMENT_GROUP_DESCRIPTION ;;
  }

  dimension: device_type_description {
    type: string
    sql: ${TABLE}.DEVICE_TYPE_DESCRIPTION ;;
  }

  dimension: format_type_description {
    type: string
    sql: ${TABLE}.FORMAT_TYPE_DESCRIPTION ;;
  }

  dimension: format_type_id {
    type: string
    sql: ${TABLE}.FORMAT_TYPE_ID ;;
  }

  dimension: office_name {
    type: string
    sql: ${TABLE}.OFFICE_NAME ;;
  }

  dimension: plan_name {
    type: string
    sql: ${TABLE}.PL_PLAN_NAME ;;
  }

  dimension: platform_client_id {
    type: number
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    value_format_name: id
  }

  dimension: platform_client_description {
    type: string
    sql: ${TABLE}.PLATFORM_CLIENT_DESCRIPTION ;;
  }

  dimension: platform_client_group_description {
    type: string
    sql: ${TABLE}.PLATFORM_CLIENT_GROUP_DESCRIPTION ;;
  }

  dimension: pricing_vendor_name {
    type: string
    sql: case when ${TABLE}.PRICING_VENDOR_ID = 101 then 'Videology'
              when ${TABLE}.PRICING_VENDOR_ID = 102 then 'Moat'
              when ${TABLE}.PRICING_VENDOR_ID = 103 then 'DoubleVerify'
              when ${TABLE}.PRICING_VENDOR_ID = 104 then 'Integral Ad Science'
              else 'Other' end ;;
  }

  dimension: reporting_business_unit_description {
    type: string
    sql: ${TABLE}.REPORTING_BUSINESS_UNIT_DESCRIPTION ;;
  }

  dimension: cpu {
    type: string
    sql: ${TABLE}.CPU ;;
  }

  dimension: flight_description {
    type: string
    sql: ${TABLE}.FLIGHT_DESCRIPTION ;;
  }

  dimension_group: flight_begin_datetime_local {
    type: time
    timeframes: [raw]
    sql: ${TABLE}.FLIGHT_BEGIN_DATETIME_LOCAL ;;
  }

  dimension_group: flight_end_datetime_local {
    type: time
    timeframes: [raw]
    sql: DATEADD('M', -1,${TABLE}.FLIGHT_END_DATETIME_LOCAL) ;;
  }

  dimension: flight_status_ {
    type: string
    sql: case when ${campaign_status_description} IN ('Planning', 'Reserved', 'Pending' ) THEN 'Pending'
              when ${campaign_status_description} = 'Running' AND ${flight_begin_datetime_local_raw} >= CURRENT_DATE() THEN 'Pending'
              when ${campaign_status_description} = 'Running' AND ${flight_end_datetime_local_raw} <= CURRENT_DATE()   THEN 'Completed'
          ELSE ${campaign_status_description} END ;;
  }

  dimension_group: begin_datetime_local {
    type: time
    timeframes: [raw]
    sql: ${TABLE}.BEGIN_DATETIME_LOCAL ;;
  }

  dimension: yj_begin_datetime_local {
    type: string
    sql: TO_CHAR(${begin_datetime_local_raw}, 'MM/DD/YYYY HH12:MI AM') ;;
  }

  dimension_group: end_datetime_local {
    type: time
    timeframes: [raw]
    sql: ${TABLE}.END_DATETIME_LOCAL ;;
  }

  dimension: yj_end_datetime_local {
    type: string
    sql: TO_CHAR(dateadd(min, -1, ${end_datetime_local_raw}), 'MM/DD/YYYY HH12:MI AM') ;;
  }

  dimension: cdn_file_loc {
    type: string
    sql: ${TABLE}.CDN_FILE_LOC ;;
  }

  dimension: cdn_url {
    type: string
    sql: rtrim(regexp_substr(${TABLE}.CDN_FILE_LOC, 'https?://[^/]*/', 1, 1, 'i'), '/') ;;
  }

  dimension: clickurl {
    type: string
    sql: ${TABLE}.CLICKURL ;;
  }

  dimension: client_tracking_id {
    type: string
    sql: ${TABLE}.CLIENT_TRACKING_ID ;;
  }

  dimension: creative_format_type {
    type: string
    sql: ${TABLE}.CREATIVE_FORMAT_TYPE ;;
  }

  dimension: demo_abbreviation {
    type: string
    sql: ${TABLE}.DEMO_ABBREVIATION ;;
  }

  dimension: destination_url {
    type: string
    sql: ${TABLE}.DESTINATION_URL ;;
  }

  dimension: duration {
    type: string
    sql: ${TABLE}.DURATION ;;
  }

  dimension: end_ping_tracking {
    type: string
    sql: ${TABLE}.END_PING_TRACKING ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.EXTERNAL_ID ;;
  }

  dimension: first_quarter_ping_tracking {
    type: string
    sql: ${TABLE}.FIRST_QUARTER_PING_TRACKING ;;
  }

#   dimension: flight_description {
#     type: string
#     sql: ${TABLE}.flight_description ;;
#   }

  dimension: flight_media_description {
    type: string
    sql: ${TABLE}.FLIGHT_MEDIA_DESCRIPTION ;;
  }

  dimension: media_id {
    type: string
    sql: ${TABLE}.MEDIA_ID ;;
  }

  dimension: media_name {
    type: string
    sql: ${TABLE}.MEDIA_NAME ;;
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.MEDIA_TYPE ;;
  }

  dimension: media_width_height {
    type: string
    sql: ${TABLE}.MEDIA_WIDTH_HEIGHT ;;
  }

  dimension: mid_ping_tracking {
    type: string
    sql: ${TABLE}.MID_PING_TRACKING ;;
  }

  dimension: secure_cdn_file_loc {
    type: string
    sql: ${TABLE}.SECURE_CDN_FILE_LOC ;;
  }

  dimension: secure_cdn_url {
    type: string
    sql: rtrim(regexp_substr(${TABLE}.SECURE_CDN_FILE_LOC, 'https?://[^/]*/', 1, 1, 'i'), '/') ;;
  }

  dimension: start_ping_tracking {
    type: string
    sql: ${TABLE}.START_PING_TRACKING ;;
  }

  dimension: third_quarter_ping_tracking {
    type: string
    sql: ${TABLE}.THIRD_QUARTER_PING_TRACKING ;;
  }

  dimension: primary_objective {
    type: string
    sql: ${TABLE}.PRIMARY_OBJECTIVE ;;
  }

  dimension: secondary_objective {
    type: string
    sql: ${TABLE}.SECONDARY_OBJECTIVE ;;
  }

  dimension: campaigndemos {
    type: string
    sql: ${TABLE}.CAMPAIGNDEMOS ;;
  }

  dimension: dayparttargets {
    type: string
    sql: ${TABLE}.DAYPARTTARGETS ;;
  }


  dimension: geotargets {
    type: string
    sql: ${TABLE}.GEOTARGETS ;;
  }

  dimension: account_executive {
    type: string
    sql: ${TABLE}.ACCOUNT_EXECUTIVE ;;
  }

  dimension: account_manager {
    type: string
    sql: ${TABLE}.ACCOUNT_MANAGER ;;
  }

  dimension: custom_field_1 {
    type: string
    sql: ${TABLE}.CUSTOM_FIELD_1 ;;
  }

  dimension: custom_field_2 {
    type: string
    sql: ${TABLE}.CUSTOM_FIELD_2 ;;
  }

  dimension: addr_line1 {
    type: string
    sql: ${TABLE}.ADDR_LINE1 ;;
  }

  dimension: addr_line2 {
    type: string
    sql: ${TABLE}.ADDR_LINE2 ;;
  }

  dimension: ahc_description {
    type: string
    sql: ${TABLE}.AHC_DESCRIPTION ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: country_id {
    type: number
    sql: ${TABLE}.COUNTRY_ID ;;
  }

  dimension: customer_group_name {
    type: string
    sql: ${TABLE}.CUSTOMER_GROUP_NAME ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.CUSTOMER_ID ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.CUSTOMER_NAME ;;
  }

  dimension: customer_office_description {
    type: string
    sql: ${TABLE}.CUSTOMER_OFFICE_DESCRIPTION ;;
  }

  dimension: customer_type_description {
    type: string
    sql: ${TABLE}.CUSTOMER_TYPE_DESCRIPTION ;;
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: stateprovince {
    type: string
    sql: ${TABLE}.STATEPROVINCE ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.ADVERTISER_NAME ;;
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.BRAND_NAME ;;
  }

  dimension:industry_segment_description {
    type: string
    sql: ${TABLE}.INDUSTRY_SEGMENT_DESCRIPTION ;;
  }

  dimension: industry_segment_id {
    type: string
    sql: ${TABLE}.INDUSTRY_SEGMENT_ID ;;
  }

  dimension: industry_segment_type_description {
    type: string
    sql: ${TABLE}.INDUSTRY_SEGMENT_TYPE_DESCRIPTION ;;
  }

  dimension: contract_number {
    type: string
    sql: ${TABLE}.contract_number ;;
  }

  dimension: currency_abbreviation {
    type: string
    sql: ${TABLE}.currency_abbreviation ;;
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }

  dimension: insertion_order_status_description {
    type: string
    sql: ${TABLE}.insertion_order_status_description ;;
  }

  dimension: io_reporting_business_unit_description {
    type: string
    sql: ${TABLE}.io_reporting_business_unit_description ;;
  }

  dimension: salesperson_name {
    type: string
    sql: ${TABLE}.salesperson_name ;;
  }

  dimension: account_exec_name {
    type: string
    sql: ${TABLE}.account_exec_lastname || ', ' || ${TABLE}.account_exec_firstname ;;
  }

  dimension: launched_by {
    type: string
    sql: ${TABLE}.launched_by_userprofile_lastname || ', ' || ${TABLE}.launched_by_userprofile_firstname ;;
  }

  dimension: fm_createdby {
    type: string
    sql: ${TABLE}.fm_createdby_userprofile_lastname || ', ' || ${TABLE}.fm_createdby_userprofile_firstname ;;
  }

  dimension: pc_office_name {
    type: string
    sql: ${TABLE}.PC_OFFICE_NAME ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

}
