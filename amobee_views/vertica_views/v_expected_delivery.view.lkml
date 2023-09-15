view: v_expected_delivery {
  derived_table: {
    sql:  WITH _FLIGHT_STATS AS (
            SELECT
              fd.CAMPAIGN_ID,
              fd.FLIGHT_ID,
              CAST(DATEDIFF('SECOND', MIN(fd.BEGIN_DATETIME_LOCAL), MAX(fd.END_DATETIME_LOCAL)) AS FLOAT) AS TOTAL_TIME,
              CAST(GREATEST(0, DATEDIFF('SECOND', MIN(fd.BEGIN_DATETIME_LOCAL), LEAST(MAX(fd.END_DATETIME_LOCAL), TIMESTAMPADD('DAY', 1, MAX(lt.LOAD_THROUGH_DATE))))) AS FLOAT) AS ELAPSED_TIME,
              CAST(MAX(b.BUDGET) * (1 + MAX(fmd.AGENCY_FEE)) AS FLOAT) AS TARGET_GROSS_SPEND,
              CAST(MAX(b.UNITS) AS FLOAT) AS TARGET_UNITS
            FROM
              DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW fmd
                JOIN DIM.FLIGHT_DETAILS_VIEW fd
                  ON fd.flight_id = fmd.flight_id
                JOIN RAWDB.LOAD_TRACKING lt
                  ON fmd.STARTTIMEZONE_ID = lt.START_TIMEZONE AND
                     lt.SCHEMA_NAME = 'DEMAND_MART' AND
                     lt.TABLE_NAME = 'DAILY_CORE_STATS'
                JOIN DIM.DEMAND_UNITS_BUDGET_VIEW b
                  ON fmd.FLIGHT_ID = b.FLIGHT_ID AND
                     b.FLIGHT_MEDIA_ID IS NULL
            WHERE
              fd.BEGIN_DATETIME_LOCAL < fd.END_DATETIME_LOCAL AND
              fd.FLIGHT_ACTIVE = 1 AND
              {% condition v_campaign_details_base.campaign_id %} fd.CAMPAIGN_ID {% endcondition %} AND
              {% condition v_flight_details.flight_id %} fd.FLIGHT_ID {% endcondition %}
            GROUP BY
              fd.CAMPAIGN_ID,
              fd.FLIGHT_ID
          )
          SELECT
            s.CAMPAIGN_ID,
            s.FLIGHT_ID,
            s.ELAPSED_TIME / s.TOTAL_TIME * s.TARGET_GROSS_SPEND AS EXPECTED_GROSS_SPEND,
            s.ELAPSED_TIME / s.TOTAL_TIME * s.TARGET_UNITS AS EXPECTED_UNITS
          FROM
            _FLIGHT_STATS s ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: flight_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  measure: expected_gross_spend {
    type: sum
    hidden: yes
    sql: ${TABLE}.EXPECTED_GROSS_SPEND ;;
  }

  measure: expected_units {
    type: sum
    hidden: yes
    sql: ${TABLE}.EXPECTED_UNITS ;;
  }
}
