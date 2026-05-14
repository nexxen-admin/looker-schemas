view: media_shift_top_publishers {

  derived_table: {
    sql:
      WITH base AS (
        SELECT
          dis.inventory_source_name,
          CASE
            WHEN dis.inventory_source_id = 158 THEN dle.ssp_publisher_name
            ELSE dsn.seller_name
          END AS publisher_name,
          SUM(f.inventory_cost) AS inventory_cost
        FROM BI_DSP.fact_nexxen_dsp f
        LEFT JOIN BI_DSP.dim_dsp_inventory_source dis
          ON f.inventory_source_key = dis.inventory_source_key
        LEFT JOIN BI_DSP.dim_dsp_inventory_seller_name dsn
          ON f.inventory_source_key = dsn.inventory_source_key
         AND f.exchange_line_item_key = dsn.exchange_line_item_key
        LEFT JOIN BI_DSP.dim_dsp_exchange_line_item dle
          ON f.exchange_line_item_key = dle.exchange_line_item_key
        LEFT JOIN BI_DSP.dim_dsp_format fmt
          ON f.format_key = fmt.format_id
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
          AND {% condition lob_filter %}         mkt.LOB               {% endcondition %}
          AND {% condition agency_filter %}      mkt.market_name       {% endcondition %}
          AND {% condition advertiser_filter %}  adv.advertiser_name   {% endcondition %}
          AND {% condition country_filter %}     cty.country_name      {% endcondition %}
          AND {% condition region_filter %}      rgn.region_name       {% endcondition %}
          AND {% condition device_type_filter %} dvt.device_type       {% endcondition %}
        GROUP BY 1, 2
      )
      SELECT
        b.inventory_source_name,
        b.publisher_name,
        b.inventory_cost,
        CAST(NULL AS NUMERIC(19,4)) AS nexxen_inventory_cost,
        ROW_NUMBER() OVER (ORDER BY b.inventory_cost DESC) AS rank
      FROM base b
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
  }
  filter: lob_filter {
    label: "LOB"
    type: string
  }
  filter: agency_filter {
    label: "Agency Name"
    type: string
  }
  filter: advertiser_filter {
    label: "Advertiser Name"
    type: string
  }
  filter: country_filter {
    label: "Country"
    type: string
  }
  filter: region_filter {
    label: "Region"
    type: string
  }
  filter: device_type_filter {
    label: "Device Type"
    type: string
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
    description: "Placeholder - matching logic pending Noa's decision"
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.nexxen_inventory_cost ;;
    html: {% if value == null %}N/A{% else %}{{ rendered_value }}{% endif %} ;;
  }
}
