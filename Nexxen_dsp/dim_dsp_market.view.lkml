# The name of this view in Looker is "Dim Dsp Market"
view: dim_dsp_market {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_dsp_market ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
    hidden: yes
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Eula Accepted" in Explore.

  dimension: eula_accepted {
    type: number
    label: "Eula Accepted"
    sql: ${TABLE}.eula_accepted ;;
  }


  # dimension: amobee_business_unit {
  #   type: string
  #   label: "Amobee Business Unit"
  #   sql: CASE WHEN ${market_id} in (2196,2167,2164,2148,2142,2141,2136,2067,2050,2045,2017,1805,1792,1781,1677,1637,1626,1602,1489,1398,884,577,58) THEN 'ACCESS'
  #     WHEN ${market_id} in (2222,2181,2174,2151,2127,2099,2088,2069,2058,2056,2039,2032,2018,2013,2012,1997,1972,1810,1789,1678,1676,1659,1658,1657,1608,1606,1604,1577,1486,1477,1383,1371,1368,1310,1307,1183,1144,1090,1084,1076,1051,1008,996,933,681,671,658,305,301) THEN 'ANZ & APAC'
  #     WHEN ${market_id} in (2197,2182,2144,69,2,1,-1) THEN 'DSP Internal / Defaults'
  #     WHEN ${market_id} in (2227,2226,2225,2224,2221,2153,2117,2087,2086,2084,2064,2063,1778,1776,1662,1636,1576,1570,1566,1538,1407,1376,1121,1120,1079,961,272,175) THEN 'EMEA'
  #     WHEN ${market_id} in (2223,2215,2209,2205,2203,2202,2201,2200,2199,2193,2192,2190,2188,2187,2185,2184,2178,2175,2172,2169,2168,2166,2159,2158,2152,2149,2147,2145,2143,2139,2138,2134,2133,2132,2125,2121,2120,2111,2107,2103,2101,2091,2073,2060,2048,2035,2034,2014,2011,1990,1734,1574,1533,1532,1516,1487,1480,1472,1441,1431,1405,1393,1380,1379,1356,1204,1192,1188,1069,1058,1045,999,927,923,898,861,685,141,95,3) THEN 'Enterprise'
  #     WHEN ${market_id} in (9999) THEN 'Other' ELSE 'Unknown' END ;;
  # }



#from dsp_media_and_bids
  dimension: amobee_business_unit {
    type: string
    label: "Amobee Business Unit"
    sql: CASE WHEN ${market_id} in (2196,2167,2164,2148,2142,2141,2136,2067,2050,2045,2017,1805,1792,1781,1677,1637,1626,1489,1398,884,577,58) THEN 'ACCESS'
      WHEN ${market_id} in (2222,2181,2174,2151,2127,2099,2088,2069,2058,2056,2039,2032,2018,2013,2012,1997,1972,1810,1789,1678,1676,1659,1658,1657,1608,1606,1604,1577,1486,1477,1383,1371,1368,1310,1307,1183,1144,1090,1084,1076,1051,1008,996,933,681,671,658,305,301) THEN 'ANZ & APAC'
      WHEN ${market_id} in (2197,2182,2144,69,2,1,-1) THEN 'DSP Internal / Defaults'
      WHEN ${market_id} in (2227,2226,2225,2224,2221,2153,2117,2087,2086,2084,2064,2063,1778,1776,1662,1636,1576,1570,1566,1538,1407,1376,1121,1120,1079,961,272,175) THEN 'EMEA'
      WHEN ${market_id} in (2223,2215,2209,2205,2203,2202,2201,2200,2199,2193,2192,2190,2188,2187,2185,2184,2178,2175,2172,2169,2168,2166,2159,2158,2152,2149,2147,2145,2143,2139,2138,2134,2133,2132,2125,2121,2120,2111,2107,2103,2101,2091,2073,2060,2048,2035,2034,2014,2011,1990,1734,1574,1533,1532,1516,1487,1480,1472,1441,1431,1405,1393,1380,1379,1356,1204,1192,1188,1069,1058,1045,999,927,923,898,861,685,141,95,3,1602) THEN 'Enterprise'
      WHEN ${market_id} in (9999) THEN 'Other' ELSE 'Unknown' END ;;
  }

  # dimension: LOB  {
  #   type: string
  #   label: "LOB"
  #   sql: case when ${amobee_business_unit} = 'ACCESS' then 'MS'
  #             when ${amobee_business_unit} = 'Enterprise' then 'SS'
  #             else 'Other' end;;
  # }

  dimension: market_service_classification {
    type: string
    label: "Market Service Classification"
    sql: CASE
          WHEN ${market_id} IN (58,884,961,1008,1090,1487,1577,1637,1792,2050,2067,2148,2164,2193,2196,2230,2240,2290) THEN 'Managed'
          WHEN ${market_id} IN (141,175,681,861,1069,1079,1356,1371,1407,1472,1477,1480,1602,1608,1778,1990,2011,2048,2058,2069,2073,2086,2099,2127,2133,2139,2143,2145,2147,2151,2158,2159,2165,2169,2172,2174,2175,2181,2183,2184,2187,2188,2190,2192,2201,2202,2205,2207,2208,2215,2220,2222,2226,2227,2228,2229,2233,2235,2239,2241,2254,2258,2259,2262,2263,2267,2277,2283,2285,2286,2298) THEN 'Campaign Suite'
          WHEN ${market_id} IN (1204,1677,2045,2166,2203,2231,2247,2256,2266,2270,2272,2273,2276,2278,2282,2287,2288,2292,2302,2304,2306,2307,2311) THEN 'Hybrid'
          WHEN ${market_id} IN (1,2197) THEN 'DSP Internal / Defaults'
          ELSE NULL
        END ;;
  }

  # dimension: LOB {
  #   type: string
  #   label: "LOB"
  #   sql: CASE
  #         WHEN ${market_service_classification} = 'Managed' THEN 'MS'
  #         WHEN ${market_service_classification} = 'Campaign Suite' THEN 'SS'
  #         WHEN ${market_service_classification} = 'Hybrid' THEN 'Hybrid'
  #         ELSE 'Other'
  #       END ;;
  # }

  parameter: lob_view {
    type: unquoted
    label: "LOB View"
    default_value: "FPA"
    allowed_value: { label: "FP&A"   value: "FPA" }
    allowed_value: { label: "Finance" value: "Finance" }
  }

  dimension: LOB {
    type: string
    label: "LOB"
    sql:
    {% if lob_view._parameter_value == 'FPA' %}
      CASE
        WHEN ${market_service_classification} = 'Managed'        THEN 'MS'
        WHEN ${market_service_classification} = 'Campaign Suite' THEN 'SS'
        WHEN ${market_service_classification} = 'Hybrid'         THEN 'Hybrid'
        ELSE 'Other'
      END
    {% else %}
      CASE
        WHEN ${market_service_classification} = 'Managed'        THEN 'MS'
        WHEN ${market_service_classification} = 'Campaign Suite' THEN 'SS'
        WHEN ${market_service_classification} = 'Hybrid'
             AND ${market_id} IN (2288, 2278)                    THEN 'MS'
        WHEN ${market_service_classification} = 'Hybrid'         THEN 'SS'
        ELSE 'Other'
      END
    {% endif %} ;;
  }

  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
    hidden: yes
  }

  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
    hidden: yes
  }

  dimension: market_id {
    type: number
    label: "Market ID"
    description: "ID of the DSP market to which the Advertiser belongs"
    sql: ${TABLE}.market_id ;;
    value_format_name: id

  }


  dimension: service_type_name {
    type: string
    label: "Service Type"
    sql: CASE WHEN ${market_id} in (2203,2202,2196,2193,2187,2181,2174,2167,2164,2160,2148,2142,2141,2139,2136,2134,2133,2125,2121,2120,2111,2107,2099,2092,2091,2088,2073,2067,2050,2035,2017,1810,1805,1792,1789,1781,1734,1677,1637,1636,1626,1604,1574,1489,1487,1486,1477,1431,1398,1383,1379,1188,1121,1090,1051,1045,1008,996,961,923,884,685,577,58) THEN 'Managed'
      WHEN ${market_id} in (2221,2215,2209,2205,2201,2200,2194,2192,2190,2188,2185,2184,2183,2178,2175,2172,2169,2168,2166,2159,2158,2152,2149,2147,2145,2143,2138,2132,2127,2117,2103,2101,2087,2086,2084,2069,2064,2063,2060,2058,2056,2048,2045,2039,2034,2032,2018,2014,2013,2012,2011,2010,1997,1990,1972,1778,1776,1678,1676,1662,1659,1658,1657,1608,1606,1577,1576,1570,1566,1538,1533,1532,1516,1480,1472,1441,1407,1405,1393,1380,1376,1371,1368,1356,1310,1307,1204,1192,1183,1144,1120,1084,1079,1076,1069,1058,999,933,927,898,861,681,671,658,305,301,272,175,141,95,3) THEN 'Self-Service'
      WHEN ${market_id} in (2197,2182,2144,59,2,1,-1) THEN 'DSP Internal / Defaults'
      WHEN ${market_id} in (1602) THEN 'Managed/self service'
      WHEN ${market_id} in (9999) THEN 'Other'
      ELSE 'Unknown' END ;;
  }


  dimension: market_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.market_id_key ;;
    hidden: yes
  }

  dimension: market_name {
    type: string
    label: "Market Name"
    sql: ${TABLE}.market_name ;;
    description: "DSP market name"

  }



  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }

  dimension: time_zone_code {
    type: string
    label: "Market Timezone"
    sql: ${TABLE}.time_zone_code ;;
    description: "Timezone the market is running at"
  }

  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [market_name]
    hidden: yes
  }
}
