view: demand_warehouse_validation {

  derived_table: {
    sql:  WITH latest_tracking AS (
            SELECT
                max(load_through_date) max_date
              , min(start_timezone) AS latest_tz
              , min(utc_offset) AS latest_offset
            FROM (
              SELECT
                  load_through_date
                , start_timezone
                , tz.utc_offset
                , count(table_name) AS latest_offset
              FROM demand_mart.load_tracking
              JOIN dim.timezone tz ON load_tracking.START_TIMEZONE = tz.timezone_ID
              WHERE schema_name = 'demand_mart'
                AND table_name IN ('daily_core_stats', 'daily_domain_stats', 'daily_daypart_stats', 'daily_geo_stats')
              GROUP BY
                  load_through_date
                , start_timezone
                , tz.utc_offset
              HAVING count(DISTINCT table_name) = 4
                 AND max(load_through_date) = (
                     SELECT max(load_through_date)
                     FROM (
                       SELECT
                           load_through_date AS load_through_date
                         , count(DISTINCT table_name) AS count_tablename
                       FROM demand_mart.load_tracking
                       WHERE schema_name = 'demand_mart'
                         AND table_name IN ('daily_core_stats', 'daily_domain_stats', 'daily_daypart_stats', 'daily_geo_stats')
                       GROUP BY load_through_date) as ltd
                     WHERE count_tablename = 4)
              ) as ltr
          ),
          -- latest hours filter
          latest_hour_filter AS (
            SELECT HD.KEYDATE AS MAX_DATE
            FROM dim.HOUR_DIMENSION HD
            JOIN latest_tracking t1
            WHERE HD.date_value = t1.max_date
            GROUP BY HD.KEYDATE
          ),
          -- latest date filter
          latest_date_filter AS (
            SELECT DD.date_value AS MAX_DATE
            FROM dim.DAY_DIMENSION DD
            JOIN latest_tracking t1
            WHERE DD.date_value = t1.max_date
            GROUP BY DD.date_value
          ),
          -- latest timezone filter
          latest_timezone_filter AS (
            SELECT tz2.timezone_id AS TIMEZONE_ID
            FROM dim.TIMEZONE tz2
            JOIN latest_tracking t2
            WHERE tz2.timezone_id >= t2.latest_tz
            GROUP BY tz2.timezone_id
          ),
          -- historical hour filter (from latest day minus one day to n-days into the past)
          historical_hour_filter AS (
            SELECT HD.KEYDATE AS MAX_DATE
            FROM dim.HOUR_DIMENSION HD
            JOIN latest_tracking t1
            WHERE HD.date_value BETWEEN DATEADD(day, -2, t1.max_date) AND DATEADD(day, -1, t1.max_date)
            GROUP BY HD.KEYDATE
          ),
          -- historical date filter (from latest day minus one day to n-days into the past)
          historical_date_filter AS (
            SELECT DD.date_value AS MAX_DATE
            FROM dim.DAY_DIMENSION DD
            JOIN latest_tracking t1
            WHERE DD.date_value BETWEEN dateadd(day, -2, t1.max_date) AND dateadd(day, -1, t1.max_date)
            GROUP BY DD.date_value
          ),
          -- latest aggregate for RAW_IMPRESSION
          latest_raw_impression_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.BT_DATA_COST) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.DEMO_PROVIDER_COST) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) WJXBFS8
              , SUM(a11.PAYOUT) WJXBFS9
              , SUM(a11.REVENUE) WJXBFSa
            FROM rawdb.RAW_IMPRESSION a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND (a12.starttimezone_id) IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- historical aggregate for RAW_IMPRESSION
          historical_raw_impression_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.BT_DATA_COST) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.DEMO_PROVIDER_COST) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) WJXBFS8
              , SUM(a11.PAYOUT) WJXBFS9
              , SUM(a11.REVENUE) WJXBFSa
            FROM rawdb.RAW_IMPRESSION a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- latest aggregate for raw HOURLY_ANALYTICS
          latest_raw_hourly_analytics_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , date_trunc('day', a11.DEMAND_DATE) AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.BT_DATA_COST) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.DEMO_PROVIDER_DATA_COST) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) WJXBFS8
              , SUM(a11.PAYOUT) WJXBFS9
              , SUM(a11.REVENUE) WJXBFSa
            FROM rawdb.HOURLY_ANALYTICS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM latest_hour_filter)
              AND (a12.starttimezone_id) IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.starttimezone_id, date_trunc('day', a11.DEMAND_DATE)
          ),
          -- historical aggregate for raw HOURLY_ANALYTICS
          historical_raw_hourly_analytics_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , date_trunc('day', a11.DEMAND_DATE) AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.BT_DATA_COST) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.DEMO_PROVIDER_DATA_COST) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) WJXBFS8
              , SUM(a11.PAYOUT) WJXBFS9
              , SUM(a11.REVENUE) WJXBFSa
            FROM rawdb.HOURLY_ANALYTICS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM historical_hour_filter)
            GROUP BY a12.starttimezone_id, date_trunc('day', a11.DEMAND_DATE)
          ),
          -- latest aggregate for DAILY_GEO_STATS
          latest_daily_geo_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_GEO_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND a12.starttimezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- historical aggregate for DAILY_GEO_STATS
          historical_daily_geo_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_GEO_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- latest aggregate for demand_mart.DAILY_DOMAIN_STATS
          latest_daily_domain_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_DOMAIN_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
            AND a12.starttimezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- historical aggregate for demand_mart.DAILY_DOMAIN_STATS
          historical_daily_domain_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_DOMAIN_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- latest aggregate for demand_mart.DAILY_DAYPART_STATS
          latest_daily_daypart_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_DAYPART_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND a12.starttimezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- historical aggregate for demand_mart.DAILY_DAYPART_STATS
          historical_daily_daypart_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_DAYPART_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.starttimezone_id, a11.DEMAND_DATE
          ),
          -- latest aggregate for DAILY_CORE_STATS
          latest_daily_core_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_CORE_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND a12.starttimezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.starttimezone_id ,a11.DEMAND_DATE
          ),
          -- historical aggregate for DAILY_CORE_STATS
          historical_daily_core_stats_agg AS (
            SELECT
                a12.starttimezone_id AS starttimezone_id
              , a11.DEMAND_DATE AS CustCol_36
              , SUM(a11.BILLABLE_IMPRESSIONS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.btproviderdatacost) AS WJXBFS3
              , SUM(a11.CLICKS) AS WJXBFS4
              , SUM(a11.COMPLETED_100) AS WJXBFS5
              , SUM(a11.demoproviderdatacost) AS WJXBFS6
              , SUM(a11.IMPRESSIONS) AS WJXBFS7
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS8
              , SUM(a11.PAYOUT) AS WJXBFS9
              , SUM(a11.REVENUE) AS WJXBFSa
            FROM demand_mart.DAILY_CORE_STATS a11
            JOIN dim.FLIGHT_MEDIA_DETAILS a12
              ON (a11.FLIGHT_MEDIA_ID = a12.FLIGHT_MEDIA_ID)
            WHERE a11.DEMAND_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.starttimezone_id ,a11.DEMAND_DATE
          ),
          -- latest diff stats
          latest_diff_stats AS (
            SELECT
                COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36, pa16.CustCol_36) AS DEMAND_DATE
              , COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id, pa16.starttimezone_id) AS  STARTTIMEZONE_ID
              , MAX(TZ.timezone_description) AS TIMEZONE_DESCRIPTION
              , MAX(TZ.utc_offset) AS UTC_OFFSET
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa12.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa13.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa14.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa15.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa16.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa12.WJXBFS2), 0)) AS BILLABLE_UNITS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa13.WJXBFS2), 0)) AS BILLABLE_UNITS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa14.WJXBFS2), 0)) AS BILLABLE_UNITS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa15.WJXBFS2), 0)) AS BILLABLE_UNITS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa16.WJXBFS2), 0)) AS BILLABLE_UNITS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa12.WJXBFS3), 0)) AS BT_DATA_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa13.WJXBFS3), 0)) AS BT_DATA_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa14.WJXBFS3), 0)) AS BT_DATA_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa15.WJXBFS3), 0)) AS BT_DATA_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa16.WJXBFS3), 0)) AS BT_DATA_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa12.WJXBFS4), 0)) AS CLICKS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa13.WJXBFS4), 0)) AS CLICKS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa14.WJXBFS4), 0)) AS CLICKS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa15.WJXBFS4), 0)) AS CLICKS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa16.WJXBFS4), 0)) AS CLICKS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa12.WJXBFS5), 0)) AS COMPLETED_100_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa13.WJXBFS5), 0)) AS COMPLETED_100_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa14.WJXBFS5), 0)) AS COMPLETED_100_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa15.WJXBFS5), 0)) AS COMPLETED_100_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa16.WJXBFS5), 0)) AS COMPLETED_100_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa12.WJXBFS6), 0)) AS DEMO_DATA_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa13.WJXBFS6), 0)) AS DEMO_DATA_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa14.WJXBFS6), 0)) AS DEMO_DATA_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa15.WJXBFS6), 0)) AS DEMO_DATA_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa16.WJXBFS6), 0)) AS DEMO_DATA_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa12.WJXBFS7), 0)) AS IMPRESSIONS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa13.WJXBFS7), 0)) AS IMPRESSIONS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa14.WJXBFS7), 0)) AS IMPRESSIONS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa15.WJXBFS7), 0)) AS IMPRESSIONS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa16.WJXBFS7), 0)) AS IMPRESSIONS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa12.WJXBFS8), 0)) AS IS_VIEWABLE_100_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa13.WJXBFS8), 0)) AS IS_VIEWABLE_100_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa14.WJXBFS8), 0)) AS IS_VIEWABLE_100_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa15.WJXBFS8), 0)) AS IS_VIEWABLE_100_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa16.WJXBFS8), 0)) AS IS_VIEWABLE_100_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa12.WJXBFS9), 0)) AS PAYOUT_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa13.WJXBFS9), 0)) AS PAYOUT_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa14.WJXBFS9), 0)) AS PAYOUT_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa15.WJXBFS9), 0)) AS PAYOUT_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa16.WJXBFS9), 0)) AS PAYOUT_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa12.WJXBFSa), 0)) AS REVENUE_GEO_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa13.WJXBFSa), 0)) AS REVENUE_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa14.WJXBFSa), 0)) AS REVENUE_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa15.WJXBFSa), 0)) AS REVENUE_CORE_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa16.WJXBFSa), 0)) AS REVENUE_RAW_IMPRESSION
            FROM latest_raw_hourly_analytics_agg pa11
            FULL OUTER JOIN latest_daily_geo_stats_agg pa12
              ON (pa11.CustCol_36 = pa12.CustCol_36 AND pa11.starttimezone_id = pa12.starttimezone_id)
            FULL OUTER JOIN latest_daily_domain_stats_agg pa13
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36) = pa13.CustCol_36 AND
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id) = pa13.starttimezone_id)
            FULL OUTER JOIN latest_daily_daypart_stats_agg pa14
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36) = pa14.CustCol_36 AND
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id) = pa14.starttimezone_id)
            FULL OUTER JOIN latest_daily_core_stats_agg pa15
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36) = pa15.CustCol_36 and
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id) = pa15.starttimezone_id)
            FULL OUTER JOIN latest_raw_impression_agg pa16
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36) = pa16.CustCol_36 and
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id) = pa16.starttimezone_id)
            JOIN dim.TIMEZONE TZ
              ON (COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id, pa16.starttimezone_id) = TZ.timezone_id)
            GROUP BY
                COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36, pa16.CustCol_36)
              , COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id, pa16.starttimezone_id)
          ),
          -- historical diff stats from latest day minus one day to n-days into the past
          historical_diff_stats AS (
            SELECT
                COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36, pa16.CustCol_36) AS DEMAND_DATE
              , COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id, pa16.starttimezone_id) AS  STARTTIMEZONE_ID
              , MAX(TZ.timezone_description) AS TIMEZONE_DESCRIPTION
              , MAX(TZ.utc_offset) AS UTC_OFFSET
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa12.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa13.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa14.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa15.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS1), 0) - COALESCE(max(pa16.WJXBFS1), 0)) AS BILLABLE_IMPRESSIONS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa12.WJXBFS2), 0)) AS BILLABLE_UNITS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa13.WJXBFS2), 0)) AS BILLABLE_UNITS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa14.WJXBFS2), 0)) AS BILLABLE_UNITS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa15.WJXBFS2), 0)) AS BILLABLE_UNITS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS2), 0) - COALESCE(max(pa16.WJXBFS2), 0)) AS BILLABLE_UNITS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa12.WJXBFS3), 0)) AS BT_DATA_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa13.WJXBFS3), 0)) AS BT_DATA_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa14.WJXBFS3), 0)) AS BT_DATA_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa15.WJXBFS3), 0)) AS BT_DATA_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS3), 0) - COALESCE(max(pa16.WJXBFS3), 0)) AS BT_DATA_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa12.WJXBFS4), 0)) AS CLICKS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa13.WJXBFS4), 0)) AS CLICKS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa14.WJXBFS4), 0)) AS CLICKS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa15.WJXBFS4), 0)) AS CLICKS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS4), 0) - COALESCE(max(pa16.WJXBFS4), 0)) AS CLICKS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa12.WJXBFS5), 0)) AS COMPLETED_100_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa13.WJXBFS5), 0)) AS COMPLETED_100_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa14.WJXBFS5), 0)) AS COMPLETED_100_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa15.WJXBFS5), 0)) AS COMPLETED_100_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS5), 0) - COALESCE(max(pa16.WJXBFS5), 0)) AS COMPLETED_100_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa12.WJXBFS6), 0)) AS DEMO_DATA_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa13.WJXBFS6), 0)) AS DEMO_DATA_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa14.WJXBFS6), 0)) AS DEMO_DATA_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa15.WJXBFS6), 0)) AS DEMO_DATA_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS6), 0) - COALESCE(max(pa16.WJXBFS6), 0)) AS DEMO_DATA_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa12.WJXBFS7), 0)) AS IMPRESSIONS_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa13.WJXBFS7), 0)) AS IMPRESSIONS_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa14.WJXBFS7), 0)) AS IMPRESSIONS_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa15.WJXBFS7), 0)) AS IMPRESSIONS_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS7), 0) - COALESCE(max(pa16.WJXBFS7), 0)) AS IMPRESSIONS_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa12.WJXBFS8), 0)) AS IS_VIEWABLE_100_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa13.WJXBFS8), 0)) AS IS_VIEWABLE_100_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa14.WJXBFS8), 0)) AS IS_VIEWABLE_100_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa15.WJXBFS8), 0)) AS IS_VIEWABLE_100_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS8), 0) - COALESCE(max(pa16.WJXBFS8), 0)) AS IS_VIEWABLE_100_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa12.WJXBFS9), 0)) AS PAYOUT_GEO_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa13.WJXBFS9), 0)) AS PAYOUT_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa14.WJXBFS9), 0)) AS PAYOUT_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa15.WJXBFS9), 0)) AS PAYOUT_CORE_STATS
              , (COALESCE(max(pa11.WJXBFS9), 0) - COALESCE(max(pa16.WJXBFS9), 0)) AS PAYOUT_RAW_IMPRESSION
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa12.WJXBFSa), 0)) AS REVENUE_GEO_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa13.WJXBFSa), 0)) AS REVENUE_DOMAIN_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa14.WJXBFSa), 0)) AS REVENUE_DAYPART_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa15.WJXBFSa), 0)) AS REVENUE_CORE_STATS
              , (COALESCE(max(pa11.WJXBFSa), 0) - COALESCE(max(pa16.WJXBFSa), 0)) AS REVENUE_RAW_IMPRESSION
            FROM historical_raw_hourly_analytics_agg pa11
            FULL OUTER JOIN historical_daily_geo_stats_agg pa12
              ON (pa11.CustCol_36 = pa12.CustCol_36 AND pa11.starttimezone_id = pa12.starttimezone_id)
            FULL OUTER JOIN historical_daily_domain_stats_agg pa13
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36) = pa13.CustCol_36 AND
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id) = pa13.starttimezone_id)
            FULL OUTER JOIN historical_daily_daypart_stats_agg pa14
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36) = pa14.CustCol_36 AND
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id) = pa14.starttimezone_id)
            FULL OUTER JOIN historical_daily_core_stats_agg pa15
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36) = pa15.CustCol_36 and
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id) = pa15.starttimezone_id)
            FULL OUTER JOIN historical_raw_impression_agg pa16
              ON (COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36) = pa16.CustCol_36 and
                  COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id) = pa16.starttimezone_id)
            JOIN dim.TIMEZONE TZ
              ON (COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id, pa16.starttimezone_id) = TZ.timezone_id)
            GROUP BY
                COALESCE(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36, pa16.CustCol_36)
              , COALESCE(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id, pa16.starttimezone_id)
          )
          -- combines latest diff stats and historical diff stats
          SELECT * FROM latest_diff_stats
          UNION
          SELECT * FROM historical_diff_stats;;
  }

  dimension: demand_date {
    description: "Date"
    type: date
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension: tz_id {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.STARTTIMEZONE_ID ;;
  }

  dimension: tz_description {
    description: "Timezone Description"
    type: string
    sql: ${TABLE}.TIMEZONE_DESCRIPTION ;;
  }

  dimension: utc_offset {
    description: "UTC Offset"
    type: number
    sql: ${TABLE}.UTC_OFFSET ;;
  }


  dimension: billable_impressions_geo {
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS_GEO_STATS ;;
  }

  dimension: billable_impressions_domain {
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS_DOMAIN_STATS ;;
  }

  dimension: billable_impressions_daypart {
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS_DAYPART_STATS ;;
  }

  dimension: billable_impressions_core {
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS_CORE_STATS ;;
  }

  dimension: billable_impressions_raw {
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS_RAW_IMPRESSION ;;
  }

  dimension: billable_units_geo {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_GEO_STATS ;;
  }

  dimension: billable_units_domain {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_DOMAIN_STATS ;;
  }

  dimension: billable_units_daypart {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_DAYPART_STATS ;;
  }

  dimension: billable_units_core {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_CORE_STATS ;;
  }

  dimension: billable_units_raw {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_RAW_IMPRESSION ;;
  }

  dimension: bt_data_geo {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.BT_DATA_GEO_STATS ;;
  }

  dimension: bt_data_domain {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.BT_DATA_DOMAIN_STATS ;;
  }

  dimension: bt_data_daypart {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.BT_DATA_DAYPART_STATS ;;
  }

  dimension: bt_data_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.BT_DATA_CORE_STATS ;;
  }

  dimension: bt_data_raw {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.BT_DATA_RAW_IMPRESSION ;;
  }

  dimension: clicks_geo {
    type: number
    sql: ${TABLE}.CLICKS_GEO_STATS ;;
  }

  dimension: clicks_domain {
    type: number
    sql: ${TABLE}.CLICKS_DOMAIN_STATS ;;
  }

  dimension: clicks_daypart {
    type: number
    sql: ${TABLE}.CLICKS_DAYPART_STATS ;;
  }

  dimension: clicks_core {
    type: number
    sql: ${TABLE}.CLICKS_CORE_STATS ;;
  }

  dimension: clicks_raw {
    type: number
    sql: ${TABLE}.CLICKS_RAW_IMPRESSION ;;
  }

  dimension: completed_100_geo {
    type: number
    sql: ${TABLE}.COMPLETED_100_GEO_STATS ;;
  }

  dimension: completed_100_domain {
    type: number
    sql: ${TABLE}.COMPLETED_100_DOMAIN_STATS ;;
  }

  dimension: completed_100_daypart {
    type: number
    sql: ${TABLE}.COMPLETED_100_DAYPART_STATS ;;
  }

  dimension: completed_100_core {
    type: number
    sql: ${TABLE}.COMPLETED_100_CORE_STATS ;;
  }

  dimension: completed_100_raw {
    type: number
    sql: ${TABLE}.COMPLETED_100_RAW_IMPRESSION ;;
  }

  dimension: demo_data_geo {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.DEMO_DATA_GEO_STATS ;;
  }

  dimension: demo_data_domain {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.DEMO_DATA_DOMAIN_STATS ;;
  }

  dimension: demo_data_daypart {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.DEMO_DATA_DAYPART_STATS ;;
  }

  dimension: demo_data_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.DEMO_DATA_CORE_STATS ;;
  }

  dimension: demo_data_raw {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.DEMO_DATA_RAW_IMPRESSION ;;
  }

  dimension: impressions_geo {
    type: number
    sql: ${TABLE}.IMPRESSIONS_GEO_STATS ;;
  }

  dimension: impressions_domain {
    type: number
    sql: ${TABLE}.IMPRESSIONS_DOMAIN_STATS ;;
  }

  dimension: impressions_daypart {
    type: number
    sql: ${TABLE}.IMPRESSIONS_DAYPART_STATS ;;
  }

  dimension: impressions_core {
    type: number
    sql: ${TABLE}.IMPRESSIONS_CORE_STATS ;;
  }

  dimension: impressions_raw {
    type: number
    sql: ${TABLE}.IMPRESSIONS_RAW_IMPRESSION ;;
  }

  dimension: is_viewable_100_geo {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_GEO_STATS ;;
  }

  dimension: is_viewable_100_domain {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_DOMAIN_STATS ;;
  }

  dimension: is_viewable_100_daypart {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_DAYPART_STATS ;;
  }

  dimension: is_viewable_100_core {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_CORE_STATS ;;
  }

  dimension: is_viewable_100_raw {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_RAW_IMPRESSION ;;
  }

  dimension: payout_geo {
    type: number
    sql: ${TABLE}.PAYOUT_GEO_STATS ;;
  }

  dimension: payout_domain {
    type: number
    sql: ${TABLE}.PAYOUT_DOMAIN_STATS ;;
  }

  dimension: payout_daypart {
    type: number
    sql: ${TABLE}.PAYOUT_DAYPART_STATS ;;
  }

  dimension: payout_core {
    type: number
    sql: ${TABLE}.PAYOUT_CORE_STATS ;;
  }

  dimension: payout_raw {
    type: number
    sql: ${TABLE}.PAYOUT_RAW_IMPRESSION ;;
  }

  dimension: revenue_geo {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.REVENUE_GEO_STATS ;;
  }

  dimension: revenue_domain {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.REVENUE_DOMAIN_STATS ;;
  }

  dimension: revenue_daypart {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.REVENUE_DAYPART_STATS ;;
  }

  dimension: revenue_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.REVENUE_CORE_STATS ;;
  }

  dimension: revenue_raw {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.REVENUE_RAW_IMPRESSION ;;
  }

  dimension: mistmatch_check {
    type: number
    label: "Mismatch Check"
    sql: CASE WHEN ${billable_impressions_core} NOT BETWEEN -1 and 1
        OR ${billable_impressions_daypart} NOT BETWEEN -1 and 1
        OR ${billable_impressions_domain} NOT BETWEEN -1 and 1
        OR ${billable_impressions_geo} NOT BETWEEN -1 and 1
        OR ${billable_impressions_raw} NOT BETWEEN -1 and 1
        OR ${billable_units_core} NOT BETWEEN -1 and 1
        OR ${billable_units_daypart} NOT BETWEEN -1 and 1
        OR ${billable_units_domain} NOT BETWEEN -1 and 1
        OR ${billable_units_geo} NOT BETWEEN -1 and 1
        OR ${billable_units_raw} NOT BETWEEN -1 and 1
        OR ${clicks_core} NOT BETWEEN -1 and 1
        OR ${clicks_daypart} NOT BETWEEN -1 and 1
        OR ${clicks_domain} NOT BETWEEN -1 and 1
        OR ${clicks_geo} NOT BETWEEN -1 and 1
        OR ${clicks_raw} NOT BETWEEN -1 and 1
        OR ${completed_100_core} NOT BETWEEN -1 and 1
        OR ${completed_100_daypart} NOT BETWEEN -1 and 1
        OR ${completed_100_domain} NOT BETWEEN -1 and 1
        OR ${completed_100_geo} NOT BETWEEN -1 and 1
        OR ${completed_100_raw} NOT BETWEEN -1 and 1
        OR ${impressions_core} NOT BETWEEN -1 and 1
        OR ${impressions_daypart} NOT BETWEEN -1 and 1
        OR ${impressions_domain} NOT BETWEEN -1 and 1
        OR ${impressions_geo} NOT BETWEEN -1 and 1
        OR ${impressions_raw} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_core} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_daypart} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_domain} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_geo} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_raw} NOT BETWEEN -1 and 1
        OR ${bt_data_core} NOT BETWEEN -0.01 and 0.01
        OR ${bt_data_daypart} NOT BETWEEN -0.01 and 0.01
        OR ${bt_data_domain} NOT BETWEEN -0.01 and 0.01
        OR ${bt_data_geo} NOT BETWEEN -0.01 and 0.01
        OR ${bt_data_raw} NOT BETWEEN -0.01 and 0.01
        OR ${demo_data_core} NOT BETWEEN -0.01 and 0.01
        OR ${demo_data_daypart} NOT BETWEEN -0.01 and 0.01
        OR ${demo_data_domain} NOT BETWEEN -0.01 and 0.01
        OR ${demo_data_geo} NOT BETWEEN -0.01 and 0.01
        OR ${demo_data_raw} NOT BETWEEN -0.01 and 0.01
        OR ${payout_core} NOT BETWEEN -0.01 and 0.01
        OR ${payout_daypart} NOT BETWEEN -0.01 and 0.01
        OR ${payout_domain} NOT BETWEEN -0.01 and 0.01
        OR ${payout_geo} NOT BETWEEN -0.01 and 0.01
        OR ${payout_raw} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_core} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_domain} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_daypart} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_geo} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_raw} NOT BETWEEN -0.01 and 0.01 THEN 1 ELSE 0 END;;
  }


}
