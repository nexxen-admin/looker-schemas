view: supply_warehouse_validation {

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
              FROM supply_mart.load_tracking
              JOIN dim.timezone tz ON load_tracking.START_TIMEZONE = tz.timezone_ID
              WHERE schema_name = 'supply_mart'
                AND table_name IN ('daily_placement_core_stats', 'daily_placement_domain_stats')
              GROUP BY
                  load_through_date
                , start_timezone
                , tz.utc_offset
              HAVING count(DISTINCT table_name) = 2
                 AND max(load_through_date) = (
                     SELECT max(load_through_date)
                     FROM (
                       SELECT
                           load_through_date AS load_through_date
                         , count(DISTINCT table_name) AS count_tablename
                       FROM supply_mart.load_tracking
                       WHERE schema_name = 'supply_mart'
                         AND table_name IN ('daily_placement_core_stats', 'daily_placement_domain_stats')
                       GROUP BY load_through_date
                     )
                     WHERE count_tablename = 2)
            )
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
                a12.placement_timezone_id AS starttimezone_id
              , a11.SUPPLY_DATE AS CustCol_36
              , 0 AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , -1 AS WJXBFS8 -- cannot get publisher requests since unserved requests absence
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM rawdb.RAW_IMPRESSION a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND (a12.placement_timezone_id) IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.placement_timezone_id, a11.SUPPLY_DATE
          ),
          -- historical aggregate for RAW_IMPRESSION
          historical_raw_impression_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , a11.SUPPLY_DATE AS CustCol_36
              , 0 AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , -1 AS WJXBFS8 -- cannot get publisher requests since unserved requests absence
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM rawdb.RAW_IMPRESSION a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.placement_timezone_id, a11.SUPPLY_DATE
          ),
          -- latest aggregate for raw HOURLY_ANALYTICS
          latest_raw_hourly_analytics_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , DATE_TRUNC('day', a11.SUPPLY_DATE) AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM rawdb.HOURLY_ANALYTICS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM latest_hour_filter)
              AND a12.placement_timezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.placement_timezone_id, DATE_TRUNC('day', a11.SUPPLY_DATE)
          ),
          -- historical aggregate for raw HOURLY_ANALYTICS
          historical_raw_hourly_analytics_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , DATE_TRUNC('day', a11.SUPPLY_DATE) AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM rawdb.HOURLY_ANALYTICS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM historical_hour_filter)
            GROUP BY a12.placement_timezone_id, DATE_TRUNC('day', a11.SUPPLY_DATE)
          ),
          -- latest aggregate for daily placement core stats
          latest_daily_placment_core_stats_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , a11.SUPPLY_DATE AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM supply_mart.DAILY_PLACEMENT_CORE_STATS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND a12.placement_timezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.placement_timezone_id, a11.SUPPLY_DATE
          ),
          -- historical aggregate for daily placement core stats
          historical_daily_placment_core_stats_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , a11.SUPPLY_DATE AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM supply_mart.DAILY_PLACEMENT_CORE_STATS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.placement_timezone_id, a11.SUPPLY_DATE
          ),
          -- latest aggregate for daily placemnt domain stats
          latest_daily_placment_domain_stats_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , a11.SUPPLY_DATE AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM supply_mart.DAILY_PLACEMENT_DOMAIN_STATS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM latest_date_filter)
              AND a12.placement_timezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.placement_timezone_id, a11.SUPPLY_DATE
          ),
          -- historical aggregate for daily placemnt domain stats
          historical_daily_placment_domain_stats_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , a11.SUPPLY_DATE AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM supply_mart.DAILY_PLACEMENT_DOMAIN_STATS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM historical_date_filter)
            GROUP BY a12.placement_timezone_id, a11.SUPPLY_DATE
          ),
          -- aggregate for hourly core metrics
          latest_hourly_core_metrics_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , DATE_TRUNC('day', a11.SUPPLY_DATE) AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM supply.HOURLY_CORE_METRICS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM latest_hour_filter)
              AND a12.placement_timezone_id IN (SELECT TIMEZONE_ID FROM latest_timezone_filter)
            GROUP BY a12.placement_timezone_id, DATE_TRUNC('day', a11.SUPPLY_DATE)
          ),
          -- historical aggregate for hourly core metrics
          historical_hourly_core_metrics_agg AS (
            SELECT
                a12.placement_timezone_id AS starttimezone_id
              , DATE_TRUNC('day', a11.SUPPLY_DATE) AS CustCol_36
              , SUM(a11.BIDS) AS WJXBFS1
              , SUM(a11.BILLABLE_UNITS) AS WJXBFS2
              , SUM(a11.CLICKS) AS WJXBFS3
              , SUM(a11.COMPLETED_100) AS WJXBFS4
              , SUM(a11.IMPRESSIONS) AS WJXBFS5
              , SUM(a11.IS_VIEWABLE_100) AS WJXBFS6
              , SUM(a11.PAYOUT) AS WJXBFS7
              , SUM(a11.PUBLISHER_REQUESTS) AS WJXBFS8
              , SUM(a11.REVENUE) AS WJXBFS9
            FROM supply.HOURLY_CORE_METRICS a11
            JOIN dim.PLACEMENT_DETAILS a12
              ON (a11.PLACEMENT_ID = a12.PLACEMENT_ID)
            WHERE a11.SUPPLY_DATE IN (SELECT MAX_DATE FROM historical_hour_filter)
            GROUP BY a12.placement_timezone_id, DATE_TRUNC('day', a11.SUPPLY_DATE)
          ),
          -- latest diff stats
          latest_diff_stats AS (
            SELECT
                coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id) AS STARTTIMEZONE_ID
              , a15.timezone_description AS TIMEZONE_DESCRIPTION
              , a15.utc_offset AS UTC_OFFSET
              , coalesce(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36) AS SUPPLY_DATE
              , (COALESCE(pa11.WJXBFS1, 0) - COALESCE(pa12.WJXBFS1, 0)) AS BIDS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS1, 0) - COALESCE(pa13.WJXBFS1, 0)) AS BIDS_DOMAIN
              , (COALESCE(pa14.WJXBFS1, 0) - COALESCE(pa11.WJXBFS1, 0)) AS BIDS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS1, 0) - COALESCE(pa15.WJXBFS1, 0)) AS BIDS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS2, 0) - COALESCE(pa12.WJXBFS2, 0)) AS BILLABLE_UNITS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS2, 0) - COALESCE(pa13.WJXBFS2, 0)) AS BILLABLE_UNITS_DOMAIN
              , (COALESCE(pa14.WJXBFS2, 0) - COALESCE(pa11.WJXBFS2, 0)) AS BILLABLE_UNITS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS2, 0) - COALESCE(pa15.WJXBFS2, 0)) AS BILLABLE_UNITS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS3, 0) - COALESCE(pa12.WJXBFS3, 0)) AS CLICKS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS3, 0) - COALESCE(pa13.WJXBFS3, 0)) AS CLICKS_DOMAIN
              , (COALESCE(pa14.WJXBFS3, 0) - COALESCE(pa11.WJXBFS3, 0)) AS CLICKS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS3, 0) - COALESCE(pa15.WJXBFS3, 0)) AS CLICKS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS4, 0) - COALESCE(pa12.WJXBFS4, 0)) AS COMPLETED_100_DAILY_CORE
              , (COALESCE(pa11.WJXBFS4, 0) - COALESCE(pa13.WJXBFS4, 0)) AS COMPLETED_100_DOMAIN
              , (COALESCE(pa14.WJXBFS4, 0) - COALESCE(pa11.WJXBFS4, 0)) AS COMPLETED_100_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS4, 0) - COALESCE(pa15.WJXBFS4, 0)) AS COMPLETED_100_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS5, 0) - COALESCE(pa12.WJXBFS5, 0)) AS IMPRESSIONS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS5, 0) - COALESCE(pa13.WJXBFS5, 0)) AS IMPRESSIONS_DOMAIN
              , (COALESCE(pa14.WJXBFS5, 0) - COALESCE(pa11.WJXBFS5, 0)) AS IMPRESSIONS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS5, 0) - COALESCE(pa15.WJXBFS5, 0)) AS IMPRESSIONS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS6, 0) - COALESCE(pa12.WJXBFS6, 0)) AS IS_VIEWABLE_100_DAILY_CORE
              , (COALESCE(pa11.WJXBFS6, 0) - COALESCE(pa13.WJXBFS6, 0)) AS IS_VIEWABLE_100_DOMAIN
              , (COALESCE(pa14.WJXBFS6, 0) - COALESCE(pa11.WJXBFS6, 0)) AS IS_VIEWABLE_100_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS6, 0) - COALESCE(pa15.WJXBFS6, 0)) AS IS_VIEWABLE_100_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS7, 0) - COALESCE(pa12.WJXBFS7, 0)) AS PAYOUT_DAILY_CORE
              , (COALESCE(pa11.WJXBFS7, 0) - COALESCE(pa13.WJXBFS7, 0)) AS PAYOUT_DOMAIN
              , (COALESCE(pa14.WJXBFS7, 0) - COALESCE(pa11.WJXBFS7, 0)) AS PAYOUT_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS7, 0) - COALESCE(pa15.WJXBFS7, 0)) AS PAYOUT_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS8, 0) - COALESCE(pa12.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS8, 0) - COALESCE(pa13.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_DOMAIN
              , (COALESCE(pa14.WJXBFS8, 0) - COALESCE(pa11.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_HOURLY_CORE
              -- , (COALESCE(pa11.WJXBFS8, 0) - COALESCE(pa15.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS9, 0) - COALESCE(pa12.WJXBFS9, 0)) AS REVENUE_DAILY_CORE
              , (COALESCE(pa11.WJXBFS9, 0) - COALESCE(pa13.WJXBFS9, 0)) AS REVENUE_DOMAIN
              , (COALESCE(pa14.WJXBFS9, 0) - COALESCE(pa11.WJXBFS9, 0)) AS REVENUE_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS9, 0) - COALESCE(pa15.WJXBFS9, 0)) AS REVENUE_RAW_IMPRESSION
            FROM latest_raw_hourly_analytics_agg pa11
            FULL OUTER JOIN latest_daily_placment_core_stats_agg pa12
              ON (pa11.CustCol_36 = pa12.CustCol_36 AND pa11.starttimezone_id = pa12.starttimezone_id)
            FULL OUTER JOIN latest_daily_placment_domain_stats_agg pa13
              ON (coalesce(pa11.CustCol_36, pa12.CustCol_36) = pa13.CustCol_36 AND coalesce(pa11.starttimezone_id, pa12.starttimezone_id) = pa13.starttimezone_id)
            FULL OUTER JOIN latest_hourly_core_metrics_agg pa14
              ON (coalesce(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36) = pa14.CustCol_36 AND coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id) = pa14.starttimezone_id)
            FULL OUTER JOIN latest_raw_impression_agg pa15
              ON (coalesce(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36) = pa15.CustCol_36 AND coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id) = pa15.starttimezone_id)
            JOIN dim.TIMEZONE a15
              ON  (coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id) = a15.timezone_id)
          ),
          -- historical diff stats
          historical_diff_stats AS (
            SELECT
                coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id) AS STARTTIMEZONE_ID
              , a15.timezone_description AS TIMEZONE_DESCRIPTION
              , a15.utc_offset AS UTC_OFFSET
              , coalesce(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36, pa15.CustCol_36) AS SUPPLY_DATE
              , (COALESCE(pa11.WJXBFS1, 0) - COALESCE(pa12.WJXBFS1, 0)) AS BIDS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS1, 0) - COALESCE(pa13.WJXBFS1, 0)) AS BIDS_DOMAIN
              , (COALESCE(pa14.WJXBFS1, 0) - COALESCE(pa11.WJXBFS1, 0)) AS BIDS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS1, 0) - COALESCE(pa15.WJXBFS1, 0)) AS BIDS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS2, 0) - COALESCE(pa12.WJXBFS2, 0)) AS BILLABLE_UNITS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS2, 0) - COALESCE(pa13.WJXBFS2, 0)) AS BILLABLE_UNITS_DOMAIN
              , (COALESCE(pa14.WJXBFS2, 0) - COALESCE(pa11.WJXBFS2, 0)) AS BILLABLE_UNITS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS2, 0) - COALESCE(pa15.WJXBFS2, 0)) AS BILLABLE_UNITS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS3, 0) - COALESCE(pa12.WJXBFS3, 0)) AS CLICKS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS3, 0) - COALESCE(pa13.WJXBFS3, 0)) AS CLICKS_DOMAIN
              , (COALESCE(pa14.WJXBFS3, 0) - COALESCE(pa11.WJXBFS3, 0)) AS CLICKS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS3, 0) - COALESCE(pa15.WJXBFS3, 0)) AS CLICKS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS4, 0) - COALESCE(pa12.WJXBFS4, 0)) AS COMPLETED_100_DAILY_CORE
              , (COALESCE(pa11.WJXBFS4, 0) - COALESCE(pa13.WJXBFS4, 0)) AS COMPLETED_100_DOMAIN
              , (COALESCE(pa14.WJXBFS4, 0) - COALESCE(pa11.WJXBFS4, 0)) AS COMPLETED_100_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS4, 0) - COALESCE(pa15.WJXBFS4, 0)) AS COMPLETED_100_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS5, 0) - COALESCE(pa12.WJXBFS5, 0)) AS IMPRESSIONS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS5, 0) - COALESCE(pa13.WJXBFS5, 0)) AS IMPRESSIONS_DOMAIN
              , (COALESCE(pa14.WJXBFS5, 0) - COALESCE(pa11.WJXBFS5, 0)) AS IMPRESSIONS_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS5, 0) - COALESCE(pa15.WJXBFS5, 0)) AS IMPRESSIONS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS6, 0) - COALESCE(pa12.WJXBFS6, 0)) AS IS_VIEWABLE_100_DAILY_CORE
              , (COALESCE(pa11.WJXBFS6, 0) - COALESCE(pa13.WJXBFS6, 0)) AS IS_VIEWABLE_100_DOMAIN
              , (COALESCE(pa14.WJXBFS6, 0) - COALESCE(pa11.WJXBFS6, 0)) AS IS_VIEWABLE_100_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS6, 0) - COALESCE(pa15.WJXBFS6, 0)) AS IS_VIEWABLE_100_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS7, 0) - COALESCE(pa12.WJXBFS7, 0)) AS PAYOUT_DAILY_CORE
              , (COALESCE(pa11.WJXBFS7, 0) - COALESCE(pa13.WJXBFS7, 0)) AS PAYOUT_DOMAIN
              , (COALESCE(pa14.WJXBFS7, 0) - COALESCE(pa11.WJXBFS7, 0)) AS PAYOUT_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS7, 0) - COALESCE(pa15.WJXBFS7, 0)) AS PAYOUT_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS8, 0) - COALESCE(pa12.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_DAILY_CORE
              , (COALESCE(pa11.WJXBFS8, 0) - COALESCE(pa13.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_DOMAIN
              , (COALESCE(pa14.WJXBFS8, 0) - COALESCE(pa11.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_HOURLY_CORE
              -- , (COALESCE(pa11.WJXBFS8, 0) - COALESCE(pa15.WJXBFS8, 0)) AS PUBLISHER_REQUESTS_RAW_IMPRESSION
              , (COALESCE(pa11.WJXBFS9, 0) - COALESCE(pa12.WJXBFS9, 0)) AS REVENUE_DAILY_CORE
              , (COALESCE(pa11.WJXBFS9, 0) - COALESCE(pa13.WJXBFS9, 0)) AS REVENUE_DOMAIN
              , (COALESCE(pa14.WJXBFS9, 0) - COALESCE(pa11.WJXBFS9, 0)) AS REVENUE_HOURLY_CORE
              , (COALESCE(pa11.WJXBFS9, 0) - COALESCE(pa15.WJXBFS9, 0)) AS REVENUE_RAW_IMPRESSION
            FROM historical_raw_hourly_analytics_agg pa11
            FULL OUTER JOIN historical_daily_placment_core_stats_agg pa12
              ON (pa11.CustCol_36 = pa12.CustCol_36 AND pa11.starttimezone_id = pa12.starttimezone_id)
            FULL OUTER JOIN historical_daily_placment_domain_stats_agg pa13
              ON (coalesce(pa11.CustCol_36, pa12.CustCol_36) = pa13.CustCol_36 AND coalesce(pa11.starttimezone_id, pa12.starttimezone_id) = pa13.starttimezone_id)
            FULL OUTER JOIN historical_hourly_core_metrics_agg pa14
              ON (coalesce(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36) = pa14.CustCol_36 AND coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id) = pa14.starttimezone_id)
            FULL OUTER JOIN historical_raw_impression_agg pa15
              ON (coalesce(pa11.CustCol_36, pa12.CustCol_36, pa13.CustCol_36, pa14.CustCol_36) = pa15.CustCol_36 AND coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id) = pa15.starttimezone_id)
            JOIN dim.TIMEZONE a15
              ON  (coalesce(pa11.starttimezone_id, pa12.starttimezone_id, pa13.starttimezone_id, pa14.starttimezone_id, pa15.starttimezone_id) = a15.timezone_id)
          )
          -- combines latest diff stats and historical diff stats
          SELECT * FROM latest_diff_stats
          UNION
          SELECT * FROM historical_diff_stats;;
  }

  dimension: supply_date {
    description: "Date"
    type: date
    sql: ${TABLE}.SUPPLY_DATE ;;
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


  dimension: bids_daily_core {
    type: number
    sql: ${TABLE}.BIDS_DAILY_CORE ;;
  }

  dimension: bids_domain {
    type: number
    sql: ${TABLE}.BIDS_DOMAIN ;;
  }

  dimension: bids_hourly_core {
    type: number
    sql: ${TABLE}.BIDS_HOURLY_CORE ;;
  }

  dimension: bids_raw {
    type: number
    sql: ${TABLE}.BIDS_RAW_IMPRESSION ;;
  }

  dimension: billable_units_daily_core {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_DAILY_CORE ;;
  }

  dimension: billable_units_raw {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_RAW_IMPRESSION ;;
  }

  dimension: billable_units_domain {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_DOMAIN ;;
  }

  dimension: billable_units_hourly_core {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS_HOURLY_CORE ;;
  }

  dimension: clicks_daily_core {
    type: number
    sql: ${TABLE}.CLICKS_DAILY_CORE ;;
  }

  dimension: clicks_domain {
    type: number
    sql: ${TABLE}.CLICKS_DOMAIN ;;
  }

  dimension: clicks_raw {
    type: number
    sql: ${TABLE}.CLICKS_RAW_IMPRESSION ;;
  }

  dimension: clicks_hourly_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.CLICKS_HOURLY_CORE ;;
  }

  dimension: completed_100_daily_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.COMPLETED_100_DAILY_CORE ;;
  }

  dimension: completed_100_domain {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.COMPLETED_100_DOMAIN ;;
  }

  dimension: completed_100_hourly_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.COMPLETED_100_HOURLY_CORE ;;
  }

  dimension: completed_100_raw {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.COMPLETED_100_RAW_IMPRESSION ;;
  }

  dimension: impressions_daily_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.IMPRESSIONS_DAILY_CORE ;;
  }

  dimension: impressions_domain {
    type: number
    sql: ${TABLE}.IMPRESSIONS_DOMAIN ;;
  }

  dimension: impressions_hourly_core {
    type: number
    sql: ${TABLE}.IMPRESSIONS_HOURLY_CORE ;;
  }

  dimension: impressions_raw {
    type: number
    sql: ${TABLE}.IMPRESSIONS_RAW_IMPRESSION ;;
  }

  dimension: is_viewable_100_daily_core {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_DAILY_CORE ;;
  }

  dimension: is_viewable_100_daily_domain {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_DOMAIN ;;
  }


  dimension: is_viewable_100_hourly_core {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_HOURLY_CORE ;;
  }

  dimension: is_viewable_100_raw {
    type: number
    sql: ${TABLE}.IS_VIEWABLE_100_RAW_IMPRESSION ;;
  }

  dimension: payout_daily_core {
    type: number
    sql: ${TABLE}.PAYOUT_DAILY_CORE ;;
  }

  dimension: payout_domain {
    type: number
    sql: ${TABLE}.PAYOUT_DOMAIN ;;
  }

  dimension: payout_hourly_core {
    type: number
    sql: ${TABLE}.PAYOUT_HOURLY_CORE ;;
  }

  dimension: payout_raw {
    type: number
    sql: ${TABLE}.PAYOUT_RAW_IMPRESSION ;;
  }

  dimension: publisher_requests_daily_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.PUBLISHER_REQUESTS_DAILY_CORE ;;
  }

  dimension: publisher_requests_domain {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.PUBLISHER_REQUESTS_DOMAIN ;;
  }

  dimension: publisher_requests_hourly_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.PUBLISHER_REQUESTS_HOURLY_CORE ;;
  }

  dimension: publisher_requests_raw_impressions {
    type: number
    hidden: yes
    value_format_name: decimal_4
    sql: ${TABLE}.PUBLISHER_REQUESTS_RAW_IMPRESSION ;;
  }

  dimension: revenue_daily_core {
    type: number
    value_format_name: decimal_4
    sql: ${TABLE}.REVENUE_DAILY_CORE ;;
  }

  dimension: revenue_domain {
    type: number
    sql: ${TABLE}.REVENUE_DOMAIN ;;
  }

  dimension: revenue_hourly_core {
    type: number
    sql: ${TABLE}.REVENUE_HOURLY_CORE ;;
  }

  dimension: revenue_raw {
    type: number
    sql: ${TABLE}.REVENUE_RAW_IMPRESSION ;;
  }

  dimension: mistmatch_check {
    type: number
    label: "Mismatch Check"
    sql: CASE WHEN ${bids_daily_core} NOT BETWEEN -1 and 1
        OR ${bids_domain} NOT BETWEEN -1 and 1
        OR ${bids_hourly_core} NOT BETWEEN -1 and 1
        OR ${bids_raw} NOT BETWEEN -1 and 1
        OR ${billable_units_daily_core} NOT BETWEEN -1 and 1
        OR ${billable_units_domain} NOT BETWEEN -1 and 1
        OR ${billable_units_hourly_core} NOT BETWEEN -1 and 1
        OR ${billable_units_raw} NOT BETWEEN -1 and 1
        OR ${clicks_daily_core} NOT BETWEEN -1 and 1
        OR ${clicks_domain} NOT BETWEEN -1 and 1
        OR ${clicks_hourly_core} NOT BETWEEN -1 and 1
        OR ${clicks_raw} NOT BETWEEN -1 and 1
        OR ${completed_100_daily_core} NOT BETWEEN -1 and 1
        OR ${completed_100_domain} NOT BETWEEN -1 and 1
        OR ${completed_100_hourly_core} NOT BETWEEN -1 and 1
        OR ${completed_100_raw} NOT BETWEEN -1 and 1
        OR ${impressions_daily_core} NOT BETWEEN -1 and 1
        OR ${impressions_domain} NOT BETWEEN -1 and 1
        OR ${impressions_hourly_core} NOT BETWEEN -1 and 1
        OR ${impressions_raw} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_daily_core} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_daily_domain} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_hourly_core} NOT BETWEEN -1 and 1
        OR ${is_viewable_100_raw} NOT BETWEEN -1 and 1
        OR ${publisher_requests_daily_core} NOT BETWEEN -1 and 1
        OR ${publisher_requests_domain} NOT BETWEEN -1 and 1
        OR ${publisher_requests_hourly_core} NOT BETWEEN -1 and 1
      --  OR ${publisher_requests_raw_impressions} NOT BETWEEN -1 and 1
        OR ${payout_daily_core} NOT BETWEEN -0.01 and 0.01
        OR ${payout_domain} NOT BETWEEN -0.01 and 0.01
        OR ${payout_hourly_core} NOT BETWEEN -0.01 and 0.01
        OR ${payout_raw} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_daily_core} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_domain} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_hourly_core} NOT BETWEEN -0.01 and 0.01
        OR ${revenue_raw} NOT BETWEEN -0.01 and 0.01
          THEN 1 ELSE 0 END ;;
  }

}
