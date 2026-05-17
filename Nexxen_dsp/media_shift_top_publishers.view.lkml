view: media_shift_top_publishers {

  derived_table: {
    sql:
      WITH base AS (
        SELECT
          dis.inventory_source_name,
          dsn.seller_name AS publisher_name,
          SUM(f.inventory_cost) AS inventory_cost
        FROM BI_DSP.fact_nexxen_dsp f
        LEFT JOIN BI_DSP.dim_dsp_inventory_source dis
          ON f.inventory_source_key = dis.inventory_source_key
        LEFT JOIN BI_DSP.dim_dsp_inventory_seller_name dsn
          ON f.inventory_source_key = dsn.inventory_source_key
         AND f.exchange_line_item_key = dsn.exchange_line_item_key
        LEFT JOIN BI_DSP.dim_dsp_format fmt
          ON f.format_key = fmt.format_key
        JOIN BI_DSP.dim_dsp_market mkt
          ON f.market_id_key = mkt.market_id_key
        JOIN BI_DSP.dim_dsp_advertiser adv
          ON f.advertiser_id_key = adv.advertiser_id_key
        LEFT JOIN BI_DSP.dim_dsp_country cty
          ON f.country_key = cty.country_key
        LEFT JOIN BI_DSP.dim_dsp_region rgn
          ON f.region_key = rgn.region_key
        LEFT JOIN BI_DSP.dim_dsp_device_type dvt
          ON f.device_type_key = dvt.device_type_key
        WHERE 1=1
          AND {% condition date_filter %}        f.date_key            {% endcondition %}
          AND {% condition format_filter %}      fmt.format            {% endcondition %}
          AND {% condition lob_filter %}
            CASE
              WHEN mkt.market_id IN (2196,2167,2164,2148,2142,2141,2136,2067,2050,2045,2017,1805,1792,1781,1677,1637,1626,1489,1398,884,577,58) THEN 'MS'
              WHEN mkt.market_id IN (2223,2215,2209,2205,2203,2202,2201,2200,2199,2193,2192,2190,2188,2187,2185,2184,2178,2175,2172,2169,2168,2166,2159,2158,2152,2149,2147,2145,2143,2139,2138,2134,2133,2132,2125,2121,2120,2111,2107,2103,2101,2091,2073,2060,2048,2035,2034,2014,2011,1990,1734,1574,1533,1532,1516,1487,1480,1472,1441,1431,1405,1393,1380,1379,1356,1204,1192,1188,1069,1058,1045,999,927,923,898,861,685,141,95,3,1602) THEN 'SS'
              ELSE 'Other'
            END
          {% endcondition %}
          AND {% condition agency_filter %}      mkt.market_name       {% endcondition %}
          AND {% condition advertiser_filter %}  adv.advertiser_name   {% endcondition %}
          AND {% condition country_filter %}     cty.country_name      {% endcondition %}
          AND {% condition region_filter %}      rgn.region_name       {% endcondition %}
          AND {% condition device_type_filter %} dvt.device_type       {% endcondition %}
          AND dsn.seller_name IS NOT NULL
        GROUP BY 1, 2
      ),
      nexxen AS (
        SELECT
          dsn.seller_name AS publisher_name,
          SUM(f.inventory_cost) AS nexxen_inventory_cost
        FROM BI_DSP.fact_nexxen_dsp f
        JOIN BI_DSP.dim_dsp_inventory_source dis
          ON f.inventory_source_key = dis.inventory_source_key
        JOIN BI_DSP.dim_dsp_inventory_seller_name dsn
          ON f.inventory_source_key = dsn.inventory_source_key
         AND f.exchange_line_item_key = dsn.exchange_line_item_key
        WHERE dis.inventory_source_id = 158
          AND {% condition date_filter %}        f.date_key            {% endcondition %}
          AND dsn.seller_name IS NOT NULL
        GROUP BY 1
      )
      SELECT
        b.inventory_source_name,
        b.publisher_name,
        b.inventory_cost,
        n.nexxen_inventory_cost,
        ROW_NUMBER() OVER (ORDER BY b.inventory_cost DESC) AS rank
      FROM base b
      LEFT JOIN nexxen n
        ON UPPER(TRIM(b.publisher_name)) = UPPER(TRIM(n.publisher_name))
    ;;
  }
  # ---- Templated filters (bind to dashboard filters by title) ----
  filter: date_filter {
    label: "Date Key UTC Date"
    type: date
  }
  filter: format_filter {
    label: "Format"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_format.format
  }
  filter: lob_filter {
    label: "LOB"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_market.LOB
  }
  filter: agency_filter {
    label: "Agency Name"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_market.market_name
  }
  filter: advertiser_filter {
    label: "Advertiser Name"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_advertiser.advertiser_name
  }
  filter: country_filter {
    label: "Country"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_country.country_name
  }
  filter: region_filter {
    label: "Region"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_region.region_name
  }
  filter: device_type_filter {
    label: "Device Type"
    type: string
    suggest_explore: fact_nexxen_dsp
    suggest_dimension: dim_dsp_device_type.device_type
  }
  # ---- Top X parameter ----
  parameter: top_x {
    label: "Top X"
    description: "Number of top publishers to display"
    type: number
    default_value: "7"
  }
  # ---- Dimensions ----
  dimension: inventory_source_name {
    type: string
    sql: ${TABLE}.inventory_source_name ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }
  # ---- Measures ----
  measure: inventory_cost {
    label: "Inventory Cost"
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.inventory_cost ;;
  }
  measure: nexxen_inventory_cost {
    label: "Nexxen Inventory Cost"
    description: "Nexxen inventory cost for the same publisher (matched on seller_name). N/A if publisher has no Nexxen presence."
    type: sum
    value_format: "$#,##0"
    sql: NULLIF(${TABLE}.nexxen_inventory_cost, 0) ;;
    html: {% if value == 0 or value == null %}N/A{% else %}{{ rendered_value }}{% endif %} ;;
  }
}
